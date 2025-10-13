from datetime import datetime

from django.shortcuts import render, redirect
from django.core.exceptions import ValidationError
from django.utils.safestring import mark_safe
from django import forms
from django.contrib.auth.hashers import make_password
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.db.models.signals import post_save
from django.db.models import Q
from django.dispatch import receiver
from openpyxl import load_workbook

from OnlineShop import models
from OnlineShop.utils.bootstrap import BootStrapModelForm
from OnlineShop.utils.encrypt import md5
from OnlineShop.utils.pagination import Pagination



class SellOrderInfoModelForm(forms.ModelForm):
    class Meta:
        model = models.SellOrders
        fields = '__all__'

# 把 choices 做成字典，方便反向查
STATUS_MAP = {label: val for val, label in models.SellOrders.status_choices}

def sellorder_info_admin(request):
    search_data = request.GET.get('search_data', '').strip()
    queryset = models.SellOrders.objects.select_related('user', 'inventory_items').order_by('-updated_at')

    if search_data:
        # 先判断是不是中文状态
        status_num = STATUS_MAP.get(search_data)          # 找不到返回 None
        q = Q(id__icontains=search_data) | Q(user__username__icontains=search_data)
        if status_num is not None:                        # 输入的是“已完成”等
            q |= Q(status=status_num)
        queryset = queryset.filter(q)

    page_object = Pagination(request, queryset)
    context = {
        'sell_orders': page_object.page_queryset,
        'search_data': search_data,
        'page_string': page_object.html(),
        'title': '所有订单',
        'form': SellOrderInfoModelForm(),
    }
    return render(request, 'order/sellorder_info_admin.html', context)

# ajax管理员修改订单、入库单待实现

def sellorder_info_user(request):
    search_data = request.GET.get('search_data', '').strip()
    queryset = models.SellOrders.objects.filter(
        user_id=request.session['info']['id'],
        is_deleted=False
    ).select_related('user', 'inventory_items').order_by('-updated_at')
    if search_data:
        queryset = queryset.filter(
            Q(id__icontains=search_data) |
            Q(inventory_items__items_name__name__icontains=search_data)
        )
    page_object = Pagination(request, queryset)
    context = {
        'sell_orders': page_object.page_queryset,
        'search_data': search_data,
        'page_string': page_object.html(),
        'title': '我的订单',
        'form': SellOrderInfoModelForm(),
    }
    return render(request, 'order/sellorder_info_user.html', context)

def sellorder_delete_user(request, nid):
    models.SellOrders.objects.filter(id=nid).update(is_deleted=True)  # 只改标记，不删数据
    return redirect('/sellorder/info/user/')


class SellOrderAddModelForm(forms.ModelForm):
    class Meta:
        model = models.SellOrders
        exclude = ['id', 'user', 'order_date', 'updated_at']   
@csrf_exempt
def sellorder_add(request):
    if request.method == 'POST':
        form = SellOrderAddModelForm(data=request.POST)
    if form.is_valid():
        form.instance.user_id = request.session['info']['id']
        form.instance.is_deleted = False     
        form.save()
        return JsonResponse({'status': 'True'})
    else:
        return JsonResponse({'status': 'False', 'error': form.errors})

@receiver(post_save, sender=models.SellOrders)
def sell_order_trigger(sender, instance, created, **kwargs):
    if created:
        total_price = instance.order_quantity * instance.inventory_items.sell_price
        print(f"新订单已创建：订单ID {instance.id}, 总金额 {total_price}")

class PurchaseOrderInfoModelForm(forms.ModelForm):
    class Meta:
        model = models.PurchaseOrders
        fields = '__all__'

STATUS_MAP = {label: val for val, label in models.PurchaseOrders.STATUS_CHOICES}

def purchaseorder_info(request):
    search_data = request.GET.get('search_data', '').strip()
    queryset = models.PurchaseOrders.objects.select_related(
        'merchant_items__merchant', 'employee').order_by('-updated_at')
    if search_data:
        status_num = STATUS_MAP.get(search_data)        
        q = Q(id__icontains=search_data) | Q(merchant_items__merchant_items__icontains=search_data) | Q(employee__employee_name__icontains=search_data)
        if status_num is not None:                      
            q |= Q(status=status_num)
        queryset = queryset.filter(q)

    page_object = Pagination(request, queryset)
    form = PurchaseOrderInfoModelForm()
    title='所有入库单'
    context = {
        'form': form,
        'purchase_orders': page_object.page_queryset,
        'title':title,
        'search_data':search_data,
        'page_string':page_object.html()}
    return render(request, 'order/purchase_info.html', context)
    


def purchase_order_upload(request):
    file = request.FILES.get('excel')
    if not file:
        return redirect('/purchase/order/info/')         

    wb = load_workbook(file)
    sheet = wb.worksheets[0]                           

    for row in sheet.iter_rows(min_row=2, max_row=sheet.max_row, values_only=True):
        # 按列顺序取值
        item_name, merchant_name, price, desc, catalog, qty, emp_name = row[:7]

        if not all([item_name, merchant_name, price, qty, emp_name]):
            continue                                   

        item_obj, _ = models.PurchaseItems.objects.get_or_create(
            name=item_name.strip(),
            defaults={
                'description': desc or '',
                'catalog': catalog or ''
            }
        )

        merchant_obj, _ = models.MerchantInfo.objects.get_or_create(
            merchant_name=merchant_name.strip(),
            defaults={'phone': ''}                     
        )

        merchant_item_obj, _ = models.MerchantItems.objects.get_or_create(
            merchant=merchant_obj,
            merchant_items=item_obj,
            defaults={'merchant_price': price}
        )
        
        emp_obj = models.EmployeeInfo.objects.filter(employee_name=emp_name.strip()).first()
        if not emp_obj:
            continue                                    # 员工必须存在，否则跳过

        models.PurchaseOrders.objects.create(
            merchant_items=merchant_item_obj,
            purchase_quantity=qty,
            employee=emp_obj,
            status=1                                     
        )

    return redirect('/purchaseorder/upload/')
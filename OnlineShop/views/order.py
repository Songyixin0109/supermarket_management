from datetime import datetime
from decimal import Decimal
from math import ceil
from openpyxl import load_workbook

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
from django.utils import timezone
from django.db import transaction

from OnlineShop import models
from OnlineShop.utils.bootstrap import BootStrapModelForm
from OnlineShop.utils.encrypt import md5
from OnlineShop.utils.pagination import Pagination
from OnlineShop.models import PurchaseOrders, InventoryItems, EmployeeInfo

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

class SellOrderAdminEditForm(forms.ModelForm):
    """管理员编辑：仅 status 可改"""
    class Meta:
        model = models.SellOrders
        fields = '__all__'          # 全部字段都展示

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # 除了 status 以外全部禁用
        for name, field in self.fields.items():
            if name != 'status':
                field.disabled = True

@csrf_exempt
def sellorder_admin_edit(request, nid):
    order = models.SellOrders.objects.filter(id=nid).first()
    if not order:
        return JsonResponse({'status': False, 'error': '订单不存在'})

    # ① 首次弹窗：只把表单初始数据返回，让前端自己拼
    if request.method == 'GET':
        form = SellOrderAdminEditForm(instance=order)   # 其余字段已disabled
        # 把各字段当前值序列化给前端
        field_data = {f: form.initial.get(f, getattr(order, f)) for f in form.fields}
        field_data['status_choices'] = models.SellOrders.status_choices
        return JsonResponse({'status': True, 'fields': field_data})

    # ② 保存：仅status会被clean进来，其余忽略
    form = SellOrderAdminEditForm(data=request.POST, instance=order)
    if not form.is_valid():
        return JsonResponse({'status': False, 'error': form.errors})

    # 只真正更新status
    new_status = form.cleaned_data['status']
    if new_status != order.status:
        models.SellOrders.objects.filter(id=nid).update(status=new_status)
    return JsonResponse({'status': True, 'msg': '状态已更新'})

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
        'merchant_items__merchant', 'employee').order_by('updated_at')
    if search_data:
        status_num = STATUS_MAP.get(search_data)        
        # 修复搜索条件：对 ForeignKey 字段使用正确的查找方式
        q = Q(id__icontains=search_data) | \
            Q(merchant_items__merchant_items__name__icontains=search_data) | \
            Q(employee__employee_name__icontains=search_data)
        
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
    
class PurchaseOrderStatusForm(forms.ModelForm):
    """管理员编辑：仅 status 可改"""
    class Meta:
        model = models.PurchaseOrders
        fields = '__all__'          # 全部字段都展示

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # 除了 status 以外全部禁用
        for name, field in self.fields.items():
            if name != 'status':
                field.disabled = True

@csrf_exempt
def purchase_admin_edit(request, nid):
    order = (
        models.PurchaseOrders.objects.select_related(
            "merchant_items__merchant_items",
            "merchant_items__merchant",
            "employee",
        )
        .filter(id=nid)
        .first()
    )
    if not order:
        return JsonResponse({"status": False, "error": "入库单不存在"})

    if request.method == "GET":
        fields = {}
        fields["id"] = order.id
        fields["merchant_items"] = (
            order.merchant_items.merchant_items.name
            if order.merchant_items
            else "-"
        )
        fields["merchant_name"] = (
            order.merchant_items.merchant.merchant_name
            if order.merchant_items
            else "-"
        )
        fields["merchant_price"] = (
            str(order.merchant_items.merchant_price)
            if order.merchant_items
            else "-"
        )
        fields["purchase_quantity"] = order.purchase_quantity
        fields["employee"] = (
            order.employee.employee_name if order.employee else "-"
        )
        fields["status"] = order.status
        fields["created_at"] = order.created_at.strftime("%Y-%m-%d %H:%M")
        fields["updated_at"] = order.updated_at.strftime("%Y-%m-%d %H:%M")
        fields["status_choices"] = models.PurchaseOrders.STATUS_CHOICES
        return JsonResponse({"status": True, "fields": fields})

    new_status = int(request.POST.get("status", -1))
    original_status = order.status
    if new_status == original_status:
        return JsonResponse({"status": False, "error": {"status": ["您没有改变状态！"]}})

    # ① 手动刷新 updated_at（auto_now 不会被 update 触发）
    models.PurchaseOrders.objects.filter(id=nid).update(
        status=new_status, updated_at=timezone.now()
    )

    # ② 已入库(2) 时 自动写 / 更新 InventoryItems
    if new_status == 2:
        order.refresh_from_db()
        merchant_items = order.merchant_items
        if merchant_items:
            sell_price = int(ceil(merchant_items.merchant_price * Decimal("1.3")))
            qty = order.purchase_quantity

            inv, created = models.InventoryItems.objects.get_or_create(
                items_name=merchant_items.merchant_items,
                defaults={"sell_price": sell_price, "inventory_quantity": qty},
            )
            if not created:
                inv.inventory_quantity += qty
                inv.sell_price = sell_price
                inv.save()

            # ← 当场抓痕
            print(f'[库存] 已写入/更新  inv.id={inv.id}  数量={inv.inventory_quantity}  created={created}')

        else:
            print('[库存] merchant_items 为空，跳过')

    return JsonResponse({"status": True, "msg": "状态已更新"})

@csrf_exempt
def purchase_order_upload(request):
    if request.method != 'POST':
        return JsonResponse({'status': False, 'msg': '仅支持 POST'})

    file = request.FILES.get('excel')
    if not file:
        return JsonResponse({'status': False, 'msg': '未选择文件'})

    # 取当前登录员工
    user_id = request.session.get('info', {}).get('id')          # 当前登录用户ID
    emp = EmployeeInfo.objects.filter(id=user_id).first()
    if not emp:
        return JsonResponse({'status': False, 'msg': '未找到当前员工信息，请重新登录'})

    try:
        wb = load_workbook(file)
        sheet = wb.worksheets[0]

        for row in sheet.iter_rows(min_row=2, max_row=sheet.max_row, values_only=True):
            item_name, merchant_name, price, desc, catalog, qty = row[:6]

            if not all([item_name, merchant_name, price, qty]):
                continue            # 必填列有空值则跳过

            item_obj, _ = models.PurchaseItems.objects.get_or_create(
                name=item_name.strip(),
                defaults={'description': desc or '', 'catalog': catalog or ''}
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

            models.PurchaseOrders.objects.create(
                merchant_items=merchant_item_obj,
                purchase_quantity=qty,
                employee=emp,          
                status=1
            )

        return JsonResponse({'status': True, 'msg': '导入成功'})
    except Exception as e:
        return JsonResponse({'status': False, 'msg': f'导入失败：{str(e)}'})
    


# @receiver(post_save, sender=PurchaseOrders)
# def auto_create_or_update_inventory(sender, instance, created, **kwargs):
#     """
#     管理员把入库单状态改成“已入库”时，
#     自动把商品同步到 InventoryItems，售价=进价*1.3 向上取整
#     """
#     # 只在状态更新为“已入库”时触发
#     if instance.status != 2:          # 2 代表 models 里的“已入库”
#         return

#     # 防止重复处理（如果已处理过直接返回）
#     if getattr(instance, '_sync_done', False):
#         return

#     with transaction.atomic():
#         # 取出关联数据
#         merchant_items = instance.merchant_items
#         if not merchant_items:
#             return
#         purchase_item = merchant_items.merchant_items   # PurchaseItems
#         in_price = merchant_items.merchant_price        # 进货价
#         sell_price = int(ceil(in_price * 1.3))          # 1.3 倍向上取整
#         qty = instance.purchase_quantity                # 本次入库数量

#         # 存在就更新，不存在就创建
#         inv, created_flag = InventoryItems.objects.select_for_update().get_or_create(
#             items_name=purchase_item,
#             defaults={
#                 'sell_price': sell_price,
#                 'inventory_quantity': qty
#             }
#         )
#         if not created_flag:
#             # 已存在，只累加库存
#             inv.inventory_quantity += qty
#             # 售价也按最新一次进货价重新计算（如不需要可删掉）
#             inv.sell_price = sell_price
#             inv.save()

#     # 打标记，防止重复
#     instance._sync_done = True
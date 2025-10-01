from datetime import datetime

from django.shortcuts import render, redirect
from django.core.exceptions import ValidationError
from django.utils.safestring import mark_safe
from django import forms
from django.contrib.auth.hashers import make_password
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.db.models.signals import post_save
from django.dispatch import receiver


from OnlineShop import models
from OnlineShop.models import UserInfo
from OnlineShop.utils.bootstrap import BootStrapModelForm
from OnlineShop.utils.encrypt import md5
from OnlineShop.utils.pagination import Pagination

class SellOrderInfoModelForm(forms.ModelForm):
    class Meta:
        model = models.SellOrders
        fields = '__all__'
def sellorder_info_admin(request):
    if request.method == 'GET':
        data_dict = {}
        search_data = request.GET.get('search_data', '')
        if search_data:
            data_dict['id'] = search_data
        queryset = models.SellOrders.objects.filter(**data_dict).select_related('user', 'inventory_items')
        page_object = Pagination(request, queryset)
        form = SellOrderInfoModelForm()
        title='Sell Order'
        context = {
            'form': form,
            'sell_orders': page_object.page_queryset,
            'title':title,
            'search_data':search_data,
            'page_string':page_object.html()}
        return render(request, 'order/sellorder_info_admin.html', context)

def sellorder_info_user(request):
    if request.method == 'GET':
        data_dict = {}
        data_dict['user_id'] = request.session['info']['id']
        print(request.session['info'])
        search_data = request.GET.get('search_data', '')
        if search_data:
            data_dict['id'] = search_data
        queryset = models.SellOrders.objects.filter(**data_dict).select_related('user', 'inventory_items')
        page_object = Pagination(request, queryset)
        form = SellOrderInfoModelForm()
        title = '我的订单'
        context = {
            'form': form,
            'sell_orders': page_object.page_queryset,
            'title': title,
            'search_data': search_data,
            'page_string': page_object.html()}
        return render(request, 'order/sellorder_info_user.html', context)

def sellorder_delete_admin(request, nid):
    models.SellOrders.objects.get(id=nid).delete()
    return redirect('/sellorder/info/admin/')

def sellorder_delete_user(request, nid):
    models.SellOrders.objects.get(id=nid).delete()
    return redirect('/sellorder/info/user/')


class SellOrderAddModelForm(forms.ModelForm):
    class Meta:
        model = models.SellOrders
        exclude=['id','user','order_date']
@csrf_exempt
def sellorder_add(request):
    if request.method == 'POST':
        form = SellOrderAddModelForm(data=request.POST)
        if form.is_valid():
            form.instance.user_id = request.session['info']['id']
            form.instance.order_date = datetime.now()
            form.save()
            return JsonResponse({'status': 'True'})
        else:
            return JsonResponse({'status': 'False','error':form.errors})

@receiver(post_save, sender=models.SellOrders)
def sell_order_trigger(sender, instance, created, **kwargs):
    if created:
        total_price = instance.order_quantity * instance.inventory_items.ask_price
        print(f"新订单已创建：订单ID {instance.id}, 总金额 {total_price}")
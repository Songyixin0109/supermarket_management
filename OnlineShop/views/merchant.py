from django.shortcuts import render, redirect
from django import forms
from django.core.exceptions import ValidationError
from matplotlib.pyplot import title

from OnlineShop import models
from OnlineShop.utils.bootstrap import BootStrapModelForm
from OnlineShop.utils.encrypt import md5
from OnlineShop.utils.pagination import Pagination

def merchant_info(request):
    data_dict = {}
    search_data = request.GET.get('search_data', '')
    if search_data:
        data_dict['username__contains'] = search_data
    queryset = models.MerchantInfo.objects.filter(**data_dict)
    page_object = Pagination(request, queryset)
    title = '商户信息'
    context = {
                'merchant_list': page_object.page_queryset,
                'title': title,
                'search_data':search_data,
                'page_string':page_object.html(),}
    return render(request,'merchant/merchant_info.html',context)

class MerchantModelForm(BootStrapModelForm):
    class Meta:
        model = models.MerchantInfo
        fields = '__all__'
    
        def clean_username(self):
            merchant_name = self.cleaned_data.get('merchant_name')
            exist = models.UserInfo.objects.filter(merchant_name=merchant_name).exists()
            if exist:
                raise ValidationError("用户名已存在")
            return merchant_name

def merchant_add(request):
    title='新增商家'
    if request.method == 'GET':
        form = MerchantModelForm()
        return render(request, 'register_edit.html', {'form':form, 'title':title})
    if request.method == 'POST':
        form = MerchantModelForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/merchant/info/')
        else:
            return render(request, 'register_edit.html', {'form':form, 'title':title})
        
class MerchantEditModelForm(BootStrapModelForm):
    merchant_name = forms.CharField(
        label='商家名称',disabled=True)
    class Meta:
        model = models.MerchantInfo
        fields = ['merchant_name','phone', 'email', 'address']
        labels={
            'merchant_name': '商家名称',
            'phone': '联系电话',
            'email': '联系邮箱',
            'address': '联系地址',
        }

def merchant_edit(request, nid):
    title = '编辑商家'
    if request.method == "GET":
        form = MerchantEditModelForm(instance=models.MerchantInfo.objects.get(id=nid))
        return render(request, 'register_edit.html', {'form': form, 'title': title})
    if request.method == "POST":
        form = MerchantEditModelForm(request.POST, instance=models.MerchantInfo.objects.get(id=nid))
        if form.is_valid():
            form.save()
            return redirect('/merchant/info/')
        else:
            return render(request, 'register_edit.html', {'form': form, 'title': title})

def merchant_delete(request, nid):
    models.MerchantInfo.objects.get(id=nid).delete()
    return redirect('/merchant/info/')

# class MerchantItemsModelForm(BootStrapModelForm):

# def inventory_info_user(request):
#     if request.method == 'GET':
#         data_dict = {}
#         search_data = request.GET.get('search_data', '')
#         if search_data:
#             data_dict['name__contains'] = search_data
#         queryset = models.InventoryItems.objects.filter(**data_dict)
#         page_object = Pagination(request, queryset)
#         form = InventoryItemsInfoModelForm()

#         title = '商品列表'
#         context = {'form': form,
#                    'inventory_items': page_object.page_queryset,
#                    'title': title,
#                    'search_data': search_data,
#                    'page_string': page_object.html(), }

#         return render(request, 'inventory/inventory_info_user.html', context)
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

def merchant_add(request):
    title='新增商家'
    if request.method == 'GET':
        form = MerchantModelForm()
        return render(request, 'register_edit.html', {'form':form, 'title':title})
    if request.method == 'POST':
        form = MerchantModelForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/admin/info/')
        else:
            return render(request, 'register_edit.html', {'form':form, 'title':title})
        
class MerchantEditModelForm(BootStrapModelForm):
    class Meta:
        model = models.MerchantInfo
        fields = ['phone', 'email', 'address']
from django.shortcuts import render, redirect
from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator
from django.utils.safestring import mark_safe
from django import forms
from django.contrib.auth.hashers import make_password

from OnlineShop import models
from OnlineShop.models import UserInfo
from OnlineShop.utils.bootstrap import BootStrapModelForm
from OnlineShop.utils.encrypt import md5
from OnlineShop.utils.pagination import Pagination

# Create your views here.
def user_info(request):
    title='用户信息'
    data_dict={}
    search_data = request.GET.get('search_data','')
    print(search_data)
    if search_data:
        data_dict['username__contains'] = search_data
    queryset = models.UserInfo.objects.filter(**data_dict)
    page_object=Pagination(request,queryset)
    context = {'user_list': page_object.page_queryset,
               'title':title,
               'search_data':search_data,
               'page_string':page_object.html()}
    return render(request, 'user/user_info.html', context)
class UserInfoModelForm(BootStrapModelForm):
    confirm_password = forms.CharField(
        label='确认密码',
        widget=forms.PasswordInput(render_value=True))
    phone = forms.CharField(
        label='电话号码',
        validators=[
            RegexValidator(
                regex=r'^1[3-9]\d{9}$',
                message='电话号码格式错误')
        ])
    class Meta:
        model = models.UserInfo
        fields = ['username', 'password', 'name', 'gender', 'phone', 'email']
        labels = {
            'username': '用户名',
            'password': '密码',
            'name': '姓名',
            'gender': '性别',
            'phone': '电话号码',
            'email': '邮箱',
        }
        widgets = {'password': forms.PasswordInput(render_value=True)}
    def clean_password(self):
        password = self.cleaned_data.get('password')
        if len(password) < 8:
            raise ValidationError("密码长度至少8位")
        if not any(char.islower() for char in password):
            raise ValidationError("密码必须包含至少一个小写字母")
        if not any(char.isupper() for char in password):
            raise ValidationError("密码必须包含至少一个大写字母")
        return md5(password)
    def clean_confirm_password(self):
        password = self.cleaned_data.get('password') 
        confirm_password = self.cleaned_data.get('confirm_password')  
        if password != md5(confirm_password):
            raise forms.ValidationError('两次密码输入不一致')
        return confirm_password
    def clean_username(self):
        username = self.cleaned_data.get('username')
        exist = models.UserInfo.objects.filter(username=username).exists()
        if exist:
            raise ValidationError("用户名已存在")
        return username
def user_register(request):
    title='新建用户'
    if request.method == "GET":
        form = UserInfoModelForm()
        return render(request, 'register_edit.html', {'form': form, 'title':title })
    if request.method == "POST":
        form = UserInfoModelForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/')
        else:
            return render(request, 'register_edit.html', {'form': form, 'title': title})
class UserInfoEditModelForm(BootStrapModelForm):
    username = forms.CharField(label='用户名', disabled=True)
    class Meta:
        model = models.UserInfo
        fields = ['username', 'password', 'name', 'gender', 'phone', 'email']
        labels = {
            'username': '用户名',
            'password': '密码',
            'name': '姓名',
            'gender': '性别',
            'phone': '电话',
            'email': '邮箱',
        }
        widgets = {'password': forms.PasswordInput(render_value=True)}
    def clean_password(self):
        password = self.cleaned_data.get('password')
        if len(password) < 8:
            raise ValidationError("密码长度至少8位")
        if not any(char.islower() for char in password):
            raise ValidationError("密码必须包含至少一个小写字母")
        if not any(char.isupper() for char in password):
            raise ValidationError("密码必须包含至少一个大写字母")
        return password
def user_edit(request, nid):
    title='编辑用户'
    if request.method == "GET":
        form = UserInfoEditModelForm(instance=UserInfo.objects.get(id=nid))
        return render(request, 'register_edit.html', {'form': form,'title':title})
    if request.method == "POST":
        form = UserInfoEditModelForm(request.POST, instance=UserInfo.objects.get(id=nid))
        if form.is_valid():
            form.save()
            return redirect('/user/info/')
        else:
            return render(request, 'register_edit.html', {'form': form,'title':title})
def user_delete(request, nid):
    models.UserInfo.objects.get(id=nid).delete()
    return redirect('/user/info/')

class SellOrderModelForm(forms.ModelForm):
    class Meta:
        model = models.SellOrders
        exclude=['id','user','order_date']
        labels = {
            'inventory_items':'商品名称',
            'order_quantity':'购买数量',
        }
def user_index(request):
    form = SellOrderModelForm()
    return render(request,'user/index.html',{'form':form})
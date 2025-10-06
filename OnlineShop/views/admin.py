from django.shortcuts import render, redirect
from django import forms
from django.core.exceptions import ValidationError
from matplotlib.pyplot import title

from OnlineShop import models
from OnlineShop.utils.bootstrap import BootStrapModelForm
from OnlineShop.utils.encrypt import md5
from OnlineShop.utils.pagination import Pagination

def admin_info(request):
    data_dict = {}
    search_data = request.GET.get('search_data', '')
    if search_data:
        data_dict['username__contains'] = search_data
    queryset = models.Admin.objects.filter(**data_dict)
    page_object = Pagination(request, queryset)
    title = '管理员信息'
    context = {
                'admin_list': page_object.page_queryset,
                'title': title,
                'search_data':search_data,
                'page_string':page_object.html(),}
    return render(request,'admin/admin_info.html',context)

class AdminModelForm(BootStrapModelForm):
    confirm_password = forms.CharField(
        label='确认密码',
        widget=forms.PasswordInput(render_value=True))
    class Meta:
        model = models.Admin
        fields = ['username', 'password']
        labels = {
            'username': '用户名',
            'password': '密码',
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
        exist = models.Admin.objects.filter(username=username).exists()
        if exist:
            raise ValidationError("用户名已存在")
        return username
def admin_register(request):
    title='新建管理员'
    if request.method == 'GET':
        form = AdminModelForm()
        return render(request, 'register_edit.html', {'form':form, 'title':title})
    if request.method == 'POST':
        form = AdminModelForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/')
        else:
            return render(request, 'register_edit.html', {'form':form, 'title':title})

class AdminEditModelForm(BootStrapModelForm):
    confirm_password = forms.CharField(
        label='确认密码',
        widget=forms.PasswordInput(render_value=True))
    class Meta:
        model = models.Admin
        exclude = ['username']
        labels = {
            'password': '新密码',
        }
        widgets = {'password': forms.PasswordInput(render_value=True)}
    def clean_password(self):
        password = self.cleaned_data['password']
        return md5(password)
    def clean_confirm_password(self):
        password = self.cleaned_data['password']
        confirm_password = md5(self.cleaned_data['confirm_password'])
        if password != confirm_password:
            raise ValidationError('密码不一致')
        return confirm_password
def admin_edit(request, nid):
    title = '编辑管理员'
    if request.method == "GET":
        form = AdminEditModelForm()
        return render(request, 'register_edit.html', {'form': form, 'title': title})
    if request.method == "POST":
        form = AdminEditModelForm(request.POST, instance=models.Admin.objects.get(id=nid))
        if form.is_valid():
            form.save()
            return redirect('/admin/info/')
        else:
            return render(request, 'register_edit.html', {'form': form, 'title': title})

def admin_delete(request, nid):
    models.Admin.objects.get(id=nid).delete()
    return redirect('/admin/info/')
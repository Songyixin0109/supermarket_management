from django.shortcuts import render, redirect
from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator
from django.utils.safestring import mark_safe
from django import forms
from django.contrib.auth.hashers import make_password

from OnlineShop import models
from OnlineShop.models import EmployeeInfo
from OnlineShop.utils.bootstrap import BootStrapModelForm
from OnlineShop.utils.encrypt import md5
from OnlineShop.utils.pagination import Pagination

# Create your views here.
def employee_info(request):
    title='员工信息'
    data_dict={}
    search_data = request.GET.get('search_data','')
    print(search_data)
    if search_data:
        data_dict['employeename__contains'] = search_data
    queryset = models.EmployeeInfo.objects.filter(**data_dict)
    page_object=Pagination(request,queryset)
    context = {'employee_list': page_object.page_queryset,
               'title':title,
               'search_data':search_data,
               'page_string':page_object.html()}
    return render(request, 'employee/employee_info.html', context)
class EmployeeInfoModelForm(BootStrapModelForm):
    confirm_password = forms.CharField(
        label='确认密码',
        widget=forms.PasswordInput(render_value=True)
        )
    phone = forms.CharField(
        label='电话号码',
        validators=[
            RegexValidator(
                regex=r'^1[3-9]\d{9}$',
                message='手机号码格式错误')
        ])
    class Meta:
        model = models.EmployeeInfo
        fields = ['employeename', 'password',  'gender', 'phone', 'position']
        labels = {
            'employeename': '员工名',
            'password': '密码',
            'gender': '性别',
            'phone': '电话',
            'position': '部门',
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
    def clean_employeename(self):
        employeename = self.cleaned_data.get('employeename')
        exist = models.EmployeeInfo.objects.filter(employeename=employeename).exists()
        if exist:
            raise ValidationError("用户名已存在")
        return employeename
def employee_register(request):
    title='新建员工'
    if request.method == "GET":
        form = EmployeeInfoModelForm()
        return render(request, 'register_edit.html', {'form': form, 'title':title })
    if request.method == "POST":
        form = EmployeeInfoModelForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/')
        else:
            return render(request, 'register_edit.html', {'form': form, 'title': title})
class EmployeeInfoEditModelForm(BootStrapModelForm):
    class Meta:
        model = models.EmployeeInfo
        exclude = 'employeename',
        labels = {
            'password': '密码',
            'gender': '性别',
            'phone': '电话',
            'position': '部门',
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
def employee_edit(request, nid):
    title='编辑员工'
    if request.method == "GET":
        form = EmployeeInfoEditModelForm(instance=models.EmployeeInfo.objects.get(id=nid))
        return render(request, 'register_edit.html', {'form': form,'title':title})
    if request.method == "POST":
        form = EmployeeInfoEditModelForm(request.POST, instance=models.EmployeeInfo.objects.get(id=nid))
        if form.is_valid():
            form.save()
            return redirect('/employee/info/')
        else:
            return render(request, 'register_edit.html', {'form': form,'title':title})
def employee_delete(request, nid):
    models.EmployeeInfo.objects.get(id=nid).delete()
    return redirect('/employee/info/')


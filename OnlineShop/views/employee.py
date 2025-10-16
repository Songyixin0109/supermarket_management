from django.shortcuts import render, redirect
from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator
from django import forms
from django.db.models import Q

from OnlineShop import models
from OnlineShop.utils.bootstrap import BootStrapModelForm
from OnlineShop.utils.encrypt import md5
from OnlineShop.utils.pagination import Pagination

def employee_info(request):
    title='员工信息'

    search_data = request.GET.get('search_data','').strip()
    queryset = models.EmployeeInfo.objects.all() 
    if search_data:
        queryset = queryset.filter(
            Q(id__icontains=search_data) |
            Q(employee_name__icontains=search_data)
        )
    page_object=Pagination(request,queryset)
    context = {
        'employee_list': page_object.page_queryset,
        'title':title,
        'search_data':search_data,
        'page_string':page_object.html()
        }
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
        fields = ['employee_name', 'password',  'gender', 'phone', 'date','position']
        labels = {
            'employee_name': '员工名',
            'password': '密码',
            'gender': '性别',
            'phone': '电话',
            'date': '入职日期',
            'position': '职位',
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
        employee_name = self.cleaned_data.get('employee_name')
        exist = models.EmployeeInfo.objects.filter(employee_name=employee_name).exists()
        if exist:
            raise ValidationError("用户名已存在")
        return employee_name
def employee_register(request):
    title='新建员工'
    if request.method == "GET":
        form = EmployeeInfoModelForm()
        return render(request, 'register_edit.html', {'form': form, 'title':title })
    if request.method == "POST":
        form = EmployeeInfoModelForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/admin/info/')
        else:
            return render(request, 'register_edit.html', {'form': form, 'title': title})
class EmployeeInfoEditModelForm(BootStrapModelForm):
    employee_name = forms.CharField(label='员工名',  disabled=True)
    phone = forms.CharField(
    label='电话号码',
    validators=[
        RegexValidator(
            regex=r'^1[3-9]\d{9}$',
            message='手机号码格式错误')
    ])
    class Meta:
        model = models.EmployeeInfo
        fields = ['employee_name', 'gender', 'phone', 'position']
        labels = {
            'employee_name': '员工名',
            'gender': '性别',
            'phone': '电话',
            'position': '职位',
        }
def employee_edit(request, nid):
    row_data = models.EmployeeInfo.objects.filter(id=nid).first()
    if not row_data:
        return redirect('/employee/info/')
    title='编辑员工'
    if request.method == "GET":
        form = EmployeeInfoEditModelForm(instance=row_data)
        return render(request, 'register_edit.html', {'form': form,'title':title})
    if request.method == "POST":
        form = EmployeeInfoEditModelForm(request.POST, instance=row_data)
        if form.is_valid():
            form.save()
            return redirect('/employee/info/')
        else:
            return render(request, 'register_edit.html', {'form': form,'title':title})
def employee_delete(request, nid):
    models.EmployeeInfo.objects.get(id=nid).delete()
    return redirect('/employee/info/')

class EmployeeResetModelForm(BootStrapModelForm):
    confirm_password = forms.CharField(
        label='确认密码',
        widget=forms.PasswordInput(render_value=True))
    class Meta:
        model = models.EmployeeInfo
        fields = ['password']
        labels = {
            'password': '新密码',
        }
        widgets = {'password': forms.PasswordInput(render_value=True)}
    def clean_password(self):
        password = self.cleaned_data['password']
        if len(password) < 8:
            raise ValidationError("密码长度至少8位")
        if not any(char.islower() for char in password):
            raise ValidationError("密码必须包含至少一个小写字母")
        if not any(char.isupper() for char in password):
            raise ValidationError("密码必须包含至少一个大写字母")
        md5_pwd = md5(password)
        exists = models.Admin.objects.filter(id=self.instance.pk, password=md5_pwd).exists()
        if exists:
            raise ValidationError("新密码不能与原密码相同")
        return md5_pwd
    def clean_confirm_password(self):
        password = self.cleaned_data.get('password') 
        confirm_password = md5(self.cleaned_data['confirm_password'])
        if password != confirm_password:
            raise ValidationError('密码不一致')
        return confirm_password
    
def employee_reset(request, nid):
    row_data = models.EmployeeInfo.objects.filter(id=nid).first()
    if not row_data:
        return redirect('/employee/info/')
    title = '重置密码 - {}'.format(row_data.employee_name)
    if request.method == "GET":
        form = EmployeeResetModelForm()
        return render(request, 'register_edit.html', {'form': form, 'title': title})
    if request.method == "POST":
        form = EmployeeResetModelForm(request.POST, instance=row_data)
        if form.is_valid():
            form.save()
            return redirect('/employee/info/')
        else:
            return render(request, 'register_edit.html', {'form': form, 'title': title})

from django.shortcuts import render,HttpResponse,redirect
from django import forms

from OnlineShop import models

from OnlineShop.utils.bootstrap import BootStrapForm
from OnlineShop.utils.encrypt import md5

class AdminLoginForm(BootStrapForm):
    username = forms.CharField(label='用户名',widget=forms.TextInput,required=True)
    password = forms.CharField(label='密码',widget=forms.PasswordInput(render_value=True),required=True)

    def clean_password(self):
        password = self.cleaned_data.get('password')
        return md5(password)
def admin_login(request):
    if request.method == 'GET':
        form = AdminLoginForm()
        return render(request, 'login.html', {'form':form})
    if request.method == 'POST':
        form = AdminLoginForm(request.POST)
        if form.is_valid():
            admin_object=models.Admin.objects.filter(**form.cleaned_data).first()
            if admin_object:
                request.session['info'] = {'id':admin_object.id,'username':admin_object.username}
                return redirect('/admin/info/')
            else:
                form.add_error('password','用户名或密码错误')
                return render(request, 'login.html', {'form':form})
        else:
            return render(request, 'login.html', {'form':form})

class UserLoginForm(BootStrapForm):
    username = forms.CharField(label='用户名', widget=forms.TextInput, required=True)
    password = forms.CharField(label='密码', widget=forms.PasswordInput(render_value=True), required=True)

    def clean_password(self):
        password = self.cleaned_data.get('password')
        return md5(password)

def user_login(request):
    if request.method == 'GET':
        form = UserLoginForm()
        return render(request, 'login.html', {'form': form})
    if request.method == 'POST':
        form = UserLoginForm(request.POST)
        if form.is_valid():
            user_object = models.UserInfo.objects.filter(**form.cleaned_data).first()
            if user_object:
                request.session['info'] = {'id': user_object.id, 'username': user_object.username}
                return redirect('/user/index/')
            else:
                form.add_error('password', '用户名或密码错误')
                return render(request, 'login.html', {'form': form})
        else:
            return render(request, 'login.html', {'form': form})
def logout(request):
    request.session.clear()
    return redirect('/')
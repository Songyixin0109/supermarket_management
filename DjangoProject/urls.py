"""
URL configuration for DjangoProject project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
# from django.contrib import admin
from django.urls import path
from OnlineShop import view
from OnlineShop.views import user, admin, employee,account, order, inventory, merchant

urlpatterns = [
    #    path('admin/', admin.site.urls),
    path('', view.welcome, name='welcome'),
    path('welcome/',view.welcome_in,name='welcome_in'),
    #用户管理
    path('user/info/', user.user_info, name='user_info'),
    path('user/register/',user.user_register, name='user_registration'),
    path('user/edit/<int:nid>/',user.user_edit,name='user_edit'),
    path('user/delete/<int:nid>/',user.user_delete,name='user_delete'),
    path('user/reset/<int:nid>/',user.user_reset,name='user_reset'),
    # path('user/index/',user.user_index,name='user_index'),

    #管理员管理
    path('admin/info/', admin.admin_info, name='admin_info'),
    path('admin/register/',admin.admin_register, name='admin_registration'),
    path('admin/reset/<int:nid>/',admin.admin_reset,name='admin_reset'),
    path('admin/delete/<int:nid>/',admin.admin_delete,name='admin_delete'),

    #员工管理
    path('employee/info/', employee.employee_info, name='employee_info'),
    path('employee/register/',employee.employee_register, name='employee_registration'),
    path('employee/edit/<int:nid>/',employee.employee_edit,name='employee_edit'),
    path('employee/delete/<int:nid>/',employee.employee_delete,name='employee_delete'),
    path('employee/reset/<int:nid>/',employee.employee_reset,name='employee_reset'),
    
    #登录注销
    path('admin/login/',account.admin_login,name='admin_login'),
    path('user/login/',account.user_login,name='user_login'),
    path('employee/login/',account.employee_login,name='employee_login'),
    path('image/code/',account.image_code,name='image_code'),
    path('logout/',account.logout,name='logout'),

    #订单管理
    path('sellorder/info/admin/',order.sellorder_info_admin, name='sellorder_info_admin'),
    path('sellorder/info/user/',order.sellorder_info_user, name='sellorder_info_user'),
    path('sellorder/add/',order.sellorder_add, name='sellorder_add'),
    path('sellorder/admin/edit/<int:nid>/', order.sellorder_admin_edit, name='sellorder_admin_edit'),
    path('sellorder/delete/user/<int:nid>/',order.sellorder_delete_user, name='sellorder_delete_user'),
    path('purchaseorder/info/',order.purchaseorder_info, name='purchaseorder_info'),
    path('purchaseorder/upload/',order.purchase_order_upload, name='purchaseorder_upload'),
    path('purchase/admin/edit/<int:nid>/', order.purchase_admin_edit, name='purchase_admin_edit'),

    #库存管理
    path('inventory/info/admin/', inventory.inventory_info_admin, name='inventory_info_admin'),
    path('inventory/info/user/', inventory.inventory_info_user, name='inventory_info_user'),
    path('inventory/delete/<int:nid>/',inventory.inventory_delete,name='inventory_delete'),
    path('inventory/statistics/',inventory.inventory_statistics, name='inventory_statistics'),
    path('inventory/chart/',inventory.inventory_chart, name='inventory_chart'),
    # path('inventory/upload/',inventory.inventory_upload,name='inventory_upload'),

    #商家管理
    path('merchant/info/', merchant.merchant_info, name='merchant_info'),
    path('merchant/add/', merchant.merchant_add, name='merchant_add'),
    path('merchant/edit/<int:nid>/', merchant.merchant_edit, name='merchant_edit'),
    path('merchant/delete/<int:nid>/', merchant.merchant_delete, name='merchant_delete'),
]

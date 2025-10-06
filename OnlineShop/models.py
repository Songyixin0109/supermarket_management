# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
from django.core.validators import MinValueValidator


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class EmployeeInfo(models.Model):
    GENDER_CHOICES = (
        ('M', '男'),
        ('F', '女')
        )
    employeename = models.CharField('员工名', max_length=16, unique=True)
    password = models.CharField('密码', max_length=32)
    gender = models.CharField('性别', max_length=1, choices=GENDER_CHOICES,default='F')
    phone = models.CharField('电话号码', max_length=20)
    position = models.CharField('部门',max_length=16, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'employee_info'


class InventoryItems(models.Model):
    """库存商品"""
    items_name = models.CharField('商品名', max_length=100)
    description = models.TextField('描述', blank=True, null=True)
    category = models.CharField('类别', max_length=255)
    sell_price = models.DecimalField('价格', max_digits=10, decimal_places=2,validators=[MinValueValidator(0)])
    Inventory_quantity = models.IntegerField('库存数量', validators=[MinValueValidator(0)])

    class Meta:
        # managed = False
        db_table = 'inventory_items'

    def __str__(self):
        return self.name

class MerchantInfo(models.Model):
    """商家"""
    merchant_name = models.CharField('商家名称',max_length=32)
    phone = models.CharField('联系电话',max_length=16)
    email = models.CharField('联系邮箱',max_length=32, blank=True, null=True)
    address = models.CharField('联系地址',max_length=255)

    class Meta:
        # managed = False
        db_table = 'merchant_info'


class MerchantItems(models.Model):
    id = models.IntegerField(primary_key=True)
    merchant = models.ForeignKey(MerchantInfo, models.DO_NOTHING)
    purchase_items = models.ForeignKey('PurchaseItems', models.DO_NOTHING)
    purchase_price = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        # managed = False
        db_table = 'merchant_items'


class PurchaseItems(models.Model):
    name = models.CharField(max_length=32, blank=True, null=True)
    description = models.CharField(max_length=255, blank=True, null=True)
    catalog = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'purchase_items'


class PurchaseOrders(models.Model):
    merchant_items = models.ForeignKey(MerchantItems, models.DO_NOTHING)
    purchase_quantity = models.IntegerField()
    employee = models.ForeignKey(EmployeeInfo, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'purchase_orders'


class SellOrders(models.Model):
    user = models.ForeignKey('UserInfo', models.DO_NOTHING)
    inventory_items = models.ForeignKey(InventoryItems, models.DO_NOTHING)
    order_quantity = models.IntegerField()
    order_date =  models.TimeField(blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'sell_orders'


class UserInfo(models.Model):
    """用户"""
    GENDER_CHOICES = (
        ('M', '男'),
        ('F', '女')
        )
    username = models.CharField('用户名', max_length=16, unique=True)
    password = models.CharField('密码', max_length=32)
    name = models.CharField('姓名', max_length=32, blank=True, null=True)
    gender = models.CharField('性别', max_length=1, choices=GENDER_CHOICES,default='F')
    phone = models.CharField('电话号码', max_length=20)
    email = models.EmailField('邮箱', blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'user_info'
    def __str__(self):
        return self.username

class Admin(models.Model):
    username = models.CharField(max_length=32)
    password = models.CharField(max_length=32)

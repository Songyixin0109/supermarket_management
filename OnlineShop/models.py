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
    employee_name = models.CharField('员工名', max_length=16, unique=True)
    password = models.CharField('密码', max_length=32)
    gender = models.CharField('性别', max_length=1, choices=GENDER_CHOICES,default='F')
    phone = models.CharField('电话号码', max_length=20)

    position_choices = (
        (1,'销售员'),
        (2,'经理'),
        (3,'会计'),
        (4,'采购员'),
        (5,'技术员'),
        (6,'售后'),
        (7,'其他') #仓库管理员
    )

    position = models.SmallIntegerField('职位',choices=position_choices,default=1)
    

    class Meta:
        # managed = False
        db_table = 'employee_info'


class MerchantInfo(models.Model):
    """商家"""
    merchant_name = models.CharField('商家名称',max_length=32)
    phone = models.CharField('联系电话',max_length=16)
    email = models.CharField('联系邮箱',max_length=32, blank=True, null=True)
    address = models.CharField('联系地址',max_length=255)

    class Meta:
        # managed = False
        db_table = 'merchant_info'

class PurchaseItems(models.Model):
    """商品描述"""
    name = models.CharField('商品名称',max_length=32, unique=True)
    description = models.CharField('商品描述',max_length=255, blank=True, null=True)
    catalog = models.CharField('分类',max_length=255, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'purchase_items'


class MerchantItems(models.Model):
    """商家商品"""
    merchant = models.ForeignKey(MerchantInfo, on_delete=models.CASCADE)
    merchant_items = models.ForeignKey(PurchaseItems,on_delete=models.CASCADE,related_name='merchant_items_set' )
    merchant_price = models.DecimalField('进货价',max_digits=10, decimal_places=2)

    class Meta:
        # managed = False
        db_table = 'merchant_items'


class InventoryItems(models.Model):
    """库存商品"""
    items_name = models.ForeignKey(PurchaseItems, on_delete=models.CASCADE)
    sell_price = models.DecimalField('销售价', max_digits=10, decimal_places=2,validators=[MinValueValidator(0)])
    Inventory_quantity = models.IntegerField('库存数量', validators=[MinValueValidator(0)])

    class Meta:
        # managed = False
        db_table = 'inventory_items'

    def __str__(self):
        return self.items_name


class PurchaseOrders(models.Model):
    merchant_items = models.ForeignKey(
        MerchantItems,
        on_delete=models.SET_NULL,   
        null=True, blank=True
    )
    purchase_quantity = models.IntegerField('进货数量', validators=[MinValueValidator(0)])
    employee = models.ForeignKey(
        EmployeeInfo,
        on_delete=models.SET_NULL,
        null=True, blank=True
    )

    STATUS_CHOICES = (
        (1, '待入库'),
        (2, '已入库'),
        (3, '已取消'),  
    )
    status = models.PositiveSmallIntegerField('状态', choices=STATUS_CHOICES, default=1)

    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    updated_at = models.DateTimeField('更新时间', auto_now=True)

    class Meta:
        db_table = 'purchase_orders'


class SellOrders(models.Model):
    user = models.ForeignKey('UserInfo', on_delete=models.SET_NULL, null=True, blank=True)
    inventory_items = models.ForeignKey(InventoryItems, on_delete=models.SET_NULL, null=True, blank=True)
    order_quantity = models.IntegerField()
    order_date =  models.DateTimeField('创建时间', auto_now_add=True)

    status_choices = (
        (1,'未完成'),
        (2,'已完成'),
        (3,'已取消')
    )

    status = models.SmallIntegerField('状态',choices=status_choices,default=1)

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

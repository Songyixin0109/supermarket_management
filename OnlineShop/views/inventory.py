from django.shortcuts import render, redirect
from django.db.models import Prefetch,Q
from django.http import JsonResponse

from OnlineShop import models
from OnlineShop.models import MerchantItems,InventoryItems
from OnlineShop.views.order import SellOrderAddModelForm
from OnlineShop.utils.pagination import Pagination
from OnlineShop.utils.bootstrap import BootStrapModelForm

class InventoryItemsInfoModelForm(BootStrapModelForm):
    class Meta:
        model = models.InventoryItems
        fields = '__all__'

def inventory_info_admin(request):
    search_data = request.GET.get('search_data', '').strip()

    queryset = InventoryItems.objects.select_related('items_name').prefetch_related(
        Prefetch(
            'items_name__merchant_items_set',
            queryset=MerchantItems.objects.select_related('merchant')
        )
    )

    if search_data:         
        queryset = queryset.filter(
            Q(id__icontains=search_data) |
            Q(items_name__name__icontains=search_data)
        )

    page_object = Pagination(request, queryset)
    context = {
        'inventory_items': page_object.page_queryset,
        'title': '库存商品',
        'search_data': search_data,
        'page_string': page_object.html(),
    }
    return render(request, 'inventory/inventory_info_admin.html', context)


def inventory_info_user(request):
    search_data = request.GET.get('search_data', '').strip()

    queryset = InventoryItems.objects.select_related('items_name').prefetch_related(
        Prefetch(
            'items_name__merchant_items_set',
            queryset=MerchantItems.objects.select_related('merchant')
        )
    )

    if search_data:          # 同上
        queryset = queryset.filter(
            Q(id__icontains=search_data) |
            Q(items_name__name__icontains=search_data)
        )

    page_object = Pagination(request, queryset)
    sell_form = SellOrderAddModelForm()
    context = {
        'inventory_items': page_object.page_queryset,
        'title': '商品列表',
        'search_data': search_data,
        'page_string': page_object.html(),
        'sell_form': sell_form, 
    }
    return render(request, 'inventory/inventory_info_user.html', context)
    

def inventory_delete(request, nid):
    models.InventoryItems.objects.get(id=nid).delete()
    return redirect('/inventory/info/admin/')

def inventory_statistics(request):
    title='数据统计'
    if request.method == 'GET':
        return render(request,'inventory/inventory_statistics.html',{'title':title})

from django.db.models import Sum, F
from django.http import JsonResponse

def inventory_chart(request):
    # ---------- 1. 柱状图：销量占比 ----------
    sale_data = (models.SellOrders.objects
                 .values('inventory_items__items_name__name')
                 .annotate(total_qty=Sum('order_quantity'))
                 .order_by('-total_qty')[:10])
    bar_legend = ['销量']
    bar_x = [d['inventory_items__items_name__name'] or '未知商品' for d in sale_data]
    bar_series = [{
        'name': '销量',
        'type': 'bar',
        'data': [d['total_qty'] for d in sale_data]
    }]

    # ---------- 2. 折线图：销售价 ----------
    price_data = (InventoryItems.objects
                  .select_related('items_name')
                  .values('items_name__name')
                  .annotate(price=Sum('sell_price'))
                  .order_by('items_name__name')[:10])
    line_legend = ['销售价']
    line_x = [d['items_name__name'] for d in price_data]
    line_series = [{
        'name': '销售价',
        'type': 'line',
        'data': [float(d['price']) for d in price_data]
    }]

    # ---------- 3. 饼图：种类库存量占比 ----------
    catalog_qty = (InventoryItems.objects
                   .values('items_name__catalog')
                   .annotate(total_qty=Sum('inventory_quantity'))
                   .order_by('-total_qty'))
    pie_legend = [d['items_name__catalog'] or '未分类' for d in catalog_qty]
    pie_series = [{
        'name': '库存量',
        'type': 'pie',
        'radius': '60%',
        'data': [{'value': d['total_qty'], 'name': d['items_name__catalog'] or '未分类'}
                 for d in catalog_qty]
    }]

    return JsonResponse({
        'status': True,
        'bar': {'legend': bar_legend, 'x_axis': bar_x, 'series': bar_series},
        'line': {'legend': line_legend, 'x_axis': line_x, 'series': line_series},
        'pie': {'legend': pie_legend, 'series': pie_series}
    })

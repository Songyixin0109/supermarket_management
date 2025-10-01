"""
在视图函数中：
    def user_info(request):
    1.筛选数据
    queryset = models.UserInfo.objects.all()
    2.实例化分页对象
    page_object=Pagination(request,queryset)

        context = {
        'user_list': page_object.page_queryset,  #分完页的数据
        'page_string':page_object.html()         #生成页码
        }
        return render(request, 'user/user_info.html', context)
在html中：
    {% for obj in user_list %}

    {% endfor %}

    <ul class="pagination">
        {{ page_string }}
    </ul>
"""

from django.utils.safestring import mark_safe
class Pagination(object):

    def __init__(self,request,queryset,page_size=10,page_param='page',plus = 5):
        """

        :param request: 请求对象
        :param queryset:符合条件的数据
        :param page_size:每页显示数据条数
        :param page_param:在url中获取分页的参数，如/user/info/?page=1
        :param plus:前后页码数
        """
        page = int(request.GET.get(page_param, '1'))
        # if page.is_integer():
        #     page = int(page)
        # else:
        #     page = 1
        self.page = page
        self.page_size = page_size
        self.start = (page - 1) * page_size
        self.end = page * page_size

        self.page_queryset = queryset[self.start:self.end]

        total_count = queryset.count()
        total_page_count,div =divmod(total_count,page_size)
        if div:
            total_page_count+=1
        self.total_page_count=total_page_count
        self.plus = plus
    def html(self):

        if (self.page - self.plus) > 0:
            start_page = self.page - self.plus
        else:
            start_page = 1
        if (self.page + self.plus) < self.total_page_count:
            end_page = self.page + self.plus
        else:
            end_page = self.total_page_count

        page_str_list = []
        page_str_list.append('<li ><a href="?page={}">首页</a></li>'.format(1))
        if self.page > 1:
            prev = '<li ><a href="?page={}">上一页</a></li>'.format(self.page - 1)
        else:
            prev = '<li ><a href="?page={}">上一页</a></li>'.format(1)
        page_str_list.append(prev)

        for i in range(start_page, end_page + 1):
            if i == self.page:
                ele = '<li class="active"><a href="?page={}">{}</a></li>'.format(i, i)
            else:
                ele = '<li><a href="?page={}">{}</a></li>'.format(i, i)
            page_str_list.append(ele)

        if self.page < self.total_page_count:
            next = '<li ><a href="?page={}">下一页</a></li>'.format(self.page + 1)
        else:
            next = '<li ><a href="?page={}">下一页</a></li>'.format(self.total_page_count)
        page_str_list.append(next)
        page_str_list.append('<li ><a href="?page={}">尾页</a></li>'.format(self.total_page_count))

        search_string = """<li>
                            <div style="float: right;width: 100px">
                                <form method="get">
                                    <div class="input-group">
                                        <input type="text" name="page" class="form-control" ">
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="submit">跳转</button>
                                        </span>
                                    </div>
                                </form>
                            </div>
                        </li>"""
        page_str_list.append(search_string)

        page_string = mark_safe(''.join(page_str_list))
        return page_string
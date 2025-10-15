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
        :param queryset:符合条件的数据（根据这个数据给他进行分页处理）
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
        self.request = request
        self.page_param = page_param  # 保存页码参数名
        
        # 创建查询参数的副本并移除当前页码
        self.query_dict = request.GET.copy()
        if self.page_param in self.query_dict:
            self.query_dict.pop(self.page_param)


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
        
        # 首页
        self.query_dict.setlist(self.page_param, [1])
        page_str_list.append('<li><a href="?{}">首页</a></li>'.format(self.query_dict.urlencode()))
        
        # 上一页
        prev_page = self.page - 1 if self.page > 1 else 1
        self.query_dict.setlist(self.page_param, [prev_page])
        page_str_list.append('<li><a href="?{}">上一页</a></li>'.format(self.query_dict.urlencode()))

        # 页码
        for i in range(start_page, end_page + 1):
            self.query_dict.setlist(self.page_param, [i])
            if i == self.page:
                ele = '<li class="active"><a href="?{}">{}</a></li>'.format(self.query_dict.urlencode(), i)
            else:
                ele = '<li><a href="?{}">{}</a></li>'.format(self.query_dict.urlencode(), i)
            page_str_list.append(ele)

        # 下一页
        next_page = self.page + 1 if self.page < self.total_page_count else self.total_page_count
        self.query_dict.setlist(self.page_param, [next_page])
        page_str_list.append('<li><a href="?{}">下一页</a></li>'.format(self.query_dict.urlencode()))
        
        # 尾页
        self.query_dict.setlist(self.page_param, [self.total_page_count])
        page_str_list.append('<li><a href="?{}">尾页</a></li>'.format(self.query_dict.urlencode()))

        # 跳转表单
        search_string = """<li>
                        <div style="float: right;width: 100px">
                            <form method="get">
                                <div class="input-group">
                                    <input type="text" 
                                            name="{}" 
                                            style="position: relative; float:left;display: inline-block;width: 60px;margin-right: 1px" 
                                            class="form-control" placeholder="页码">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="submit">跳转</button>
                                    </span>
                                </div>
                            </form>
                        </div>
                    </li>""".format(self.page_param)
        page_str_list.append(search_string)

        page_string = mark_safe(''.join(page_str_list))
        return page_string
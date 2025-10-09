from django.shortcuts import render
# Create your views here.
def index(request):
    return render(request, 'index.html')

def welcome(request):
    return render(request, 'welcome.html')

def welcome_in(request):
    title='欢迎页'
    return render(request, 'welcome_in.html', {'title':title})



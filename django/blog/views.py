from django.shortcuts import render
from .models import post #database를 가져오라는 명령

# Create your views here.
def index(request):

    posts = post.objects.all()  #post에 있는 내용을 다 뿌려라

    return render(
        request,
        'blog/index.html',
        {
            'posts' : posts,
        }
    )
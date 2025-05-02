# from django.shortcuts import render
from django.views.generic import ListView, DetailView
from .models import Post #database를 가져오라는 명령

class PostList(ListView):
    model = Post
    template_name = 'blog/index.html'
    ordering = '-pk'

class PostDetail(DetailView):
    model = Post

# Create your views here.
# def index(request):

#     posts = Post.objects.all().order_by('-pk')  #post에 있는 내용을 다 뿌려라

#     return render(
#         request,
#         'blog/index.html',
#         {
#             'posts' : posts,
#         }
#     )

# def single_post_page(request, pk):
#     post = Post.objects.get(pk=pk)

#     return render(
#         request,
#         'blog/single_post_page.html',
#         {
#             'post' : post,
#         }
#     )


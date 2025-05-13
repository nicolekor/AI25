from django.db import models
from django.contrib.auth.models import User
import os

# Create your models here.

class Post(models.Model):
    title = models.CharField(max_length=30)
    hook_text = models.CharField(max_length=100, blank=True)
    content = models.TextField()


    #blank true 는 값을 입력하지 않아도 공백을 인정해주는 것
    head_image = models.ImageField(upload_to='blog/images/%Y/%m/%d/', blank=True) 
    file_upload = models.FileField(upload_to='blog/files/%Y/%m/%d/', blank=True)

    created_at = models.DateTimeField(auto_now_add=True)  #작성일자
    updated_at = models.DateTimeField(auto_now=True)

    # author : 250513 p295까지 완료
    author = models.ForeignKey(User, null=True, on_delete=models.SET_NULL)

    def __str__(self):
        return f'[{self.pk}]{self.title} :: {self.author}'
    
    def get_absolute_url(self):  #blog 게시글 상세 페이지에서 view on site 버튼 생성
        return f'/blog/{self.pk}/'
    
    def get_file_name(self):
        return os.path.basename(self.file_upload.name)
    
    def get_file_ext(self):
        return self.get_file_name().split('.')[-1]


# 모델 수정할 때 마다 migration 작업을 해야됌 
# pip install pillow : imagefield 명령어(11줄)를 실행시키기 위해 필요함
# p214
# 터미널에서 pip install Pillow - python manage.py makemigrations - python manage.py migrate 순서로 진행


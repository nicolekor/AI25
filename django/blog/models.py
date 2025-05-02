from django.db import models

# Create your models here.

class Post(models.Model):
    title = models.CharField(max_length=30)
    content = models.TextField()

    created_at = models.DateTimeField(auto_now_add=True)  #작성일자
    updated_at = models.DateTimeField(auto_now=True)

    # author : 추후 작성 예정

    def __str__(self):
        return f'[{self.pk}]{self.title}'
    
    def get_absolute_url(self):  #blog 게시글 상세 페이지에서 view on site 버튼 생성
        return f'/blog/{self.pk}/'
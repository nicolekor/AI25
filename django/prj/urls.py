
from django.contrib import admin
from django.urls import path, include

from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('blog/', include('blog.urls')),
    path('admin/', admin.site.urls),
    path('', include('single_pages.urls')), # 기본 도메인 주소를 띄었을 때 나타나는 내용을 싱글페이지로 지정함
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
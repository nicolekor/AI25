from django.test import TestCase, Client
from bs4 import BeautifulSoup
from .models import Post


# Create your tests here.
class TestView(TestCase):
    def setUp(self):
        self.client = Client()

    def navbar_test(self, soup):
        navbar = soup.nav
        self.assertIn('Blog', navbar.text)
        self.assertIn('About Me', navbar.text)

        logo_btn = navbar.find('a', text = 'My Django')
        self.assertEqual(logo_btn.attrs['href'], '/')

        home_btn = navbar.find('a', text = 'Home')
        self.assertEqual(home_btn.attrs['href'], '/')

        blog_btn = navbar.find('a', text = 'Blog')
        self.assertEqual(blog_btn.attrs['href'], '/blog/')

        about_me_btn = navbar.find('a', text = 'About Me')
        self.assertEqual(about_me_btn.attrs['href'], '/about_me/')

        
    
    def test_post_list(self):
        # 1.1. 포스트 목록 페이지 가져옴
        response = self.client.get('/blog/')
        # 1.2. 정상적으로 페이지 로드
        self.assertEqual(response.status_code, 200)
        # 1.3. 페이지 타이틀은 'Blog'다 
        soup = BeautifulSoup(response.content, 'html.parser') 
        self.assertEqual(soup.title.text.strip(), 'Blog')
        # 1.4. 내비게이션 바가 있다
        # navbar = soup.nav
        # # 1.5. Blog, About Me 라는 문구가 내비게이션 바에 있다
        # self.assertIn('Blog', navbar.text)
        # self.assertIn('About Me', navbar.text)
        self.navbar_test(soup)   #p278

        # 2.1. 포스트(게시물)가 하나도 없다면
        self.assertEqual(Post.objects.count(), 0)
        # 2.2. main area에 '아직 게시물이 없습니다'라는 문구가 나타남
        main_area = soup.find('div', id='main-area')
        self.assertIn('아직 게시물이 없습니다.', main_area.text)

        # 3.1. 포스트가 2개 있다면
        post_001 = Post.objects.create(
            title = '첫 번째 포스트 입니다.', 
            content = 'Hello World. We are the world.',
        )
        post_002 = Post.objects.create(
            title = '두 번째 포스트 입니다.', 
            content = '1등이 전부는 아니잖아.',
        )
        self.assertEqual(Post.objects.count(), 2)

        # 3.2. 포스트 목록 페이지 새로고침 할때
        response = self.client.get('/blog/')
        soup = BeautifulSoup(response.content, 'html.parser')
        self.assertEqual(response.status_code, 200)
        # 3.3. main area에 포스트 2개의 제목이 존재한다
        main_area = soup.find('div', id='main-area')
        self.assertIn(post_001.title, main_area.text)
        self.assertIn(post_002.title, main_area.text)

        # 3.4. '아직 게시물이 없습니다'라는 문구는 더이상 나타나지 않는다.
        self.assertNotIn('아직 게시물이 없습니다', main_area.text)

def test_post_detail(self):
    #1.1 Post가 하나 있다
    post_001 = Post.objects.create(
        title = '첫번째 포스트',
        content = 'Hello World. We are the world',
    )
    #1.2 그 포스트의  url 은 'blog/1/'이다
    self.assertEqual(post_001.get_absolute_url(), '/blog/1/')

    #2. 첫번째 포스트의 상세 페이지 테스트
    #2.1 첫번째 post url로 접근하면 정상적으로 작동한다(status code: 200)
    response = self.client.get(post_001.get_absolute_url())
    self.assertEqual(response.status_code, 200)
    soup = BeautifulSoup(response.content, 'html.parser')

    #2.2 포스트 목록 페이지와 똑같은 내비게이션 바가 있다
    # navbar = soup.nav
    # self.assertIn('Blog', navbar.text)
    # self.assertIn('About Me', navbar.text)
    self.navbar_test(soup) #279


    #2.3 첫번째 포스트의 제목이 웹브라우저탭 타이틀에 들어있따.
    self.assertIn(post_001.title, soup.title.text)

    #2.4 첫번째 포스트의 제목이 포스트 영역
    main_area = soup.find('div', id='main-area')
    post_area = main_area.find('div', id='post-area')
    self.assertIn(post_001.title, post_area.text)

    #2.5 첫번째 포스트의 작성자가 포스트 영역에 있다
    #아직 작성불가

    #2.6 첫번째 포스트의 내용이 포스트 영역에 있다.
    self.assertIn(post_001.content, post_area.text)
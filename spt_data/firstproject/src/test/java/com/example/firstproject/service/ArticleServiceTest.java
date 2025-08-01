package com.example.firstproject.service;


import com.example.firstproject.dto.ArticleForm;
import com.example.firstproject.entity.Article;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
@Rollback
class ArticleServiceTest {
    @Autowired
    ArticleService articleService;

    @Test
    void index() {
//        1. 예상데이터
        Article a = new Article(1L, "가가가가", "1111");
        Article b = new Article(2L, "나나나나", "2222");
        Article c = new Article(3L, "다다다다", "3333");
        List<Article> expected = new ArrayList<Article>(Arrays.asList(a, b, c));


//        2. 실제 데이터
        List<Article> articles = articleService.index();

//        3. 비교 및 검증  // db에 있는 자료랑 방금 위에서 만든 예상데이터랑 비교해봐라
        assertEquals(expected.toString(), articles.toString());
       
    }

    @Test
    void show_성공_존재하는_id_입력() {
//        1. 예상 데이터
        Long id = 1L;
        Article expected = new Article(id, "가가가가", "1111");

//        2. 실제 데이터
        Article article = articleService.show(id);

//        3. 비교 및 검증
        assertEquals(expected.toString(), article.toString());
    }



    @Test
    void show_실패_존재하지않는_id_입력() {
//        1. 예상 데이터
        Long id = -1L;
        Article expected = null;

//        2. 실제 데이터
        Article article = articleService.show(id);

//        3. 비교 및 검증
        assertEquals(expected, article);
    }

    @Test
    @Transactional
    void create_성공title과content만있는dto입력() {
        //        1. 예상 데이터
        String title = "라라라라";
        String content = "4444";
        ArticleForm dto = new ArticleForm(null, title, content);
        Article expected = new Article(4L, title, content);

//        2. 실제 데이터
        Article article = articleService.create(dto);

//        3. 비교 및 검증
        assertEquals(expected.toString(), article.toString());
    }

    @Test
    @Transactional
    void create_실패id가포함된dto입력() {
        //        1. 예상 데이터
        Long id = 4L;
        String title = "라라라라";
        String content = "4444";
        ArticleForm dto = new ArticleForm(id, title, content);
        Article expected = null;

//        2. 실제 데이터
        Article article = articleService.create(dto);

//        3. 비교 및 검증
        assertEquals(expected, article);

    }
}
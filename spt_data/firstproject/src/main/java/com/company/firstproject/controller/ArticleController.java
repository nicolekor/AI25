package com.company.firstproject.controller;

import com.company.firstproject.dto.ArticleForm;
import com.company.firstproject.entity.Article;
import com.company.firstproject.repository.ArticleRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Optional;

@Slf4j
@Controller
public class ArticleController {
    @Autowired
    private ArticleRepository articleRepository;

    @GetMapping("/articles/new")
    public String newArticleForm() {
        return "articles/new";
    }

    @PostMapping("/articles/create")
    public String createArticle(ArticleForm form) {
        log.info(form.toString());
//        System.out.println(form.toString());
        // 1. DTO
        Article article = form.toEntity();
        log.info(form.toString());
//        System.out.println(article.toString());
        // 2. 리파지터리로 엔티티db로 저장
        Article saved = articleRepository.save(article);
        log.info(form.toString());
//        System.out.println(saved.toString());

        return "";
    }
    @GetMapping("/articles/{id}")
    public String show(@PathVariable Long id, Model model){
        log.info("id = " + id);
//        1. id 조회해 데이터 가져오기
        Optional<Article> articleEntity = articleRepository.findById(id);
//        2. 모델에 데이터 등록
        model.addAttribute("article", articleEntity);
//        3. 뷰 페이지 반환
        return "";
    }
}

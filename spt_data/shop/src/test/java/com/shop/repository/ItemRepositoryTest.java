package com.shop.repository;

import com.shop.constant.ItemSellStatus;
import com.shop.entity.Item;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;


@SpringBootTest
@Transactional
//@TestPropertySource(locations = "classpath:application-test.yml")
class ItemRepositoryTest {

    @Autowired
    private ItemRepository itemRepository;

//    @Test
//    @DisplayName("상품 저장 테스트")
//    public void createItemTest(){
//        for(int i=1; i<=10; i++){
//            Item item = new Item();
//            item.setItemNm("테스트 상품" + i);
//            item.setPrice(10000 + i);
//            item.setItemDetail("테스트 상품 상세 설명" + i);
//            item.setItemSellStatus(ItemSellStatus.SELL);
//            item.setStockNumber(100);
//            item.setRegTime(LocalDateTime.now());
//            item.setUpdateTime(LocalDateTime.now());
//            Item savedItem = itemRepository.save(item);
//
//        }
//    }

    @Test
    @DisplayName("상품 생성 테스트")
    public void createItemTest() {
        Item item = Item.builder()
                .itemNm("테스트 상품")
                .price(10000)
                .stockNumber(100)
                .itemDetail("테스트 상품 상세 설명")
                .itemSellStatus(ItemSellStatus.SELL)
                .regTime(LocalDateTime.now())
                .updateTime(LocalDateTime.now())
                .build();

        System.out.println("==========> item: " + item);
        Item saveItem = itemRepository.save(item);
        System.out.println("==========> savedItem: " + saveItem);
    }



//    public void createItemList(){
//        for(int i=1; i<=10; i++){
//            Item item = new Item();
//            item.setItemNm("테스트 상품" + i);
//            item.setPrice(10000 + i);
//            item.setItemDetail("테스트 상품 상세 설명" + i);
//            item.setItemSellStatus(ItemSellStatus.SELL);
//            item.setStockNumber(100);
//            item.setRegTime(LocalDateTime.now());
//            item.setUpdateTime(LocalDateTime.now());
//            Item savedItem = itemRepository.save(item);
//
//        }
//    }
    // 3.0 버전 (강사님 방식)
    public void createItemList(){
        for(int i=0 ; i < 10 ; i++){
            Item item = Item.builder()
                    .itemNm("테스트 상품" + i)
                    .price(10000 + i)
                    .stockNumber(100 + i)
                    .itemDetail("테스트 상품 상세 설명" + i)
                    .itemSellStatus(ItemSellStatus.SELL)
                    .regTime(LocalDateTime.now())
                    .updateTime(LocalDateTime.now())
                    .build();

            itemRepository.save(item);
        }
    }


    @Test
    @DisplayName("상품명 조회 테스트")
    public void findByItemNmTest(){
        this.createItemTest();
        List<Item> itemList = itemRepository.findByItemNm("테스트 상품1");
        for (Item item : itemList){
            System.out.println(item.toString());
        }
    }

}
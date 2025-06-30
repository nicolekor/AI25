package com.example.springdemo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @GetMapping(value = "/test")
    public UserDto test(){

//        UserDto userDto = new UserDto();
//        userDto.setAge(20);
//        userDto.setName("hoon");
//        아래에 builer 쓴거랑 동일

        UserDto userDto = UserDto.builder()
                .age(20)
                .name("hoon")
                .build();

        return userDto;
    }
}

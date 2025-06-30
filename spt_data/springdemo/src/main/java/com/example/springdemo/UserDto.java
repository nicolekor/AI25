package com.example.springdemo;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Builder
@Getter
@Setter
@ToString
public class UserDto {
    private String name;
    private Integer age;
}

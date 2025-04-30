package com.devsgeek.demo.api.trello.models.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CardModelDTO {
    private String name;
    private String description;
}

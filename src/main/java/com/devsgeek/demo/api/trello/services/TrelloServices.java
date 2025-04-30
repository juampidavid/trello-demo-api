package com.devsgeek.demo.api.trello.services;

import com.devsgeek.demo.api.trello.models.dto.CardModelDTO;
import kong.unirest.HttpResponse;
import kong.unirest.JsonNode;
import kong.unirest.Unirest;
import lombok.NoArgsConstructor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.concurrent.CompletableFuture;

@Service
@NoArgsConstructor
public class TrelloServices {

    @Value("${trello.list.id}")
    private String TRELLO_LIST_ID;

    @Value("${trello.api.key}")
    private String TRELLO_API_KEY;

    @Value("${trello.token}")
    private String TRELLO_TOKEN;

    @Async
    public void Post(CardModelDTO card) {

        System.out.println(TRELLO_LIST_ID);

        HttpResponse<JsonNode> result =
                Unirest.post("https://api.trello.com/1/cards")
                .header("Accept", "application/json")
                .queryString("idList", TRELLO_LIST_ID)
                .queryString("key", TRELLO_API_KEY)
                .queryString("token", TRELLO_TOKEN)
                .queryString("name", card.getName())
                .queryString("desc", card.getDescription())
                .queryString("pos", "top")
                .asJson();
    };
}

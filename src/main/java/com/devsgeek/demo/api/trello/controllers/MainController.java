package com.devsgeek.demo.api.trello.controllers;

import com.devsgeek.demo.api.trello.models.dto.CardModelDTO;
import com.devsgeek.demo.api.trello.services.TrelloServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MainController {

    @Autowired
    private TrelloServices trelloServices;

    @GetMapping("/hello")
    public ResponseEntity<?> Hello() {
        return ResponseEntity.ok("Hello World");
    }

    @PostMapping("/post")
    public ResponseEntity<?> Post(@RequestBody CardModelDTO card) {
        trelloServices.Post(card);
        return ResponseEntity.ok("ok");
    }
}

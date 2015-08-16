package com.un1acker.aggregator.controller;

import com.un1acker.aggregator.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/users")
public class AdminController {

    @Autowired
    private UserService userService;

    @RequestMapping
    public String users(Model model) {
        model.addAttribute("users", userService.findAll());
        return "users";
    }

    @RequestMapping("/{id}")
    public String details(Model model, @PathVariable Integer id) {
        model.addAttribute("user", userService.findOneWithBlogs(id));
        return "user-detail";
    }


    @RequestMapping("/delete/{id}")
    public String deleteUser(@PathVariable Integer id) {
        userService.delete(id);
        return "redirect:/users.html";
    }
}

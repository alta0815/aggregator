package com.un1acker.aggregator.service;

import com.un1acker.aggregator.entity.Blog;
import com.un1acker.aggregator.entity.Item;
import com.un1acker.aggregator.entity.User;
import com.un1acker.aggregator.exception.RssException;
import com.un1acker.aggregator.repository.BlogRepository;
import com.un1acker.aggregator.repository.ItemRepository;
import com.un1acker.aggregator.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.method.P;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BlogService {

    private static final int ONE_HOUR_IN_MSEC = 60 * 60 * 1000;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BlogRepository blogRepository;

    @Autowired
    private RSSService RSSService;

    @Autowired
    private ItemRepository itemRepository;

    public void save(Blog blog, String name) {
        User user = userRepository.findByName(name);
        blog.setUser(user);
        blogRepository.save(blog);
        saveItems(blog);
    }

    public void saveItems(Blog blog) {
        try {
            List<Item> itemList = RSSService.getItems(blog.getUrl());
            for (Item item : itemList) {
                item.setBlog(blog);
                itemRepository.save(item);

            }
        } catch (RssException e) {
            e.printStackTrace();
        }
    }

    @Scheduled(fixedDelay = ONE_HOUR_IN_MSEC)
    public void reloadBlogs() {
        List<Blog> blogs = blogRepository.findAll();
        blogs.forEach(this::saveItems);
    }

    public void delete(Integer id) {
        blogRepository.delete(id);
    }

    public Blog findOne(Integer id) {
        return blogRepository.findOne(id);
    }

    @PreAuthorize("#blog.user.name == authentication.name or hasRole('ROLE_ADMIN')")
    public void delete(@P("blog") Blog blog) {
        blogRepository.delete(blog);
    }
}

package com.un1acker.aggregator.service;

import com.un1acker.aggregator.entity.Blog;
import com.un1acker.aggregator.entity.User;
import com.un1acker.aggregator.repository.BlogRepository;
import com.un1acker.aggregator.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by un1acker on 8/11/2015.
 */
@Service
public class BlogService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BlogRepository blogRepository;

    public void save(Blog blog, String name) {
        User user = userRepository.findByName(name);
        blog.setUser(user);
        blogRepository.save(blog);
    }

    public void delete(Integer id) {
        blogRepository.delete(id);
    }
}

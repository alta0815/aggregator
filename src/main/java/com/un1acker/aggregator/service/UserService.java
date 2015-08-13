package com.un1acker.aggregator.service;

import com.un1acker.aggregator.entity.Blog;
import com.un1acker.aggregator.entity.Item;
import com.un1acker.aggregator.entity.Role;
import com.un1acker.aggregator.entity.User;
import com.un1acker.aggregator.repository.BlogRepository;
import com.un1acker.aggregator.repository.ItemRepository;
import com.un1acker.aggregator.repository.RoleRepository;
import com.un1acker.aggregator.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BlogRepository blogRepository;

    @Autowired
    private ItemRepository itemRepository;

    @Autowired
    private RoleRepository roleRepository;

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public User findOne(Integer id) {
        return userRepository.findOne(id);
    }

    @Transactional
    public User findOneWithBlogs(Integer id) {
        User user = userRepository.findOne(id);
        List<Blog> blogs = blogRepository.findByUser(user);
        for (Blog blog : blogs) {
            List<Item> items = itemRepository.findByBlog(blog, new PageRequest(0, 10, Sort.Direction.DESC, "publishedDate"));
            blog.setItems(items);
        }
        user.setBlogs(blogs);
        return user;
    }

    public void save(User user) {
        user.setEnabled(true);
        user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
        List<Role> roles = new ArrayList<>();
        roles.add(roleRepository.findByName("ROLE_USER"));
        user.setRoles(roles);

        userRepository.save(user);
    }

    public User findOneWithBlogs(String name) {
        User user = userRepository.findByName(name);
        return findOneWithBlogs(user.getId());
    }

    public void delete(Integer id) {
        userRepository.delete(id);
    }
}

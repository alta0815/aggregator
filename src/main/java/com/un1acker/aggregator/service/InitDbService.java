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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Transactional
@Service
public class InitDbService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BlogRepository blogRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private ItemRepository itemRepository;

    @PostConstruct
    public void init() {
        Role roleUser = new Role();
        roleUser.setName("ROLE_USER");
        roleRepository.save(roleUser);

        Role roleAdmin = new Role();
        roleAdmin.setName("ROLE_ADMIN");
        roleRepository.save(roleAdmin);

        User userAdmin = new User();
        userAdmin.setName("admin");
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        userAdmin.setPassword(encoder.encode("admin"));
        userAdmin.setEnabled(true);
        List<Role> roles = new ArrayList<>();
        roles.add(roleAdmin);
        roles.add(roleUser);
        userAdmin.setRoles(roles);
        userRepository.save(userAdmin);

        Blog blog = new Blog();
        blog.setName("MyBlog");
        blog.setUrl("http://feeds.feedburner.com/javavids?format=xml");
        blog.setUser(userAdmin);
        blogRepository.save(blog);

        Item item1 = new Item();
        item1.setBlog(blog);
        item1.setTitle("Blog");
        item1.setLink("http://www.javavids.com/");
        item1.setPublishedDate(new Date());
        itemRepository.save(item1);

        Item item2 = new Item();
        item2.setBlog(blog);
        item2.setTitle("BlogSecond");
        item2.setLink("http://www.javavids.com/");
        item2.setPublishedDate(new Date());
        itemRepository.save(item2);
    }
}

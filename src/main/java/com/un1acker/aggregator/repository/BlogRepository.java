package com.un1acker.aggregator.repository;

import com.un1acker.aggregator.entity.Blog;
import com.un1acker.aggregator.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BlogRepository extends JpaRepository<Blog, Integer> {
    List<Blog> findByUser(User user);
}

package com.un1acker.aggregator.repository;

import com.un1acker.aggregator.entity.Blog;
import com.un1acker.aggregator.entity.Item;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ItemRepository extends JpaRepository<Item, Integer> {
    List<Item> findByBlog(Blog blog, Pageable pageable);

    Item findByBlogAndLink(Blog blog, String link);
}

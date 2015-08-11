package com.un1acker.aggregator.repository;

import com.un1acker.aggregator.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by un1acker on 8/8/2015.
 */
public interface UserRepository extends JpaRepository<User, Integer> {
}

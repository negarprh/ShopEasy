package com.example.shopeasy.model;


/**
 * Interface for user-related behavior, used to demonstrate abstraction.
 * Implemented by the User model class.
 *
 * Author: Negar
 */

public interface IUser {
    String getUsername();
    String getRole();
    void setRole(String role);
}


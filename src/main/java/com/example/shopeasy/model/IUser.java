package com.example.shopeasy.model;


/**
 * Interface representing a user account in the system.
 */
public interface IUser {
    int getUserId();
    String getUsername();
    String getPassword();
    String getRole();
}


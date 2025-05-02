package com.example.shopeasy.model;


/**
 * Interface representing product behavior and basic data access.
 * Used to abstract product-related operations.
 *
 * Author: Negar
 */
public interface IProduct {
    String getName();
    double getPrice();
    boolean isInStock();
}
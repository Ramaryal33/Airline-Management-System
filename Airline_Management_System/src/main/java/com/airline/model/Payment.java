package com.airline.model;

import java.sql.Timestamp;

/**
 * Represents a payment made against a booking.  
 * On success, controller returns a confirmation message—no extra module needed.
 */
public class Payment {
    private int paymentId;
    private int bookingId;
    private String paymentMethod;
    private double amount;
    private Timestamp paymentDate;

    public Payment() {}

    // Constructor without paymentId
    public Payment(int bookingId, String paymentMethod, double amount, Timestamp paymentDate) {
        this.bookingId = bookingId;
        this.paymentMethod = paymentMethod;
        this.amount = amount;
        this.paymentDate = paymentDate;
    }

    // Full constructor
    public Payment(int paymentId, int bookingId, String paymentMethod, double amount, Timestamp paymentDate) {
        this.paymentId = paymentId;
        this.bookingId = bookingId;
        this.paymentMethod = paymentMethod;
        this.amount = amount;
        this.paymentDate = paymentDate;
    }

    // Getters and Setters
    public int getPaymentId() { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public Timestamp getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Timestamp paymentDate) { this.paymentDate = paymentDate; }
}

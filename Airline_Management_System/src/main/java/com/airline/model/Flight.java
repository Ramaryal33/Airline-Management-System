package com.airline.model;

import java.time.LocalDate;
import java.time.LocalTime;

public class Flight {
    private String flightId;
    private String fromCity;
    private String toCity;
    private LocalDate departureDate;
    private LocalTime departureTime;
    private double price;
    private String travelClass;

    // Constructor
    public Flight(String flightId, String fromCity, String toCity, LocalDate departureDate, LocalTime departureTime, double price, String travelClass) {
        this.flightId = flightId;
        this.fromCity = fromCity;
        this.toCity = toCity;
        this.departureDate = departureDate;
        this.departureTime = departureTime;
        this.price = price;
        this.travelClass = travelClass;
    }

    // Getters and setters

    public String getFlightId() {
        return flightId;
    }

    public void setFlightId(String flightId) {
        this.flightId = flightId;
    }

    public String getFromCity() {
        return fromCity;
    }

    public void setFromCity(String fromCity) {
        this.fromCity = fromCity;
    }

    public String getToCity() {
        return toCity;
    }

    public void setToCity(String toCity) {
        this.toCity = toCity;
    }

    public LocalDate getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(LocalDate departureDate) {
        this.departureDate = departureDate;
    }

    public LocalTime getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(LocalTime departureTime) {
        this.departureTime = departureTime;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getTravelClass() {
        return travelClass;
    }

    public void setTravelClass(String travelClass) {
        this.travelClass = travelClass;
    }
}

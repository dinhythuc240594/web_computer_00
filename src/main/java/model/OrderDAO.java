package model;

import java.sql.Date;

public class OrderDAO {

    private int id;
    private int user_id;
    private Date orderDate;
    private double totalPrice;
    private String status;
    private String address;
    private String payment;
    private String note;
    private Boolean is_active;

    public OrderDAO(){}

    public OrderDAO(int id, int user_id, Date orderDate,
                    double totalPrice, String status,
                    String address, String payment,
                    String note, Boolean is_active) {
        this.id = id;
        this.user_id = user_id;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.status = status;
        this.address = address;
        this.payment = payment;
        this.note = note;
        this.is_active = is_active;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Boolean getIs_active() {
        return is_active;
    }

    public void setIs_active(Boolean is_active) {
        this.is_active = is_active;
    }

    public int getUser_id() {
        return user_id;
    }
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
}

package model;

public class CartItem {

    private ProductDAO product;
    private int quantity;

    public CartItem() {
    }

    public CartItem(ProductDAO product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public ProductDAO getProduct() {
        return product;
    }

    public void setProduct(ProductDAO product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}



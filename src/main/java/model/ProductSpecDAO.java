package model;

public class ProductSpecDAO {

    private int id;
    private String name;
    private String description;
    private int value;
    private int productId;

    public ProductSpecDAO(){}

    public ProductSpecDAO(int id, String name, String description, int value, int productId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.value = value;
        this.productId = productId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
}

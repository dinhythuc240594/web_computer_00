package model;

public class ProductSpecDAO {

    private int id;
    private String name;
    private String description;
    private String valueSpec;
    private int productId;

    public ProductSpecDAO(){}

    public ProductSpecDAO(int id, String name, String description, String valueSpec, int productId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.valueSpec = valueSpec;
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

    public String getvalueSpec() {
        return valueSpec;
    }

    public void setvalueSpec(String valueSpec) {
        this.valueSpec = valueSpec;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
}

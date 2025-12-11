package model;

import java.util.Date;

public class ProductDAO {

    private int id;
    private String name;
    private String description;
    private Double price;
    private String image;
    private String slug;
    private int category_id;
    private int stock_quantity;
    private int brand_id;
    private Boolean is_active;
    private Date created_at;
    private Date updated_at;
    
    // Các trường giảm giá
    private Double original_price;
    private Double discount_percentage;
    private Boolean is_on_sale;
    private Date sale_start_date;
    private Date sale_end_date;

    public ProductDAO(){}

    public ProductDAO(int id, String name, String description, Double price,
                      String image, String slug, int category_id, int stock_quantity,
                      int brand_id, Boolean is_active) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.image = image;
        this.slug = slug;
        this.category_id = category_id;
        this.stock_quantity = stock_quantity;
        this.brand_id = brand_id;
        this.is_active = is_active;
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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public int getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }

    public int getBrand_id() {
        return brand_id;
    }

    public void setBrand_id(int brand_id) {
        this.brand_id = brand_id;
    }

    public Boolean getIs_active() {
        return is_active;
    }

    public void setIs_active(Boolean is_active) {
        this.is_active = is_active;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Double getOriginal_price() {
        return original_price;
    }

    public void setOriginal_price(Double original_price) {
        this.original_price = original_price;
    }

    public Double getDiscount_percentage() {
        return discount_percentage;
    }

    public void setDiscount_percentage(Double discount_percentage) {
        this.discount_percentage = discount_percentage;
    }

    public Boolean getIs_on_sale() {
        return is_on_sale;
    }

    public void setIs_on_sale(Boolean is_on_sale) {
        this.is_on_sale = is_on_sale;
    }

    public Date getSale_start_date() {
        return sale_start_date;
    }

    public void setSale_start_date(Date sale_start_date) {
        this.sale_start_date = sale_start_date;
    }

    public Date getSale_end_date() {
        return sale_end_date;
    }

    public void setSale_end_date(Date sale_end_date) {
        this.sale_end_date = sale_end_date;
    }
    
    // Helper method để lấy giá gốc (nếu có original_price thì dùng, không thì dùng price)
    public Double getOriginalPrice() {
        if (original_price != null) {
            return original_price;
        }
        return price; // Nếu không có original_price thì dùng price làm giá gốc
    }
    
    // Helper method để lấy giá bán hiện tại (nếu có giảm giá thì là price, không thì là original_price hoặc price)
    public Double getCurrentPrice() {
        if (isCurrentlyOnSale() && original_price != null) {
            return price; // Giá sau giảm
        }
        return original_price != null ? original_price : price;
    }
    
    // Helper method để kiểm tra có đang trong thời gian giảm giá không
    public boolean isCurrentlyOnSale() {
        if (is_on_sale == null || !is_on_sale) {
            return false;
        }
        Date now = new Date();
        if (sale_start_date != null && now.before(sale_start_date)) {
            return false;
        }
        return sale_end_date == null || !now.after(sale_end_date);
    }
    
    // Helper method để tính phần trăm giảm giá (từ original_price và price nếu discount_percentage null)
    public Double getCalculatedDiscountPercentage() {
        // Nếu đã có discount_percentage thì dùng luôn
        if (discount_percentage != null && discount_percentage > 0) {
            return discount_percentage;
        }
        
        // Nếu không có, tính từ original_price và price
        Double origPrice = getOriginalPrice();
        Double currPrice = getCurrentPrice();
        
        if (origPrice != null && currPrice != null && origPrice > 0 && origPrice > currPrice) {
            double discount = ((origPrice - currPrice) / origPrice) * 100.0;
            return discount;
        }
        
        return null;
    }
    
    // Helper method để kiểm tra sản phẩm có phải mới không (tạo trong vòng 7 ngày)
    public boolean isNewProduct() {
        if (created_at == null) {
            return false;
        }
        
        Date now = new Date();
        long diffInMillis = now.getTime() - created_at.getTime();
        long diffInDays = diffInMillis / (1000 * 60 * 60 * 24); // Chuyển đổi từ milliseconds sang ngày
        
        // Sản phẩm mới nếu được tạo trong vòng 7 ngày
        return diffInDays <= 7;
    }

}

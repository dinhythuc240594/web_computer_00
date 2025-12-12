package model;

public class PageRequest {

    private int page;
    private int pageSize;
    private String sortField;
    private String orderField;
    private String keyword;
    private int productId;
    private int categoryId;
    private int brandId;
    private Boolean isActive;

    public PageRequest() {

    }

    public PageRequest(int page, int pageSize,
                       String sortField, String orderField, String keyword) {
        this.page = page;
        this.pageSize = pageSize;
        this.sortField = sortField;
        this.orderField = orderField;
        this.keyword = keyword;
    }

    public PageRequest(int page, int pageSize, String sortField,
                       String orderField, String keyword, int productId) {
        this.page = page;
        this.pageSize = pageSize;
        this.sortField = sortField;
        this.orderField = orderField;
        this.keyword = keyword;
        this.productId = productId;
    }

    public PageRequest(int page, int pageSize,
                       String sortField, String orderField, String keyword,
                       int productId, int categoryId) {
        this.page = page;
        this.pageSize = pageSize;
        this.sortField = sortField;
        this.orderField = orderField;
        this.keyword = keyword;
        this.productId = productId;
        this.categoryId = categoryId;
    }

    public PageRequest(int page, int pageSize,
                       String sortField, String orderField, String keyword,
                       int productId, int categoryId, int brandId) {
        this.page = page;
        this.pageSize = pageSize;
        this.sortField = sortField;
        this.orderField = orderField;
        this.keyword = keyword;
        this.productId = productId;
        this.categoryId = categoryId;
        this.brandId = brandId;
    }

    public int getOffset() {
        return ((page - 1) * pageSize);
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String getSortField() {
        return sortField;
    }

    public void setSortField(String sortField) {
        this.sortField = sortField;
    }

    public String getOrderField() {
        return orderField;
    }

    public void setOrderField(String orderField) {
        this.orderField = orderField;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }
}

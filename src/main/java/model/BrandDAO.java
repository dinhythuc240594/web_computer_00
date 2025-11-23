package model;

public class BrandDAO {

    private int id;
    private String name;
    private String code;
    private Boolean is_active;

    public BrandDAO(){};

    public BrandDAO(int id, String name, String code, Boolean is_active) {
        this.id = id;
        this.name = name;
        this.code = code;
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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Boolean getIs_active() {
        return is_active;
    }

    public void setIs_active(Boolean is_active) {
        this.is_active = is_active;
    }
}

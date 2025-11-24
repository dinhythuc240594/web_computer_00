package model;

public class CategoryDAO {

    private int id;
    private String name;
    private String description;
    private Boolean is_active;
    private int parent_id;

    public CategoryDAO(){}

    public CategoryDAO(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    public CategoryDAO(int id, String name, String description, Boolean is_active) {
        this.id = id;
        this.name = name;
        this.description = description;
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

    public Boolean getIs_active() {
        return is_active;
    }

    public void setIs_active(Boolean is_active) {
        this.is_active = is_active;
    }

    public int getParent_id() {
        return parent_id;
    }

    public void setParent_id(int parent_id) {
        this.parent_id = parent_id;
    }
}

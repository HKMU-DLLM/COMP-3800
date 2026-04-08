package comp.comp3800.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "lectures")
public class Lecture {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // IMPORTANT
    private Long id;

    private String title;

    private String summary;

    @Column(name = "course_order")
    private int order;

    @OneToMany(mappedBy = "lecture", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<CourseMaterial> materials;



    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public List<CourseMaterial> getMaterials() {
        return materials;
    }

    public void setMaterials(List<CourseMaterial> materials) {
        this.materials = materials;
    }
}
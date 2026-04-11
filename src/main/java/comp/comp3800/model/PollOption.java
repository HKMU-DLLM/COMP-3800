package comp.comp3800.model;

import jakarta.persistence.*;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(
        name = "poll_options",
        uniqueConstraints = @UniqueConstraint(name = "uk_poll_option_index", columnNames = {"poll_id", "option_index"})
)
public class PollOption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "poll_id", nullable = false)
    private Poll poll;

    @Column(name = "option_text", nullable = false, length = 300)
    private String optionText;

    @Column(name = "option_index", nullable = false)
    private int optionIndex;

    @Column(name = "created_at", nullable = false)
    private Instant createdAt = Instant.now();

    public PollOption() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getOptionIndex() {
        return optionIndex;
    }

    public void setOptionIndex(int optionIndex) {
        this.optionIndex = optionIndex;
    }

    public String getOptionText() {
        return optionText;
    }

    public void setOptionText(String optionText) {
        this.optionText = optionText;
    }

    public Poll getPoll() {
        return poll;
    }

    public void setPoll(Poll poll) {
        this.poll = poll;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }
    @OneToMany(mappedBy = "selectedOption", 
               cascade = CascadeType.REMOVE, 
               orphanRemoval = true)
    private List<PollVote> votes = new ArrayList<>();

    public List<PollVote> getVotes() {
        return votes;
    }

    public void setVotes(List<PollVote> votes) {
        this.votes = votes;
    }
}
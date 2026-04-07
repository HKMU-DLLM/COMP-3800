package comp.comp3800.model;

import jakarta.persistence.*;
import java.time.Instant;

@Entity
@Table(
        name = "poll_votes",
        uniqueConstraints = @UniqueConstraint(name = "uk_poll_voter", columnNames = {"poll_id", "voter_id"})
)
public class PollVote {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "poll_id", nullable = false)
    private Poll poll;

    @ManyToOne(optional = false)
    @JoinColumn(name = "voter_id", nullable = false)
    private User voter;

    @ManyToOne(optional = false)
    @JoinColumn(name = "selected_option_id", nullable = false)
    private PollOption selectedOption;

    @Column(name = "created_at", nullable = false)
    private Instant createdAt = Instant.now();

    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt = Instant.now();

    @PreUpdate
    public void onUpdate() {
        updatedAt = Instant.now();
    }

    public PollVote() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Poll getPoll() {
        return poll;
    }

    public void setPoll(Poll poll) {
        this.poll = poll;
    }

    public User getVoter() {
        return voter;
    }

    public void setVoter(User voter) {
        this.voter = voter;
    }

    public PollOption getSelectedOption() {
        return selectedOption;
    }

    public void setSelectedOption(PollOption selectedOption) {
        this.selectedOption = selectedOption;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }

    public Instant getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Instant updatedAt) {
        this.updatedAt = updatedAt;
    }
}

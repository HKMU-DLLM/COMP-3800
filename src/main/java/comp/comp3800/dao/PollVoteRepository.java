package comp.comp3800.dao;

import comp.comp3800.model.PollVote;
import comp.comp3800.model.VotingHistoryItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PollVoteRepository extends JpaRepository<PollVote, Long> {

    Optional<PollVote> findByPollIdAndVoterId(Long pollId, Long voterId);

    @Query("SELECT pv.selectedOption.id, COUNT(pv) FROM PollVote pv " +
           "WHERE pv.poll.id = :pollId GROUP BY pv.selectedOption.id")
    List<Object[]> countVotesByPollId(@Param("pollId") Long pollId);

    @Query("""
        SELECT new comp.comp3800.model.VotingHistoryItem(
            pv.id,
            pv.poll.id,
            pv.poll.question,
            po.optionIndex,
            po.optionText,
            pv.createdAt,
            pv.updatedAt
        )
        FROM PollVote pv
        JOIN pv.poll p
        JOIN pv.selectedOption po
        WHERE pv.voter.id = :voterId
        ORDER BY pv.createdAt DESC
    """)
    List<VotingHistoryItem> findHistoryByVoterId(@Param("voterId") Long voterId);

    void deleteByVoterId(Long voterId);
}
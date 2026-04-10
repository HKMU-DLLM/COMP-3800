package comp.comp3800.dao;

import comp.comp3800.model.PollVote;
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

    void deleteByPollId(Long pollId);
}
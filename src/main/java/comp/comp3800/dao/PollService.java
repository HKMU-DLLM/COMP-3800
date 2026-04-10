package comp.comp3800.dao;

import comp.comp3800.model.Poll;
import comp.comp3800.model.PollOption;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PollService {

    @Autowired
    private PollRepository pollRepository;

    @Autowired
    private PollOptionRepository pollOptionRepository;

    @Autowired
    private PollVoteRepository pollVoteRepository;

    @PersistenceContext
    private EntityManager entityManager;

    // ====================== 強制刪除 Poll（支援有人投票的情況） ======================
    @Transactional
    public void forceDeletePoll(Long pollId) {
        // 1. 刪除所有投票
        entityManager.createNativeQuery("DELETE FROM poll_votes WHERE poll_id = :pollId")
                .setParameter("pollId", pollId)
                .executeUpdate();

        // 2. 刪除所有選項
        entityManager.createNativeQuery("DELETE FROM poll_options WHERE poll_id = :pollId")
                .setParameter("pollId", pollId)
                .executeUpdate();

        entityManager.createNativeQuery(
                        "DELETE FROM comments WHERE target_type = 'POLL' AND target_id = :pollId")
                .setParameter("pollId", pollId)
                .executeUpdate();

        pollRepository.deleteById(pollId);

        System.out.println("✅ Force deleted poll ID: " + pollId
                + " (votes + options + comments 已全部清除)");
    }

    @Transactional
    public Poll createPoll(String question, List<String> optionTexts) {
        if (optionTexts == null || optionTexts.size() != 5) {
            throw new IllegalArgumentException("Poll must have exactly 5 options");
        }

        Poll poll = new Poll();
        poll.setQuestion(question);
        Poll savedPoll = pollRepository.save(poll);

        for (int i = 0; i < 5; i++) {
            PollOption option = new PollOption();
            option.setPoll(savedPoll);
            option.setOptionText(optionTexts.get(i).trim());
            option.setOptionIndex(i + 1);
            pollOptionRepository.save(option);
        }
        return savedPoll;
    }

    @Transactional
    public void updatePoll(Long pollId, String question, List<String> optionTexts) {
        if (optionTexts == null || optionTexts.size() != 5) {
            throw new IllegalArgumentException("Poll must have exactly 5 options");
        }

        Poll poll = pollRepository.findById(pollId)
                .orElseThrow(() -> new RuntimeException("Poll not found"));

        poll.setQuestion(question);
        pollRepository.save(poll);

        for (int i = 0; i < 5; i++) {
            int index = i + 1;
            PollOption option = poll.getOptions().stream()
                    .filter(o -> o.getOptionIndex() == index)
                    .findFirst()
                    .orElseThrow(() -> new RuntimeException("Option " + index + " not found"));

            option.setOptionText(optionTexts.get(i).trim());
            pollOptionRepository.save(option);
        }
    }
}
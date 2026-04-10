package comp.comp3800.dao;

import comp.comp3800.model.Poll;
import comp.comp3800.model.PollOption;
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
    public void deletePoll(Long pollId) {
        pollRepository.deleteById(pollId);
    }
}
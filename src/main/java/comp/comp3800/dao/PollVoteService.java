package comp.comp3800.dao;

import comp.comp3800.model.Poll;
import comp.comp3800.model.PollOption;
import comp.comp3800.model.PollVote;
import comp.comp3800.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;


@Service
public class PollVoteService {

    @Autowired
    private PollVoteRepository pollVoteRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PollOptionRepository pollOptionRepository;

    @Autowired
    private PollRepository pollRepository;

    public Optional<PollVote> getUserVote(Long pollId, String username) {
        User user = userRepository.findByUsername(username).orElse(null);
        if (user == null) return Optional.empty();
        return pollVoteRepository.findByPollIdAndVoterId(pollId, user.getId());
    }

    public Map<Long, Long> getVoteCounts(Long pollId) {
        List<Object[]> results = pollVoteRepository.countVotesByPollId(pollId);
        Map<Long, Long> counts = new HashMap<>();
        for (Object[] row : results) {
            counts.put((Long) row[0], (Long) row[1]);
        }
        return counts;
    }

    @Transactional
    public void castOrUpdateVote(Long pollId, Long optionId, Principal principal) {
        String username = principal.getName();
        User voter = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Poll poll = pollRepository.findById(pollId)
                .orElseThrow(() -> new RuntimeException("Poll not found"));

        PollOption option = pollOptionRepository.findById(optionId)
                .orElseThrow(() -> new RuntimeException("Option not found"));

        Optional<PollVote> existing = pollVoteRepository.findByPollIdAndVoterId(pollId, voter.getId());

        if (existing.isPresent()) {
            PollVote vote = existing.get();
            vote.setSelectedOption(option);
            pollVoteRepository.save(vote);
        } else {
            PollVote vote = new PollVote();
            vote.setPoll(poll);
            vote.setVoter(voter);
            vote.setSelectedOption(option);
            pollVoteRepository.save(vote);
        }
    }
}
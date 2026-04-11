package comp.comp3800.model;

import java.time.Instant;

public record VotingHistoryItem(
        Long voteId,
        Long pollId,
        String pollQuestion,
        Integer optionIndex,
        String selectedOptionText,
        Instant createdAt,
        Instant updatedAt
) {}
package comp.comp3800.controller;

import comp.comp3800.dao.CommentRepository;
import comp.comp3800.dao.CommentService;
import comp.comp3800.dao.PollRepository;
import comp.comp3800.dao.PollService;
import comp.comp3800.dao.PollVoteService;
import comp.comp3800.dao.UserRepository;
import comp.comp3800.model.Comment;
import comp.comp3800.model.Poll;
import comp.comp3800.model.PollOption;
import comp.comp3800.model.PollVote;
import comp.comp3800.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/poll")
public class PollController {

    @Autowired
    private PollRepository pollRepo;

    @Autowired
    private CommentService commentSer;

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private CommentRepository commentRepo;

    @Autowired
    private PollVoteService pollVoteService;

    @Autowired
    private PollService pollService;

    // ====================== 一般學生/老師看 Poll ======================
    @GetMapping("/{id}")
    public String viewPoll(@PathVariable Long id, Model model, Principal principal) {
        Poll poll = pollRepo.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        List<Comment> comments = commentSer.getCommentsForPoll(id);

        Map<Long, Long> voteCounts = pollVoteService.getVoteCounts(id);
        String selectedOptionId = null;

        if (principal != null) {
            Optional<PollVote> userVote = pollVoteService.getUserVote(id, principal.getName());
            if (userVote.isPresent()) {
                selectedOptionId = String.valueOf(userVote.get().getSelectedOption().getId());
            }
        }

        model.addAttribute("pollDatabase", poll);
        model.addAttribute("commentDatabase", comments);
        model.addAttribute("optsDatabase", poll.getOptions());
        model.addAttribute("voteCounts", voteCounts);
        model.addAttribute("selectedOptionId", selectedOptionId);

        return "poll";
    }

    @PostMapping("/vote")
    public String submitVote(@RequestParam Long pollId,
                             @RequestParam Long optionId,
                             Principal principal) {
        if (principal == null) {
            return "redirect:/login";
        }
        pollVoteService.castOrUpdateVote(pollId, optionId, principal);
        return "redirect:/poll/" + pollId;
    }

    @PostMapping("/comment")
    public String addPollComment(@RequestParam Long pollId,
                                 @RequestParam String content,
                                 Principal principal) {
        commentSer.addCommentToPoll(pollId, content, principal);
        return "redirect:/poll/" + pollId;
    }

    @PostMapping("/poll/comment/add")
    public String saveComment(@RequestParam String content, @RequestParam Long pollId, Principal principal) {
        Comment comment = new Comment();
        comment.setContent(content);
        comment.setTargetId(pollId);
        comment.setTargetType(Comment.TargetType.POLL);

        User currentUser = userRepo.findByUsername(principal.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));
        comment.setAuthor(currentUser);

        commentRepo.save(comment);
        return "redirect:/poll/" + pollId;
    }

    // ====================== POLL MANAGEMENT (TEACHER ONLY) ======================

    @GetMapping("/admin/polls/new")
    public String showCreatePollForm(Model model) {
        model.addAttribute("pollForm", new PollForm());
        return "create-poll";
    }

    @PostMapping("/admin/polls/new")
    public String createPoll(@ModelAttribute("pollForm") PollForm form) {
        List<String> options = List.of(
            form.getOption1(), form.getOption2(), form.getOption3(),
            form.getOption4(), form.getOption5()
        );
        pollService.createPoll(form.getQuestion(), options);
        return "redirect:/lecture/list";
    }

    @PostMapping("/admin/polls/{pollId}/delete")
    public String deletePoll(@PathVariable Long pollId) {
        pollService.deletePoll(pollId);
        return "redirect:/lecture/list";
    }

    // ====================== EDIT POLL ======================
    @GetMapping("/admin/polls/{pollId}/edit")
    public String showEditPollForm(@PathVariable Long pollId, Model model) {
        Poll poll = pollRepo.findById(pollId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        PollEditForm form = new PollEditForm();
        form.setQuestion(poll.getQuestion());

        List<PollOption> options = poll.getOptions();

        // 使用傳統寫法，避免 lambda 編譯錯誤
        java.util.Collections.sort(options, new java.util.Comparator<PollOption>() {
            @Override
            public int compare(PollOption a, PollOption b) {
                return Integer.compare(a.getOptionIndex(), b.getOptionIndex());
            }
        });

        if (options.size() >= 5) {
            form.setOption1(options.get(0).getOptionText());
            form.setOption2(options.get(1).getOptionText());
            form.setOption3(options.get(2).getOptionText());
            form.setOption4(options.get(3).getOptionText());
            form.setOption5(options.get(4).getOptionText());
        }

        model.addAttribute("pollEditForm", form);
        model.addAttribute("pollId", pollId);
        return "edit-poll";
    }

    @PostMapping("/admin/polls/{pollId}/edit")
    public String updatePoll(@PathVariable Long pollId,
                             @ModelAttribute("pollEditForm") PollEditForm form) {

        List<String> options = List.of(
            form.getOption1(), form.getOption2(), form.getOption3(),
            form.getOption4(), form.getOption5()
        );

        pollService.updatePoll(pollId, form.getQuestion(), options);
        return "redirect:/lecture/list";
    }

    // ====================== FORM CLASSES ======================
    public static class PollForm {
        private String question;
        private String option1;
        private String option2;
        private String option3;
        private String option4;
        private String option5;

        public String getQuestion() { return question; }
        public void setQuestion(String question) { this.question = question; }
        public String getOption1() { return option1; }
        public void setOption1(String option1) { this.option1 = option1; }
        public String getOption2() { return option2; }
        public void setOption2(String option2) { this.option2 = option2; }
        public String getOption3() { return option3; }
        public void setOption3(String option3) { this.option3 = option3; }
        public String getOption4() { return option4; }
        public void setOption4(String option4) { this.option4 = option4; }
        public String getOption5() { return option5; }
        public void setOption5(String option5) { this.option5 = option5; }
    }

    public static class PollEditForm {
        private String question;
        private String option1;
        private String option2;
        private String option3;
        private String option4;
        private String option5;

        public String getQuestion() { return question; }
        public void setQuestion(String question) { this.question = question; }
        public String getOption1() { return option1; }
        public void setOption1(String option1) { this.option1 = option1; }
        public String getOption2() { return option2; }
        public void setOption2(String option2) { this.option2 = option2; }
        public String getOption3() { return option3; }
        public void setOption3(String option3) { this.option3 = option3; }
        public String getOption4() { return option4; }
        public void setOption4(String option4) { this.option4 = option4; }
        public String getOption5() { return option5; }
        public void setOption5(String option5) { this.option5 = option5; }
    }
}
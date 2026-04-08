package comp.comp3800.controller;

import comp.comp3800.dao.CommentRepository;
import comp.comp3800.dao.PollRepository;
import comp.comp3800.dao.UserRepository;
import comp.comp3800.dao.CommentService;
import comp.comp3800.model.Comment;
import comp.comp3800.model.Poll;
import comp.comp3800.model.PollOption;
import comp.comp3800.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.util.List;

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

    @GetMapping("/{id}")
    public String viewPoll(@PathVariable Long id, Model model) {
        Poll poll = pollRepo.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
        List<PollOption> options = poll.getOptions();
        List<Comment> pollComments = commentSer.getCommentsForPoll();

        model.addAttribute("pollDatabase", poll);
        model.addAttribute("commentDatabase", pollComments);
        model.addAttribute("optsDatabase", options);

        return "poll";
    }

    @PostMapping("/vote")
    public String submitVote(@RequestParam Long pollId, @RequestParam Long optionId) {
        return "redirect:/lecture/list?voted=true";
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

        return "redirect:/poll/{id}";
    }
}

package comp.comp3800.controller;

import comp.comp3800.dao.*;
import comp.comp3800.model.Comment;
import comp.comp3800.model.Lecture;
import comp.comp3800.model.Poll;
import comp.comp3800.model.User;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import java.io.IOException;
import java.security.Principal;
import java.util.List;


@Controller
@RequestMapping("/lecture")
public class LectureController {

    @Resource
    private lectureService lecService;

    @Autowired
    private LectureRepository lectureRepo;

    @Autowired
    private PollRepository pollRepo;


    @Autowired
    private UserRepository userRepo;

    @Autowired
    private CommentRepository commentRepo;

    @Autowired
    private CommentService commentSer;

@GetMapping(value = {"", "/list"})
public String list(ModelMap model) {
    List<Lecture> lectures = lectureRepo.findAll();
    List<Poll> polls = pollRepo.findAll();
    List<Comment> lectComments = commentSer.getCommentsForLect();

    model.addAttribute("lectureDatabase", lectures);
    model.addAttribute("pollDatabase", polls);
    model.addAttribute("commentDatabase", lectComments);

    return "list";
}

    @GetMapping("/coursematerial/{id}")
    public String viewMaterial(@PathVariable Long id, Model model) {
        Lecture lecture = lectureRepo.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        model.addAttribute("lecture", lecture);
        return "coursematerial";
    }

    @GetMapping("/create")
    public ModelAndView create() {
        return new ModelAndView("create", "lectureForm", new Form());
    }

    public static class Form {
        private String title;
        private String summary;
        private int order;
        private List<MultipartFile> attachments;

        // Getters and Setters of customerName, subject, body, attachments


        public String getSummary() {
            return summary;
        }

        public void setSummary(String summary) {
            this.summary = summary;
        }

        public int getOrder() {
            return order;
        }

        public void setOrder(int order) {
            this.order = order;
        }

        public List<MultipartFile> getAttachments() {
            return attachments;
        }

        public void setAttachments(List<MultipartFile> attachments) {
            this.attachments = attachments;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }
    }
    @PostMapping("/create")
    public String create(@ModelAttribute("lectureForm") LectureController.Form form,
                         Principal principal) throws IOException {
        lecService.createLecture(
                form.getTitle(),
                form.getSummary(),
                form.getOrder(),
                form.getAttachments()
        );
        return "redirect:/lecture/list";
    }

    @PostMapping("/coursematerial/comment/add")
    public String saveComment(@RequestParam String content, @RequestParam Long pollId, Principal principal) {
        Comment comment = new Comment();
        comment.setContent(content);
        comment.setTargetId(pollId);
        comment.setTargetType(Comment.TargetType.POLL);

        User currentUser = userRepo.findByUsername(principal.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));
        comment.setAuthor(currentUser);

        commentRepo.save(comment);

        return "redirect:/coursematerial/{id}";
    }
}



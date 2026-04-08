package comp.comp3800.controller;

import comp.comp3800.dao.PollRepository;
import comp.comp3800.dao.lectureService;
import comp.comp3800.model.Lecture;
import comp.comp3800.dao.LectureRepository;
import comp.comp3800.model.Poll;
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

@GetMapping(value = {"", "/list"})
public String list(ModelMap model) {
    // Fetch all lectures from H2
    List<Lecture> lectures = lectureRepo.findAll();
    List<Poll> polls = pollRepo.findAll();

    // Add to model (ensure name matches what JSP expects)
    model.addAttribute("lectureDatabase", lectures);
    model.addAttribute("pollDatabase", polls);
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

}



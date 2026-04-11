package comp.comp3800.controller;

import comp.comp3800.dao.CommentService;
import comp.comp3800.dao.LectureRepository;
import comp.comp3800.dao.PollRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

    @Autowired
    private LectureRepository lectureRepo;

    @Autowired
    private PollRepository pollRepo;

    @Autowired
    private CommentService commentSer;

    @GetMapping({"/", "/indexpage"})
    public String index(ModelMap model) {
        model.addAttribute("lectureDatabase", lectureRepo.findAll());
        model.addAttribute("pollDatabase", pollRepo.findAll());
        model.addAttribute("commentDatabase", commentSer.getCommentsForLect());
        return "indexpage";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

}
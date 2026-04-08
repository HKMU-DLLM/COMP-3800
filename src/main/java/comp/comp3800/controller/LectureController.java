package comp.comp3800.controller;

import comp.comp3800.dao.PollRepository;
import comp.comp3800.model.Lecture;
import comp.comp3800.dao.LectureRepository;
import comp.comp3800.model.Poll;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;


@Controller
@RequestMapping("/lecture")
public class LectureController {

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
}



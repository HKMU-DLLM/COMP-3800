package comp.comp3800.controller;

import comp.comp3800.model.Lecture;
import comp.comp3800.repositories.LectureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


@Controller
@RequestMapping("/lecture")
public class LectureController {

    @Autowired
    private LectureRepository lectureRepo;

@GetMapping(value = {""
        , "/list"})
public String list(ModelMap model) {
    // Fetch all lectures from H2
    List<Lecture> lectures = lectureRepo.findAll();

    // Add to model (ensure name matches what JSP expects)
    model.addAttribute("lectureDatabase", lectures);

    return "list";
}
}
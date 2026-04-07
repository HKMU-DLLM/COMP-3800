package comp.comp3800.controller;

import comp.comp3800.model.Lecture;
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
    //private volatile long TICKET_ID_SEQUENCE = 1;
    private Map<Long, Lecture> LectureDatabase = new ConcurrentHashMap<>();
// Controller methods, Form-backing object, ...

@GetMapping(value = {""
        , "/list"})
public String list(ModelMap model) {
    model.addAttribute("LectureDatabase", LectureDatabase);
    return "list";
}
}
package comp.comp3800.controller;

import comp.comp3800.dao.*;
import comp.comp3800.exception.LectureNotFound;
import comp.comp3800.exception.courseMaterialNotFound;
import comp.comp3800.model.*;
import comp.comp3800.view.DownloadingView;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/lecture")
public class LectureController {

    @Resource
    private lectureService lecService;

    @Autowired
    private LectureRepository lectureRepo;

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private CommentRepository commentRepo;

    @Autowired
    private CommentService commentSer;

    @Autowired
    private CourseMaterialRepository courseMaterialRepo;


    @GetMapping("/coursematerial/{id}")
    public String viewMaterial(@PathVariable Long id, Model model) {
        Lecture lecture = lectureRepo.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        List<Comment> comments = commentSer.getCommentsForLecture(id);

        model.addAttribute("lecture", lecture);
        model.addAttribute("commentDatabase", comments);
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

        public String getSummary() { return summary; }
        public void setSummary(String summary) { this.summary = summary; }
        public List<MultipartFile> getAttachments() { return attachments; }
        public void setAttachments(List<MultipartFile> attachments) { this.attachments = attachments; }
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
    }

    @PostMapping("/create")
    public String create(@ModelAttribute("lectureForm") LectureController.Form form,
                         Principal principal) throws IOException {
        lecService.createLecture(form.getTitle(), form.getSummary(), form.getAttachments());
        return "redirect:/indexpage";
    }

    @GetMapping("/{lectureId}/attachment/{materialId}")
    public View download(@PathVariable("lectureId") long lectureId,
                         @PathVariable("materialId") long materialId) {

        CourseMaterial material = courseMaterialRepo.findById(materialId).orElse(null);

        if (material != null && material.getLecture() != null && material.getLecture().getId() == lectureId) {
            try {
                Path path = Paths.get(material.getStoredFilePath());
                byte[] data = Files.readAllBytes(path);
                return new DownloadingView(material.getOriginalFileName(), material.getContentType(), data);
            } catch (IOException e) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "File not found on server");
            }
        }
        return new RedirectView("/indexpage", true);
    }

    @PostMapping("/{lectureId}/upload")
    public String handleFileUpload(@PathVariable("lectureId") Long lectureId,
                                   @RequestParam("attachments") MultipartFile[] attachments,
                                   RedirectAttributes redirectAttributes) {
        try {
            Lecture lecture = lectureRepo.findById(lectureId)
                    .orElseThrow(() -> new RuntimeException("Lecture not found"));

            lecService.addAttachments(lecture, attachments);

            redirectAttributes.addFlashAttribute("message", "Files uploaded successfully!");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to upload files: " + e.getMessage());
        }

        redirectAttributes.addAttribute("id", lectureId);
        return "redirect:/lecture/coursematerial/" + lectureId;
    }





    @GetMapping("/coursematerial/{lectureId}/attachment/{materialId}/delete")
    public String deleteAttachment(@PathVariable long lectureId,
                                   @PathVariable Long materialId)
            throws LectureNotFound, courseMaterialNotFound {

        lecService.deleteAttachment(lectureId, materialId);
        return "redirect:/lecture/coursematerial/" + lectureId;
    }

    @PostMapping("/coursematerial/comment")
    public String addLectureComment(@RequestParam Long lectureId,
                                    @RequestParam String content,
                                    Principal principal,
                                    RedirectAttributes redirectAttributes) {
        commentSer.addCommentToLecture(lectureId, content, principal);
        return "redirect:/coursematerial/{id}";
    }

    @PostMapping("/coursematerial/comment/add")
    public String saveComment(@RequestParam String content,
                              @RequestParam Long lectureId,
                              Principal principal,
                              RedirectAttributes redirectAttributes) {

        Comment comment = new Comment();
        comment.setContent(content);
        comment.setTargetId(lectureId);
        comment.setTargetType(Comment.TargetType.LECTURE);

        User currentUser = userRepo.findByUsername(principal.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));
        comment.setAuthor(currentUser);

        commentRepo.save(comment);

        redirectAttributes.addAttribute("id", lectureId);

        return "redirect:/lecture/coursematerial/{id}";
    }

    @PostMapping("/admin/comments/delete/{commentId}")
    public String deleteComment(@PathVariable Long commentId,
                                @RequestParam Long lectureId,
                                RedirectAttributes redirectAttributes) {
        commentSer.deleteComment(commentId);
        redirectAttributes.addAttribute("id", lectureId);
        return "redirect:/lecture/coursematerial/{id}";
    }


    @GetMapping("/coursematerial/{id}/delete")
    public String delete(@PathVariable("id") long id) throws LectureNotFound {
        lecService.delete(id);
        return "redirect:/indexpage";
    }

}
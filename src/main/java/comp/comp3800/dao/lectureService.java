package comp.comp3800.dao;

import comp.comp3800.exception.LectureNotFound;
import comp.comp3800.exception.courseMaterialNotFound;
import comp.comp3800.model.CourseMaterial;
import comp.comp3800.model.Lecture;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;


@Service

public class lectureService {

    @Resource
    private LectureRepository lecRepo;
    @Resource
    private CourseMaterialRepository cRepo;

    @Transactional
    public List<CourseMaterial> getTickets() {
        return cRepo.findAll();
    }

    @Transactional
    public Lecture getlecture(long id)
            throws LectureNotFound {
        Lecture lec = lecRepo.findById(id).orElse(null);
        if (lec == null) {
            throw new LectureNotFound(id);
        }
        return lec;
    }

    @Transactional
    public CourseMaterial getAttachment(long ticketId, UUID attachmentId)
            throws LectureNotFound, courseMaterialNotFound {
        Lecture lec = lecRepo.findById(ticketId).orElse(null);
        if (lec == null) {
            throw new LectureNotFound(ticketId);
        }
        CourseMaterial courseMaterial = (CourseMaterial) cRepo.findById(attachmentId).orElse(null);
        if (courseMaterial == null) {
            throw new courseMaterialNotFound(attachmentId);
        }
        return courseMaterial;
    }

    @Transactional
    public long createLecture(String title, String summary,
                              List<MultipartFile> attachments) throws IOException {

        Lecture lecture = new Lecture();
        lecture.setTitle(title);
        lecture.setSummary(summary);

        // Folder where you store files
        Path uploadRoot = Paths.get("src/uploads");
        Files.createDirectories(uploadRoot);

        if (attachments != null) {
            for (MultipartFile filePart : attachments) {
                if (filePart == null || filePart.isEmpty()) {
                    continue;
                }

                // 1) Save file to disk
                String storedName = UUID.randomUUID() + "_" + filePart.getOriginalFilename();
                Path target = uploadRoot.resolve(storedName);
                Files.copy(filePart.getInputStream(), target);

                // 2) Create CourseMaterial
                CourseMaterial m = new CourseMaterial();
                m.setLecture(lecture);
                m.setOriginalFileName(filePart.getOriginalFilename());
                m.setContentType(filePart.getContentType());
                m.setFileSize(filePart.getSize());
                m.setStoredFilePath(target.toString());

                // IMPORTANT: do NOT use setContents anymore for now
                // m.setContents(null);

                lecture.getMaterials().add(m);
            }
        }

        Lecture saved = lecRepo.save(lecture);
        return saved.getId();
    }

}

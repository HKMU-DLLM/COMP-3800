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

        if (attachments != null) {
            for (MultipartFile filePart : attachments) {
                if (filePart == null || filePart.isEmpty()) {
                    continue; // skip empty inputs
                }

                CourseMaterial coursematerial = new CourseMaterial();
                coursematerial.setOriginalFileName(filePart.getOriginalFilename());
                coursematerial.setContentType(filePart.getContentType());
                coursematerial.setContents(filePart.getBytes());
                coursematerial.setLecture(lecture);

                // NEW: ensure storedFilePath is non-null
                // If you don't actually store on disk, at least store a logical name:
                String generatedName = UUID.randomUUID() + "_" + filePart.getOriginalFilename();
                coursematerial.setStoredFilePath(generatedName);

                if (coursematerial.getOriginalFileName() != null
                        && !coursematerial.getOriginalFileName().isEmpty()
                        && coursematerial.getContents() != null
                        && coursematerial.getContents().length > 0) {
                    lecture.getMaterials().add(coursematerial);
                }
            }
        }

        Lecture savedlecture = lecRepo.save(lecture);
        return savedlecture.getId();
    }

}

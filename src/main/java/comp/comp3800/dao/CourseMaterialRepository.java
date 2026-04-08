package comp.comp3800.dao;

import comp.comp3800.model.CourseMaterial;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface CourseMaterialRepository extends JpaRepository<CourseMaterial, Long> {
    Optional<Object> findById(UUID attachmentId);
}


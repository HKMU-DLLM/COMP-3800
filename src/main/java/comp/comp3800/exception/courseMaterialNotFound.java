package comp.comp3800.exception;

import java.util.UUID;

public class courseMaterialNotFound extends Exception {
    public courseMaterialNotFound(UUID id) {
        super("Attachment " + id + " does not exist.");
    }
}
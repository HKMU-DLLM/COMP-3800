package comp.comp3800.exception;

public class LectureNotFound extends Exception {
    public LectureNotFound (long id) {
        super("Lecture " + id + " does not exist.");
    }
}
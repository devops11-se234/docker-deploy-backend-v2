package camt.se234.deployment.service;

import org.springframework.stereotype.Service;

@Service
public class GradeServiceImpl implements GradeService {
    @Override
    public String getGrade(double score) {
        if (score >= 79.0) {
            return "A";
        }
        else if (score >= 74.5){
            return "B";
        }else if (score >= 59.2){
            return "C";
        }else if (score > 33.0) {
            return "D";
        } else
            return "F";

    }
}

package main.java;

import java.sql.Date;
import java.time.LocalDate;

public class Employer {

    private int idEmployer;
    private String fio;
    private boolean gender;
    private LocalDate birthDate;

    public Employer(int idEmployer, String fio, boolean gender, LocalDate birthDate) {
        this.idEmployer = idEmployer;
        this.fio = fio;
        this.gender = gender;
        this.birthDate = birthDate;
    }

    public Employer(String fio, boolean gender, LocalDate birthDate) {
        this.fio = fio;
        this.gender = gender;
        this.birthDate = birthDate;
    }

    public Employer() {

    }

    public int getIdEmployer() {
        return idEmployer;
    }

    public void setIdEmployer(int idEmployer) {
        this.idEmployer = idEmployer;
    }

    public String getFio() {
        return fio;
    }

    public void setFio(String fio) {
        this.fio = fio;
    }

    public boolean isGender() {
        return gender;
    }

    public boolean isMale(){
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public String getGender(){
        if(isMale()) return "М";
        return "Ж";
    }

    public void setGender(String gender){
        if(gender.equals("Мужчина")) this.gender=true;
        this.gender = false;
    }

    @Override
    public String toString() {
        return "Employer{" +
                "idEmployer=" + idEmployer +
                ", fio='" + fio + '\'' +
                ", gender=" + gender +
                ", birthDate=" + birthDate +
                '}';
    }
}

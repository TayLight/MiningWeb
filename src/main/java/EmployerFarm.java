package main.java;

public class EmployerFarm {
    private int idFarm;
    private int idEmployer;

    public EmployerFarm() {
    }

    public EmployerFarm(int idFarm, int idEmployer) {
        this.idFarm = idFarm;
        this.idEmployer = idEmployer;
    }

    public int getIdFarm() {
        return idFarm;
    }

    public void setIdFarm(int idFarm) {
        this.idFarm = idFarm;
    }

    public int getIdEmployer() {
        return idEmployer;
    }

    public void setIdEmployer(int idEmployer) {
        this.idEmployer = idEmployer;
    }
}

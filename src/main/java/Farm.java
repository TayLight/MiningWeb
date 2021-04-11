package main.java;

public class Farm {

    private int idFarm;
    private int expProfit;

    public Farm(int idFarm, int expProfit) {
        this.idFarm = idFarm;
        this.expProfit = expProfit;
    }

    public Farm() {
    }

    public Farm(int expProfit) {
        this.expProfit = expProfit;
    }

    public int getIdFarm() {
        return idFarm;
    }

    public void setIdFarm(int idFarm) {
        this.idFarm = idFarm;
    }

    public int getExpProfit() {
        return expProfit;
    }

    public void setExpProfit(int expProfit) {
        this.expProfit = expProfit;
    }

    @Override
    public String toString() {
        return "Farm{" +
                "idFarm=" + idFarm +
                ", expProfit=" + expProfit +
                '}';
    }
}

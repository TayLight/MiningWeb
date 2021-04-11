package main.java;

public class VideoCard {

    private int idVideoCard;
    private String title;
    private int countMB;
    private String maker;
    private int frequency;
    private int percent;
    private int idFarm;

    public int getIdFarm() {
        return idFarm;
    }

    public void setIdFarm(int idFarm) {
        this.idFarm = idFarm;
    }

    public VideoCard(int idVideoCard, String title, int countMB, String maker, int frequency, int percent) {
        this.idVideoCard = idVideoCard;
        this.title = title;
        this.countMB = countMB;
        this.maker = maker;
        this.frequency = frequency;
        this.percent = percent;
    }

    public VideoCard(String title, int countMB, String maker, int frequency, int percent) {
        this.title = title;
        this.countMB = countMB;
        this.maker = maker;
        this.frequency = frequency;
        this.percent = percent;
    }

    public VideoCard() {

    }

    public int getIdVideoCard() {
        return idVideoCard;
    }

    public void setIdVideoCard(int idVideoCard) {
        this.idVideoCard = idVideoCard;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getCountMB() {
        return countMB;
    }

    public void setCountMB(int countMB) {
        this.countMB = countMB;
    }

    public String getMaker() {
        return maker;
    }

    public void setMaker(String maker) {
        this.maker = maker;
    }

    public int getFrequency() {
        return frequency;
    }

    public void setFrequency(int frequency) {
        this.frequency = frequency;
    }

    public int getPercent() {
        return percent;
    }

    public void setPercent(int percent) {
        this.percent = percent;
    }

    @Override
    public String toString() {
        return "VideoCard{" +
                "idVideoCard=" + idVideoCard +
                ", title='" + title + '\'' +
                ", countMB=" + countMB +
                ", maker='" + maker + '\'' +
                ", frequency=" + frequency +
                ", percent=" + percent +
                '}';
    }
}

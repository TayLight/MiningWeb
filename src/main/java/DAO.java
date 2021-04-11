package main.java;

import java.sql.*;
import java.time.Instant;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

public class DAO {
    private DBUtil db;

    public DAO() {
        db=new DBUtil();
    }

    public void addFarm(Farm farm) {
        try (Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("INSERT INTO public.farm(expprofit) values (?)");
            preparedStatement.setInt(1, farm.getExpProfit());
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addVideoCard(VideoCard videoCard) {
        try (Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("INSERT INTO public.videocard(title, countmb, maker, frequency, percent) " +
                            "values (?, ?, ?, ?, ?)");
            preparedStatement.setString(1, videoCard.getTitle());
            preparedStatement.setInt(2, videoCard.getCountMB());
            preparedStatement.setString(3, videoCard.getMaker());
            preparedStatement.setInt(4, videoCard.getFrequency());
            preparedStatement.setInt(5, videoCard.getPercent());
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Employer addEmployer(Employer employer) {
        try (Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("INSERT INTO public.employer(fio, gender, birthdate) " +
                            "values (?, ?, ?)");
            preparedStatement.setString(1, employer.getFio());
            preparedStatement.setBoolean(2, employer.isMale());
            preparedStatement.setDate(3, Date.valueOf(employer.getBirthDate()));
            preparedStatement.execute();
            preparedStatement = connection.prepareStatement("SELECT * FROM employer ORDER BY id_employer DESC LIMIT 1;");
            ResultSet rs =preparedStatement.executeQuery();
            while (rs.next()) {
                employer = new Employer();
                employer.setIdEmployer(rs.getInt("id_employer"));
                employer.setFio(rs.getString("fio"));
                employer.setGender(rs.getBoolean("gender"));
                Date date = rs.getDate("birthdate");
                employer.setBirthDate(Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalDate());
                return employer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employer;
    }

    public void deleteFarm(int id) {
        try (Connection connection = db.getConnection()) {
            updateVideocardOnDeleteFarm(id);
            deleteFarmEmployerByFarm(id);
            PreparedStatement preparedStatement = connection.prepareStatement("delete from public.farm where id_farm=?");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateVideocardOnDeleteFarm(int id){
        try(Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("update videocard set id_farm=null where id_farm = ?");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Farm> getAllFarmsByIdVideoCard(int id) {
        ArrayList<Farm> farms = new ArrayList<>();
        try (Connection connection = db.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select * from public.videocard where id_farm=" + id);
            while (rs.next()) {
                Farm farm;
                farm = getFarmById(rs.getInt("id_farm"));
                farms.add(farm);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return farms;
    }

    public void addFarmEmployer(int idEmployer, int idFarm){
        try(Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("insert into public.farm_employer (id_farm, id_employer) values (?, ?)");
            preparedStatement.setInt(1, idFarm);
            preparedStatement.setInt(2, idEmployer);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addFarmEmployerWithIdEmployer(int idEmployer){
        try(Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("delete from public.farm_employer where id_employer=?");
            preparedStatement.setInt(1, idEmployer);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addFarmEmployerWithIdFarm(int idFarm){
        try(Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("delete from public.farm_employer where id_farm=?");
            preparedStatement.setInt(1, idFarm);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteEmployer(int id) {
        try (Connection connection = db.getConnection()) {
            deleteFarmEmployerByEmployer(id);
            PreparedStatement preparedStatement = connection.prepareStatement("delete from public.employer where id_employer =?");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void setVideocardForFarm(int videocard, int farm){
        System.out.println("Я сетю?");
        try (Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("update videocard set id_farm= ?" +
                            "where id_videocard = ?");
            preparedStatement.setInt(1, farm);
            preparedStatement.setInt(2, videocard);
            preparedStatement.execute();
            System.out.println("Я засетил");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteFarmEmployerByEmployer(int id){
        try (Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("delete from public.farm_employer where id_employer =?");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteFarmEmployerByFarm(int id){
        try (Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("delete from public.farm_employer where id_farm =?");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteVideoCard(int id) {
        try (Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("delete from public.videocard where id_videocard=?");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateFarm(Farm farm) {
        try (Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("update farm set expprofit = ? where id_farm = ?");
            preparedStatement.setInt(1, farm.getExpProfit());
            preparedStatement.setInt(2, farm.getIdFarm());
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateVideoCard(VideoCard videoCard) {
        try (Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("update videocard set title = ?,countmb = ?, maker = ?, frequency = ?, percent = ? " +
                            "where id_videocard = ?");
            preparedStatement.setString(1, videoCard.getTitle());
            preparedStatement.setInt(2, videoCard.getCountMB());
            preparedStatement.setString(3, videoCard.getMaker());
            preparedStatement.setInt(4, videoCard.getFrequency());
            preparedStatement.setInt(5, videoCard.getPercent());
            preparedStatement.setInt(6, videoCard.getIdVideoCard());
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Employer getEmployerById(int id){
        try(Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("select * from employer where id_employer=?");
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Employer employer = new Employer();
                employer.setIdEmployer(rs.getInt("id_employer"));
                employer.setFio(rs.getString("fio"));
                employer.setGender(rs.getBoolean("gender"));
                Date date = rs.getDate("birthdate");
                employer.setBirthDate(Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalDate());
                return employer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Farm getFarmById(int id){
        try(Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("select * from farm where id_farm=?");
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Farm farm = new Farm();
                farm.setIdFarm(rs.getInt("id_farm"));
                farm.setExpProfit(rs.getInt("expprofit"));
                return farm;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public VideoCard getVideocardById(int id){
        try(Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("select * from videocard where id_videocard=?");
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                VideoCard videoCard = new VideoCard();
                videoCard.setIdVideoCard(rs.getInt("id_videocard"));
                videoCard.setTitle(rs.getString("title"));
                videoCard.setCountMB(rs.getInt("countmb"));
                videoCard.setMaker(rs.getString("maker"));
                videoCard.setFrequency(rs.getInt("frequency"));
                videoCard.setPercent(rs.getInt("percent"));
                videoCard.setIdFarm(rs.getInt("id_farm"));
                return videoCard;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateEmployer(Employer employer) {
        try (Connection connection = db.getConnection()) {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("update public.employer set fio=?, gender=?, birthdate=? where  id_employer = ?");
            preparedStatement.setString(1, employer.getFio());
            preparedStatement.setBoolean(2, employer.isMale());
            preparedStatement.setDate(3, Date.valueOf(employer.getBirthDate()));
            preparedStatement.setInt(4, employer.getIdEmployer());
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Farm> getAllFarms() {
        ArrayList<Farm> farms = new ArrayList<Farm>();
        try (Connection connection = db.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select * from farm");
            while (rs.next()) {
                Farm farm = new Farm();
                farm.setIdFarm(rs.getInt("id_farm"));
                farm.setExpProfit(rs.getInt("expprofit"));
                farms.add(farm);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return farms;
    }

    public ArrayList<Farm> getAllFarmsByIdEmployer(int id) {
        ArrayList<Farm> farms = new ArrayList<Farm>();
        try (Connection connection = db.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select * from public.farm_employer where id_employer=" + id);
            while (rs.next()) {
                Farm farm = getFarmById(rs.getInt("id_farm"));
                farms.add(farm);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return farms;
    }

    public ArrayList<Employer> getAllEmployersByIdFarm(int id) {
        ArrayList<Employer> farms = new ArrayList<Employer>();
        try (Connection connection = db.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select * from public.farm_employer where id_farm=" + id);
            while (rs.next()) {
                Employer farm;
                farm = getEmployerById(rs.getInt("id_employer"));
                farms.add(farm);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return farms;
    }

    public ArrayList<Employer> getAllEmployers() {
        ArrayList<Employer> employers = new ArrayList<Employer>();
        try (Connection connection = db.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select * from employer");
            while (rs.next()) {
                Employer employer = new Employer();
                employer.setIdEmployer(rs.getInt("id_employer"));
                employer.setFio(rs.getString("fio"));
                employer.setGender(rs.getBoolean("gender"));
                Date date = rs.getDate("birthdate");
                employer.setBirthDate(Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalDate());
                employers.add(employer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employers;
    }

    public ArrayList<VideoCard> getAllVideoCards() {
        ArrayList<VideoCard> videoCards = new ArrayList<VideoCard>();
        try (Connection connection = db.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select * from videocard");
            while (rs.next()) {
                VideoCard videoCard = new VideoCard();
                videoCard.setIdVideoCard(rs.getInt("id_videocard"));
                videoCard.setTitle(rs.getString("title"));
                videoCard.setCountMB(rs.getInt("countmb"));
                videoCard.setMaker(rs.getString("maker"));
                videoCard.setFrequency(rs.getInt("frequency"));
                videoCard.setPercent(rs.getInt("percent"));
                videoCards.add(videoCard);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return videoCards;
    }

    public static void main(String[] arg) {
        DAO dao = new DAO();
        List<VideoCard> people = dao.getAllVideoCards();
        List<Employer> employers = dao.getAllEmployers();
        List<Farm> farms = dao.getAllFarms();
        for (VideoCard person : people) {
            System.out.println(person);
        }
        for (Employer employer : employers) {
            System.out.println(employer);
        }
        for (Farm farm : farms) {
            System.out.println(farm);
        }
    }
}


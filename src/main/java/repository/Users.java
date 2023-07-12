package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import data.User;

public class Users {

	static final String url = "jdbc:oracle:thin:@192.168.4.93:1521:xe";
	static final String user = "C##ANGPANG_TWITTER";
	static final String password = "1q2w3e4rdh!";

	// 데이터 등록시 사용할 function
	public static int create(String id, String pass, String nick) {

		try {
			// 1. 연결
			Connection conn = DriverManager.getConnection(url, user, password);

			// 2. 요청 객체 준비
			String sql = "INSERT INTO USERS(ID,PASS,NICK) VALUES(?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, id.toLowerCase());
			ps.setString(2, pass);
			ps.setString(3, nick);

			int r = ps.executeUpdate();

			conn.close();
			return r;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	// 특정ID를 가진 데이터를 찾고자할때 사용할 function
	public static User findById(String id) {
		try {
			Connection conn = DriverManager.getConnection(url, user, password);

			String sql = "SELECT * FROM USERS WHERE ID = ?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, id.toLowerCase());
			ResultSet rs = ps.executeQuery();

			User u = null;
			if (rs.next()) {
				u = new User();
				u.setId(rs.getString("id"));
				u.setPass(rs.getString("pass"));
				u.setNick(rs.getString("nick"));
				u.setProfile(rs.getString("profile"));
				u.setImg(rs.getString("img"));
				u.setJoined(rs.getDate("joined"));
			}

			conn.close();
			return u;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static int updateOne(String id, String nick, String profile, String img) {
		try {
			Connection conn = DriverManager.getConnection(url, user, password);

			String sql = "UPDATE USERS SET NICK=?, PROFILE=?, IMG=? WHERE ID=?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, nick);
			ps.setString(2, profile);
			ps.setString(3, img);
			ps.setString(4, id.toLowerCase());
			int r = ps.executeUpdate();

			conn.close();
			return r;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	public static List<User> findByKeyword(String q) {
		List<User> one = new ArrayList<>();

		try {
			Connection conn = DriverManager.getConnection(url, user, password);
			String sql = "select users.*, nvl(followers.cnt,0) as cnt from users "
					+ "left join followers on users.id = followers.target "
					+ "where nick like ?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + q + "%");

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setId(rs.getString("id"));
				user.setPass(rs.getString("pass"));
				user.setNick(rs.getString("nick"));
				user.setImg(rs.getString("img"));
				user.setProfile(rs.getString("profile"));
				user.setJoined(rs.getDate("joined"));
				user.setFollowerCnt(rs.getInt("cnt"));

				one.add(user);
			}
			conn.close();
			return one;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
}

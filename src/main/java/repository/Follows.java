package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import data.Follow;
import data.User;

public class Follows {
	static final String url = "jdbc:oracle:thin:@192.168.4.93:1521:xe";
	static final String user = "C##ANGPANG_TWITTER";
	static final String password = "1q2w3e4rdh!";

	public static int create(String code, String owner, String target) {
		try {
			// 1. 연결
			Connection conn = DriverManager.getConnection(url, user, password);
			// 2. 요청객체 준비
			String sql = "INSERT INTO FOLLOWS VALUES(?, ?, ?, SYSDATE)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, code);
			ps.setString(2, owner);
			ps.setString(3, target);
			// 3. 요청 실행
			int r = ps.executeUpdate();
			// 4. 연결해제
			conn.close();
			return r;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	public static List<Follow> findByOwner(String id) {
		try {
			// 1. 연결
			Connection conn = DriverManager.getConnection(url, user, password);
			// 2. 요청객체 준비
			String sql = "SELECT * FROM FOLLOWS JOIN USERS ON USERS.ID = FOLLOWS.TARGET WHERE OWNER=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, id);

			// 3. 요청후 응답 처리
			ResultSet rs = ps.executeQuery();

			List<Follow> list = new ArrayList<>();
			while (rs.next()) {
				String code = rs.getString("code");
				String owner = rs.getString("owner");
				String target = rs.getString("target");
				Date followed = rs.getDate("followed");

				User targetUser = new User();
				targetUser.setNick(rs.getString("nick"));
				targetUser.setProfile(rs.getString("profile"));
				targetUser.setImg(rs.getString("img"));
				targetUser.setJoined(rs.getDate("joined"));

				Follow f = new Follow();
				f.setCode(code);
				f.setOwner(owner);
				f.setFollowed(followed);
				f.setTarget(target);
				f.setTargetUser(targetUser);

				list.add(f);
			}
			conn.close();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}

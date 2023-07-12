package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import data.Follow;
import data.Tweet;
import data.TweetAttach;
import data.User;

public class Tweets {

	static final String url = "jdbc:oracle:thin:@192.168.4.93:1521:xe";
	static final String user = "C##ANGPANG_TWITTER";
	static final String password = "1q2w3e4rdh!";

	// 1. 데이터 등록
	public static int create(String code, String writer, String body) {

		try {
			Connection conn = DriverManager.getConnection(url, user, password);

			String sql = "INSERT INTO TWEETS(CODE, WRITER, BODY) VALUES(?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, code);
			ps.setString(2, writer);
			ps.setString(3, body);

			int r = ps.executeUpdate();

			conn.close();
			return r;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	// 2. 최신 글 5개
	public static List<Tweet> findLatest(int limit) {

		try {
			Connection conn = DriverManager.getConnection(url, user, password);
			String sql = "";
			PreparedStatement ps = null;
			if (limit == -1) {
				sql = "SELECT * FROM (SELECT * FROM TWEETS "
						+ "JOIN USERS ON USERS.ID = TWEETS.WRITER ORDER BY WRITED DESC)";
				ps = conn.prepareStatement(sql);
			} else {
				sql = "SELECT * FROM (SELECT * FROM TWEETS "
						+ "JOIN USERS ON USERS.ID = TWEETS.WRITER ORDER BY WRITED DESC) WHERE ROWNUM <=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, limit);
			}

			ResultSet rs = ps.executeQuery();

			List<Tweet> tw = new ArrayList<>();
			while (rs.next()) {
				Tweet tweet = new Tweet();
				TweetAttach tweetAttach = new TweetAttach();

				String code = rs.getString("code");
				String writer = rs.getString("writer");
				String body = rs.getString("body");
				Date writed = rs.getDate("writed");

				tweet.setCode(code);
				tweet.setWriter(writer);
				tweet.setBody(body);
				tweet.setWrited(writed);

				tw.add(tweet);
			}
			conn.close();
			return tw;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static int delete(String code) {

		try {
			Connection conn = DriverManager.getConnection(url, user, password);

			String sql = "DELETE FROM TWEETS WHERE CODE=?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, code);
			int r = ps.executeUpdate();

			conn.close();
			return r;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	public static int makeLike(String id, String targetCode) {
		try {
			Connection conn = DriverManager.getConnection(url, user, password);

			String sql = "insert into likes values(?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, id);
			ps.setString(2, targetCode);
			int r = ps.executeUpdate();

			conn.close();
			return r;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	public static List<Tweet> likeCnt(String id, String code) {
		List<Tweet> one = new ArrayList<>();

		try {
			Connection conn = DriverManager.getConnection(url, user, password);
			String sql = "select tweets.*, nvl(likers.cnt, 0) as cnt from tweets "
					+ "left join likers on likers.target_code = tweets.code";

			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Tweet tweet = new Tweet();
				tweet.setCode(rs.getString("code"));
				tweet.setWriter(rs.getString("writer"));
				tweet.setBody(rs.getString("body"));
				tweet.setWrited(rs.getDate("writed"));
				tweet.setLikeCnt(rs.getInt("cnt"));

				one.add(tweet);
			}
			conn.close();
			return one;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}

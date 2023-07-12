package data;

import java.util.Date;

public class Tweet {

	String code;
	String writer;
	String body;
	Date writed;

	// writer 추가 정보를 join 으로 얻을 때를 대비해서
	String writerNick;
	String writerImg;

	String targetCode;
	int likeCnt;

	// setter, getter 추가

	public String getCode() {
		return code;
	}

	public String getTargetCode() {
		return targetCode;
	}

	public void setTargetCode(String targetCode) {
		this.targetCode = targetCode;
	}

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public Date getWrited() {
		return writed;
	}

	public void setWrited(Date writed) {
		this.writed = writed;
	}

	public String getWriterNick() {
		return writerNick;
	}

	public void setWriterNick(String writerNick) {
		this.writerNick = writerNick;
	}

	public String getWriterImg() {
		return writerImg;
	}

	public void setWriterImg(String writerImg) {
		this.writerImg = writerImg;
	}

}

package kr.co.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class AlramVO {

	private String toId;
	private String fromId;
	private int bno;
	private String title;
	private String categori;
	private int bgno;
	
	
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="MM-dd hh:mm:ss")
	private Date alramDate;
	
	
	
	
	public int getBgno() {
		return bgno;
	}
	public void setBgno(int bgno) {
		this.bgno = bgno;
	}
	public Date getAlramDate() {
		return alramDate;
	}
	public void setAlramDate(Date alramDate) {
		this.alramDate = alramDate;
	}
	public String getToId() {
		return toId;
	}
	public void setToId(String toId) {
		this.toId = toId;
	}
	public String getFromId() {
		return fromId;
	}
	public void setFromId(String fromId) {
		this.fromId = fromId;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCategori() {
		return categori;
	}
	public void setCategori(String categori) {
		this.categori = categori;
	}
	
	
}

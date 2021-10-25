package kr.co.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ReplyVO {

	private int bno;
	private int rno;
	private String content;
	private String writer;
	private String id;
	private int likehit;
	private int hatehit;
	private int devhit;
	private BoardVO boardVO;
	
	
	
	
	
	
	
	public BoardVO getBoardVO() {
		return boardVO;
	}
	public void setBoardVO(BoardVO boardVO) {
		this.boardVO = boardVO;
	}
	public int getHatehit() {
		return hatehit;
	}
	public void setHatehit(int hatehit) {
		this.hatehit = hatehit;
	}
	public int getDevhit() {
		return devhit;
	}
	public void setDevhit(int devhit) {
		this.devhit = devhit;
	}

	private MemberVO memberVO;
	
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public int getLikehit() {
		return likehit;
	}
	public void setLikehit(int likehit) {
		this.likehit = likehit;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="MM-dd hh:mm:ss")
	private Date regdate;
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [bno=" + bno + ", rno=" + rno + ", content=" + content + ", writer=" + writer + ", regdate="
				+ regdate + "]";
	}
	
	
}
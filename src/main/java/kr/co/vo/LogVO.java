package kr.co.vo;

import java.util.Date;

public class LogVO {
	private String memberId;
	private int bno;
	private int rno;
	private String questionId;
	private int categori;
	private Date logdate;
	private BoardVO boardVO;
	private ReplyVO replyVO;
	
	
	
	
	public BoardVO getBoardVO() {
		return boardVO;
	}
	public void setBoardVO(BoardVO boardVO) {
		this.boardVO = boardVO;
	}
	public ReplyVO getReplyVO() {
		return replyVO;
	}
	public void setReplyVO(ReplyVO replyVO) {
		this.replyVO = replyVO;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
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
	public String getQuestionId() {
		return questionId;
	}
	public void setQuestionId(String questionId) {
		this.questionId = questionId;
	}
	public int getCategori() {
		return categori;
	}
	public void setCategori(int categori) {
		this.categori = categori;
	}
	public Date getLogdate() {
		return logdate;
	}
	public void setLogdate(Date logdate) {
		this.logdate = logdate;
	}
	
	
	
	

}

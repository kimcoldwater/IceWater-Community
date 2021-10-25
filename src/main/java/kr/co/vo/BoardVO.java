package kr.co.vo;

import java.util.Date;

public class BoardVO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private int hit;
	private int replyhit;
	private int next;
	private int last;
	private String nexttitle;
	private String lasttitle;
	private int bgnoinsert;
	private int bgno;
	private String id;
	private int likehit;
	private int hatehit;
	private int devhit;
	private int helppoint;
	private int questioncheck;
	private String questionid;
	private BoardCheckVO boardCheckVO;
	private MemberVO memberVO;
	
	private Date scrapdate;
	
	
	
	
	
	
	
	
	public Date getScrapdate() {
		return scrapdate;
	}
	public void setScrapdate(Date scrapdate) {
		this.scrapdate = scrapdate;
	}
	public String getQuestionid() {
		return questionid;
	}
	public void setQuestionid(String questionid) {
		this.questionid = questionid;
	}
	public int getHelppoint() {
		return helppoint;
	}
	public void setHelppoint(int helppoint) {
		this.helppoint = helppoint;
	}
	public int getQuestioncheck() {
		return questioncheck;
	}
	public void setQuestioncheck(int questioncheck) {
		this.questioncheck = questioncheck;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public int getDevhit() {
		return devhit;
	}
	public void setDevhit(int devhit) {
		this.devhit = devhit;
	}
	
	
	
	
	



	public BoardCheckVO getBoardCheckVO() {
		return boardCheckVO;
	}
	public void setBoardCheckVO(BoardCheckVO boardCheckVO) {
		this.boardCheckVO = boardCheckVO;
	}
	
	public int getHatehit() {
		return hatehit;
	}
	public void setHatehit(int hatehit) {
		this.hatehit = hatehit;
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
	public int getBgno() {
		return bgno;
	}
	public void setBgno(int bgno) {
		this.bgno = bgno;
	}
	public int getBgnoinsert() {
		return bgnoinsert;
	}
	public void setBgnoinsert(int bgnoinsert) {
		this.bgnoinsert = bgnoinsert;
	}
	public String getNexttitle() {
		return nexttitle;
	}
	public void setNexttitle(String nexttitle) {
		this.nexttitle = nexttitle;
	}
	public String getLasttitle() {
		return lasttitle;
	}
	public void setLasttitle(String lasttitle) {
		this.lasttitle = lasttitle;
	}
	public int getNext() {
		return next;
	}
	public void setNext(int next) {
		this.next = next;
	}
	public int getLast() {
		return last;
	}
	public void setLast(int last) {
		this.last = last;
	}
	public int getReplyhit() {
		return replyhit;
	}
	public void setReplyhit(int replyhit) {
		this.replyhit = replyhit;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
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
	
	

}

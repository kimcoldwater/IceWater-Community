package kr.co.vo;

import java.util.Date;

public class MemberVO{

	private String memberId;
	private String memberPw;
	private String memberName; 
	private String memberEmail;
	private Date memberJoinDate; 
	private String memberImg; 
	private int memberPoint;
	private String memberId_yn;
	private int memberAuth;
	private int memberDevPoint;
	private int memberRank;
	private Date memberSanctionTime;
	
	private String email;
	private String naverid;
	private String nickname;
	
	
	
	
	
	public Date getMemberSanctionTime() {
		return memberSanctionTime;
	}
	public void setMemberSanctionTime(Date memberSanctionTime) {
		this.memberSanctionTime = memberSanctionTime;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNaverid() {
		return naverid;
	}
	public void setNaverid(String naverid) {
		this.naverid = naverid;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getMemberRank() {
		return memberRank;
	}
	public void setMemberRank(int memberRank) {
		this.memberRank = memberRank;
	}
	public int getMemberDevPoint() {
		return memberDevPoint;
	}
	public void setMemberDevPoint(int memberDevPoint) {
		this.memberDevPoint = memberDevPoint;
	}
	public int getMemberAuth() {
		return memberAuth;
	}
	public void setMemberAuth(int memberAuth) {
		this.memberAuth = memberAuth;
	}
	public String getMemberId_yn() {
		return memberId_yn;
	}
	public void setMemberId_yn(String memberId_yn) {
		this.memberId_yn = memberId_yn;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public Date getMemberJoinDate() {
		return memberJoinDate;
	}
	public void setMemberJoinDate(Date memberJoinDate) {
		this.memberJoinDate = memberJoinDate;
	}
	public String getMemberImg() {
		return memberImg;
	}
	public void setMemberImg(String memberImg) {
		this.memberImg = memberImg;
	}
	public int getMemberPoint() {
		return memberPoint;
	}
	public void setMemberPoint(int memberPoint) {
		this.memberPoint = memberPoint;
	}
	@Override
	public String toString() {
		return "MemberVO [memberId=" + memberId + ", memberPw=" + memberPw + ", memberName=" + memberName
				+ ", memberEmail=" + memberEmail + ", memberJoinDate=" + memberJoinDate + ", memberImg=" + memberImg
				+ ", memberPoint=" + memberPoint + "]";
	}
  
	
	
}
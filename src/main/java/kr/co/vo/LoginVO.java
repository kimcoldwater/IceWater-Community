package kr.co.vo;

public class LoginVO {

	private String memberId;
	private String memberPw;
	private boolean useCookie;
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public boolean isUseCookie() {
		return useCookie;
	}
	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}


	
	
}

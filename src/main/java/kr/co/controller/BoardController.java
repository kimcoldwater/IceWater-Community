package kr.co.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.service.BoardService;
import kr.co.service.ReplyService;
import kr.co.vo.AlramVO;
import kr.co.vo.BoardVO;
import kr.co.vo.MemberVO;
import kr.co.vo.PageMaker;
import kr.co.vo.ReplyVO;
import kr.co.vo.SearchCriteria;

@CrossOrigin(origins = "*")
@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
		
	@Inject
	BoardService service;
	
	@Inject
	ReplyService replyService;
	
	@RequestMapping(value="/startPage", method=RequestMethod.GET)
	public String startPage() throws Exception{
		return "/board/startPage";
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, Model model)throws Exception {
		String memberId = "";
		
		if(session.getAttribute("login") != null) {
		MemberVO memberVO =(MemberVO) session.getAttribute("login");
		memberId = memberVO.getMemberId();
		}
		model.addAttribute("list",service.bestList(memberId));
		model.addAttribute("qna",service.qnaList(memberId));
		model.addAttribute("best1",service.bestList1(memberId));
		model.addAttribute("best3",service.bestList3(memberId));
		model.addAttribute("best4",service.bestList4(memberId));
		model.addAttribute("best6",service.bestList6(memberId));
		model.addAttribute("bestBoard",service.bestBoard(memberId));
		return "/board/home";
	}
	
	@RequestMapping(value = "board/list", method = RequestMethod.GET)
	public String list(HttpSession session,Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("list"+scri.getBgno());
		
			if(session.getAttribute("login") != null) {
			MemberVO memberVO =(MemberVO) session.getAttribute("login");			
			scri.setMemberId(memberVO.getMemberId());
		
			}
		
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(scri);
			pageMaker.setTotalCount(service.listCount(scri));
		model.addAttribute("list", service.list(scri));
		model.addAttribute("notice", service.notice());
	
		
		model.addAttribute("pageMaker", pageMaker);
		
	
	
		
		return "board/list";
		
	}
	
	
	//????????? ?????????
	@RequestMapping(value = "/board/writeView", method=RequestMethod.GET)
	public String writeView(HttpSession session ,@ModelAttribute("scri") SearchCriteria scri,Model model) throws Exception{
		logger.info("writeView ID");
		MemberVO memberVO =(MemberVO) session.getAttribute("login");
		model.addAttribute("point", service.questionPointCheck(memberVO.getMemberId()));
		
		model.addAttribute("bgno", scri.getBgno());
		
		
		
		return "/board/writeView";
		
	}
	
	//?????????
	@RequestMapping(value="/board/write", method=RequestMethod.POST)
	public String write(BoardVO boardVO,MultipartHttpServletRequest mpRequest, RedirectAttributes rttr,@ModelAttribute("scri")SearchCriteria scri) throws Exception{
		logger.info("write");
		logger.info("mpRequest");
		//????????????????????????
		if(boardVO.getBgnoinsert() == 25 || boardVO.getBgnoinsert() == 26|| 
				boardVO.getBgnoinsert() == 27 || boardVO.getBgnoinsert() == 28 || boardVO.getBgnoinsert() == 32) {
			service.upDevPoint(3, boardVO.getId());
		}else {
			service.upPoint(3, boardVO.getId());
		}
		
		service.write(boardVO,mpRequest);
		
		//??????????????????
		if(boardVO.getHelppoint() != 0) {
		service.questionPointDown(boardVO.getHelppoint(),boardVO.getId());
		
		}
		
		
		
		
		rttr.addAttribute("bgno", scri.getBgno());
		rttr.addAttribute("sort", scri.getSort());
		return "redirect:/board/list";
	}
	
	
	
	@RequestMapping(value="/board/readView", method=RequestMethod.GET)
	public String read(HttpSession session,@ModelAttribute("scri") SearchCriteria scri,BoardVO boardVO, Model model) throws Exception{
		logger.info("read");
		
		//?????? ?????? ??????
		if(session.getAttribute("login") != null) {
			MemberVO memberVO =(MemberVO) session.getAttribute("login");
		
		//?????? ???????????? ?????????????????? insert
		if(service.boardCheck(boardVO.getBno(),memberVO.getMemberId())==0) {
		
		service.insertBoardCheck(boardVO.getBno(), memberVO.getMemberId());
		}
		
		//????????? ????????? ?????? ?????? ??????
		BoardVO movePageVO = service.movePage(boardVO);
		
		int nextPageCheck = service.nextPageCheck(movePageVO.getNext(), memberVO.getMemberId());
		model.addAttribute("nextPageCheck", nextPageCheck);
		
		int lastPageCheck = service.nextPageCheck(movePageVO.getLast(),memberVO.getMemberId());
		model.addAttribute("lastPageCheck", lastPageCheck);
		}
		
		model.addAttribute("read", service.read(boardVO.getBno()));
		model.addAttribute("scri", scri);
		model.addAttribute("replyVO",new ReplyVO());
		
		List<Map<String, Object>> fileList = service.selectFileList(boardVO.getBno());
		model.addAttribute("file", fileList);
		
		model.addAttribute("move", service.movePage(boardVO));
		model.addAttribute("scrap", service.scrapCount(boardVO.getBno()));
		
		
		return "/board/readView";
				
	}
	
	@RequestMapping(value="/board/updateView", method=RequestMethod.GET)
	public String updateView(BoardVO boardVO, Model model , @ModelAttribute("scri") SearchCriteria scri)throws Exception{
		logger.info("updateView");
		
		model.addAttribute("update", service.read(boardVO.getBno()));
		model.addAttribute("scri",scri);
		
		List<Map<String, Object>> fileList = service.selectFileList(boardVO.getBno());
		model.addAttribute("file", fileList);
		
		return"board/updateView";
	}
	
	// ????????? ??????
		@RequestMapping(value = "/update", method = RequestMethod.POST)
		public String update(BoardVO boardVO, 
							 @ModelAttribute("scri") SearchCriteria scri, 
							 RedirectAttributes rttr,
							 @RequestParam(value="fileNoDel[]") String[] files,
							 @RequestParam(value="fileNameDel[]") String[] fileNames,
							 MultipartHttpServletRequest mpRequest) throws Exception {
			logger.info("update");
			service.update(boardVO, files, fileNames, mpRequest);
			
			rttr.addAttribute("bno", boardVO.getBno());
			rttr.addAttribute("bgno", scri.getBgno());
			rttr.addAttribute("page", scri.getPage());
			rttr.addAttribute("perPageNum", scri.getPerPageNum());
			rttr.addAttribute("searchType", scri.getSearchType());
			rttr.addAttribute("keyword", scri.getKeyword());
			rttr.addAttribute("sort", scri.getSort());

			return "redirect:/board/readView";
		}
				
	
		@RequestMapping(value = "/board/delete", method = RequestMethod.POST)
		public String delete(BoardVO boardVO,@ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception{
			logger.info("delete ID"+boardVO.getId());
			
			service.delete(boardVO);
			
			rttr.addAttribute("bgno", scri.getBgno());
			rttr.addAttribute("page", scri.getPage());
			rttr.addAttribute("perPageNum", scri.getPerPageNum());
			rttr.addAttribute("searchType", scri.getSearchType());
			rttr.addAttribute("keyword", scri.getKeyword());
			rttr.addAttribute("sort", scri.getSort());
			return "redirect:/board/list";
		}
		
		@RequestMapping(value="/board/fileDown")
		public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
			Map<String, Object> resultMap = service.selectFileInfo(map);
			String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
			String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
			
			// ????????? ???????????? ???????????? ??????????????? ?????? byte[]???????????? ????????????.
			byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("/var/lib/tomcat9/webapps/upload/"+storedFileName));
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
		}
		
		
		
		
		//LIKE??????
		@ResponseBody
		@RequestMapping(value = "/board/updateLike" , method = RequestMethod.POST)
		public int updateLike(HttpSession session,int bno,@RequestParam("memberId")String memberId,@RequestParam("writerId")String writerId,Model model)throws Exception{
				logger.info("?????????");
				
				MemberVO memberVO =(MemberVO) session.getAttribute("login");
				String memberID = memberVO.getMemberId();
				logger.info("updateLike-memberID"+memberID);

				
				if(service.hateCheck(bno, memberId) == 1) {
					int likeCheck = 2;
					return likeCheck; 
				}else {
				
				int likeCheck = service.likeCheck(bno, memberId);
				if(likeCheck == 0) {
					//????????? ????????????
					service.insertLike(bno, memberId); //like????????? ??????
					service.updateLike(bno);	//?????????????????? +1
					service.memberPointPlus(writerId); //??????????????? +1
					
				}else if(likeCheck == 1) {
					service.updateLikeCancel(bno); //?????????????????? =1
					service.deleteLike(bno, memberId); //like????????? ??????
					service.memberPointDown(writerId);
			
				}
				return likeCheck;
				}
			
		}
		
		//HATE ??????
		@ResponseBody
		@RequestMapping(value = "/board/updateHate" , method = RequestMethod.POST)
		public int updateHate(int bno, String memberId,String writerId,Model model)throws Exception{
				if(service.likeCheck(bno, memberId) == 1) {
					int hateCheck = 2;
				return hateCheck;
				
				}else {
				int hateCheck = service.hateCheck(bno, memberId);
				if(hateCheck == 0) {
					//????????? ????????????
					service.insertHate(bno, memberId); //like????????? ??????
					service.updateHate(bno);	//?????????????????? +1
					service.memberPointDown(writerId);
					
				}else if(hateCheck == 1) {
					service.updateHateCancel(bno); //?????????????????? =1
					service.deleteHate(bno, memberId); //like????????? ??????
					service.memberPointPlus(writerId);
					
				}
				return hateCheck;
				}
		
			
		}
		
		//DEV ??????
		@ResponseBody
		@RequestMapping(value = "/board/updateDev" , method = RequestMethod.POST)
		public int updateDev(int bno, String memberId,String writerId,Model model)throws Exception{
				int devCheck = service.devCheck(bno, memberId);
				if(devCheck == 0) {
					//????????? ????????????
					service.insertDev(bno, memberId); //like????????? ??????
					service.updateDev(bno);	//?????????????????? +1
					service.memberDevPointPlus(writerId);
					
				}else if(devCheck == 1) {
					service.updateDevCancel(bno); //?????????????????? =1
					service.deleteDev(bno, memberId); //like????????? ??????
					service.memberDevPointDown(writerId);
					
				}
				return devCheck;
				}
		
			
		

		//??????
		@ResponseBody
		@RequestMapping(value = "/board/questionCheck",method=RequestMethod.POST)
		public int questionCheck(int bno,int helppoint,String Id,int rno,String memberId) throws Exception{
			int questionCheck ;
			try {
			service.questionPointUp(helppoint, Id);
			service.questionCheck(bno,rno);
			service.insertLog(bno,rno,Id,memberId);
			service.insertLogReply(bno,rno,Id,memberId);
			questionCheck = 1;
			}catch(Exception e) {
				questionCheck = 2;
				return questionCheck;
			}
			return questionCheck;
			
			
		}
		
		
		
		
		//?????????
		@ResponseBody
		@RequestMapping(value = "/board/scrap", method=RequestMethod.POST)
		public int scrap (String Id, int bno) throws Exception{
			int scrap = service.scrapCheck(Id, bno);
			if (scrap == 0) {
			service.scrap(Id, bno);
			}else if(scrap == 1) {
			service.scrapCancel(Id, bno);
			}
			return scrap;
		}
		
		
		@RequestMapping(value="/board/mypageView", method=RequestMethod.GET)
		public String mypageView(String select,String memberId,Model model) throws Exception{
			logger.info("select"+select);
			model.addAttribute("info",service.memberInfo(memberId));
			model.addAttribute("memberId", memberId);
			model.addAttribute("memberDevCount", service.memberDevCount(memberId));
			
			if(select.equals("log")) {
			model.addAttribute("log",service.memberLog(memberId));
			}else if(select.equals("write")) {
			model.addAttribute("write",service.memberWrite(memberId));
			}else if(select.equals("scrap")) {
			model.addAttribute("scrap", service.memberScrap(memberId));
			}else if(select.equals("reply")) {
			model.addAttribute("reply", service.memberReply(memberId));
			}
			return "/board/mypageView";
			
		}
		
		
		//???????????????
		@RequestMapping(value = "board/popular", method = RequestMethod.GET)
		public String popularBoard(HttpSession session,Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
			logger.info("list"+scri.getBgno());
			
				if(session.getAttribute("login") != null) {
				MemberVO memberVO =(MemberVO) session.getAttribute("login");			
				scri.setMemberId(memberVO.getMemberId());
			
				}
			
				
				PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(scri);
				pageMaker.setTotalCount(service.popularCount(scri));
			model.addAttribute("list", service.popularBoard(scri));
			model.addAttribute("notice", service.notice());
		
			
			model.addAttribute("pageMaker", pageMaker);
			
		
		
			
			return "/board/popular";
			
		}
	
		
		
		
		
		//??????
				@ResponseBody
				@RequestMapping(value = "/board/insertAlram", method=RequestMethod.POST)
				public int insertAlram (String toId , String fromId , String bno , String title , String categori,String bgno) throws Exception{
					logger.info("??????insert"+categori+"//"+fromId+toId+bno+categori+title);
					int alram = 1;
					
					service.insertAlram(toId, fromId, bno, title, categori,bgno);
					
					return alram;
				}
		
		//?????????
				@ResponseBody
				@RequestMapping(value = "/board/alramCount", method=RequestMethod.GET)
				public int alramCount (String memberId) throws Exception{
					
					int alram = service.alramCount(memberId);
					
					return alram;
				}	
				
				
				//????????????
				@ResponseBody
				@RequestMapping(value = "/board/alramList", method=RequestMethod.GET)
				public List<AlramVO> alramList(String memberId) throws Exception{
										
					return service.alramList(memberId);
				}	
				
				
				//????????????
				@ResponseBody
				@RequestMapping(value = "/board/alramClick", method=RequestMethod.POST)
				public String alramClick(String memberId, int bno) throws Exception{
					logger.info("????????????");
					service.alramClick(memberId, bno);
					
					return "/board/readView?bno="+bno;
				}	
				
		
}
	
		
	



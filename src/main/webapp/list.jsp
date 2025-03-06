<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="jspboard.Paging" %>
<%-- <%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>    
<%@ page import="java.text.SimpleDateFormat, jspboard.*" %> --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="include/header.jsp" %>
<script>
window.onpageshow = function(event){   // onpageshow는 page 호출되면 캐시든 아니든 무조건 호출된다.
    if (event.persisted || (window.performance && window.performance.navigation.type == 2)){
        // 사파리 or 안드로이드에서 뒤로가기로 넘어온 경우 캐시를 이용해 화면을 보여주는데, 
        // 이때 사파리의 경우 event.persisted 가 ture다. 
        // 그외 브라우저(크롬 등)에서는 || 뒤에 있는 조건으로 뒤로가기인지 체크가 가능하다!
        window.location.reload();
    }
};
</script>

<c:set var="pg" 
       value="${param.pg ne null and not empty param.pg ? param.pg : 1 }" />
<c:set var="listSize" value="${ param.listSize ne null and not empty param.listSize ? param.listSize : 10 }" />
<jsp:useBean id="dao" class="jspboard.BoardDAO" scope="page"/>
<c:set var="boardList" value="${ dao.getListBoards(pg, listSize,  param.searchOption, param.searchKeyword)}" />
<c:set var="totalPosts" value="${ dao.getTotalPosts(param.searchOption, param.searchKeyword) }" />

<%
// el 변수를 자바변수로 변환
	int currentPage = Integer.parseInt(pageContext.getAttribute("pg").toString());
	int totalPosts = Integer.parseInt(pageContext.getAttribute("totalPosts").toString());
	int postsPerPage = Integer.parseInt(pageContext.getAttribute("listSize").toString());
	
	int pagesPerBlock = 10;

	Paging paging = new Paging(currentPage, totalPosts, postsPerPage, pagesPerBlock);
	
	request.setAttribute("paging", paging);
%>

<%-- <%
    int pg = 1;
    int listSize = 10;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");   
    try{
       String getPg = request.getParameter("pg");
       if(getPg != null && !getPg.trim().isEmpty()){
          pg = Integer.parseInt(getPg);
       }
       
    }catch(NumberFormatException e){
       pg = 1;
    } 
    //DAO 객체
    BoardDAO dao = new BoardDAO();
    List<BoardDTO> bbsList = dao.getListBoards(pg, listSize);
%> --%>

<!-- design list -->
		<div class="search-box">
            <form name="search-form" method="get" id="searchBoard" action="getListBoards" class="d-flex justify-content-center">
                <div class="select-box">
                    <div class="selected">--검색선택-- <i class="ri-arrow-drop-down-line"></i></div>
                    <ul class="options">
                        <li data-value="author">이름검색</li>
                        <li data-value="title">제목검색</li>
                        <li data-value="content">내용검색</li>
                    </ul>
                </div>
                <input type="search" class="search-input" name="searchKeyword" placeholder="검색">
                <input type="hidden" id="option" name="searchOption" value="${param.searchOption }">
                <button type="submit" class="btn-search">검색</button>
                <button type="reset" class="btn-search" id="reset">초기화</button>
            </form>
        </div>
        <div class="d-flex justify-content-between pb-2">
            <div class="init-text d-flex">
                <div class="all-text"><i class="ri-first-list-line"></i>총 게시물&nbsp;&nbsp;<span><fmt:formatNumber value="${ totalPosts }"/></span> 건</div>
                <div class="now-text">현재 페이지&nbsp;&nbsp;<span>${ pg }/${ paging.getTotalPages() }</span></div>
            </div>
            <div class="sortting">
                <span>페이지당 목록</span>
                <select class="list-ct" id="list-ct">
                    <option value="5">5</option>
                    <option value="10" selected>10</option>
                    <option value="20">20</option>
                    <option value="30">30</option>
                </select>
            </div>
        </div>
        <table class="list-table">
            <colgroup>
                <col width="5%">
                <col width="65%">
                <col width="10%">
                <col width="10%">
                <col width="10%">
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>글쓴이</th>
                    <th>날짜</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>
				<!-- 루프 start -->
				<c:choose>
					<c:when test="${empty boardList}"><tr><td colspan="5">게시글이 없습니다.</td></tr></c:when>
					<c:otherwise>
						<c:forEach var="data" items="${boardList}" varStatus="status">
							<tr>
								<td class="text-center">${ data.id }</td>
								<td><a href="detail.jsp?id=${ data.id }" class="title-text">${ data.title }</a></td>
								<td class="text-center">${ data.writer }</td>
								<td class="text-center"><fmt:formatDate value="${ data.wDate }" pattern="yyyy.MM.dd"/></td>
								<td class="text-center">${ data.hit }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
                <!-- 루프 end -->
            </tbody>
        </table>
        <div class="d-flex justify-content-end mt-4">
            <a href="write.jsp" class="btn">글쓰기</a>
        </div>
        <ul class="paging">
        	<c:if test="${ paging.getStartPage() > 1 }">
	        	<!-- 처음 페이지로 이동 -->
	            <li><a href="list.jsp?pg=1&searchOption=${param.searchOption}&searchKeyword=${searchKeyword}&listSize=${listSize}" class="first"><i class="ri-arrow-left-double-line"></i></a></li>
	            
	        	<!-- 이전 페이지로 이동 -->
	            <li><a href="list.jsp?pg=${ paging.getStartPage() - 1 }&searchOption=${param.searchOption}&searchKeyword=${searchKeyword}&listSize=${listSize}" class="prev"><i class="ri-arrow-left-s-line"></i></a></li>
            </c:if>
            
            <c:forEach var="i" begin="${paging.getStartPage()}" end="${paging.getEndPage()}" varStatus="status">
            	<li>
            		<a href="list.jsp?pg=${ i }&searchOption=${param.searchOption}&searchKeyword=${searchKeyword}&listSize=${listSize}"
            			class="${ i == pg ?  'act' : ''}">${ i }</a>
            	</li>
            	
            </c:forEach>
            
            <c:if test="${ paging.getEndPage() < paging.getTotalPages() }">
            <!-- 다음 페이지로 이동 -->
            <li><a href="list.jsp?pg=${ paging.getEndPage() + 1 }&searchOption=${param.searchOption}&searchKeyword=${searchKeyword}&listSize=${listSize}" class="next"><i class="ri-arrow-right-s-line"></i></a></li>
            
            <!-- 마지막 페이지로 이동 -->
            <li><a href="list.jsp?pg=${ paging.getTotalPages() }&searchOption=${param.searchOption}&searchKeyword=${searchKeyword}&listSize=${listSize}" class="last"><i class="ri-arrow-right-double-line"></i></a></li>
            </c:if>
        </ul>
		<!-- / design list-->

		
<script src="/jspBoard/lib/js/script.js"></script>
    <!-- defer => document ready function 과 기능이 같음 -->
<%@ include file="include/footer.jsp" %>
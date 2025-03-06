package jspboard;

public class Paging {
	
	// 미리 알아야하는 변수 필드
	private int currentPage; // 현재 페이지 번호
	private int totalPosts; // 총 게시글 수
	private int postsPerPage; // 한 페이지에 보일 게시글 수
	private int pagesPerBlock; // 한 화면에 보일 페이지 수
	
	
	public Paging(int currentPage, int totalPosts, int postsPerPage, int pagesPerBlock) {
		this.currentPage = currentPage;
		this.totalPosts = totalPosts;
		this.postsPerPage = postsPerPage;
		this.pagesPerBlock = pagesPerBlock;
	}
	
	// 전체페이지 수
	public int getTotalPages() {
		return (int) Math.ceil((double) totalPosts / postsPerPage);
	}
	
	// pagesPerBlock의 시작페이지
	public int getStartPage() {
		return ((currentPage - 1) / pagesPerBlock) * pagesPerBlock +1;
	}
	
	// pagesPerBlock의 마지막페이지
	public int getEndPage() {
		int endPage = getStartPage() + pagesPerBlock - 1;
		int totalPages = getTotalPages();

		return (endPage > totalPages) ? totalPages : endPage;
	}

	// 에러 발생시 메세지 표시
	@Override
	public String toString() { 
		return "Paging [currentPage=" + currentPage + ", totalPosts=" + totalPosts + ", postsPerPage=" + postsPerPage
				+ ", pagesPerBlock=" + pagesPerBlock + ", getTotalPages()=" + getTotalPages() + ", getStartPage()="
				+ getStartPage() + ", getEndPage()=" + getEndPage() + "]";
	}
	
}

 package jspboard;
 
 import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
 
 
 
 
 public class BoardDAO
 {
   Connection conn = null;
   public BoardDAO() {
     try {
       Context initContext = new InitialContext();
       DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/mydb");
       this.conn = ds.getConnection();
     } catch (Exception e) {
       e.printStackTrace();
       throw new RuntimeException("DB 연결에 실패했습니다.");
     } 
   }
   
//   총 게시글 목록 조회
   public int getTotalPosts(String searchOption, String searchKeyword) {
	   int totalPosts = 0;
	   
	   StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM MYBBS");
	   
	   if(searchOption != null && searchKeyword != null 
	             && !searchKeyword.trim().isEmpty()) {
		   sql.append(" WHERE ").append(searchOption).append(" LIKE ?");
	   }
	   
	   try(PreparedStatement ps = conn.prepareStatement(sql.toString())) {
		   if(searchOption != null && searchKeyword != null 
                   && !searchKeyword.trim().isEmpty()) {
			   ps.setString(1, "%" + searchKeyword + "%");
		   }
		   
		   ResultSet rs = ps.executeQuery();
		   if(rs.next()) {
			   totalPosts = rs.getInt(1);
		   }
		   
	   } catch(SQLException e) {
		   e.printStackTrace();
	   }
	   
	   return totalPosts;
   }
   
   public List<BoardDTO> getListBoards(int pg, int listSize, String searchOption, String searchKeyword) {
     List<BoardDTO> boardList = new ArrayList<>();
     StringBuilder sql = new StringBuilder("SELECT * FROM MYBBS");
     
     if(searchOption != null && searchKeyword != null 
             && !searchKeyword.trim().isEmpty()) {
		sql.append(" WHERE ").append(searchOption).append(" LIKE ?");
		}
	sql.append(" ORDER BY id DESC LIMIT ?, ?");
	int paramIndex = 1;
	PreparedStatement pstmt;
 
	try {
		pstmt = conn.prepareStatement(sql.toString());
		if(searchOption != null && searchKeyword != null 
                                          && !searchKeyword.trim().isEmpty()) {
          pstmt.setString(paramIndex++, "%" + searchKeyword + "%");
        }		
	    pstmt.setInt(paramIndex++, (pg -1) * listSize);
	    pstmt.setInt(paramIndex, listSize);
        ResultSet rs = pstmt.executeQuery();
      
        while(rs.next()) {
     	   BoardDTO dto = new BoardDTO();
    	      dto.setId(rs.getLong("id"));
    	      dto.setWriter(rs.getString("writer"));
    	      dto.setUserId(rs.getString("userId"));
    	      dto.setPass(rs.getString("pass"));
    	      dto.setTitle(rs.getString("title"));
    	      dto.setContent(rs.getString("content"));
    	      dto.setwDate(rs.getTimestamp("wDate"));
    	      dto.setHit(rs.getInt("hit"));
    	   
    	      boardList.add(dto);
          }
	    }catch (SQLException e) {
    		e.printStackTrace();
    	} 
	   return boardList;
	}
   
   public BoardDTO getDetailBoard(int boardId) {
	   String sql = "SELECT * FROM MYBBS WHERE 1=1 AND ID = ?";
	     BoardDTO dto = new BoardDTO();
	     
	     updateHit(boardId);
	     
	     try {
	       PreparedStatement ps = this.conn.prepareStatement(sql);
	       ps.setInt(1, boardId);
	       
	       ResultSet rs = ps.executeQuery();
	       if (rs.next()) {
	         dto.setId(rs.getLong("id"));
	         dto.setWriter(rs.getString("writer"));
	         dto.setUserId(rs.getString("userId"));
	         dto.setPass(rs.getString("pass"));
	         dto.setTitle(rs.getString("title"));
	         
//	         본문 줄바꿈 변환
//	         String content = rs.getString("content").replace("\n", "<br>");
	        
	         dto.setContent(rs.getString("content"));
	         dto.setHit(rs.getInt("hit"));
	         dto.setwDate(rs.getTimestamp("wDate"));
	         
	        
	       } 
	     } catch (Exception e) {
	       e.printStackTrace();
	     } 
	 
	     
	     return dto;
	   }
 
   
   public List<MembersDTO> getMemberList(int pg, int listSize) {
     List<MembersDTO> memList = new ArrayList<>();
     String sql = "SELECT * FROM MEMBERS  ORDER BY ID DESC LIMIT ?, ?";
     
     try {
       PreparedStatement ps = this.conn.prepareStatement(sql);
       ps.setInt(1, (pg - 1) * listSize);
       ps.setInt(2, listSize);
       
       ResultSet rs = ps.executeQuery();
       
       while (rs.next()) {
         MembersDTO dto = new MembersDTO();
         
         dto.setId(rs.getInt("id"));
         dto.setUserId(rs.getString("userId"));
         dto.setPasswd(rs.getString("passwd"));
         dto.setName(rs.getString("name"));
         dto.setEmail(rs.getString("email"));
         dto.setTel(rs.getString("tel"));
         dto.setRegdate(rs.getTimestamp("regdate"));
         dto.setModate(rs.getTimestamp("modate"));
         dto.setAuth(rs.getInt("auth"));
         
         memList.add(dto);
       } 
     } catch (SQLException e) {
       e.printStackTrace();
     } 
     
     return memList;
   }
 
   public int setWriteBoard(BoardDTO dto) {
	   
	   String sql = "INSERT INTO MYBBS (WRITER, USERID, PASS, TITLE, CONTENT) VALUES(?, ?, ?, ?, ?)";
	   
	   try(PreparedStatement ps = conn.prepareStatement(sql)) {
		   ps.setString(1, dto.getWriter());
		   ps.setString(2, dto.getUserId());
		   ps.setString(3, dto.getPass());
		   ps.setString(4, dto.getTitle());
		   ps.setString(5, dto.getContent());
		   
		   return ps.executeUpdate(); // 성공하면 1 반환
	   } catch(SQLException e) {
		   e.printStackTrace();
		   
		   return 0; // 실패하면 0 반환
	   }
	   
   }
   
   public int setUpdateBoard(BoardDTO dto) {
	   String sql = "UPDATE MYBBS SET TITLE = ?, CONTENT = ?, WDATE = NOW() WHERE ID = ? and pass = ?";
	   
	   try {
		   PreparedStatement ps = conn.prepareStatement(sql);
		   ps.setString(1, dto.getTitle());
		   ps.setString(2, dto.getContent());
		   ps.setLong(3, dto.getId());
		   ps.setString(4, dto.getPass());
		   
		   return ps.executeUpdate();
		   
	   } catch(Exception e) {
		   e.printStackTrace();
	   }
	   return 0;
   }
   
   public int delBoard(long id, String pass) {
	   String sql = "DELETE FROM MYBBS WHERE 1=1 AND ID = ? and pass = ?";
	   
	   try(PreparedStatement ps = conn.prepareStatement(sql)) {
		   ps.setLong(1, id);
		   ps.setString(2, pass);
		   
		   return ps.executeUpdate();
		   
	   } catch(SQLException e) {
		   e.printStackTrace();
		   return 0;
	   }
	   
   }
	/*
	 * public boolean boardPass(long id, String pass) { String sql =
	 * "SELECT COUNT(*) FROM MYBBS WHERE ID = ? AND PASS = ?";
	 * 
	 * return false; }
	 */
   
   public boolean insertMember(MembersDTO dto) {
     String sql = "INSERT INTO MEMBERS (USERID, PASSWD, NAME, EMAIL, TEL)VALUES (?, ?, ?, ?, ?)";
 
     
     try {
       PreparedStatement ps = this.conn.prepareStatement(sql);
       ps.setString(1, dto.getUserId());
       ps.setString(2, dto.getPasswd());
       ps.setString(3, dto.getName());
       ps.setString(4, dto.getEmail());
       ps.setString(5, dto.getTel());
       
       int result = ps.executeUpdate();
       return (result > 0);
     }
     catch (SQLException e) {
       e.printStackTrace();
       return false;
     } 
   }
 
 
 
   
   public boolean isUserIdOrEmailExists(String columnName, String value) {
     String sql = "SELECT COUNT(*) FROM MEMBERS WHERE 1=1 AND " + columnName + " = ?";
     boolean checked = false;
     try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, value);

			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next() && rs.getInt(1) > 0) {
					checked = true;  //중복
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
     return checked;
   }
 
   
   public MembersDTO checkMember(String userId, String passwd) {
     MembersDTO dto = null;
     String sql = "SELECT * FROM MEMBERS WHERE 1=1 AND USERID = ? AND PASSWD = ?";
     
     try {
       PreparedStatement ps = this.conn.prepareStatement(sql);
       ps.setString(1, userId);
       ps.setString(2, passwd);
       
       ResultSet rs = ps.executeQuery();
       dto = new MembersDTO();
       
       if (rs.next()) {
         dto.setId(rs.getInt("id"));
         dto.setUserId(rs.getString("userId"));
         dto.setPasswd(rs.getString("passwd"));
         dto.setName(rs.getString("name"));
         dto.setEmail(rs.getString("email"));
         dto.setTel(rs.getString("tel"));
         dto.setRegdate(rs.getTimestamp("regdate"));
         dto.setModate(rs.getTimestamp("modate"));
         dto.setAuth(rs.getInt("auth"));
       }
     
     }
     catch (SQLException e) {
       e.printStackTrace();
     } 
     
     return dto;
   }
    
   public void updateHit(int boardId) {
     String sql = "UPDATE MYBBS SET HIT = HIT + 1 WHERE ID = ?";
     
     try {
       PreparedStatement ps = this.conn.prepareStatement(sql);
       ps.setInt(1, boardId);
       
       ps.executeUpdate();
     } catch (Exception e) {
       e.printStackTrace();
     } 
   }
 }


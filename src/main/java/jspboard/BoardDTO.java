 package jspboard;
 
 import java.sql.Timestamp;
 
 
 
 public class BoardDTO
 {
   private long id;
   private String writer;
   private String userId;
   private String pass;
   private String title;
   private String content;
   private int hit;
   private Timestamp wDate;
   
   public long getId() {
     return this.id;
   }
   
   public void setId(long id) {
     this.id = id;
   }
   
   public String getWriter() {
     return this.writer;
   }
   
   public void setWriter(String writer) {
     this.writer = writer;
   }
   
   public String getUserId() {
     return this.userId;
   }
   
   public void setUserId(String userId) {
     this.userId = userId;
   }
   
   public String getPass() {
     return this.pass;
   }
   
   public void setPass(String pass) {
     this.pass = pass;
   }
   
   public String getTitle() {
     return this.title;
   }
   
   public void setTitle(String title) {
     this.title = title;
   }
   
   public String getContent() {
     return this.content;
   }
   
   public void setContent(String content) {
     this.content = content;
   }
   
   public int getHit() {
     return this.hit;
   }
   
   public void setHit(int hit) {
     this.hit = hit;
   }
   
   public Timestamp getwDate() {
     return this.wDate;
   }
   
   public void setwDate(Timestamp wDate) {
     this.wDate = wDate;
   }
 
 
   
   public String toString() {
     return "BoardDTO [id=" + this.id + ", writer=" + this.writer + ", userId=" + this.userId + ", pass=" + this.pass + ", title=" + 
       this.title + ", content=" + this.content + ", hit=" + this.hit + ", wDate=" + this.wDate + "]";
   }
 }

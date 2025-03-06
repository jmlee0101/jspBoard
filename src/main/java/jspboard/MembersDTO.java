 package jspboard;
 
 import java.sql.Timestamp;
 
 
 
 
 public class MembersDTO
 {
   private int id;
   private String userId;
   private String passwd;
   private String name;
   private String email;
   private String tel;
   private Timestamp regdate;
   private Timestamp modate;
   private int auth;
   
   public int getId() {
     return this.id;
   }
   public void setId(int id) {
     this.id = id;
   }
   public String getUserId() {
     return this.userId;
   }
   public void setUserId(String userId) {
     this.userId = userId;
   }
   public String getPasswd() {
     return this.passwd;
   }
   public void setPasswd(String passwd) {
     this.passwd = passwd;
   }
   public String getName() {
     return this.name;
   }
   public void setName(String name) {
     this.name = name;
   }
   public String getEmail() {
     return this.email;
   }
   public void setEmail(String email) {
     this.email = email;
   }
   public String getTel() {
     return this.tel;
   }
   public void setTel(String tel) {
     this.tel = tel;
   }
   public Timestamp getRegdate() {
     return this.regdate;
   }
   public void setRegdate(Timestamp regdate) {
     this.regdate = regdate;
   }
   public Timestamp getModate() {
     return this.modate;
   }
   public void setModate(Timestamp modate) {
     this.modate = modate;
   }
   public int getAuth() {
     return this.auth;
   }
   public void setAuth(int auth) {
     this.auth = auth;
   }
 
   
   public String toString() {
     return "MembersDTO [id=" + this.id + ", userId=" + this.userId + ", passwd=" + this.passwd + ", name=" + this.name + ", email=" + 
       this.email + ", tel=" + this.tel + ", auth=" + this.auth + "]";
   }
 }



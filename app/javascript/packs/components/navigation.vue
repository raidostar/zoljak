<template>
  <div id="navigation-div">
    <nav>
      <div class="ul-div">
        <ul>
          <li><a class="menus" href="/schools">학교별</a></li>
          <li><a class="menus" href="/years">연도별</a></li>
          <li><a class="menus" href="/functions">기능별</a></li>
          <li><a class="menus" href="/awards">수상</a></li>
          <li><a class="menus" href="/communities">커뮤니티</a></li>
          <li><a class="menus" href="/myworks">내 작품관리</a></li>
          <li class="login"><a class="menus" @click="openLogin">로그인</a></li>
        </ul>
      </div>
    </nav>
    <div v-show="login" class="login-area">
      <div class="login-panel">
        <div class="login-title">
          <p class="subtitle">졸업작품을 위한 플랫폼</p>
          <p class="title">졸작 ː卒作</p>
        </div>
        <div class="email-area login-input">
          <label>이메일</label><br/>
          <input class="login-text" type="email" name="user[id]" placeholder="이메일 입력"/>
        </div>
        <div class="password-area login-input">
          <label>비밀번호</label><br/>
          <input class="login-text" type="email" name="user[password]" v-model="email" @keyup.enter="doLogin" placeholder="비밀번호 입력"/>
        </div>
        <div class="button-area">
          <button class="login-button" @click="doStart">로그인</button>
        </div>
        <div class="sign-in-area">
          <a class="sign-in-link" href="/users/sign_up">회원가입</a>
        </div>
        <div class="guide-area">
          <a class="info guide-link" @click="openInfo">개인정보처리방침</a>
          <a class="regulation guide-link" @click="openRegulation">이용약관</a>
        </div>
      </div>
      <div class="close-panel" @click="closeLogin"></div>
    </div>
  </div>
</template>
<script type="text/javascript">
  import axios from 'axios'
  export default {
    name: 'navigation',
    data: function(){
      return {
        login: false,
        email: '',
      }
    },
    methods: {
      openLogin(){
        this.login = true
      },
      closeLogin(){
        this.login = false
      },
      doStart(){
        axios.post('email_check', {
          email: this.email
        }).then((res)=>{
          console.log(res.data)
        }, (error)=>{
          console.log(error)
        })
      },
      openSignin(){
        alert("회원가입 버튼 테스트!")
      },
      openInfo(){
        alert("개인정 버튼 테스트!")
      },
      openRegulation(){
        alert("약관 버튼 테스트!")
      }
    }
  }
</script>
<style type="text/css" scoped>
@font-face {
  font-family: barun;
  src: url('../font/BareunBatangOTFPro-3.otf');
}
ul {
  padding-left: 0px;
  overflow: scroll;
  height: 100%;
  -ms-overflow-style: none;
  -o-overflow-style: none;
  line-height: 80px;
  background-color: #000000;
}
ul::-webkit-scrollbar {
  display:none;
}
li {
  width: 10%;
  height: inherit;
  margin: 0;
  padding: 0;
  text-align: center;
  list-style: none;
  float: left
}
.menus {
  color: #DDDDDD;
}
.menus:hover {
  cursor: pointer;
  color: #FFFFFF;
  text-decoration: none;
  font-size: 18px;
}
.ul-div {
  height: 80px;
}
.login {
  float: right;
}
.login-area {
  position: fixed;
  top: 0px;
  left: 0px;
  height: 100%;
  width: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 10;
}
.login-panel{
  position: relative;
  top: 200px;
  margin: 0 auto;
  width: 400px;
  height: 585px;
  background-color: #FFFFFF;
  border-radius: 4px;
  z-index: 12;
}
.login-title{
  position: relative;
  height: 210px;
  line-height: 55px;
  font-family: barun;
  text-align: center;
  padding-top: 50px;
}
.close-panel {
  position: absolute;
  top: 0px;
  left: 0px;
  height: 100%;
  width: 100%;
  z-index: 11;
}
.subtitle {
  font-size: 20px;
}
.title {
  font-size: 35px;
  line-height: 60px;
}
.login-input{
  margin: 25px 45px;
}
.login-text {
  width: 310px;
}
.button-area {
  text-align: center;
  margin: 45px auto 10px auto;
}
.login-button {
  height: 50px;
  width: 350px;
  border: none;
}
.login-button:hover {
  background-color: #DDDDDD;
  border-radius: 4px;
}
.login-button:focus {
  outline: none;
}
.sign-in-area {
  text-align: center;
}
.guide-area{
  text-align: center;
  position: relative;
  top: 20px;
}
.sign-in-link{
  color: #007bff;
}
.sign-in-link:hover{
  cursor: pointer;
}
.guide-link {
  color: #CCCCCC;
  font-size: 12px;
  margin: 0 10px;
}
.guide-link:hover {
  cursor: pointer;
}
</style>

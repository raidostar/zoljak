<template>
  <div class="sign-in">
    <div class="email-area area">
      <p class="email-title">메일</p> 
      <input class="email text-box" name="user[email]" v-model="email" @blur="emailValidation" @keyup.esc="emailValidation">
      <button class="mailcheck-button" @click="emailCheck">이메일 중복체크</button>
      <span :style="colorChange">{{emailcheckMessage}}</span>
    </div>
    <div class="password-area area">
      <p class="password-title">패스워드</p>
      <input class="password text-box" type="password" name="user[password]" v-model="password"/>
      <span class="password-check-message">{{ passwordCheck }}</span>
    </div>
    <div class="password-area area">
      <p class="password-title">패스워드 확인</p>
      <input class="password text-box" type="password" name="user[password]" v-model="rePassword"/>
      <span class="password-check-message">{{ passwordRecheck }}</span>
    </div>
    <div class="name-area area">
      <p class="name-title">이름</p>
      <input class="name text-box" type="text" name="user[name]" v-model="name"/>
    </div>
    <div class="phone-area area">
      <p class="phone-title">전화번호</p>
      <select class="phone-select" v-model="phoneNumber1">
        <option value="010">010</option>
        <option value="011">011</option>
        <option value="019">019</option>
      </select>-
      <input class="phone-box" type="text" name="user[phone_number2]" v-model="phoneNumber2">-
      <input class="phone-box" type="text" name="user[phone_number3]" v-model="phoneNumber3">
    </div>
    <div class="univ-area area">
      <p class="univ-title">학교명</p>
      <input class="univ-box" type="text" name="user[school]" v-model="school" ref="univ" :disabled="selectedSchool!='direct'">
      <select class="univ-select" v-model="selectedSchool" @change="selectSchool">
        <option value="cau">중앙대학교</option>
        <option value="korea">고려대학교</option>
        <option value="snu">서울대학교</option>
        <option value="yonsei">연세대학교</option>
        <option value="direct">직접입력</option>
      </select>
    </div>
    <div class="major-area area">
      <p class="major-box">전공</p>
      <select class="major-select" v-model="major">
        <option value="architecture">건축학</option>
      </select>
    </div>
    <div class="schoolyear-area area">
      <p class="schoolyear-title">학년</p>
      <select class="year-select" v-model="schoolyear">
        <option value=0>학년선택</option>
        <option value=1>1학년</option>
        <option value=2>2학년</option>
        <option value=3>3학년</option>
        <option value=4>4학년</option>
        <option value=5>5학년</option>
      </select>
    </div>
    <div class="button-area area">
      <button 
      class="submit-button" 
      type="button" 
      @click="signIn" 
      :disabled="!emailCheckBool&&!emailValidationBool">
      회원가입
    </button>
    </div>
  </div>
</template>
<script type="text/javascript">
  import axios from 'axios'
  //axios & devise
  let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
  axios.defaults.headers.common['X-CSRF-Token'] = token
  axios.defaults.headers.common['Accept'] = 'application/json'
  export default {
    name: 'login',
    data: function(){
      return {
        email: '',
        password: '',
        rePassword: '',
        name: '',
        schoolNumber: "2021000000",
        emailcheckMessage: '',
        colorChange: {},
        emailCheckBool: false,
        emailValidationBool: false,
        passwordCheck: '',
        passwordRecheck: '',
        phoneNumber: '',
        phoneNumber1: "010",
        phoneNumber2: "",
        phoneNumber3: "",
        school: '중앙대학교',
        selectedSchool: 'cau',
        major: "architecture",
        schoolyear: 0,
      }
    },
    methods: {
      signIn(){
        console.log("sign in test")
      },
      emailCheck(){
        console.log(this.email)
        if(this.email == ''){
          this.colorChange = {'color': '#dc3545'}
          this.emailcheckMessage = "메일을 입력해주세요"
        } else {
          axios.post('email_check', {
            email: this.email
          }).then((res)=>{
            console.log(res.data)
            if(res.data){
              this.colorChange = {'color': '#dc3545'}
              this.emailcheckMessage = "이미 있는 이메일입니다."
            }else {
              this.colorChange = {'color': '#28a745'}
              this.emailcheckMessage = "사용 가능한 메일입니다."
              this.emailCheckBool = true
            }
          }, (error)=>{
            console.log(error)
          })
        }
      },
      emailValidation(){
        if(!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(this.email)){
          this.colorChange = {'color': '#dc3545'}
          this.emailcheckMessage = "잘못된 이메일 형식입니다."
        } else {
          this.colorChange = {'color': '#28a745'}
          this.emailcheckMessage = ""
          this.emailValidationBool = true
        }
      },
      selectSchool(){
        if(this.selectedSchool!='direct'){
          switch(this.selectedSchool){
            case 'cau':
            this.school = "중앙대학교"
            break;
            case 'korea':
            this.school = "고려대학교"
            break;
            case 'snu':
            this.school = "서울대학교"
            break;
            case 'yonsei':
            this.school = "연세대학교"
            break;
          }
        } else {
          this.school = ''
        }
      },
    },
  }
</script>
<style type="text/css" scoped>
.sign-in {
  width: 500px;
  margin: 0 auto;
}
.area {
  margin-bottom: 2rem;
}
.email {
  margin-bottom: 20px;
}
.text-box {
  width: 100%;
}
.mailcheck-button {
  border: none; 
}
.mailcheck-button:hover {
  background-color: #DDDDDD;
  border-radius: 4px;
}
.mailcheck-button:focus {
  outline: none;
}
.major-area, .schoolyear-area{
  width: 50%;
  float: left;
}
.major-select {
  width: 90%;
  height: 30px;
}
.year-select{
  width: 90%;
  height: 30px;
}
.button-area {
  width: 100%;
  margin: 0 auto;
  margin-bottom: 2rem;
}
.submit-button {
  width: 100%;
  height: 50px;
  border: none;
  border-radius: 2px;
}
.submit-button:hover {
  background-color: #DDDDDD;
  border-radius: 4px;
}
.submit-button:focus {
  outline: none;
}
.phone-select {
  height: 30px;
  width: 30%;
}
.phone-box {
  width: 30%;
}
.univ-select{
  width: 150px;
  height: 30px;
}
</style>
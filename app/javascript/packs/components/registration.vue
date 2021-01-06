<template>
  <div class="sign-in">
    <div class="email-area area">
      <p class="email-title">메일(아이디)</p>
      <input class="email text-box" name="user[email]" v-model="email" @keyup="emailValidation" @keyup.esc="emailValidation">
      <button class="mailcheck-button" @click="emailCheck">이메일 중복체크</button>
      <span :style="emailMessageColor">{{emailcheckMessage}}</span>
    </div>
    <div class="password-area area">
      <p class="password-title">패스워드</p>
      <input class="password text-box" type="password" name="user[password]" v-model="password" @keyup="passwordValidation" @blur="passwordValidation"/>
      <span class="password-check-message" :style="passMessageColor">{{ passwordCheck }}</span>
    </div>
    <div class="password-area area">
      <p class="password-title">패스워드 확인</p>
      <input class="password text-box" type="password" name="user[password]" v-model="rePassword" @keyup="repasswordValidation" @blur="repasswordValidation"/>
      <span class="password-check-message" :style="repassMessageColor">{{ passwordRecheck }}</span>
    </div>
    <div class="name-area area">
      <p class="name-title">이름</p>
      <input class="name text-box" type="text" name="user[name]" v-model="name" maxlength="5" @keyup="nameValidation" @blur="nameValidation"/>
      <span class="name-check-message" :style="nameMessageColor">{{ nameCheck }}</span>
    </div>
    <div class="phone-area area">
      <p class="phone-title">전화번호</p>
      <select class="phone-select" v-model="phoneNumber1">
        <option value="010">010</option>
        <option value="011">011</option>
        <option value="019">019</option>
      </select>-
      <input class="phone-box" type="text" name="user[phone_number2]" v-model="phoneNumber2" maxlength="4" @keyup="phoneTypeValidation(phoneNumber2)">-
      <input class="phone-box" type="text" name="user[phone_number3]" v-model="phoneNumber3" maxlength="4" @keyup="phoneTypeValidation(phoneNumber3)" @blur="phoneValidation"><br/>
      <span class="phone-check-message" :style="phoneMessageColor">{{ phoneCheck }}</span>
    </div>
    <div class="univ-area area">
      <p class="univ-title">학교명</p>
      <input class="univ-box" type="text" name="user[school]" v-model="school" :disabled="selectedSchool!='direct'" @keyup="schoolValidation">
      <select class="univ-select" v-model="selectedSchool" @change="selectSchool">
        <option value="cau">중앙대학교</option>
        <option value="korea">고려대학교</option>
        <option value="snu">서울대학교</option>
        <option value="yonsei">연세대학교</option>
        <option value="hanyang">한양대학교</option>
        <option value="hongik">홍익대학교</option>
        <option value="direct">직접입력</option>
      </select><br/>
      <span class="school-check-message" :style="schoolMessageColor">{{ schoolCheck }}</span>
    </div>
    <div class="major-area area">
      <p class="major-box">전공</p>
      <select class="major-select" v-model="major">
        <option value="architecture">건축학</option>
      </select>
    </div>
    <div class="schoolyear-area area">
      <p class="schoolyear-title">학년</p>
      <select class="year-select" v-model="schoolyear" @change="yearValidation">
        <option value=0>학년선택</option>
        <option value=1>1학년</option>
        <option value=2>2학년</option>
        <option value=3>3학년</option>
        <option value=4>4학년</option>
        <option value=5>5학년</option>
      </select><br/>
      <span class="year-check-message" :style="yearMessageColor">{{ yearCheck }}</span>
    </div>
    <div class="button-area area">
      <button 
      class="submit-button" 
      type="button" 
      @click="signIn"
      :style="submitStyle"
      :disabled="validBool">
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
        emailMessageColor: {},
        emailCheckBool: false,
        emailValidBool: false,
        passwordCheck: '',
        passwordRecheck: '',
        passMessageColor: {},
        repassMessageColor: {},
        passwordValidBool: false,
        repasswordValidBool: false,
        nameCheck: '',
        nameMessageColor: {},
        nameValidBool: false,
        phoneNumber: '',
        phoneNumber1: "010",
        phoneNumber2: "",
        phoneNumber3: "",
        phoneMessageColor: {},
        phoneCheck: '',
        phoneTypeBool: false,
        phoneValidBool: false,
        school: '중앙대학교',
        selectedSchool: 'cau',
        schoolValidBool: false,
        schoolMessageColor: {},
        schoolCheck: '',
        schoolValidBool: false,
        major: "architecture",
        schoolyear: 0,
        yearMessageColor: {},
        yearCheck: '',
        yearValidBool: false,
        submitStyle: {'cursor': 'not-allowed'},
        validBool: false,
      }
    },
    methods: {
      signIn(){
        console.log("sign in test")
      },
      emailCheck(){
        console.log(this.email)
        if(this.email == ''){
          this.emailMessageColor = {'color': '#dc3545'}
          this.emailcheckMessage = "메일을 입력해주세요"
        } else {
          axios.post('email_check', {
            email: this.email
          }).then((res)=>{
            console.log(res.data)
            if(res.data){
              this.emailMessageColor = {'color': '#dc3545'}
              this.emailcheckMessage = "이미 있는 이메일입니다."
            }else {
              this.emailMessageColor = {'color': '#007bff'}
              this.emailcheckMessage = "사용 가능한 메일입니다."
              this.emailCheckBool = true
              this.checkBool()
            }
          }, (error)=>{
            console.log(error)
          })
        }
      },
      emailValidation(){
        if(!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(this.email)){
          this.emailMessageColor = {'color': '#dc3545'}
          this.emailcheckMessage = "잘못된 이메일 형식입니다."
        } else {
          this.emailMessageColor = {'color': '#007bff'}
          this.emailcheckMessage = ""
          this.emailValidBool = true
          this.checkBool()
        }
      },
      passwordValidation(){
        if(!/(?=.*\d)(?=.*[a-z]).{8,}/.test(this.password)){
          this.passMessageColor = {'color': '#dc3545'}
          this.passwordCheck = "비밀번호는 숫자와 문자를 조합하여 8자리 이상으로 만들어 주세요"
        } else {
          this.passMessageColor = {'color': '#007bff'}
          this.passwordCheck = "가능한 비밀번호입니다."
          this.passwordValidBool = true
          this.checkBool()
        }
      },
      repasswordValidation(){
        if(this.password===this.rePassword){
          this.repassMessageColor = {'color': '#007bff'}
          this.passwordRecheck = "비밀번호가 일치합니다."
          this.repasswordValidBool = true
          this.checkBool()
        } else {
          this.repassMessageColor = {'color': '#dc3545'}
          this.passwordRecheck = "비밀번호가 일치하지 않습니다."
        }
      },
      nameValidation(){
        if(this.name.length<1){
          this.nameMessageColor = {'color': '#dc3545'}
          this.nameCheck = "이름을 입력해주세요."
        } else if(!/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/.test(this.name)){
          this.nameMessageColor = {'color': '#dc3545'}
          this.nameCheck = "이름은 한글만 입력이 가능합니다."
        } else {
          this.nameMessageColor = {'color': '#007bff'}
          this.nameCheck = ""
          this.nameValidBool = true
          this.checkBool()
        }
      },
      phoneTypeValidation(phone){
        if(!/(?=.*\d)/.test(phone)){
          this.phoneMessageColor = {'color': '#dc3545'}
          this.phoneCheck = "전화번호는 숫자만 입력이 가능합니다."
        } else {
          this.phoneMessageColor = {'color': '#007bff'}
          this.phoneCheck = ""
          this.phoneTypeBool = true
          this.checkBool()
        }
      },
      phoneValidation(){
        this.phoneNumber = this.phoneNumber1+this.phoneNumber2+this.phoneNumber3
        if(this.phoneNumber.length!=11){
          this.phoneMessageColor = {'color': '#dc3545'}
          this.phoneCheck = "전화번호를 입력해주세요"
        } else {
          this.phoneMessageColor = {'color': '#007bff'}
          this.phoneCheck = ""
          this.phoneValidBool = true
          this.checkBool()
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
            case 'hanyang':
            this.school = "한양대학교"
            break;
            case 'hongik':
            this.school = "홍익대학교"
            break;
            this.schoolValidBool = true
            this.checkBool()
          }
        } else {
          this.school = ''
          this.schoolValidBool = false
          this.checkBool()
        }
      },
      schoolValidation(){
        if(this.selectedSchool=='direct'&&this.school.length==0){
          this.schoolMessageColor = {'color': '#dc3545'}
          this.schoolCheck = "학교명을 입력해주세요"
        } else if(!/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/.test(this.school)){
          this.schoolMessageColor = {'color': '#dc3545'}
          this.schoolCheck = "학교명은 한글만 입력이 가능합니다."
        } else {
          this.schoolMessageColor = {'color': '#007bff'}
          this.schoolCheck = ""
          this.schoolValidBool = true
          this.checkBool()
        }
      },
      yearValidation(){
        if(this.schoolyear==0){
          this.yearMessageColor = {'color': '#dc3545'}
          this.yearCheck = "학년을 선택해주세요"
        }else{
          this.yearMessageColor = {'color': '#007bff'}
          this.yearCheck = ""
          this.yearValidBool = true
          this.checkBool()
        }
      },
      checkBool(){
        if(this.emailCheckBool&&this.emailValidBool&&this.passwordValidBool&&this.repasswordValidBool&&this.nameValidBool&&this.phoneTypeBool&&this.phoneValidBool&&this.schoolValidBool&&this.yearValidBool){
          console.log("ready to sign in!!")
          this.submitStyle = {'cursor': 'pointer'}
          this.validBool = true
        } else {
          this.submitStyle = {'cursor': 'not-allowed'}
          this.validBool = false
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
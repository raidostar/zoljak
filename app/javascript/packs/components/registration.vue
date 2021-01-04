<template>
  <div class="sign-in">
    <div class="email-area area">
      <p class="email-title">메일</p> 
      <input class="email text-box" name="user[email]" v-model="email">
      <button class="mailcheck-button" @click="emailCheck">이메일 중복체크</button>
      <span :style="colorChange">{{emailcheck_message}}</span>
    </div>
    <div class="password-area area">
      <p class="password-title">패스워드</p>
      <input class="password text-box" type="password" name="user[password]" v-model="password"/>
      <p class="password-title">패스워드 확인</p>
      <input class="password text-box" type="password" name="user[password]" v-model="re_password"/>
    </div>
    <div class="name-area area">
      <p class="name-title">이름</p>
      <input class="name text-box" type="text" name="user[name]" v-model="name"/>
    </div>
    <div class="major-area area">
      <p class="major text-box">전공</p>
      <select class="select-box">
        <option value="architecture">건축학</option>
      </select>
    </div>
    <div class="schoolnumber-area area">
      <p class="schoolnumber-title">학번</p>
      <input class="schoolnumber text-box" type="number" name="user[schoolnumber]" v-model="schoolnumber">
    </div>
    <div class="button-area area">
      <button class="submit-button" type="button" @click="signIn">회원가입</button>
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
        re_password: '',
        name: '',
        schoolnumber: 0,
        emailcheck_message: '',
        colorChange: {},

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
          this.emailcheck_message = "메일을 입력해주세"
        } else {
          axios.post('email_check', {
            email: this.email
          }).then((res)=>{
            console.log(res.data)
            if(res.data){
              this.colorChange = {'color': '#dc3545'}
              this.emailcheck_message = "이미 있는 이메일입니다."
            }else {
              this.colorChange = {'color': '#28a745'}
              this.emailcheck_message = "사용 가능한 메일입니다."
            }
          }, (error)=>{
            console.log(error)
          })
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
.select-box {
  width: 100%;
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
</style>
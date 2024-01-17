function check_ok() {
 if (document.signup.id.value.length == 0) {
  alert("아이디를 입력해주세요!");
  signup.id.focus();
  return;
  
 }
 if (document.signup.id.value.length < 4) {
  alert("아이디는 4글자 이상입력해주세요!");
  signup.id.focus();
  return;
 }
 if (document.signup.pw.value == "") {
  alert("비밀번호를 입력해 주세요!");
  signup.pw.focus();
  return;
 }
 
 if (document.signup.pw.value != document.signup.pw2.value) {
  alert("비밀번호가 일치하지 않습니다.");
  signup.pw2.focus();
  return;
 }

 if (document.signup.name.value.length == 0) {
  alert("이름을 입력해 주세요!");
  signup.name.focus();
  return;
 }
 if (document.signup.email.value.length == 0) {
  alert("이메일을 입력해주세요!");
  signup.email.focus();
  return;
 }
 
 document.signup.submit();
}
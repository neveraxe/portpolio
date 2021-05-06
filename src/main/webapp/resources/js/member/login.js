$(document).ready(function() {
	
	var form = $("#loginForm");
	
	// 로그인 버튼 클릭 시 
	$("#btn_login").on("click", function(){
		
		var mb_id_pk = $("#mb_id_pk");
		var mb_passwd = $("#mb_passwd");

		if(mb_id_pk.val()==null || mb_id_pk.val()==""){
			alert("Please enter your ID.");
			mb_id_pk.focus();
			
		} else if(mb_passwd.val()==null || mb_passwd.val()==""){
			alert("Please enter your Password.");
			mb_passwd.focus();

		} else {
			form.submit();
		}
	});
	
});


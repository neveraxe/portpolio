$(document).ready(function(){
    
    
    // 비밀번호 찾기 : 메일전송
    $("#btn_PW_Search").on("click", function(){
        
        var userInfo = {mb_id_pk:$("#mb_id_pk").val(), mb_name: $("#mb_name").val()};

        $.ajax({
            url: '/member/find_pwd',
            type: 'post',
            data: userInfo,
            dataType: 'text',
            success: function(data) {
                // 비밀번호 출력작업
                if(data == "success") {
                    alert("가입하신 메일로 비밀번호를 전송하였습니다.");
                }else{
                    //alert();
					$("#result").html("입력정보가 틀립니다.");
                }

            }
        });
    });
    
     // 아이디 찾기 : 화면출력
	 $("#btn_ID_Search").on("click", function(){
        

        var userInfo = {mb_name:$("#mb_name").val()};

        $.ajax({
            url: '/member/find_id',
            type: 'post',
            data: userInfo,
            dataType: 'text',
            success: function(data) {
                // 아이디 출력작업
                if(data != "") {
                    //alert(data);
                    $("#result").html($("#mb_name").val() + " 님의 아이디는?" + data);
                }else{
                    //alert();
                    $("#result").html("입력정보가 틀립니다.");
                }

                $("#mb_name").val("");
            }
        });
    });

});
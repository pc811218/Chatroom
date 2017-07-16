<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link type="text/css" href="css/roomStyle.css" rel="stylesheet" />
	<link type="text/css" href="http://code.jquery.com/ui/1.10.3/themes/hot-sneaks/jquery-ui.css" rel="stylesheet" />
	<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script type="text/javascript" src="js/jquery.validate.js"></script>
    <style type="text/css">
    	small {
    		font-size: 8pt;
    		font-style: italic; 
    	}
    	.my-error-class {
    		color:red;
		}
		.bg-red {
			border:2px solid red;
		}
    </style>	
	<script type="text/javascript">
    var accountRex = /^[A-Za-z][\w\.]{5,11}$/; //英文開頭、後面接英文/數字/_(6~12)
    var passwordRex = /^[A-Za-z0-9@_]{6,12}$/; //英文/數字(6~12)
	var nameRex = /^[A-Za-z\u4e00-\u9fa5]{2,10}$/; //英文/中文(2~10)
	$(function(){

		//設定註冊視窗
		var dialog = $( "#dialog" );
		dialog.dialog({
			autoOpen: false,
			resizable:false,
			hide: { effect: "fade", duration: 300 },
			minWidth: 420,
			minHeight: 300,
			close: function(event, ui){
				
			}
		});
		
		//點擊出現註冊視窗
		$('#regist_button').click(function(){
			dialog.dialog("open");
		})
		
		//後端驗證有錯，直接顯示註冊視窗
		if('${error}' != ''){
			dialog.dialog("open");
		}
		//設定驗證
		jqValid();
		
        // set jquery validation option
        function jqValid() {
            $.validator.addMethod('regexpValid',
            function (value, element, regexp) {

                return regexp.test(value);
            },
            'wrong!');

            var form = $('#form-dialog');
            form.validate({
            	errorClass: "my-error-class",
                rules: {
                    account: { 'regexpValid': accountRex },
                    password: { 'regexpValid': passwordRex },
                    passwordCheck : {equalTo:'#password'},
                    name: { 'regexpValid': nameRex }
                },
                messages: {
                    passwordCheck:'密碼不符'
                }
            });
        }
        
        //set all to default when clear button clicked
        $('#clear').click(function () {
            $('input[type="text"],input[type="password"]').val('');
           
        });
		
        //註冊成功跳出
		if('${isRegistOK}' == '1') {
			alert('註冊成功!');
		} else if('${isRegistOK}' == '0'){
			alert('註冊失敗!');
		}
	});
	</script>
<title>WebSite Login</title>
</head>
<body>
	<form id="login_form" method="POST" action="login.do">
		<table>
				<tr>
					<td><span class="short_label">使用者帳號 :</span></td>
					<td>
						<span class="short_text"><input name="userName" value="${param.userName}" type="text"/></span>
					</td>
				</tr>
				<tr>
					<td><span class="short_text">使用者密碼 : </span></td>
					<td>
						<span class="short_text"><input name="password" type="password"/></span>
					</td>
				</tr>
				<tr>
					<td><span><input id="login_button" type="submit" value="登入" /></span></td>
					<td><span><input id="regist_button" type="button" value="註冊" /></span></td>
				</tr>
				
			</table>
			<p class="my-error-class">${errMsg}</p>
	</form>
	
	<div id="dialog" title="註冊新帳號" >
		<form id="form-dialog" action="regist.do" method="POST">
			<table>
				<tr>
					<td>帳號:</td>
					<td><input id="account"  name="account" type="text" value="" class="text ui-widget-content ui-corner-all">
						<br><small>英文開頭、後面接英文/數字/_(6~12)</small>
					</td>
				</tr>
				
				<tr>
					<td>密碼:</td>
					<td><input id="password" name="password" type="password" class="text ui-widget-content ui-corner-all">
						<br><small>英文/數字(6~12)</small>
					</td>
				</tr>
				<tr>
					<td>密碼確認:</td>
					<td><input id="passwordCheck" name="passwordCheck" type="password" class="text ui-widget-content ui-corner-all">
						<br><small>再次輸入密碼</small>
					</td>
				</tr>
				
				<tr>
					<td>姓名:</td>
					<td><input id="name" name="name" type="text" class="text ui-widget-content ui-corner-all">
						<br><small>英文/中文(2~10) </small>
					</td>
				</tr>
				<tr>
					<td><input type="submit" value="送出"></td>
					<td><input type="button" id="clear" value="清除"></td>
				</tr>
			</table>
			
			<div class="my-error-class bg-red">
				<c:forEach var="registMsg" items="${error}">
					<p>${registMsg}</p>
				</c:forEach>
			</div>
			
		</form>
	</div>
</body>
</html>
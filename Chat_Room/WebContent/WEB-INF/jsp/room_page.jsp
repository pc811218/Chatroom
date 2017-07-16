<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chat room</title>
<link rel="stylesheet" href="css/roomStyle.css" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
</head>
<body>
		<h1>聊天室大廳</h1>
		<h2>未連線</h2>

        	<textarea id="messagesArea" class="panel message-area" readonly ></textarea>

	<div>
		<span>${name}: </span>
		
		<input id="input" type="text">
		<input id="send" type="button" value="send">
		<p></p>

		<br> <br> 
		<input id="disconn" type="button" value="離線">
		<input id="getconn" type="button" value="連線">
	</div>
	
	<script type="text/javascript">
		
		//global var
		var webSocket;
		
		var typeArea = $('#input');
		var connbtn = $('#getconn');
		var disbtn = $('#disconn');
		var sendbtn = $('#send');
		var msgArea = $('#messagesArea');
		
		$(function() { //body onload
			
			connect();
			
			
			sendbtn.on('click', function(event) {
				sendToServer(typeArea);	
			});
			
			typeArea.on('keypress',function(event){
				//按下Enter也可以送出訊息
				if ( event.which == 13 ) {
					sendToServer(typeArea);
				}
			});
			
			
			disbtn.on('click', function() {
				webSocket.close();
				
			});

			connbtn.on('click', function() {
				connect();
			});
		});//end onload
		
		
		//******websocket 連線初始化******
		function connect() {
			// 建立 websocket 物件
			var wsurl = getEndPointURL("/ChatServer/${uesrInfo.account}/${uesrInfo.name}");
			webSocket = new WebSocket(wsurl);

			//設定連線成功事件
			webSocket.onopen = function(event) {
				alert("WebSocket 成功連線");
				$('h2').text('已連線').css('color','green');
				connbtn.prop("disabled",true);
				disbtn.prop("disabled",false);
				sendbtn.prop("disabled",false);
			};

			//設定接收訊息事件
			webSocket.onmessage = function(evt) {
				var msg = evt.data;
				
				msgArea.val(msgArea.val()+'\n'+msg);
				//讓聊天室卷軸自動往下捲動
				msgArea.scrollTop(msgArea[0].scrollHeight);
			};

			//設定結束事件
			webSocket.onclose = function(event) {
				alert('已離線');
				$('h2').text('未連線').css('color','red');
				connbtn.prop("disabled",false);
				disbtn.prop("disabled",true);
				sendbtn.prop("disabled",true);
			};
		}
		
		//取得完整WebSocket的URL
		function getEndPointURL(endPointName){
			//動態取得websocket路徑
			var MyPoint = endPointName;
			var host = window.location.host;
			var path = window.location.pathname;
			var webCtx = path.substring(0, path.indexOf('/', 1));
			var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
			
			return endPointURL;
		}
		
		function sendToServer(targetInput){
			var input = targetInput.val();
			if(input != '') {
				webSocket.send(input);
				targetInput.val('');	
			}
		}

	</script>
</body>
</html>
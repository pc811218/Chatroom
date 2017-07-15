<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Chat room</title>
<link rel="stylesheet" href="css/styles.css" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
</head>
<body>
		<h2>未連線</h2>
        <textarea id="messagesArea" class="panel message-area" readonly ></textarea>
	<div>
		
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

		$(function() { //body onload

			connect();
		
			$('#send').on('click', function() {
				var input = $('#input').val();
				webSocket.send(input);
			});

			$('#disconn').on('click', function() {
				webSocket.close();
			});

			$('#getconn').on('click', function() {
				connect();
			});
		});//end onload
		
		//連線初始化
		function connect() {
			// 建立 websocket 物件
			webSocket = new WebSocket(getEndPointURL("/echo"));

			//設定連線成功事件
			webSocket.onopen = function(event) {
				alert("WebSocket 成功連線");
			};

			//設定接收訊息事件
			webSocket.onmessage = function(evt) {
				var msg = evt.data;
				var msgArea = $('#messagesArea');
				msgArea.val(msgArea.val()+'\n'+msg);
				//$('p').text(msg);
			};

			//設定結束事件
			webSocket.onclose = function(event) {
				alert('已離線');
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


	</script>
</body>
</html>
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
		<h2>���s�u</h2>
        <textarea id="messagesArea" class="panel message-area" readonly ></textarea>
	<div>
		
		<input id="input" type="text">
		<input id="send" type="button" value="send">
		<p></p>

		<br> <br> 
		<input id="disconn" type="button" value="���u">
		<input id="getconn" type="button" value="�s�u">
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
		
		//�s�u��l��
		function connect() {
			// �إ� websocket ����
			webSocket = new WebSocket(getEndPointURL("/echo"));

			//�]�w�s�u���\�ƥ�
			webSocket.onopen = function(event) {
				alert("WebSocket ���\�s�u");
			};

			//�]�w�����T���ƥ�
			webSocket.onmessage = function(evt) {
				var msg = evt.data;
				var msgArea = $('#messagesArea');
				msgArea.val(msgArea.val()+'\n'+msg);
				//$('p').text(msg);
			};

			//�]�w�����ƥ�
			webSocket.onclose = function(event) {
				alert('�w���u');
			};
		}
		
		//���o����WebSocket��URL
		function getEndPointURL(endPointName){
			//�ʺA���owebsocket���|
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
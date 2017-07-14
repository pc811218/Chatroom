<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>WebSocket Test</title>
<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
</head>
<body>
<input id="input" type="text">
<input id="send" type="button" value="sendEcho">
<p></p>

<script type="text/javascript">
	var wsUri = "ws://localhost:8081/Chatroom/echo";
	var webSocket = new WebSocket(wsUri);
	webSocket.onopen = function(event) {
		alert("WebSocket 成功連線");
	};
	
	webSocket.onmessage = function (evt) {
        var msg = evt.data;
        $('p').text(msg);
    };
	
	$('#send').on('click',function(){
		var input = $('#input').val();
		webSocket.send(input);
	});
	//websocket.send('hi');
</script>
</body>
</html>
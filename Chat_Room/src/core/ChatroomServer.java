package core;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/echo")
public class ChatroomServer {
	
	private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());

	
	@OnOpen
	public void onOpen(Session userSession) {
		allSessions.add(userSession);
		System.out.println(userSession.getId() + ": 已連線");
	}
	
	@OnError
	public void onError(Session userSession, Throwable e){
		e.printStackTrace();
	}
	
	
    @OnMessage
    public String handleMessage(String msg) {
    	return "Your message is: " + msg;
    }
    
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		allSessions.remove(userSession);
		System.out.println(userSession.getId() + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
	}
}

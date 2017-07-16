package core;

import java.util.Hashtable;
import java.util.Map;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/ChatServer/{account}/{name}")
public class ChatroomServer {
	
//	private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
	private static final Map<Session,String> allSessions = new Hashtable<Session,String>();
	
	
	@OnOpen
	public void onOpen(@PathParam("account") String account,@PathParam("name") String name, Session userSession) {
		String user = name+"("+account+")";
		allSessions.put(userSession,user);
		sendToAll("=========="+user+"已加入聊天!==========");
		System.out.println(user + ": 已連線");
		System.out.println(allSessions);
	}
	
	@OnError
	public void onError(Session userSession, Throwable e){
		sendToAll("=========="+allSessions.get(userSession)+"已離開...==========");
		allSessions.remove(userSession);
		//e.printStackTrace();
	}
	
	
    @OnMessage
    public void handleMessage(String msg, Session userSession) {
    	String user = allSessions.get(userSession);
    	sendToAll(user+ " : " + msg);

    }
    
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		sendToAll("=========="+allSessions.get(userSession)+"已離開...==========");
		System.out.println(allSessions.get(userSession) + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
		allSessions.remove(userSession);
	}
	
	//傳送給全部人
	private void sendToAll(String message){
		for (Session session : allSessions.keySet()) {
			if (session.isOpen()) 
				session.getAsyncRemote().sendText(message);
		}
	}
	
	
}

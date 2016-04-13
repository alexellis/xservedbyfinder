
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashSet;

public class App {
	
	public static void main(String[] args) {

		URL url = null;
		HttpURLConnection conn = null;
		HashSet<String> nodes = new HashSet<String>();
		
		String path = "https://www.raspberrypi.org/blog/the-little-computer-that-could/";
		int n = 50;
		
		try {
			
			System.out.println("Calling " + path + " " + n + " times");
			
			for(int i=0; i<n; i++) {
				
				path += ("?t=" + System.currentTimeMillis());
				//path = "http://localhost:3000";
				
				url = new URL( path );
				conn = (HttpURLConnection) url.openConnection();
				
				if(conn.getResponseCode() != 200) {
					throw(new Exception("Bad Response Code " + conn.getResponseCode()));
				}

				String nodeName = conn.getHeaderField("X-Served-By");
				
				nodes.add(nodeName);
				
				conn.disconnect();
				conn = null;
				
			}
			
		} catch (Exception e) {
			System.out.println("Exception: " + e);
		} finally {
			conn = null;
		}
		
		System.out.println("Nodes : " + nodes);
		
	}

}

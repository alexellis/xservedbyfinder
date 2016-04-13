import java.io.IOException;

import java.net.URL;
import java.net.MalformedURLException;
import java.net.URLConnection;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.ArrayList;
import java.util.Properties;


public class App {

  /*
   * Needed for access within corporate network. Pass proxyHost proxyPort as environmental variables.
   */
  private static void setProxy() {
    String proxy = System.getenv("proxyHost");
    String port= System.getenv("proxyPort");
    if(proxy !=null && proxy.length() > 0) {
      Properties systemProperties = System.getProperties();
      systemProperties.setProperty("http.proxyHost", proxy);
      systemProperties.setProperty("http.proxyPort", port);
      systemProperties.setProperty("https.proxyHost", proxy);
      systemProperties.setProperty("https.proxyPort", port);
    }
  }

  private static String makeRequest(String httpUrl) throws MalformedURLException, IOException {
    URL url = new URL(httpUrl);
    URLConnection connection = url.openConnection();

    String servedBy = null;
    for (Entry<String, List<String>> header : connection.getHeaderFields().entrySet()) {
        String key = header.getKey();
        if(key!=null && key.equals("X-Served-By")) {
          servedBy = header.getValue().toString();
          break;
        }
    }
    return servedBy;
  }

  private static void printResults(ArrayList<String> found) {
    for(int i =0;i< found.size();i++){
      System.out.println(found.get(i));
    }
  }

  private static String getHttpUrl() {
    String url = System.getenv("httpUrl");
    if(url == null) {
      url = "https://www.raspberrypi.org/";
    }
    return url;
  }

  public static void main(String[] args) {
    try {
      setProxy();

      // Read URL from httpUrl environmental variable
      String httpUrl = getHttpUrl();

      // This could also be an environmental variable.
      int maxRequests = 5;

      ArrayList<String> found = new ArrayList<String>();

      for(int i = 0; i < maxRequests; i++) {
          String servedBy = makeRequest(httpUrl);
          if(found.contains(servedBy) == false) {
            found.add(servedBy);
          }
      }

      printResults(found);
    } catch (Exception ex) {
    	ex.printStackTrace();
    }
  }
}


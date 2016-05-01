use std::str;
use std::env;
use std::io::Read;
use std::io::Write;
use std::net::TcpStream;
use std::collections::HashMap;

fn main() {
    let args: Vec<_> = env::args().collect();
    if args.len() < 2 {
        panic!("Please provide a HOST:PORT to connect to, e.g. `-- 127.0.0.1:8080`");
    }

    println!("\nFinding servers for host {}", args[1]);

    let mut socket = TcpStream::connect(&args[1][..]).unwrap();
    let mut existing_server_count = 0;
    let mut buffer = vec![0; 1024];
    let mut header_values = HashMap::new();

    loop {
        // Make a HEAD request over the socket and decode the response.
        socket.write_all(b"HEAD / HTTP/1.1\r\n\r\n").unwrap();
        socket.read(&mut buffer).unwrap();
        let response = str::from_utf8(&buffer).unwrap();

        // RegEx is a separate package so parse the response by splitting on CRLF and
        // find the X-Served-By HTTP header.
        for s in response.split("\r\n") {
            if s.starts_with("X-Served-By: ") {
                // Split the header to get the server name.
                let server_name = s.split("X-Served-By: ");
                let server_name: Vec<&str> = server_name.collect();
                let server_name = server_name[1];

                // Keep track of the consecutive times an existing x-served-by header value was
                // returned and use this to decide when we have found them all.
                match header_values.contains_key(server_name) {
                    true => {
                        existing_server_count += 1;
                    }
                    false => {
                        existing_server_count = 0;
                    }
                }

                // Store the header value in a HashMap and keep track of how many times the header
                // value has been received from the server.
                // Note: Need to call `s.to_string()` to take a new owned string value to insert
                // into the HashMap, otherwise the code won't compile. This is an example of Rust's
                // strict compile time checking to ensure null reference errors are avoided.
                let counter = header_values.entry(server_name.to_string()).or_insert(1);
                *counter += 1;
            }
        }

        // If we have made 25 or more requests since seeing a new x-served-by value then
        // quit the loop.
        if existing_server_count >= 25 {
            break;
        }
    }

    for key in header_values.keys() {
        println!("{}", key);
    }
}

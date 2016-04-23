for i in {1..25} ; do curl -s -I http://localhost:3000 ; done | grep X-Served-By | cut -d":" -f 2 | sort | uniq

target:
	$(MAKE) fetch
	$(MAKE) final
fetch: fetch1 fetch2 fetch3 fetch4
fetch1:
	./curl25times.sh > out1.txt
fetch2:
	./curl25times.sh > out2.txt
fetch3:
	./curl25times.sh > out3.txt
fetch4:
	./curl25times.sh > out4.txt
final:
	./print_results.sh && rm *.txt

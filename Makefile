all: combn.cpp
	g++ -std=c++0x -g combn.cpp -lgomp -fopenmp -o combn.out && ./combn.out
clean:
	$(RM) ./*.out

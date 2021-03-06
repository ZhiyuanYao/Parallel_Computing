
# Home directory
HOMET=/home/davidza/

# Ask the number of cores to be used in the parallelization:
CORES := $(shell bash -c 'read -p "Enter the number of cores for parallelization: " pwd; echo $$pwd') 


# Execute the code for each language
cpp:
	g++ Cpp_main.cpp -fopenmp -o Cpp_main
	export OMP_NUM_THREADS=$(CORES); ./Cpp_main;
	rm Cpp_main

julia_parallel:
	julia -p$(CORES) Julia_main_parallel.jl

julia_pmap:
	julia -p$(CORES) Julia_main_pmap.jl

Rcpp:
	export OMP_NUM_THREADS=$(CORES); Rscript Rcpp_main.R;

R:
	Rscript R_main.R $(CORES)

python:
	python Python_main.py $(CORES)

matlab:
	matlab -nodesktop -nodisplay -r "Matlab_main $(CORES)"

MPI:
	mpic++ -g MPI_main.cpp -o main
	mpirun -np $(CORES) -hostfile MPI_host_file ./main
	rm main

CUDA:
	nvcc CUDA_main.cu -o main
	./main
	rm main


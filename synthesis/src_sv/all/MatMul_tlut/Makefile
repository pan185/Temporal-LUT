###############################################
#####################Makefile##################

VSIM = $(PREFIX) vsim
VLOG = $(PREFIX) vlog
VCOM = $(PREFIX) vcom
VLIB = $(PREFIX) vlib

VLOG_OPTS = -suppress vlog-2583 +acc
DIM_ROW1 = 1
DIM_COL1 = 784
DIM_ROW2 = 784
DIM_COL2 = 1

compile: gen_file rtl tb

gen_file:
	g++ -o _app.out gen.cpp
	./_app.out $(DIM_ROW1) $(DIM_COL1) $(DIM_ROW2) $(DIM_COL2) > c.txt
	cat adder_tree.txt > adder_tree.sv 
	cat c.txt >> adder_tree.sv 
	cat d.txt >> adder_tree.sv

# compile RTL files
rtl: gen_file
	if [ ! -d work ]; then $(VLIB) work; fi
	${VLOG} -lint -work ${VLOG_OPTS} *.sv
    

# compile verification environment
tb:
	if [ ! -d work ]; then $(VLIB) work; fi
	$(VLOG) $(VLOG_OPTS)    *.sv
	${VLOG} $(VLOG_OPTS) t_lut_tb.sv

# run simulator in GUI mode 
run: rtl tb
	${VSIM} t_lut_tb -do 'run -all'

runc: rtl tb
	${VSIM} -c  -voptargs=+acc t_lut_tb 

# Clean the generated files 
clean:
	rm -rf work 
	rm -rf vsim.wlf
	rm -rf _app.out
 

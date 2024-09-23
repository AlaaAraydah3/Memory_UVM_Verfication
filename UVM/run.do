vlog memory_pkg.sv tb.sv +cover
vsim -batch top -coverage  
run -all
coverage report -codeAll -cvg -verbose -file coverage_report.txt

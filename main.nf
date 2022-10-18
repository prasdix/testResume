#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process test_resume1 {
	echo true
	// publishDir "/root/bioinformatics-pipeline/nextflow_POC/POC_testresume/output", mode:'copy'	
	
	output:
		path('*.*'), emit: out_ch1
	
	script:
	"""
		echo "executing A"
		echo "Value of process 1 sd   " > A_file.txt
		
	"""
}

process test_resume2 {
	echo true
	// publishDir "/root/bioinformatics-pipeline/nextflow_POC/POC_testresume/output", mode:'copy'	
	
	input:
		path 'test.txt'
		
	output:
		path('*.*'), emit: out_ch2
	
	script:
	"""	
		echo "executing B"
		echo "Value of process 2   sd" > B_file.txt
	"""
}


/*process test_resume3 {
	echo true
	// publishDir "/root/bioinformatics-pipeline/nextflow_POC/POC_testresume/output", mode:'copy'	
			
	output:
		path('*.*'), emit: out_ch3
	
	script:
	"""	
		echo "executing C"
		echo "Value of process 3 sd" > C_file.txt
	"""
}*/

workflow {
	test_resume1()
	test_resume2(test_resume1.out.out_ch1)
	test_resume3()
	test_resume1.out.out_ch1.view()
	test_resume2.out.out_ch2.view()
	test_resume3.out.out_ch3.view()
	
}

workflow.onComplete {
    println "Pipeline completed at: $workflow.complete"
    println "Execution status: ${ workflow.success ? 'OK' : 'failed' }"
}

workflow.onError = {
    println "Oops .. something when wrong"
}


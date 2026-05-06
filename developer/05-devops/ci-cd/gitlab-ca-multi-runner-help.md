# $ gitlab-ci-multi-runner help

## NAME: 

	gitlab-ci-multi-runner - a GitLab Runner

## USAGE:

	gitlab-ci-multi-runner [global options] command [command options] [arguments...]
   
## VERSION:

	1.4.1 (fae8f18)
   
## AUTHOR(S):

	Kamil Trzciński <ayufan@ayufan.eu> 
   
## COMMANDS:

   exec			execute a build locally
   
   list			List all configured runners
   
   run			run multi runner service
   
   register		register a new runner
   
   install		install service
   
   uninstall		uninstall service
   
   start		start service
   
   stop			stop service
   
   restart		restart service
   
   status		get status of a service
   
   run-single		start single runner
   
   unregister		unregister specific runner
   
   verify		verify all registered runners
   
   artifacts-downloader	download and extract build artifacts (internal)
   
   artifacts-uploader	create and upload build artifacts (internal)
   
   cache-archiver	create and upload cache artifacts (internal)
   
   cache-extractor	download and extract cache artifacts (internal)
   
   help, h		Shows a list of commands or help for one command


## GLOBAL OPTIONS:

   --debug			debug mode [$DEBUG]
   
   --log-level, -l "info"	Log level (options: debug, info, warn, error, fatal, panic)
   
   --cpuprofile 		write cpu profile to file [$CPU_PROFILE]
   
   --help, -h			show help
   
   --version, -v		print the version
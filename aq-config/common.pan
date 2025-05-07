unique template features/monitoring/crossjack/common;

include 'repository/config/crossjack';

# Default ports for jobstats exporters
variable NODE_EXPORTER_PORT ?= '9100';
variable CGROUP_EXPORTER_PORT ?= '9306';
variable NVIDIA_EXPORTER_PORT ?= '9821';

# Default prometheus port
variable PROMETHEUS_PORT ?= '9090';

# Slurm network for iptables
variable SLURM_NETWORKS = list('0.0.0.0/21');

###################
### JOBSATS RPM ###
###################

# Install jobstats rpm
'/software/packages' = pkg_repl('jobstats','1.0.0-1','x86_64');

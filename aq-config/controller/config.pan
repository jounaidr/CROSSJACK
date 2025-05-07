template features/monitoring/crossjack/controller/config;

include 'components/chkconfig/config';
include 'components/filecopy/config';
include 'components/iptables/config';

include 'features/monitoring/crossjack/common';

#############
### PORTS ###
#############

# Open port 9090 prometheus
'/software/components/iptables/filter/rules' = {
    foreach(_; network; SLURM_NETWORKS) {
        append(SELF, dict(
            'command', '-A',
            'chain', 'INPUT',
            'protocol', 'tcp',
            'source', network,
            'dst_port', PROMETHEUS_PORT,
            'jump', 'ACCEPT',
        ));
    };
    SELF
};

################
### PROM RPM ###
################

# Install prometheus rpm
'/software/packages' = pkg_repl('prometheus2','2.53.0-1.el9','x86_64');

###################
### PROM CONFIG ###
###################

# Add scarf specific prom config
'/software/components/filecopy/services/{/etc/prometheus/prometheus.yml}' = dict(
    'config', file_contents('rig/features/monitoring/crossjack/controller/prometheus.yml'),
    'owner', 'root:root',
    'perms', '0644',
);

# Add node list for scarf specifc prom config
'/software/components/filecopy/services/{/etc/prometheus/scarf_nodes.json}' = dict(
    'config', file_contents('rig/features/monitoring/crossjack/controller/scarf_nodes.json'),
    'owner', 'root:root',
    'perms', '0644',
);

#####################
### SERVICE FILES ###
#####################

# Start and enable prometheus  service
prefix '/software/components/chkconfig/service/prometheus';
 'on' = '';
 'startstop' = true;

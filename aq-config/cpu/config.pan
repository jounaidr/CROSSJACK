template features/monitoring/crossjack/cpu/config;

include 'components/chkconfig/config';
include 'components/filecopy/config';
include 'components/iptables/config';

include 'features/monitoring/crossjack/common';

#############
### PORTS ###
#############

# Open port 9100 for the node exporter
'/software/components/iptables/filter/rules' = {
    foreach(_; network; SLURM_NETWORKS) {
        append(SELF, dict(
            'command', '-A',
            'chain', 'INPUT',
            'protocol', 'tcp',
            'source', network,
            'dst_port', NODE_EXPORTER_PORT,
            'jump', 'ACCEPT',
        ));
    };
    SELF
};

# Open port 9306 for the cgroups exporter
'/software/components/iptables/filter/rules' = {
    foreach(_; network; SLURM_NETWORKS) {
        append(SELF, dict(
            'command', '-A',
            'chain', 'INPUT',
            'protocol', 'tcp',
            'source', network,
            'dst_port', CGROUP_EXPORTER_PORT,
            'jump', 'ACCEPT',
        ));
    };
    SELF
};

#####################
### EXPORTER RPMs ###
#####################

# Install cgroup exporter rpm
'/software/packages' = pkg_repl('cgroup_exporter','1.0.0-1','x86_64');
# Install node exporter rpm
'/software/packages' = pkg_repl('node_exporter','1.0.0-1','x86_64');

#####################
### SERVICE FILES ###
#####################

# Add service file for node exporter
'/software/components/filecopy/services/{/usr/lib/systemd/system/node_exporter.service}' = dict(
    'config', file_contents('features/monitoring/crossjack/cpu/node_exporter.service'),
    'owner', 'root:root',
    'perms', '0644',
);

# Add service file for cgroups exporter
'/software/components/filecopy/services/{/usr/lib/systemd/system/cgroup_exporter.service}' = dict(
    'config', file_contents('features/monitoring/crossjack/cpu/cgroup_exporter.service'),
    'owner', 'root:root',
    'perms', '0644',
);

# Start and enable node expoter service
prefix '/software/components/chkconfig/service/node_exporter';
'on' = '';
'startstop' = true;

# Start and enable cgroups exporter service
prefix '/software/components/chkconfig/service/cgroup_exporter';
'on' = '';
'startstop' = true;

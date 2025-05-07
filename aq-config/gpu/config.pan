template features/monitoring/crossjack/gpu/config;

include 'components/chkconfig/config';
include 'components/filecopy/config';
include 'components/iptables/config';

include 'features/monitoring/crossjack/common';

#############
### PORTS ###
#############

# Open port 9821 for the nvidia exporter
'/software/components/iptables/filter/rules' = {
    foreach(_; network; SLURM_NETWORKS) {
        append(SELF, dict(
            'command', '-A',
            'chain', 'INPUT',
            'protocol', 'tcp',
            'source', network,
            'dst_port', NVIDIA_EXPORTER_PORT,
            'jump', 'ACCEPT',
        ));
    };
    SELF
};

####################
### EXPORTER RPM ###
####################

# Add executable for nvidia exporter
'/software/packages' = pkg_repl('nvidia_exporter','1.0.0-1','x86_64');

#####################
### SERVICE FILES ###
#####################

# Add service file for nvidia exporter
'/software/components/filecopy/services/{/usr/lib/systemd/system/nvidia_exporter.service}' = dict(
    'config', file_contents('features/monitoring/crossjack/gpu/nvidia_exporter.service'),
    'owner', 'root:root',
    'perms', '0644',
);

# Start and enable nvidia expoter service
prefix '/software/components/chkconfig/service/nvidia_exporter';
'on' = '';
'startstop' = true;

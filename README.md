# CROSSJACK
CROSSJACK is a system metrics data collection and visualisation service for SCARF, implementing the [jobstats](https://github.com/PrincetonUniversity/jobstats) platform. The following repository contains various implementation specific files and documentation, for the full source code and documentation please see the [jobstats](https://github.com/PrincetonUniversity/jobstats) repository.

## Network Overview
The following diagram (V1) shows the node setup with the exports, nodes labeled with prefix `cn...` refer to CPU nodes and `gn...` GPU nodes. The following shows which exporters refer to their respective service file:
- [node_exporter](https://github.com/jounaidr/CROSSJACK/blob/main/systemd/node_exporter.service) - overall node metrics
- [cgroup_exporter](https://github.com/jounaidr/CROSSJACK/blob/main/systemd/cgroup_exporter.service) - job specific metrics
- [nvidia_exporter](https://github.com/jounaidr/CROSSJACK/blob/main/systemd/nvidia_exporter.service) - GPU metrics for nvdia hardware
![jobstats-scarf-network-v1](https://github.com/user-attachments/assets/5d6ac586-73fb-438a-9937-ae8ef5e8a011)

## RPMs
Prometheus rpm - https://packagecloud.io/prometheus-rpm/release/packages/el/9/prometheus2-2.53.0-1.el9.x86_64.rpm?distro_version_id=240

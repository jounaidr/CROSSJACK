Name: cgroup_exporter
Version: 1.0.0 
Release: 1 
Summary: RPM to install cgroup exporter binary on SCARF compute nodes
License: GPL
Source0: %{name}-%{version}.tar.gz

%description 
RPM to install cgroup exporter binary on SCARF compute nodes.

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
cp %{name} $RPM_BUILD_ROOT/%{_bindir}

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/%{name}

%post
echo "cgroup exporter binary installed successfully!"

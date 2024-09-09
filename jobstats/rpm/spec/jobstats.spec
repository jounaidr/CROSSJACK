Name: jobstats
Version: 1.0.0 
Release: 1 
Summary: RPM to install jobstats script
License: GPL
Source0: %{name}-%{version}.tar.gz

%description 
RPM to install jobstats script

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
echo "jobstats installed successfully!"

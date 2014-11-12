Name: slct
Version: 0.05
Release: 1
Source: http://kodu.neti.ee/~risto/%{name}/%{name}-%{version}.tar.gz
License: GPL
Group: Utilities/Text
BuildRoot: /var/tmp/%{name}-rpmroot
Summary: simple logfile clustering tool

%description
SLCT is a tool that was designed to find clusters in logfile(s), so that
each cluster corresponds to a certain line pattern that occurs frequently
enough. The special cluster of outliers contains lines that do not fit
well to any regular cluster.

%prep
%setup

%build
CFLAGS='-O2 -D_LARGFILE_SOURCE -D_FILE_OFFSET_BITS=64' make %{name}

%install
mkdir -p $RPM_BUILD_ROOT{%{_bindir},%{_mandir}/man1}
install -s %{name} $RPM_BUILD_ROOT%{_bindir}/%{name}
install %{name}.1 $RPM_BUILD_ROOT%{_mandir}/man1/%{name}.1

%files
%defattr(-,root,root)
%doc README COPYING ChangeLog

%{_bindir}/%{name}
%{_mandir}/man1/%{name}.1*

%changelog
* Thu May 15 2003 Risto Vaarandi <risto@eyp.ee>
  0.02-1: minor modifications
* Tue Apr 15 2003 Bennett Todd <bet@rahul.net>
  0.01-1: initial wrap

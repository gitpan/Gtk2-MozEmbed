#!/usr/bin/perl
use 5.008;
use strict;
use warnings;

use ExtUtils::MakeMaker;
use Config;
use Cwd;
use File::Spec;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2-MozEmbed/Makefile.PL,v 1.11 2008/03/15 13:44:56 kaffeetisch Exp $

our %build_reqs = (
  'perl-ExtUtils-Depends'   => '0.20',
  'perl-ExtUtils-PkgConfig' => '1.03',
  'perl-Glib'               => '1.180',
  'perl-Gtk2'               => '1.081',
  'perl-Mozilla-DOM'        => '0.01',
  'Mozilla'                 => '1.7',
  'Firefox'                 => '1.0',
  'XULRunner'               => '1.8',
);

our %pre_reqs = (
  'Gtk2'                => $build_reqs{'perl-Gtk2'},
  'ExtUtils::Depends'   => $build_reqs{'perl-ExtUtils-Depends'},
  'ExtUtils::PkgConfig' => $build_reqs{'perl-ExtUtils-PkgConfig'},
);

unless (eval "use ExtUtils::Depends '$build_reqs{'perl-ExtUtils-Depends'}';"
           . "use ExtUtils::PkgConfig '$build_reqs{'perl-ExtUtils-PkgConfig'}';"
           . "use Glib '$build_reqs{'perl-Glib'}';"
           . "use Gtk2 '$build_reqs{'perl-Gtk2'}';"
           . "use Glib::MakeHelper;"
           . "use Gtk2::CodeGen;"
           . "1") {
  warn "$@\n";
  WriteMakefile(
    PREREQ_FATAL => 1,
    PREREQ_PM    => \%pre_reqs,
  );
  exit 1; # not reached
}

# Check if Mozilla::DOM is installed. (could use an ENABLE_DOM option)
my $use_dom = 1;
unless (eval "use Mozilla::DOM '$build_reqs{'perl-Mozilla-DOM'}'; 1") {
  warn "Mozilla::DOM >= $build_reqs{'perl-Mozilla-DOM'} not found.\n";
  $use_dom = 0;
}

my %pkgcfg = ExtUtils::PkgConfig->find("xulrunner-gtkmozembed >= $build_reqs{'XULRunner'}",
                                       "mozilla-gtkmozembed >= $build_reqs{'Mozilla'}",
                                       "firefox-gtkmozembed >= $build_reqs{'Firefox'}",
                                       "mozilla-firefox-gtkmozembed >= $build_reqs{'Firefox'}");

mkdir 'build', 0777;

our @xs_files = <xs/*.xs>;
our %pod_files = (
	'MozEmbed.pm' => '$(INST_MAN3DIR)/Gtk2::MozEmbed.$(MAN3EXT)',
	Glib::MakeHelper->do_pod_files (@xs_files),
);

Gtk2::CodeGen->parse_maps('gtkmozembed2perl');
Gtk2::CodeGen->write_boot(ignore => qr/^Gtk2::MozEmbed$/);

my ($pkg) = $pkgcfg{pkg} =~ /^(\S+)/;

ExtUtils::PkgConfig->write_version_macros (
  "build/gtkmozembed2perl-version.h",
  $pkg => "GTK_MOZ_EMBED",
);

my $mozembed = ExtUtils::Depends->new('Gtk2::MozEmbed', 'Gtk2',
                                      ($use_dom ? ('Mozilla::DOM') : ()));

$mozembed->set_inc($pkgcfg{cflags});
$mozembed->set_libs($pkgcfg{libs});
$mozembed->add_xs(@xs_files);
$mozembed->add_pm('MozEmbed.pm' => '$(INST_LIBDIR)/MozEmbed.pm');
$mozembed->add_typemaps(map { File::Spec->catfile(cwd(), $_) }
                          qw(gtkmozembed.typemap
                             build/gtkmozembed2perl.typemap));

$mozembed->install(qw(gtkmozembed2perl.h
                      build/gtkmozembed2perl-autogen.h));
$mozembed->save_config('build/IFiles.pm');

my $configure_requires =
  Glib::MakeHelper->get_configure_requires_yaml(%pre_reqs);

WriteMakefile(
  NAME          => 'Gtk2::MozEmbed',
  VERSION_FROM  => 'MozEmbed.pm',
  ABSTRACT_FROM => 'MozEmbed.pm',
  PREREQ_PM     => \%pre_reqs,
  XSPROTOARG    => '-noprototypes',
  MAN3PODS      => \%pod_files,

  ($use_dom ? (CC => 'c++', XSOPT => '-C++') : ()),

  $mozembed->get_makefile_vars,

  EXTRA_META => qq/
$configure_requires
/,
);

sub MY::postamble {
  return Glib::MakeHelper->postamble_clean ()
       . Glib::MakeHelper->postamble_docs_full (
           DEPENDS => $mozembed,
           COPYRIGHT_FROM => 'copyright.pod');
}

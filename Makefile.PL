#!/usr/bin/perl -w
use 5.008;
use strict;

use ExtUtils::MakeMaker;
use Config;
use Cwd;
use File::Spec;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2-MozEmbed/Makefile.PL,v 1.5 2005/02/27 22:03:49 kaffeetisch Exp $

our %build_reqs = (
  'perl-ExtUtils-Depends'   => '0.20',
  'perl-ExtUtils-PkgConfig' => '1.03',
  'perl-Glib'               => '1.06',
  'perl-Gtk2'               => '1.00',
  'GtkMozEmbed'             => '1.7',
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
    PREREQ_PM    => {
      'Gtk2'                => $build_reqs{'perl-Gtk2'},
      'ExtUtils::Depends'   => $build_reqs{'perl-ExtUtils-Depends'},
      'ExtUtils::PkgConfig' => $build_reqs{'perl-ExtUtils-PkgConfig'},
    },
  );
  exit 1; # not reached
}

my %pkgcfg = ExtUtils::PkgConfig->find("mozilla-gtkmozembed >= $build_reqs{'GtkMozEmbed'}");

mkdir 'build', 0777;

our @xs_files = <xs/*.xs>;
our %pod_files = (
	'MozEmbed.pm' => '$(INST_MAN3DIR)/Gtk2::MozEmbed.$(MAN3EXT)',
	Glib::MakeHelper->do_pod_files (@xs_files),
);

Gtk2::CodeGen->parse_maps('gtkmozembed2perl');
Gtk2::CodeGen->write_boot(ignore => qr/^Gtk2::MozEmbed$/);

ExtUtils::PkgConfig->write_version_macros (
  "build/gtkmozembed2perl-version.h",
  "mozilla-gtkmozembed" => "GTK_MOZ_EMBED",
);

my $mozembed = ExtUtils::Depends->new('Gtk2::MozEmbed', 'Gtk2');
$mozembed->set_inc($pkgcfg{cflags});
$mozembed->set_libs($pkgcfg{libs});
$mozembed->add_xs(@xs_files);
$mozembed->add_pm('MozEmbed.pm' => '$(INST_LIBDIR)/MozEmbed.pm');
$mozembed->add_typemaps(map {File::Spec->catfile(cwd(), $_)} 'build/gtkmozembed2perl.typemap');

$mozembed->install(qw(gtkmozembed2perl.h build/gtkmozembed2perl-autogen.h));
$mozembed->save_config('build/IFiles.pm');

my $libdir = `pkg-config --variable=libdir mozilla-gtkmozembed`;
chomp($libdir);

WriteMakefile(
  NAME          => 'Gtk2::MozEmbed',
  VERSION_FROM  => 'MozEmbed.pm',
  ABSTRACT_FROM => 'MozEmbed.pm',
  XSPROTOARG    => '-noprototypes',
  MAN3PODS      => \%pod_files,
  LD            => "LD_RUN_PATH=$libdir $Config{ld}",
  $mozembed->get_makefile_vars,
);

sub MY::postamble {
  return Glib::MakeHelper->postamble_clean ()
       . Glib::MakeHelper->postamble_docs_full (
           DEPENDS => $mozembed,
           COPYRIGHT_FROM => 'copyright.pod');
}

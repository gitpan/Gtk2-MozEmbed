package Gtk2::MozEmbed;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2-MozEmbed/MozEmbed.pm,v 1.4 2004/09/11 15:24:31 kaffeetisch Exp $

use 5.008;
use strict;
use warnings;

use Gtk2;

require DynaLoader;

our @ISA = qw(DynaLoader);

our $VERSION = '0.02';

sub import {
  my $self = shift();
  $self -> VERSION(@_);
}

sub dl_load_flags { 0x01 }

Gtk2::MozEmbed -> bootstrap($VERSION);

1;
__END__

=head1 NAME

Gtk2::MozEmbed - Perl interface to the Mozilla embedding widget

=head1 SYNOPSIS

  #!/usr/bin/perl
  use strict;
  use warnings;
  use Glib qw(TRUE FALSE);
  use Gtk2 -init;
  use Gtk2::MozEmbed;

  Gtk2::MozEmbed -> set_profile_path($ENV{ HOME } . "/.mybrowser",
                                     "MyBrowser");

  my $window = Gtk2::Window -> new();
  my $moz = Gtk2::MozEmbed -> new();

  $window -> signal_connect(delete_event => sub {
    Gtk2 -> main_quit;
    return FALSE;
  });

  $window -> set_title("MyBrowser");
  $window -> set_default_size(600, 400);
  $window -> add($moz);
  $window -> show_all();

  $moz -> load_url("http://gtk2-perl.sf.net");

  Gtk2 -> main;

See examples/pumzilla in the source tarball for a more complete example.

=head1 ABSTRACT

This module allows a Perl developer to use the Mozilla embedding widget.

=head1 SEE ALSO

L<Gtk2::MozEmbed::index>(3pm), L<Gtk2>(3pm), L<Gtk2::api>(3pm).

=head1 AUTHOR

Torsten Schoenfeld E<lt>kaffeetisch@web.deE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by the gtk2-perl team

=cut

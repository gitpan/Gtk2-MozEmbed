package Gtk2::MozEmbed;

# $Header$

use 5.008;
use strict;
use warnings;

use Gtk2;

require DynaLoader;

our @ISA = qw(DynaLoader);

our $VERSION = '0.00';

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

  # ...

=head1 ABSTRACT

This module allows a Perl developer to use the Mozilla embedding widget.

=head1 SEE ALSO

L<Gtk2::MozEmbed::index>(3pm), L<Gtk2>(3pm), L<Gtk2::api>(3pm).

=head1 AUTHOR

Torsten Schoenfeld E<lt>kaffeetisch@web.deE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by the gtk2-perl team

=cut

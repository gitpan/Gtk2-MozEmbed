#!/usr/bin/perl

# $Header$

use strict;
use warnings;

use Gtk2 -init;
use Gtk2::MozEmbed;

use Test::More tests => 8;

Gtk2::MozEmbed -> set_comp_path($ENV{ HOME });
Gtk2::MozEmbed -> set_profile_path($ENV{ HOME } . "/.Schmuh", "Schmuh");

my $moz = Gtk2::MozEmbed -> new();
isa_ok($moz, "Gtk2::MozEmbed");

my $uri = "file://" . $ENV{ HOME };

# my $window = Gtk2::Window -> new();
# $window -> add($moz);
# $window -> realize();

$moz -> load_url($uri);
$moz -> stop_load();

ok(not $moz -> can_go_back());
ok(not $moz -> can_go_forward());

$moz -> go_back();
$moz -> go_forward();

# segfault: $moz -> render_data("<html></html>", $uri, "text/html");
# assertion: $moz -> open_stream($uri, "text/html");
#            $moz -> close_stream();
#            $moz -> append_data("<!-- bla -->");

is($moz -> get_link_message(), undef);
is($moz -> get_js_status(), undef);
is($moz -> get_title(), undef);
is($moz -> get_location(), $uri);

$moz -> reload([qw/reloadnormal reloadbypassproxyandcache/]);

$moz -> set_chrome_mask([qw/defaultchrome modal/]);
is_deeply($moz -> get_chrome_mask(), [qw/defaultchrome modal/]);

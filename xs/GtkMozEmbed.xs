/*
 * Copyright (C) 2004 by the gtk2-perl team
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * $Header$
 */

#include "gtkmozembed2perl.h"

/* ------------------------------------------------------------------------- */

GType
gtk2perl_moz_embed_reload_flags_get_type(void)
{
  static GType reload_flags_type = 0;

  if (!reload_flags_type) {
    static const GFlagsValue values[] = {
      { GTK_MOZ_EMBED_FLAG_RELOADNORMAL, "GTK_MOZ_EMBED_FLAG_RELOADNORMAL", "reloadnormal" },
      { GTK_MOZ_EMBED_FLAG_RELOADBYPASSCACHE, "GTK_MOZ_EMBED_FLAG_RELOADBYPASSCACHE", "reloadbypasscache" },
      { GTK_MOZ_EMBED_FLAG_RELOADBYPASSPROXY, "GTK_MOZ_EMBED_FLAG_RELOADBYPASSPROXY", "reloadbypassproxy" },
      { GTK_MOZ_EMBED_FLAG_RELOADBYPASSPROXYANDCACHE, "GTK_MOZ_EMBED_FLAG_RELOADBYPASSPROXYANDCACHE", "reloadbypassproxyandcache" },
      { GTK_MOZ_EMBED_FLAG_RELOADCHARSETCHANGE, "GTK_MOZ_EMBED_FLAG_RELOADCHARSETCHANGE", "reloadcharset" },
      { 0, NULL, NULL }
    };
    reload_flags_type = g_flags_register_static ("GtkMozEmbedReloadFlags", values);
  }

  return reload_flags_type;
}

/* ------------------------------------------------------------------------- */

GType
gtk2perl_moz_embed_chrome_flags_get_type(void)
{
  static GType chrome_flags_type = 0;

  if (!chrome_flags_type) {
    static const GFlagsValue values[] = {
      { GTK_MOZ_EMBED_FLAG_DEFAULTCHROME, "GTK_MOZ_EMBED_FLAG_DEFAULTCHROME", "defaultchrome" },
      { GTK_MOZ_EMBED_FLAG_WINDOWBORDERSON, "GTK_MOZ_EMBED_FLAG_WINDOWBORDERSON", "windowborderson" },
      { GTK_MOZ_EMBED_FLAG_WINDOWCLOSEON, "GTK_MOZ_EMBED_FLAG_WINDOWCLOSEON", "windowcloseon" },
      { GTK_MOZ_EMBED_FLAG_WINDOWRESIZEON, "GTK_MOZ_EMBED_FLAG_WINDOWRESIZEON", "windowresizeon" },
      { GTK_MOZ_EMBED_FLAG_MENUBARON, "GTK_MOZ_EMBED_FLAG_MENUBARON", "menubaron" },
      { GTK_MOZ_EMBED_FLAG_TOOLBARON, "GTK_MOZ_EMBED_FLAG_TOOLBARON", "toolbaron" },
      { GTK_MOZ_EMBED_FLAG_LOCATIONBARON, "GTK_MOZ_EMBED_FLAG_LOCATIONBARON", "locationbaron" },
      { GTK_MOZ_EMBED_FLAG_STATUSBARON, "GTK_MOZ_EMBED_FLAG_STATUSBARON", "statusbaron" },
      { GTK_MOZ_EMBED_FLAG_PERSONALTOOLBARON, "GTK_MOZ_EMBED_FLAG_PERSONALTOOLBARON", "personaltoolbaron" },
      { GTK_MOZ_EMBED_FLAG_SCROLLBARSON, "GTK_MOZ_EMBED_FLAG_SCROLLBARSON", "scrollbarson" },
      { GTK_MOZ_EMBED_FLAG_TITLEBARON, "GTK_MOZ_EMBED_FLAG_TITLEBARON", "titlebaron" },
      { GTK_MOZ_EMBED_FLAG_EXTRACHROMEON, "GTK_MOZ_EMBED_FLAG_EXTRACHROMEON", "extrachromeon" },
      { GTK_MOZ_EMBED_FLAG_ALLCHROME, "GTK_MOZ_EMBED_FLAG_ALLCHROME", "allchrome" },
      { GTK_MOZ_EMBED_FLAG_WINDOWRAISED, "GTK_MOZ_EMBED_FLAG_WINDOWRAISED", "windowraised" },
      { GTK_MOZ_EMBED_FLAG_WINDOWLOWERED, "GTK_MOZ_EMBED_FLAG_WINDOWLOWERED", "windowlowered" },
      { GTK_MOZ_EMBED_FLAG_CENTERSCREEN, "GTK_MOZ_EMBED_FLAG_CENTERSCREEN", "centerscreen" },
      { GTK_MOZ_EMBED_FLAG_DEPENDENT, "GTK_MOZ_EMBED_FLAG_DEPENDENT", "dependent" },
      { GTK_MOZ_EMBED_FLAG_MODAL, "GTK_MOZ_EMBED_FLAG_MODAL", "modal" },
      { GTK_MOZ_EMBED_FLAG_OPENASDIALOG, "GTK_MOZ_EMBED_FLAG_OPENASDIALOG", "openasdialog" },
      { GTK_MOZ_EMBED_FLAG_OPENASCHROME, "GTK_MOZ_EMBED_FLAG_OPENASCHROME", "openaschrome" },
      { 0, NULL, NULL }
    };
    chrome_flags_type = g_flags_register_static ("GtkMozEmbedChromeFlags", values);
  }

  return chrome_flags_type;
}

/* ------------------------------------------------------------------------- */

MODULE = Gtk2::MozEmbed	PACKAGE = Gtk2::MozEmbed	PREFIX = gtk_moz_embed_

BOOT:
#include "register.xsh"
#include "boot.xsh"

=for object Gtk2::MozEmbed::main

=cut

void
DESTROY (embed)
	GtkWidget *embed
    CODE:
	if (embed)
		gtk_widget_unref (embed);

##  GtkWidget * gtk_moz_embed_new (void)
GtkWidget_ornull *
gtk_moz_embed_new (class)
    C_ARGS:
	/* void */
    CLEANUP:
	if (RETVAL)
		gtk_widget_ref (RETVAL);

# What do these do?  Do you need them?
# ##  void gtk_moz_embed_push_startup (void)
# void
# gtk_moz_embed_push_startup (class)
#     C_ARGS:
# 	/* void */

# ##  void gtk_moz_embed_pop_startup (void)
# void
# gtk_moz_embed_pop_startup (class)
#     C_ARGS:
# 	/* void */

##  void gtk_moz_embed_set_comp_path (char *aPath)
void
gtk_moz_embed_set_comp_path (class, aPath)
	char *aPath
    C_ARGS:
	aPath

## void gtk_moz_embed_set_profile_path (char *aDir, char *aName)
void
gtk_moz_embed_set_profile_path (class, aDir, aName)
	char *aDir
	char *aName
    C_ARGS:
	aDir, aName

##  void gtk_moz_embed_load_url (GtkMozEmbed *embed, const char *url)
void
gtk_moz_embed_load_url (embed, url)
	GtkMozEmbed *embed
	const char *url

##  void gtk_moz_embed_stop_load (GtkMozEmbed *embed)
void
gtk_moz_embed_stop_load (embed)
	GtkMozEmbed *embed

##  gboolean gtk_moz_embed_can_go_back (GtkMozEmbed *embed)
gboolean
gtk_moz_embed_can_go_back (embed)
	GtkMozEmbed *embed

##  gboolean gtk_moz_embed_can_go_forward (GtkMozEmbed *embed)
gboolean
gtk_moz_embed_can_go_forward (embed)
	GtkMozEmbed *embed

##  void gtk_moz_embed_go_back (GtkMozEmbed *embed)
void
gtk_moz_embed_go_back (embed)
	GtkMozEmbed *embed

##  void gtk_moz_embed_go_forward (GtkMozEmbed *embed)
void
gtk_moz_embed_go_forward (embed)
	GtkMozEmbed *embed

##  void gtk_moz_embed_render_data (GtkMozEmbed *embed, const char *data, guint32 len, const char *base_uri, const char *mime_type)
void
gtk_moz_embed_render_data (embed, data, base_uri, mime_type)
	GtkMozEmbed *embed
	SV *data
	const char *base_uri
	const char *mime_type
    PREINIT:
	char *real_data;
	STRLEN len;
    CODE:
	real_data = SvPV (data, len);
	gtk_moz_embed_render_data (embed, real_data, len, base_uri, mime_type);

##  void gtk_moz_embed_open_stream (GtkMozEmbed *embed, const char *base_uri, const char *mime_type)
void
gtk_moz_embed_open_stream (embed, base_uri, mime_type)
	GtkMozEmbed *embed
	const char *base_uri
	const char *mime_type

##  void gtk_moz_embed_append_data (GtkMozEmbed *embed, const char *data, guint32 len)
void
gtk_moz_embed_append_data (embed, data)
	GtkMozEmbed *embed
	SV *data
    PREINIT:
	char *real_data;
	STRLEN len;
    CODE:
	real_data = SvPV (data, len);
	gtk_moz_embed_append_data (embed, real_data, len);

##  void gtk_moz_embed_close_stream (GtkMozEmbed *embed)
void
gtk_moz_embed_close_stream (embed)
	GtkMozEmbed *embed

##  char * gtk_moz_embed_get_link_message (GtkMozEmbed *embed)
char_own *
gtk_moz_embed_get_link_message (embed)
	GtkMozEmbed *embed

##  char * gtk_moz_embed_get_js_status (GtkMozEmbed *embed)
char_own *
gtk_moz_embed_get_js_status (embed)
	GtkMozEmbed *embed

##  char * gtk_moz_embed_get_title (GtkMozEmbed *embed)
char_own *
gtk_moz_embed_get_title (embed)
	GtkMozEmbed *embed

##  char * gtk_moz_embed_get_location (GtkMozEmbed *embed)
char_own *
gtk_moz_embed_get_location (embed)
	GtkMozEmbed *embed

##  void gtk_moz_embed_reload (GtkMozEmbed *embed, gint32 flags)
void
gtk_moz_embed_reload (embed, flags)
	GtkMozEmbed *embed
	GtkMozEmbedReloadFlags flags

##  void gtk_moz_embed_set_chrome_mask (GtkMozEmbed *embed, guint32 flags)
void
gtk_moz_embed_set_chrome_mask (embed, flags)
	GtkMozEmbed *embed
	GtkMozEmbedChromeFlags flags

##  guint32 gtk_moz_embed_get_chrome_mask (GtkMozEmbed *embed)
GtkMozEmbedChromeFlags
gtk_moz_embed_get_chrome_mask (embed)
	GtkMozEmbed *embed

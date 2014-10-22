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

#ifndef _GTKMOZEMBED2PERL_H_
#define _GTKMOZEMBED2PERL_H_

#include <gtk2perl.h>

#include <gtkmozembed.h>

#if 1 /* FIXME: use a version check here if/when a fix is incorporated
	 upstream. */

#undef GTK_TYPE_MOZ_EMBED_RELOAD_FLAGS
#define GTK_TYPE_MOZ_EMBED_RELOAD_FLAGS (gtk2perl_moz_embed_reload_flags_get_type())
GType gtk2perl_moz_embed_reload_flags_get_type (void);

#undef GTK_TYPE_MOZ_EMBED_CHROME_FLAGS
#define GTK_TYPE_MOZ_EMBED_CHROME_FLAGS (gtk2perl_moz_embed_chrome_flags_get_type())
GType gtk2perl_moz_embed_chrome_flags_get_type (void);

#endif

#include "gtkmozembed2perl-autogen.h"

#endif /* _GTKMOZEMBED2PERL_H_ */

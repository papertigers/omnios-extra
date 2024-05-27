#!/usr/bin/bash
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
# }}}

# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=links
VER=2.29
PKG=ooce/application/links
SUMMARY="Text mode web browser"
DESC="$PROG - $SUMMARY"

# does not yet build with gcc 14
((GCCVER > 13)) && set_gccver 13

set_arch 64

OPREFIX=$PREFIX
PREFIX+=/$PROG

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
"

CPPFLAGS+=" -I$OPREFIX/include"
LDFLAGS[amd64]+=" -L$OPREFIX/lib/amd64 -R$OPREFIX/lib/amd64"

NO_PARALLEL_MAKE=1

CONFIGURE_OPTS="
    --prefix=$PREFIX
    --without-x
"
# Feature is currently incomplete
#    --enable-javascript

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cvsps/cvsps-2.2_beta1.ebuild,v 1.1 2012/10/02 15:58:59 slyfox Exp $

EAPI="4"

inherit eutils toolchain-funcs

MY_P="${P/_beta/b}"
DESCRIPTION="Generates patchset information from a CVS repository"
HOMEPAGE="http://www.cobite.com/cvsps/"
#SRC_URI="http://www.cobite.com/cvsps/${MY_P}.tar.gz"
SRC_URI="http://www.catb.org/~esr/cvsps/cvsps-3.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.0-build.patch
#	epatch "${FILESDIR}"/${P}-solaris.patch
	# no configure around
	if [[ ${CHOST} == *-solaris* ]] ; then
		sed -i -e '/^LDLIBS+=/s/$/ -lsocket/' Makefile || die
	fi
	tc-export CC
}

src_install() {
	dobin cvsps || die
	doman cvsps.1
	dodoc README 
}
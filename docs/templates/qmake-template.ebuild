# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${P}.tar.gz"
fi

DESCRIPTION="<DESCRIPTION>"
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="LGPL-3"
SLOT="0"

DEPEND="

"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-util/intltool
    dev-qt/qtdeclarative:5
"

#PATCHES=(
#)

src_prepare() {
        default
}


src_configure() {
    eqmake5 CONFIG+=no_docs
}

src_install() {
    emake install INSTALL_ROOT="${D}"
}

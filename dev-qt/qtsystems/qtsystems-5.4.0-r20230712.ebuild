# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils git-r3

KEYWORDS="~amd64"
EGIT_REPO_URI="https://github.com/qt/${PN}.git"
EGIT_COMMIT="81e08ee508d0a49c588705cc9c47568b09a258db"

DESCRIPTION="Qt Systems"

HOMEPAGE="https://qt-project.org/"

LICENSE="LGPL-2.1 LGPL-3 GPL-3"
SLOT="0"

DEPEND="

"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-util/intltool
    dev-qt/qtdeclarative:5
"

src_prepare() {
        default
}


src_configure() {
    eqmake5 CONFIG+=no_docs
}

src_install() {
    emake install INSTALL_ROOT="${D}"
}

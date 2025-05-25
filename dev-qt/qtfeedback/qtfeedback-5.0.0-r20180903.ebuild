# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils git-r3

KEYWORDS="~amd64"
EGIT_REPO_URI="https://github.com/qt/${PN}.git"
EGIT_COMMIT="a14bd0bb1373cde86e09e3619fb9dc70f34c71f2"

DESCRIPTION="Qt Tactile Feedback"

HOMEPAGE="https://qt-project.org/"

LICENSE="LGPL-2.1 LGPL-3 GPL-3"
SLOT="5"

DEPEND="

"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-util/intltool
    dev-qt/qtdeclarative:5
"
PATCHES=(
    "${FILESDIR}"/0001-Set-MODULE_VERSION-to-5.0.0.patch
)

src_prepare() {
        default
}


src_configure() {
    eqmake5 CONFIG+=no_docs
}

src_install() {
    emake install INSTALL_ROOT="${D}"
}

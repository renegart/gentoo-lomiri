# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qt5-build git-r3

KEYWORDS="~amd64"
EGIT_REPO_URI="https://github.com/qt/${PN}.git"
EGIT_COMMIT="<COMMIT>"

DESCRIPTION="<DESCRIPTION>"

HOMEPAGE="https://qt-project.org/"

LICENSE="LGPL-2.1 LGPL-3 GPL-3"
SLOT="5"

RDEPEND="
    =dev-qt/qtcore-${QT5_PV}*
    =dev-qt/qtdeclarative-${QT5_PV}*
"

DEPEND="${RDEPEND}"

#PATCHES=(
#    "${FILESDIR}"/
#)

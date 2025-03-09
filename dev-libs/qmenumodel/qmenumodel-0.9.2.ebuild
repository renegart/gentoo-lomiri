# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://github.com/AyatanaIndicators/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://github.com/AyatanaIndicators/${PN}/archive/${PV}/${PN}-${PV}.tar.gz"
fi

DESCRIPTION="Qt5 renderer for Ayatana Indicators"
HOMEPAGE="https://github.com/AyatanaIndicators/${PN}"

LICENSE="LGPL-3"
SLOT="0"

DEPEND="
    dev-qt/qtdeclarative:5

"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
"

#PATCHES=(
#)

src_configure() {
    local mycmakeargs=(
        -DENABLE_COVERAGE="OFF"
        -DENABLE_TESTS="OFF"
        -DGENERATE_DOC="OFF"
    )

    cmake_src_configure
}

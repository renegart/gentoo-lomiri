# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/lib-cpp/${PN}/-/archive/${PV}/${P}.tar.gz"
fi

DESCRIPTION="<DESCRIPTION>"
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    dev-libs/properties-cpp
"

RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
    dev-libs/boost
"

src_prepare() {
    # remove hard coded enabling of tests
    sed -i "/include(CTest)/d" CMakeLists.txt  || die
    sed -i "/add_subdirectory(tests)/d" CMakeLists.txt  || die

    #remove hard coded generation of docs
    sed -i "/add_subdirectory(doc)/d" CMakeLists.txt  || die

    cmake_src_prepare
}

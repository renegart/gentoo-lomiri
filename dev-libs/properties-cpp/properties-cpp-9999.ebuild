# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/lib-cpp/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"
fi

DESCRIPTION="A very simple convenience library for handling properties and signals in C++11"
HOMEPAGE="https://gitlab.com/ubports/development/core/lib-cpp/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
    dev-build/samurai
"

src_prepare() {
    # remove hard coded enabling of tests
    sed -i "/enable_testing()/d" CMakeLists.txt  || die
    sed -i "/add_subdirectory(tests)/d" CMakeLists.txt  || die

    cmake_src_prepare
}

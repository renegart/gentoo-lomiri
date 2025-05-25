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
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${P}.tar.gz"
fi

DESCRIPTION="Library to detect and configure devices"
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    dev-cpp/yaml-cpp
"

RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
"

src_prepare() {
    eapply_user

    # remove hard coded coverage report
    sed -i "/find_package(CoverageReport)/d" CMakeLists.txt  || di

    cmake_src_prepare
}

src_configure() {
    local mycmakeargs=(
        -DDISABLE_TESTS="ON"
        -DWITH_EXTRAS="OFF"
        -DCONFIG_PATH=/etc/lomiri-deviceinfo
    )

    cmake_src_configure
}

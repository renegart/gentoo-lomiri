# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/lib-cpp/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/lib-cpp/${PN}/-/archive/${PV}/${P}.tar.gz"
fi

DESCRIPTION="<DESCRIPTION>"
HOMEPAGE="https://gitlab.com/ubports/development/core/lib-cpp/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    dev-libs/boost
    dev-libs/process-cpp
    dev-libs/libxml2
    sys-apps/dbus
"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
    dev-build/samurai
"

src_prepare() {
    eapply_user

    # remove ctest from the build
    sed -i '/include(CTest)/d' CMakeLists.txt || die
    sed -i '/add_subdirectory(tests)/d' CMakeLists.txt || die

    cmake_src_prepare
}


#src_configure() {
#    local mycmakeargs=(
#        -DWANT_TESTS="OFF"
#        -DWANT_DEMO="OFF"
#        -DWANT_DOC="OFF"
#    )
#
#    cmake_src_configure
#}

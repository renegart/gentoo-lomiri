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
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"
fi

DESCRIPTION=""
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="GPL-3"
SLOT="0"
RESTRICT=test"

DEPEND="
"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
"

#PATCHES=(
#)

#src_configure() {
#    local mycmakeargs=(
#        -DENABLE_TESTS="OFF"
#        -DENABLE_COVERAGE="OFF"
#        -DUSE_SYSTEMD="ON"
#        -DENABLE_MIRCLIENT="OFF"
#        -DLOMIRI_APP_LAUNCH_ARCH="None"
#    )
#
#    cmake_src_configure
#}

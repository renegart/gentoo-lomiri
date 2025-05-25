# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake

KEYWORDS="~amd64"
SRC_URI="https://releases.ayatana-indicators.org/source/${PN}/${PN}-${PV}.tar.gz"


DESCRIPTION="Ayatana Indicator Keyboard Applet"
HOMEPAGE="https://github.com/AyatanaIndicators/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    dev-libs/glib
    dev-libs/libayatana-appindicator
    sys-apps/accountsservice
    x11-libs/libX11
    x11-libs/libxkbcommon
    x11-libs/libxklavier
"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
"

src_configure() {
    local mycmakeargs=(
        -DENABLE_WERROR="ON"
        -DENABLE_UBUNTU_ACCOUNTSSERVICE="ON"
    )

    cmake_src_configure
}

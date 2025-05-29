# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

KEYWORDS="~amd64"
SRC_URI="https://releases.ayatana-indicators.org/source/${PN}/${P}.tar.gz"


DESCRIPTION="Ayatana Indicator Session Applet"
HOMEPAGE="https://github.com/AyatanaIndicators/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    dev-libs/glib
    dev-libs/libayatana-common
"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
"

# TODO: add RDA as USE flag.
# disable 'RDA (remote desktop awareness)' for now.

src_configure() {
    local mycmakeargs=(
        -DENABLE_TESTS="OFF"
        -DENABLE_COVERAGE="OFF"
        -DENABLE_WERROR="ON"
        -DENABLE_RDA="OFF"
    )

    cmake_src_configure
}

pkg_postinstall() {
    xdg_desktop_database_update
}

pkg_postrm() {
    xdg_desktop_database_update
}

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

KEYWORDS="~amd64"
SRC_URI="https://releases.ayatana-indicators.org/source/${PN}/${P}.tar.gz"


DESCRIPTION="Ayatana Indicator Date & Time Applet"
HOMEPAGE="https://github.com/AyatanaIndicators/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    ayatana-indicators/ayatana-indicator-messages
    dev-libs/libayatana-common
    dev-libs/libical
    dev-libs/properties-cpp
    dev-libs/glib
    gnome-extra/evolution-data-server
    media-libs/gstreamer
    net-libs/libaccounts-glib
    x11-libs/libnotify
"

RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
"

src_configure() {
    local mycmakeargs=(
        -DENABLE_TESTS="OFF"
        -DENABLE_COVERAGE="OFF"
        -DENABLE_WERROR="ON"
    )

    cmake_src_configure
}

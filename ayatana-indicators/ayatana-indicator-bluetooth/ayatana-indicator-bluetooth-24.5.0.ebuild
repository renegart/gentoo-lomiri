# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vala cmake

KEYWORDS="~amd64"
SRC_URI="https://releases.ayatana-indicators.org/source/${PN}/${P}.tar.gz"


DESCRIPTION="Ayatana System Indicator for Bluetooth Management"
HOMEPAGE="https://github.com/AyatanaIndicators/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    dev-libs/libayatana-common
    dev-libs/glib
    sys-apps/systemd
"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
    $(vala_depend)
"

src_prepare() {
    eapply_user

    vala_setup

    # fix hard coded name 'FindVala.cmake' -> maybe we should disable this file
    sed -i "s:find_program (VALA_COMPILER \"valac\"):find_program (VALA_COMPILER \"valac-$(vala_best_api_version)\"):" cmake/FindVala.cmake || die
    sed -i "s:find_program (VAPI_GEN \"vapigen\"):find_program (VAPI_GEN \"vapigen-$(vala_best_api_version)\"):" cmake/FindVala.cmake || die

    cmake_src_prepare
}

src_configure() {
    local mycmakeargs=(
        -DENABLE_WERROR=ON
    )

    cmake_src_configure
}

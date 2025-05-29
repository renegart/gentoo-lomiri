# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake vala

KEYWORDS="~amd64"
SRC_URI="https://github.com/AyatanaIndicators/${PN}/archive/${PV}/${PN}-${PV}.tar.gz"

DESCRIPTION="Shared Library for common functions required by the Ayatana System Indicators"
HOMEPAGE="https://github.com/AyatanaIndicators/${PN}"

IUSE="+lomiri"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    dev-libs/glib
    dev-libs/gobject-introspection
    lomiri? ( lomiri-extra/lomiri-url-dispatcher )
    $(vala_depend)
"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
    dev-build/samurai
"

#PATCHES=(
#)

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
        -DENABLE_COVERAGE="OFF"
        -DENABLE_TESTS="OFF"
        -DENABLE_WERROR="ON"
        -DENABLE_LOMIRI_FEATURES=$(usex lomiri)
    )

    cmake_src_configure
}

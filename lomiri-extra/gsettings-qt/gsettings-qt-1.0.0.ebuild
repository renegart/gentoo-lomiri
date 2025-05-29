# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake qmake-utils

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
fi

DESCRIPTION="Library to access GSettings from Qt"
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="LGPL-3"
SLOT="0"

DEPEND="
    dev-libs/glib
"

RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
    dev-qt/qtdeclarative:5
"
S="${WORKDIR}/${PN}-v${PV}"

src_configure() {
    # add 'qmlplugindump' to PATH
    export PATH="$(qt5_get_bindir):${PATH}"

    local mycmakeargs=(
        -DBUILD_TESTING="OFF"
    )

    cmake_src_configure
}

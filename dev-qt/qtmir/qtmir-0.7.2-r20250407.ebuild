# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake qmake-utils

KEYWORDS="~amd64"

git_commit="ea2f4774b1a109fec3e22a021fb21ff60da80626" # personal/sunweaver/debian-upstream

SRC_URI="https://gitlab.com/ubports/development/core/qtmir/-/archive/${git_commit}/qtmir-${git_commit}.tar.gz"
DESCRIPTION="QPA plugin to make Qt a Mir server"
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="LGPL-3"
SLOT="0"

S="${WORKDIR}/qtmir-${git_commit}"

DEPEND="
    dev-libs/process-cpp
    dev-util/lttng-ust
    gui-libs/mir
    lomiri-base/lomiri-api
    lomiri-extra/lomiri-app-launch
    lomiri-extra/lomiri-url-dispatcher
    lomiri-extra/gsettings-qt
    media-libs/libglvnd
    dev-qt/qtsensors:5
    x11-libs/libxkbcommon

"

RDEPEND="${DEPEND}"

BDEPEND="
    >=dev-build/cmake-3.31
    dev-build/cmake-extras
    dev-build/samurai
    dev-qt/qtdeclarative:5
    dev-util/intltool
"

#TODO:
# - remove all demo stuff

src_prepare() {
    # fix cmake min version
    sed -i "s/cmake_minimum_required(VERSION 3.1)/cmake_minimum_required(VERSION 3.31)/" CMakeLists.txt  || die

    # remove hard coded enabling of tests
    sed -i "/^pkg_check_modules(QTDBUSTEST/d" CMakeLists.txt  || die
    sed -i "/^pkg_check_modules(QTDBUSMOCK/d" CMakeLists.txt  || die

    cmake_src_prepare
}


src_configure() {
    # add 'qmlplugindump' to PATH
    export PATH="$(qt5_get_bindir):${PATH}"

    local mycmakeargs=(
        -DWITH_MIR2=ON
        -DWITH_VALGRIND="OFF"
    )

    cmake_src_configure
}

# update the icon cache after installing a new icon
pkg_postinst() {
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_icon_cache_update
}

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${P}.tar.gz"
fi

DESCRIPTION="Qt Components for Lomiri"
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="LGPL-3"
SLOT="0"

DEPEND="
    dev-libs/libevdev
    dev-libs/inih
    dev-qt/qtgraphicaleffects:5
    dev-qt/qtsvg:5
    dev-qt/qtpim:5
    dev-qt/qtsystems:5
    dev-util/lttng-ust
    gui-libs/mir
    x11-libs/libXi
"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-util/intltool
    dev-qt/qtdeclarative:5
"

PATCHES=(
    "${FILESDIR}"/0000-Remove-reset-of-compile-flags.patch
    "${FILESDIR}"/0001-Remove-debian-isms-from-test-runner.patch
    "${FILESDIR}"/0002-Don-t-build-app-launch-profiler.patch
)

src_prepare() {
        default
}


src_configure() {
    eqmake5 CONFIG+=no_docs
}

src_install() {
    emake install INSTALL_ROOT="${D}"
}

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The Lomiri (Unity8) Desktop"
HOMEPAGE="https://gitlab.com/ubports/development/core/lomiri"

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${P}.tar.gz"
fi

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
RESTRICT="test"

COMMON_DEPEND="
	ayatana-indicators/ayatana-indicator-keyboard
	ayatana-indicators/ayatana-indicator-session
	dev-libs/glib
	dev-libs/qmenumodel
	dev-libs/deviceinfo
	dev-qt/qtconcurrent:5
	dev-qt/qtdeclarative:5
	dev-qt/qtmir:5
	dev-qt/qtsvg:5
	dev-qt/qtsql:5
	dev-qt/qtxml:5
	gnome-base/gnome-desktop:3
	>=lomiri-base/lomiri-schemas-0.1.8
	>=lomiri-extra/lomiri-app-launch-0.1.5
	>=lomiri-extra/lomiri-ui-toolkit-1.3.5110
	>=net-libs/geonames-0.3.1
"

RDEPEND="${COMMON_DEPEND}"

DEPEND="${COMMON_DEPEND}"

BDEPEND="
	dev-build/cmake-extras
    dev-util/intltool
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/0001-Disable-broken-tests-due-to-dropped-mocks-from-mir-2.patch
	"${FILESDIR}"/0002-Add-qt5-suffix-to-search-for-Qt-tools.patch
	"${FILESDIR}"/0004-Disable-lightdm-integration.patch
	"${FILESDIR}"/0005-Use-Mir-2.x.patch
	"${FILESDIR}"/0006-Build-with-C-20.patch
)

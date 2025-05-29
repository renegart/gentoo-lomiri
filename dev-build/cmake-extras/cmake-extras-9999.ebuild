# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"
fi

DESCRIPTION="A collection of add-ons for the CMake build tool."
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    dev-libs/glib
"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
"

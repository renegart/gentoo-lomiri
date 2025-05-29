# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

KEYWORDS="~amd64"
SRC_URI="https://github.com/ArcticaProject/librda/archive/${PV}/${P}.tar.gz"


DESCRIPTION="Remote Desktop Awareness Shared Library"
HOMEPAGE="https://github.com/ArcticaProject/librda/${PN}"

LICENSE="GPL-3"
SLOT="0"
IUSE="ogon x2go"
RESTRICT="test"

DEPEND="
    dev-libs/glib
    x11-libs/gtk+:3
"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/automake-wrapper
    dev-build/automake
"

src_prepare() {
    eapply_user

	eautoreconf
}

src_configure() {
    local myconf=(
        $(use_enable ogon)
        $(use_enable x2go)
        --disable-tests
    )

	econf "${myconf[@]}"

}

src_compile() {
    emake
}

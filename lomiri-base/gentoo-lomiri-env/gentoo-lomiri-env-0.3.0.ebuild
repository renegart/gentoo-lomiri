# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Setup the Lomiri build environment."
HOMEPAGE="https://github.com/renegart/gentoo-lomiri"
SRC_URI=""

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64"

IUSE="dev"
RESTRICT="binchecks strip test"

S="${WORKDIR}"

src_install() {
	n="gentoo-lomiri"

	for x in {accept_keywords,env,mask,unmask,use}; do
		dodir "/etc/portage/package.${x}"
		dosym -r "${REPO_ROOT}/profiles/${n}.${x}" \
			"/etc/portage/package.${x}/0000_${n}.${x}" || die
	done

	dodir "/etc/portage/env"
	dosym -r "${REPO_ROOT}/profiles/${n}.conf.env" \
		"/etc/portage/env/${n}.conf" || die

	use dev && dosym -r "${REPO_ROOT}/profiles/${n}-dev.accept_keywords" \
		"/etc/portage/package.accept_keywords/0001_${n}-dev.accept_keywords"
}

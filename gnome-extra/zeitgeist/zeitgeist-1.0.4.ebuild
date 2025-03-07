# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )

inherit autotools python-single-r1 xdg vala

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.freedesktop.org/zeitgeist/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.freedesktop.org/zeitgeist/zeitgeist/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
fi

DESCRIPTION="Service to log activities and present to other apps"
HOMEPAGE="https://zeitgeist.freedesktop.org"


LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
IUSE="+datahub doc +downloads-monitor +fts introspection nls sql-debug telepathy test"
REQUIRED_USE="${PYTHON_REQUIRED_USE} downloads-monitor? ( datahub )"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	>=dev-db/sqlite-3.7.11:3
	>=dev-libs/glib-2.43.92:2
	>=dev-libs/json-glib-1.5.2
	>=dev-libs/xapian-1.4.25
	datahub? ( >=x11-libs/gtk+-3.0.0:3 )
	fts? ( >=dev-libs/xapian-1.4.17:0=[inmemory(+)] )
	introspection? ( >=dev-libs/gobject-introspection-1.30.0 )
	telepathy? ( >=net-libs/telepathy-glib-0.18.0 )

	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/pygobject:3[${PYTHON_USEDEP}]')
"
RDEPEND="${COMMON_DEPEND}
	>=sys-devel/gcc-5.2
	>=sys-libs/glibc-2.14

	doc? ( dev-util/devhelp )

	$(python_gen_cond_dep '
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/pyxdg[${PYTHON_USEDEP}]
	')
"
DEPEND="${COMMON_DEPEND}

	doc? (
		dev-lang/vala[valadoc]
		dev-util/gtk-doc
		media-libs/raptor:2
	)

	$(python_gen_cond_dep 'dev-python/rdflib[${PYTHON_USEDEP}]')

	$(vala_depend)
"

S="${WORKDIR}/${PN}-v${PV}"

src_prepare() {
	use doc && local VALA_USE_DEPEND="valadoc"

	# Fix doc dir #
	sed -i "s:pkgdatadir)/doc:datadir)/doc/${PF}:" Makefile.am || die

	eapply_user

	vala_setup
	export VALA_API_GEN="${VAPIGEN}"

	default

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable doc docs)
		$(use_enable datahub)
		$(use_enable downloads-monitor)
		$(use_enable fts)
		$(use_enable introspection)
		$(use_enable nls)
		$(use_enable sql-debug explain-queries)
		$(use_enable telepathy)
	)
	econf "${myeconfargs[@]}"

	# Process translations #
	pushd po >/dev/null || die
		emake update-gmo || die
	popd >/dev/null || die
}

src_install() {
	default

	# valadoc generated documentation #
	use doc && dodoc -r doc/libzeitgeist/docs_c doc/libzeitgeist/docs_vala

	find "${ED}" -name '*.la' -delete || die
}

pkg_postinst() {
	echo
	elog "In case of problems, reset ZeitGeist database:"
	elog "rm -rfv ~/.local/share/zeitgeist"
	echo
}

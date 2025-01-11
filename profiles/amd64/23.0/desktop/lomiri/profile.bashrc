if [[ ${EBUILD_PHASE} == "setup" ]]; then
	## Get gentoo-lomiri repo path via portageq tool.
	PORTAGE_QUERY_TOOL=portageq
	[[ -e "${PORTAGE_BIN_PATH}"/portageq-wrapper ]] && PORTAGE_QUERY_TOOL="${PORTAGE_BIN_PATH}"/portageq-wrapper
	if "${PORTAGE_QUERY_TOOL}" get_repo_path / gentoo-lomiri >/dev/null 2>&1; then
		REPO_ROOT=$("${PORTAGE_QUERY_TOOL}" get_repo_path / gentoo-lomiri)
	else
		die "portageq: gentoo-lomiri repo path not found. If you have recently updated sys-apps/portage then you should re-run 'emerge -avuDU --with-bdeps=y @world' to catch any updates."
	fi
fi ## End of setup phase.

# how to fix some issues, which can occur when writing ebuilds for lomiri

## error: Could not locate qmlplugindump

- inherit qmake-utils
- add the following line in your ebuild:
    ```bash
    # add 'qmlplugindump' to PATH
    export PATH="$(qt5_get_bindir):${PATH}"
    ```

## QA Notice: new icons were found installed but icon cache

- inherit xdg
- add pkg_postinst() and pkg_postrm() functions:
    ```bash
    # update the icon cache after installing a new icon
    pkg_postinst() {
        xdg_icon_cache_update
    }

    pkg_postrm() {
        xdg_icon_cache_update
    }
    ```

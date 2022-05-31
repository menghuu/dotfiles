#!/usr/bin/env bash

# configure tldr(python client)

os_command_is_installed tldr && {
    export TLDR_COLOR_NAME="cyan"
    export TLDR_COLOR_DESCRIPTION="white"
    export TLDR_COLOR_EXAMPLE="green"
    export TLDR_COLOR_COMMAND="red"
    export TLDR_COLOR_PARAMETER="white"
    export TLDR_LANGUAGE="es"
    export TLDR_CACHE_ENABLED=1
    export TLDR_CACHE_MAX_AGE=720
    export TLDR_PAGES_SOURCE_LOCATION="https://raw.githubusercontent.com/tldr-pages/tldr/master/pages"
    export TLDR_DOWNLOAD_CACHE_LOCATION="https://tldr-pages.github.io/assets/tldr.zip"
}

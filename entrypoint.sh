#!/bin/bash -l

# active bash options:
#   - stops the execution of the shell script whenever there are any errors from a command or pipeline (-e)
#   - option to treat unset variables as an error and exit immediately (-u)
#   - print each command before executing it (-x)
#   - sets the exit code of a pipeline to that of the rightmost command
#     to exit with a non-zero status, or to zero if all commands of the
#     pipeline exit successfully (-o pipefail)
set -euo pipefail

main() {

    # Retrieve input parameters
    CURRENT_VERSION="$1"; RELEASE_TYPE="$2"

    # PARAMETER CHECKS ---------------------------

    # Possible release types
    #   possible_release_types="major feature bug alpha beta pre rc"
    POSSIBLE_RELEASE_TYPES="major feature fix refactor docs"

    # Check for CURRENT_VERSION
    if [[ "$CURRENT_VERSION" == "" ]]; then
        echo "could not read previous version"; exit 1
    fi

    # Check for RELEASE_TYPE
    if [[ ! ${POSSIBLE_RELEASE_TYPES[*]} =~ ${RELEASE_TYPE} ]]; then
        echo "valid argument: [ ${POSSIBLE_RELEASE_TYPES[*]} ]"; exit 1
    fi

    # Break down CURRENT_VERSION ---------------------------
    # Initialize variables
    major=0; minor=0; patch=0;

    # break down the version number into it's components
    regex="^v?([0-9]+).([0-9]+).([0-9]+)((-[a-z]+).?([0-9]+))?$"
    if [[ $CURRENT_VERSION =~ $regex ]]; then
        major="${BASH_REMATCH[1]}"
        minor="${BASH_REMATCH[2]}"
        patch="${BASH_REMATCH[3]}"
    else
        echo "previous version '$CURRENT_VERSION' is not a semantic version"
        exit 1
    fi

    # CALCULATE NEW VERSION ---------------------------
    # increment version number based on given release type
    case "$RELEASE_TYPE" in
    "major")
        ((++major)); minor=0; patch=0;;
    "feature")
        ((++minor)); patch=0;;
    "fix")
        ((++patch));;
    "refactor")
        ((++patch));;
    "docs")
        ((++patch));;
    esac

    NEW_VERSION="${major}.${minor}.${patch}"
    echo "Create $RELEASE_TYPE-release version: $CURRENT_VERSION -> $NEW_VERSION"

    echo "new-version=$NEW_VERSION" >> $GITHUB_OUTPUT
}

# Run
main "$1" "$2"

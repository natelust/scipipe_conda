n8l::fail() {
	local code=${2:-1}
	[[ -n $1 ]] && n8l::print_error "$1"
	# shellcheck disable=SC2086
	exit $code
}

get_name()
{
	case $(uname -s) in
		Linux*)
            name="conda3_packages-linux-64.yml"
			;;
		Darwin*)
            name="conda3_packages-osx-64.yml"
			;;
		*)

			n8l::fail "Cannot install miniconda: unsupported platform $(uname -s)"
			;;
	esac


    echo $name
}

fetch()
{
    :
}

prep()
{
    local name=$(get_name)
    local url="https://raw.githubusercontent.com/lsst/scipipe_conda_env/master/etc"

	(
		set -Eeo pipefail
        mkdir -p $PREFIX
        cd $PREFIX

        curl -sSOL "${url}/${name}" 
	)
}

build()
{
    :
}

install()
{
    (
        cd $PREFIX
        name=$(get_name)
        conda env create --prefix=${PREFIX} --file=${PREFIX}${name}
        rm $name
    )
    cp -r ups $PREFIX/
}


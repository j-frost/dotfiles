function gitpod::save_env() {
    # echo "Saving file ${2} to Gitpod environment variable called ${1}"
    gp env $1="$(base64 -w0 $2)" >/dev/null
}

function gitpod::restore_file() {
    # echo "Restoring file ${2} from Gitpod environment variable called ${1}"
    echo ${(P)1} | base64 -d > ${2}
}

function gitpod::save_gcloud() {
    local _gcloud_config_dir="${HOME}/.config/gcloud"

    gitpod::save_env GCLOUD_ACTIVE_CONFIG "${_gcloud_config_dir}/active_config"
    gitpod::save_env GCLOUD_CONFIGURATION "${_gcloud_config_dir}/configurations/config_default"
    gitpod::save_env GCLOUD_CREDENTIALS "${_gcloud_config_dir}/credentials.db"
    gitpod::save_env GCLOUD_ADC_CREDENTIALS "${_gcloud_config_dir}/application_default_credentials.json"
}

function gitpod::restore_gcloud() {
    local _gcloud_config_dir="${HOME}/.config/gcloud"
    if [[ ! -d "${_gcloud_config_dir}" ]]; then
        mkdir -p "${_gcloud_config_dir}/configurations"
        gitpod::restore_file GCLOUD_ACTIVE_CONFIG "${_gcloud_config_dir}/active_config"
        gitpod::restore_file GCLOUD_CONFIGURATION "${_gcloud_config_dir}/configurations/config_default"
        gitpod::restore_file GCLOUD_CREDENTIALS "${_gcloud_config_dir}/credentials.db"
        gitpod::restore_file GCLOUD_ADC_CREDENTIALS "${_gcloud_config_dir}/application_default_credentials.json"

        [[ -n "${GCP_PROJECT}" ]] && gcloud config set project "${GCP_PROJECT}"
    fi
}

if [[ -n $(command -v gcloud) ]]; then
    gitpod::restore_gcloud
fi

if gp env | grep '^TFVARS'; then
    gitpod::restore_file TFVARS "${GITPOD_REPO_ROOT}/terraform.tfvars"
fi

if gp env | grep '^DOTENV'; then
    gitpod::restore_file DOTENV "${GITPOD_REPO_ROOT}/.env"
fi

if gp env | grep '^DOTENV_KEYS_FILE'; then
    gitpod::restore_file DOTENV_KEYS_FILE "${GITPOD_REPO_ROOT}/.env.keys"
fi

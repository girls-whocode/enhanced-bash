
function _alert() {
  if [ "${1}" = "emergency" ]; then local color="${bold}${Red}"; fi
  if [ "${1}" = "error" ]; then local color="${bold}${Red}"; fi
  if [ "${1}" = "warning" ]; then local color="${bold}${Orange}"; fi
  if [ "${1}" = "notice" ]; then local color="${bold}${CornflowerBlue}"; fi
  if [ "${1}" = "info" ]; then local color="${bold}${SteelBlue}"; fi
  if [ "${1}" = "success" ]; then local color="${bold}${Green}"; fi
  if [ "${1}" = "debug" ]; then local color="${bold}${Purple}"; fi
  if [ "${1}" = "header" ]; then local color="${bold}${Tan}"; fi
  if [ "${1}" = "input" ]; then local color="${bold}"; printLog="false"; fi
  
  # Don't use colors on pipes or non-recognized terminals
  if [[ "${TERM}" != "xterm"* ]] || [ -t 1 ]; then color=""; reset=""; fi

  # Print to console when script is not 'quiet'
  if [[ "${quiet}" = "true" ]] || [ "${quiet}" == "1" ]; then
   return
  else
   echo -e "$(date +"%r") ${color}$(printf "[%9s]" "${1}") ${reset}${_message}${reset}";
  fi

}

function die () {
  local _message="${*} Exiting.";
  echo "[$(LC_ALL=C date +"%Y-%m-%d %H:%M:%S")]:[ALERT]:[${_message}]" >> ${logsLocation}/startup.log
  echo "$(_alert emergency)";
  safeExit;
}

function error () {
  local _message="${*}";
  echo "[$(LC_ALL=C date +"%Y-%m-%d %H:%M:%S")]:[ERROR]:[${_message}]" >> ${logsLocation}/startup.log
  echo "$(_alert error)";
}

function warning () {
  local _message="${*}";
  echo "[$(LC_ALL=C date +"%Y-%m-%d %H:%M:%S")]:[WARNING]:[${_message}]" >> ${logsLocation}/startup.log
  echo "$(_alert warning)";
}

function notice () {
  local _message="${*}";
  echo "[$(LC_ALL=C date +"%Y-%m-%d %H:%M:%S")]:[NOTICE]:[${_message}]" >> ${logsLocation}/startup.log
  echo "$(_alert notice)";
}

function info () {
  local _message="${*}";
  echo "[$(LC_ALL=C date +"%Y-%m-%d %H:%M:%S")]:[INFO]:[${_message}]" >> ${logsLocation}/startup.log
  echo "$(_alert info)";
}

function debug () {
  local _message="${*}";
  echo "[$(LC_ALL=C date +"%Y-%m-%d %H:%M:%S")]:[DEBUG]:[${_message}]" >> ${logsLocation}/startup.log
  echo "$(_alert debug)";
}

function success () {
  local _message="${*}";
  # echo "[$(LC_ALL=C date +"%Y-%m-%d %H:%M:%S")]:[SUCCESS]:[${_message}]"
  echo "$(_alert success)";
}

function input() {
  local _message="${*}";
  echo -n "$(_alert input)";
}

function header() {
  local _message="========== ${*} ==========  ";
  echo "$(_alert header)";
}

function verbose() {
  if [[ "${verbose}" = "true" ]] || [ "${verbose}" == "1" ]; then
    debug "$@"
  fi
}

function is_exists() {
  if [[ -e "$1" ]]; then
    return 0
  fi
  return 1
}

function is_not_exists() {
  if [[ ! -e "$1" ]]; then
    return 0
  fi
  return 1
}

function is_file() {
  if [[ -f "$1" ]]; then
    return 0
  fi
  return 1
}

function is_not_file() {
  if [[ ! -f "$1" ]]; then
    return 0
  fi
  return 1
}

function is_dir() {
  if [[ -d "$1" ]]; then
    return 0
  fi
  return 1
}

function is_not_dir() {
  if [[ ! -d "$1" ]]; then
    return 0
  fi
  return 1
}

function is_symlink() {
  if [[ -L "$1" ]]; then
    return 0
  fi
  return 1
}

function is_not_symlink() {
  if [[ ! -L "$1" ]]; then
    return 0
  fi
  return 1
}

function is_empty() {
  if [[ -z "$1" ]]; then
    return 0
  fi
  return 1
}

function is_not_empty() {
  if [[ -n "$1" ]]; then
    return 0
  fi
  return 1
}

function type_exists() {
  if [ "$(type -P "$1")" ]; then
    return 0
  fi
  return 1
}

function type_not_exists() {
  if [ ! "$(type -P "$1")" ]; then
    return 0
  fi
  return 1
}

function is_os() {
  if [[ "${OSTYPE}" == $1* ]]; then
    return 0
  fi
  return 1
}
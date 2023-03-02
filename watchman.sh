#!/bin/bash

################################################################################
#                                                                              #
#                            W A T C H M A N                                   #
#                                                                              #
#   A Bash script that monitors changes in target ports and statuses.          #
#                                                                              #
#                            [Author: ReverseTEN]                              #
#                                                                              #
#                    GitHub: https://github.com/ReverseTEN/                    #
#                                                                              #
################################################################################



check_requirements(){
    
  # List of required packages and their installation commands
  declare -A packages=(
    ["naabu"]="go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
    ["anew"]="go install -v github.com/tomnomnom/anew@latest"
    ["httpx"]="go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest"
    ["notify"]="go install -v github.com/projectdiscovery/notify/cmd/notify@latest"
  )

  # Check if required packages are installed
  for package in "${!packages[@]}"; do
    if ! command -v "${package}" >/dev/null 2>&1; then
      echo "[inf] The package '${package}' is required but not installed. Install it with: ${packages[$package]}"
      exit 1
    fi
  done

  if [ ! -f "ips.txt" ]; then
    echo "Create an ips.txt file in the root directory of the script and add your target (IPs, Domains/Subdomains} to the file"
  fi

}


first_time(){
    mkdir $1-watcher
    naabu -silent -list "ips.txt" -top-ports 1000 -o $1-watcher/$1-ports
    httpx -silent -status-code -title -list $1-watcher/$1-ports -o $1-watcher/$1-status
    # cat command to display the concatenated results of the Subtracker script, which can help you monitor new subdomains for any changes.
    # cat "/root/scripts/subtracker/target.com/target.com-subdomains.txt" | anew "ips.txt" > /dev/null 

}

New_Changes(){
    echo "[:fox_face: Discover the Latest Updates on $1 :fox_face:]" notify -silent
    naabu -silent -list "ips.txt" -top-ports 1000 -o $1-watcher/$1-ports2
    cat $1-watcher/$1-ports2 | anew $1-watcher/$1-ports > $1-watcher/$1-NewTargetPort.txt
    if [ -s "$1-watcher/$1-NewTargetPort.txt" ]; then
        echo "[:fox_face:] New port(s) detected on asset [:fox_face:]" | notify -silent
        cat $1-watcher/$1-NewTargetPort.txt | notify -silent 
        echo "  [:fox_face:] Status checking:" | notify -silent
        httpx -silent -status-code -title -list $1-watcher/$1-NewTargetPort.txt | notify -silent
    else
        echo "[:fox_face:] No new or modified ports detected on asset" | notify -silent
    fi

    httpx -silent -status-code -title -list $1-watcher/$1-ports -o $1-watcher/$1-status2
    cat $1-watcher/$1-status2 | anew $1-watcher/$1-status > $1-watcher/$1-StatusChange.txt

    if [ -s "$1-watcher/$1-StatusChange.txt" ]; then
        echo "[:fox_face:] New status/title detected on asset [:fox_face:]" | notify -silent 
        cat $1-watcher/$1-StatusChange.txt | notify -silent
    else
        echo "  [:fox_face:] No changes detected in asset status/title ." | notify -silent
    fi

}

Main(){
    check_requirements

    if [ -d "$1-watcher" ]; then
        New_Changes $1
    else
        echo "[:fox_face: Watchman Start :fox_face:]" | notify -silent
        first_time $1
    fi
}



Main $1

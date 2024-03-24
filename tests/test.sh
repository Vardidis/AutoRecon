#!/bin/sh
RES_PATH="tests/results.txt"

test_main(){
    sudo bash ./main.sh > $RES_PATH
    if [[ ! -s $RES_PATH ]]; then
        echo "[-] Failed test: \`main.sh\` didn't produce output"
        return 1
    fi

    return 0
}

test_main
#!/bin/bash

# Phisherman - Send Mail with Attachments via telnet to SMTP mailserver
# -- Cole Hocking
# The MIME Boundary. It can't appear anywhere else in the message
# (RFC 2045)
# Keep in mind, this one is also acting as a sort of 'signature';
# Maybe you want to change it... maybe you don't ;)
MIME_BOUND="KkK170891tpbkKk__FV_KKKkkkjjwq"

show_banner() {
    # A cool banner -- yes, I'm keeping it.
    cat ./lib/phisherman_banner.txt
    echo -e "\nSend mail to anyone, as anyone; via telnet to an SMTP server."
    echo -e "You know you want to... ;)"
    echo -e "Be safe; and have fun."
    echo -e "----------------------------------------------------------\n"
}

get_info(){
    # TODO - update with variables
    # Get the smtp mail server
    SERVER="mail.example.com"
    # recipient name/address
    RECIPIENT="recip@example.com"
    # sender name/address
    SENDER="sender@example.com"
    # Email subject line
    SUBJECT="Subject Goes Here"
    # Fromline with sender mask
    FROMLINE="John Doe <$SENDER>"

}

get_template_file() { 
    # Phish Body Email template
    # TODO - Customize HTML template
    TEMPLATE_FILE="./lib/phisher.html"
    if [[ -f "${TEMPLATE_FILE}" ]]; then
        IFS=$'\n' read -d '' -r -a TEXTARR < "${TEMPLATE_FILE}"
        # Content-Type; reads filetype; will throw error if not "txt"/"html"
        CT = $( echo "${TEMPLATE_FILE}" | cut -d "." -f3)
    else
        echo "file: ${TEMPLATE_FILE} does not appear to exist; abort mission"
        exit 1
    fi    
}

# Execute telnet
exec_telnet(){
    echo "open $SERVER 25"
    sleep 2
    echo "EHLO $SERVER"
    sleep 2
    echo "MAIL FROM: $SENDER"
    sleep 2
    echo "RCPT TO: $RECIPIENT"
    sleep 2
    echo "DATA"
    sleep 2
    echo "From: $FROMLINE"
    echo "To: <$RECIPIENT>"
    echo "Subject: $SUBJECT"
    echo "MIME-Version: 1.0"
    echo "Content-Type:multipart/mixed;boundary=\"$MIME_BOUND\""
    echo ""
    # optional preamble
    echo "--$MIME_BOUND"
    echo "Content-Type:text/$CT"
    echo ""
    for i in "${TEXTARR[@]}"; do
        echo "$i"
    done
    echo ""
    echo "--$MIME_BOUND--"
    # optional epilogue
    # terminating the data section requires <CRLF>.<CRLF>
    echo "."
    sleep 2
}

main(){
    show_banner
    get_info
    get_template_file
    echo -e "\nI'm going in! Damn the torpedoes!\n"
    exec_telnet | telnet
}
main

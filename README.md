```text
  ___  __   _     __
  / _ \/ /  (_)__ / /  ___ ____  __ _  ___ ____
 / ___/ _ \/ (_-</ _ \/ -_) __/ /  ' \/ _ `/ _ \
/_/  /_//_/_/___/_//_/\__/_/   /_/_/_/\_,_/_//_/

```
### Send email via telnet, through an open SMTP server. You know you want to.

Sends SMTP MIME-encoded messages via telnet.    
As long as the server validates the sender, you can send the messages as anyone the server validates ;). 
You can also mask the sender address.  
This is a non-interactive version of my [Telmail script](https://github.com/colehocking/telmail)

##### This tool is for educational purposes only.
See the included license.  


## Usage  
- Clone the repo.
- Update target variables in the "get_info()" function of `phisherman.sh`
- Update the HTML body of your message in `./lib/phisher.html`
- `./phisherman.sh`  





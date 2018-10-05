FROM debian:stretch-slim

WORKDIR /temp
ADD command.sh /temp/command.sh
CMD ["./command.sh"]

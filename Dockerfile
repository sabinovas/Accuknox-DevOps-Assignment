FROM ubuntu:latest
RUN apt update && apt install -y apt-utils
RUN apt install -y fortune-mod cowsay

COPY wisecow.sh /wisecow.sh
RUN chmod +x /wisecow.sh
CMD ["/wisecow.sh"]
EXPOSE 4499


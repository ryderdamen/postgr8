FROM postgres:11
RUN apt-get update && apt-get install -y curl
RUN apt install -y python2.7
RUN curl https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin
RUN mkdir /code
WORKDIR /code
COPY ./backup_postgres.sh .
ENTRYPOINT ["/bin/bash"]
CMD ["backup_postgres.sh"]

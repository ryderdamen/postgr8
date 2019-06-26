FROM postgres
RUN apt-get update && apt-get install -y curl
RUN curl https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin
RUN apt install -y python2.7
RUN mkdir /code
WORKDIR /code
COPY ./restore_postgres.sh .
ENTRYPOINT ["/bin/bash"]
CMD ["restore_postgres.sh"]

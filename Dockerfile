FROM heroku/heroku:20

RUN mkdir /app
RUN addgroup --quiet --gid 2000 slug && \
    useradd slug --uid=2000 --gid=2000 --home-dir /app --no-create-home

ADD bin/* /bin/
RUN chown -R slug:slug /app

ADD builder /builder
ADD procfile /usr/local/lib/python3/site-packages/procfile
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python3/site-packages

USER slug
ENV HOME /app
RUN /builder/install-buildpacks

ENTRYPOINT ["/builder/build.sh"]

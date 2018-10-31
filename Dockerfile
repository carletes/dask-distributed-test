FROM continuumio/miniconda3:4.5.11

RUN set -ex \
	&& groupadd -g 1000 dask \
	&& useradd -d /home/dask -m -g dask -u 1000 dask

RUN set -ex \
	&& conda install \
	bokeh==1.0.0 \
	dask==0.20.0 \
	distributed==1.24.0

RUN set -ex \
	&& wget -O /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64 \
	&& chown root: /usr/local/bin/gosu \
	&& chmod 0755 /usr/local/bin/gosu

RUN set -ex \
	&& mkdir -p /var/lib/dask \
	&& chown dask: /var/lib/dask

COPY scripts/run-scheduler /usr/local/bin/
COPY scripts/run-worker /usr/local/bin/

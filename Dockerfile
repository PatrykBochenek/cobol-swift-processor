FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends gnucobol make ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY cobol/ ./cobol/
COPY scripts/ ./scripts/
COPY data/ ./data/

RUN make -C cobol all

CMD ["sh", "./scripts/run-processor.sh"]

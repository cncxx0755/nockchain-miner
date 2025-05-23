FROM rust:1.87.0

RUN  apt-get update \
  && apt-get install -y build-essential git curl wget clang \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN git clone https://github.com/zorp-corp/nockchain.git

WORKDIR nockchain

RUN sed -i "s|^export MINING_PUBKEY .=.*$|export MINING_PUBKEY ?= 3t7fLYT6vwH8jqbGFQNYxUYeCJivwHr5KfiF4Vv6dztQB1fBD6xnkM2x7VnfYf38BzbyyCu7omKWhQX5mNbHBt7uRPX9H4xSh8KEJWi2KsgfB9Xjk8M8VrYRCJxKep58sWDk|" Makefile
RUN mv .env_example .env
RUN sed -i "s|^MINING_PUBKEY=.*$|MINING_PUBKEY=3t7fLYT6vwH8jqbGFQNYxUYeCJivwHr5KfiF4Vv6dztQB1fBD6xnkM2x7VnfYf38BzbyyCu7omKWhQX5mNbHBt7uRPX9H4xSh8KEJWi2KsgfB9Xjk8M8VrYRCJxKep58sWDk|" .env

RUN make install-hoonc
RUN make build
RUN make install-nockchain-wallet
RUN make install-nockchain

CMD [ "make", "run-nockchain" ]

FROM ruby:2.5.5

ENV APP_ROOT /app
WORKDIR $APP_ROOT

COPY . $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bin/setup && \
  rm -rf ~/.gem

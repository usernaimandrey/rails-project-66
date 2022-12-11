# web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
web: /bin/bash -l -c "bundle exec puma -C config/puma.rb"
frontend: bin/webpack-dev-server
release: bin/rake db:migrate
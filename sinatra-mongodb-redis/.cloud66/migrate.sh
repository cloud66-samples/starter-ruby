#!/bin/sh
cd $STACK_PATH
bundle exec rake db:migrate

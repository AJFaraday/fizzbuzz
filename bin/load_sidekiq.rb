#!/usr/bin/env ruby
root = File.expand_path(File.dirname(__FILE__))
require File.join(root, "../", "config", "environment")
Workers.stop
Workers.start

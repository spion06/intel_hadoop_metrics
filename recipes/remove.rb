#
# Cookbook Name:: intel_hadoop_metrics
# Recipe:: default
#
# Copyright (C) 2015 Kyle McGovern
#
# All rights reserved - Do Not Redistribute
#

# make sure this is stopped
service 'logstash_intel_hadoop_metrics' do
  action [:disable,:stop]
end

logstash_instance 'intel_hadoop_metrics' do
  action :delete
end

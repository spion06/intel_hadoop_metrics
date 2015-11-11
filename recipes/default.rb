#
# Cookbook Name:: intel_hadoop_metrics
# Recipe:: default
#
# Copyright (C) 2015 Kyle McGovern
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'

package 'perf'

logstash_instance 'intel_hadoop_metrics' do
  action :create
end

directory '/opt/intel-stats-scripts' do
  owner node['logstash']['instance_default']['user']
end

directory '/var/log/intel-hadoop-metrics' do
  owner node['logstash']['instance_default']['user']
end

node['intel_hadoop_metrics']['scripts'].each do |metric_script|
  cookbook_file ::File.join('/opt/intel-stats-scripts',"#{metric_script}.sh") do
    source "#{metric_script}.sh"
    mode '0755'
  end
end

logstash_config 'intel_hadoop_metrics' do
  templates ({ 'metrics.conf' => 'metrics.erb' })
  templates_cookbook 'intel_hadoop_metrics'
  variables ({ 
    :metrics_dir => node['intel_hadoop_metrics']['metrics_dir'],
    :compress => node['intel_hadoop_metrics']['compress'],
    :scripts => node['intel_hadoop_metrics']['scripts']
  })
end


logstash_service 'intel_hadoop_metrics' do
  action [:enable]
  not_if { ::File.exist?('/etc/init.d/logstash_intel_hadoop_metrics') }
end

# don't leave this started. only start on demand
service 'logstash_intel_hadoop_metrics' do
  action [:disable,:stop]
end

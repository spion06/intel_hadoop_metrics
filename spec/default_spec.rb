require 'spec_helper'

describe 'intel_hadoop_metrics::default' do

  let(:chef_run) do
    ChefSpec::ServerRunner.new do |node,server|
      node.automatic['memory']['total'] = '123121k'
    end.converge(described_recipe)
  end

  it 'should include java' do
    expect(chef_run).to include_recipe('java::default')
  end

  it 'should install perf' do
    expect(chef_run).to install_package('perf')
  end

  it 'should setup a logstash instance' do
    expect(chef_run).to create_logstash_instance('intel_hadoop_metrics')
    expect(chef_run).to create_logstash_config('intel_hadoop_metrics')
  end

  it 'should create required directories' do
    expect(chef_run).to create_directory('/opt/intel-stats-scripts').with( owner: 'logstash')
    expect(chef_run).to create_directory('/var/log/intel-hadoop-metrics').with( owner: 'logstash')
  end

  it 'should create the metric scripts' do
    %w(cpustat iostat jvms memstat mpstat netstat perf vmstat).each do |metric_script|
      expect(chef_run).to create_cookbook_file(::File.join('/opt/intel-stats-scripts',"#{metric_script}.sh")).with( mode: '0755' )
    end
  end

  it 'should create the logtash service' do
    expect(chef_run).to enable_logstash_service('intel_hadoop_metrics')
  end

  it 'should disable the logstash service by default' do
    expect(chef_run).to disable_service('logstash_intel_hadoop_metrics')
    expect(chef_run).to stop_service('logstash_intel_hadoop_metrics')
  end
end

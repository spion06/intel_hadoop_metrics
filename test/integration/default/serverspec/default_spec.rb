require 'spec_helper'

describe 'intel_hadoop_metrics::default' do
  context service('logstash_intel_hadoop_metrics') do
# disable this for now as the logstash cookbook restarts at the end of the chef-client run
#    it { should_not be_running }
    it { should_not be_enabled }
  end

  # start the service then sleep for a minute to let it finish starting up
  context command('service logstash_intel_hadoop_metrics start && sleep 60') do
    its(:exit_status) { should be 0 }
  end
  context 'post agent start' do
    context service('logstash_intel_hadoop_metrics') do
      it { should be_running }
    end
  end

  %w(cpustat iostat jvms memstat mpstat netstat perf vmstat).each do |metric_script|
    context file(::File.join('/opt/intel-stats-scripts',"#{metric_script}.sh")) do
      it { should be_file }
      it { should be_mode '755' }
    end
    context file(::File.join('/var/log/intel-hadoop-metrics', metric_script)) do
      it { should be_file }
      it { should be_owned_by 'logstash' }
    end
  end
end

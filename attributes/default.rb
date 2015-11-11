include_attribute 'java'
include_attribute 'logstash'

default['java']['jdk_version'] = '6'

default['logstash']['instance_default']['version']        = '1.4.5'
default['logstash']['instance_default']['source_url']     = 'https://download.elasticsearch.org/logstash/logstash/logstash-1.4.5.tar.gz'
default['logstash']['instance_default']['checksum']       = 'ddb6fd2d26e87b13d87fa1495492a7346d45267df46eed29503df08d3e5d8a13'
default['logstash']['instance_default']['install_type']   = 'tarball'

default['logstash']['instance_default']['xms'] = '1G'
default['logstash']['instance_default']['xmx'] = '1G'
default['logstash']['instance_default']['init_method'] = 'native'

default['intel_hadoop_metrics']['metrics_dir'] = '/var/log/intel-hadoop-metrics/'
default['intel_hadoop_metrics']['compress'] = true
default['intel_hadoop_metrics']['scripts'] = %w(cpustat iostat jvms memstat mpstat netstat perf vmstat)

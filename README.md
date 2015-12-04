intel_hadoop_metrics
=======

## DESCRIPTION:

This cookbook sets up the necessary scripts and configures a logstash forwarder instance to collect metrics to be used by intel. 

NOTE: this cookbook must be ran twice to ensure the logstash agent is stopped

## Requirements

Chef 11+

### Platform

*  Redhat 6.x

## Usage

Apply `recipe[intel_hadoop_metrics::default]` to run_list 


## Attributes

|Key|Type|Description|Default|
|---|----|-----------|-------|
| `default['intel_hadoop_metrics']['metrics_dir']` | String | Directory to put metrics into | `/var/log/intel-hadoop-metrics/` |
| `default['intel_hadoop_metrics']['compress']` | Boolean | if metrics should be compressed in gzip format when writing to disk | `true` |
| `default['intel_hadoop_metrics']['scripts']` | Array | What metric scripts to run. The defaults are landed by this cookbook | `%w(cpustat iostat jvms memstat mpstat netstat perf vmstat)` |


## Testing

Install chefdk, vagrant and virtualbox

```
bundle install
bundlle exec rspec
kitchen test
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

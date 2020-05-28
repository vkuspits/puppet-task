class { 'prometheus::server':
  version        => '2.4.3',
  },
  scrape_configs => [
    {
      'job_name'        => 'prometheus',
      'scrape_interval' => '30s',
      'scrape_timeout'  => '30s',
      'static_configs'  => [
        {
          'targets' => [ 'localhost:9090' ],
          'labels'  => {
            'alias' => 'Prometheus',
          }
        }
      ],
    },
  ],
}
class { 'prometheus::node_exporter':
  version            => '0.12.0',
  collectors_disable => ['loadavg', 'mdadm'],
}

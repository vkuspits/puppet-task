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
    {
      'job_name'        => 'node-exporter',
      'scrape_interval' => '30s',
      'scrape_timeout'  => '30s',
      'static_configs'  => [
        {
          'targets' => ['localhost:9100'],
          'labels'  => {'alias' => 'Node'}
        }
      ],
    },
    {
      'job_name'        => 'openstack-exporter',
      'scrape_interval' => '30s',
      'scrape_timeout'  => '30s',
      'openstack_sd_configs'  => [
        {
          'region'             => ['Default'],
          'identity_endpoint'  => ['localhost:5000/v3'],
          'username'           => ['admin'],
          'domain_name'        => ['admin'],
          'password'           => ['admin123'],
          'role'               => ['instance'],
        }
      ],
    },
  ],
}
class { 'prometheus::node_exporter':
  version            => '0.12.0',
  collectors_disable => ['loadavg', 'mdadm'],
}

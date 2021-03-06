require_relative '../resource'

module Convection
  module Model
    class Template
      class Resource
        ##
        # AWS::ElastiCache::ReplicationGroup
        ##
        class ElastiCacheReplicationGroup < Resource
          include Mixin::Taggable

          type 'AWS::ElastiCache::ReplicationGroup', :elasticache_replication_group
          property :auto_failover_enabled, 'AutomaticFailoverEnabled'
          property :auto_minor_version_upgrade, 'AutoMinorVersionUpgrade'
          property :cache_node_type, 'CacheNodeType'
          property :cache_parameter_group_name, 'CacheParameterGroupName'
          property :cache_security_group_names, 'CacheSecurityGroupNames', :type => :list
          property :cache_subnet_group_name, 'CacheSubnetGroupName'
          property :engine, 'Engine'
          property :engine_version, 'EngineVersion'
          property :notification_topic_arn, 'NotificationTopicArn'
          property :num_cache_clusters, 'NumCacheClusters'
          property :port, 'Port'
          property :preferred_cache_cluster_azs, 'PreferredCacheClusterAZs', :type => :list
          property :preferred_maintenance_window, 'PreferredMaintenanceWindow'
          property :replication_group_description, 'ReplicationGroupDescription'
          property :security_group_ids, 'SecurityGroupIds', :type => :list
          property :snapshot_arns, 'SnapshotArns', :type => :list
          property :snapshot_retention_limit, 'SnapshotRetentionLimit'
          property :snapshot_window, 'SnapshotWindow'

          def render(*args)
            super.tap do |resource|
              render_tags(resource)
            end
          end
        end
      end
    end
  end
end

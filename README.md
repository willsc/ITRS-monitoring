version https://git-lfs.github.com/spec/v1
oid sha256:525d28cb5fde879bca0dc9d50d6bd984b781a594d86ee4eff7950eda4db73cab
size 17



```
<?xml version="1.0" encoding="ISO-8859-1"?>
<!--Edited using Gateway Setup Editor version GA5.1.1-200416 at 2020-07-24 14:18:13 by cdavies on itrslp140-->
<gateway compatibility="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://schema.itrsgroup.com/GA5.2.2-200702/gateway.xsd">
	<types>
		<type name="Default Samplers">
			<sampler ref="CPU"/>
			<sampler ref="network"/>
			<sampler ref="hardware"/>
		</type>
	</types>
	<samplers>
		<samplerGroup name="Default Samplers">
			<sampler name="CPU">
				<plugin>
					<cpu/>
				</plugin>
			</sampler>
			<sampler name="network">
				<plugin>
					<network/>
				</plugin>
			</sampler>
			<sampler name="hardware">
				<plugin>
					<hardware/>
				</plugin>
			</sampler>
		</samplerGroup>
	</samplers>
	<rules>
		<ruleGroup name="General">
			<rule name="Sampling Status">
				<targets>
					<target>/geneos/gateway/directory/probe/managedEntity/sampler/dataview/headlines/cell[(@name=&quot;samplingStatus&quot;)]</target>
				</targets>
				<priority>1</priority>
				<block>
					<if>
						<like>
							<dataItem>
								<property>@value</property>
							</dataItem>
							<string>OK</string>
						</like>
						<transaction>
							<update>
								<property>state/@severity</property>
								<severity>ok</severity>
							</update>
						</transaction>
						<transaction>
							<update>
								<property>state/@severity</property>
								<severity>warning</severity>
							</update>
						</transaction>
					</if>
				</block>
			</rule>
		</ruleGroup>
		<ruleGroup name="Self Monitoring">
			<rule name="Licence Duration">
				<targets>
					<target>/geneos/gateway/directory/probe/managedEntity/sampler[(@name=&quot;self&quot;)][(@type=&quot;&quot;)]/dataview[(@name=&quot;self&quot;
)]/rows/row[(@name=&quot;licenseDaysRemaining&quot;)]/cell[(@column=&quot;value&quot;)]</target>
				</targets>
				<priority>1</priority>
				<block>
					<if>
						<lt>
							<dataItem>
								<property>@value</property>
							</dataItem>
							<integer>3</integer>
						</lt>
						<transaction>
							<update>
								<property>state/@severity</property>
								<severity>critical</severity>
							</update>
						</transaction>
						<if>
							<lt>
								<dataItem>
									<property>@value</property>
								</dataItem>
								<integer>7</integer>
							</lt>
							<transaction>
								<update>
									<property>state/@severity</property>
									<severity>warning</severity>
								</update>
							</transaction>
							<transaction>
								<update>
									<property>state/@severity</property>
									<severity>ok</severity>
								</update>
							</transaction>
						</if>
					</if>
				</block>
			</rule>
		</ruleGroup>
	</rules>
	<authentication>
		<authenticateUsers>false</authenticateUsers>
		<roles>
			<role name="Administrators">
				<description>Super User Role (Full Permissions)</description>
			</role>
		</roles>
	</authentication>
	<selfAnnouncingProbes>
		<enabled>true</enabled>
	</selfAnnouncingProbes>
	<operatingEnvironment>
		<listenPorts>
			<insecure>
				<listenPort>7039</listenPort>
			</insecure>
		</listenPorts>
		<dataDirectory>/gateway/persist/data</dataDirectory>
		<insecurePasswordLevel>critical</insecurePasswordLevel>
	</operatingEnvironment>
</gateway>



```
Notes:
```
Gateway:
docker run -d --rm --name itrs_gw -v $(pwd)/setup:/gateway/persist/setup -p 7038:7038 docker.itrsgroup.com/gateway:6.0.0

Running Dedockify 

alias dedockify="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm mrhavens/dedockify"

Netprobes:

docker run -d --rm --name itrs_np -v $(pwd)/netprobe.gci:/netprobe/netprobe.gci -v $(pwd)/setup.xml:/netprobe/setup.xml -p 7036:7036 docker.itrsgroup.com/netprobe:6.0.


<?xml version="1.0" encoding="ISO-8859-1"?>
<!--Edited using Gateway Setup Editor version GA5.1.1-200416 at 2020-07-24 14:18:13 by cdavies on itrslp140-->
<gateway compatibility="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://schema.itrsgroup.com/GA5.2.2-200702/gateway.xsd">
	<types>
		<type name="Default Samplers">
			<sampler ref="CPU"/>
			<sampler ref="network"/>
			<sampler ref="hardware"/>
		</type>
	</types>
	<samplers>
		<samplerGroup name="Default Samplers">
			<sampler name="CPU">
				<plugin>
					<cpu/>
				</plugin>
			</sampler>
			<sampler name="network">
				<plugin>
					<network/>
				</plugin>
			</sampler>
			<sampler name="hardware">
				<plugin>
					<hardware/>
				</plugin>
			</sampler>
		</samplerGroup>
	</samplers>
	<rules>
		<ruleGroup name="General">
			<rule name="Sampling Status">
				<targets>
					<target>/geneos/gateway/directory/probe/managedEntity/sampler/dataview/headlines/cell[(@name=&quot;samplingStatus&quot;)]</target>
				</targets>
				<priority>1</priority>
				<block>
					<if>
						<like>
							<dataItem>
								<property>@value</property>
							</dataItem>
							<string>OK</string>
						</like>
						<transaction>
							<update>
								<property>state/@severity</property>
								<severity>ok</severity>
							</update>
						</transaction>
						<transaction>
							<update>
								<property>state/@severity</property>
								<severity>warning</severity>
							</update>
						</transaction>
					</if>
				</block>
			</rule>
		</ruleGroup>
		<ruleGroup name="Self Monitoring">
			<rule name="Licence Duration">
				<targets>
					<target>/geneos/gateway/directory/probe/managedEntity/sampler[(@name=&quot;self&quot;)][(@type=&quot;&quot;)]/dataview[(@name=&quot;self&quot;
)]/rows/row[(@name=&quot;licenseDaysRemaining&quot;)]/cell[(@column=&quot;value&quot;)]</target>
				</targets>
				<priority>1</priority>
				<block>
					<if>
						<lt>
							<dataItem>
								<property>@value</property>
							</dataItem>
							<integer>3</integer>
						</lt>
						<transaction>
							<update>
								<property>state/@severity</property>
								<severity>critical</severity>
							</update>
						</transaction>
						<if>
							<lt>
								<dataItem>
									<property>@value</property>
								</dataItem>
								<integer>7</integer>
							</lt>
							<transaction>
								<update>
									<property>state/@severity</property>
									<severity>warning</severity>
								</update>
							</transaction>
							<transaction>
								<update>
									<property>state/@severity</property>
									<severity>ok</severity>
								</update>
							</transaction>
						</if>
					</if>
				</block>
			</rule>
		</ruleGroup>
	</rules>
	<authentication>
		<authenticateUsers>false</authenticateUsers>
		<roles>
			<role name="Administrators">
				<description>Super User Role (Full Permissions)</description>
			</role>
		</roles>
	</authentication>
	<selfAnnouncingProbes>
		<enabled>true</enabled>
	</selfAnnouncingProbes>
	<operatingEnvironment>
		<listenPorts>
			<insecure>
				<listenPort>7039</listenPort>
			</insecure>
		</listenPorts>
		<dataDirectory>/gateway/persist/data</dataDirectory>
		<insecurePasswordLevel>critical</insecurePasswordLevel>
	</operatingEnvironment>
</gateway>




Prometheus:

Regex for all metric : {__name__=~".+"}
Just node :                  {__name__=~"node.+"}


Java settings:

export JAVA_HOME=/usr/lib/jvm/java-1.17.0-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-1.17.0-openjdk-amd64/jre
export PATH=/usr/lib/jvm/java-1.17.0-openjdk-amd64/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/root/.fzf/bin
export CA_PLUGIN_DIR=/usr/local/geneos/netprobe/collection_agent/plugins

Daemon startup:

root@Helsing:/usr/local/geneos/netprobe/collection_agent# java -jar collection-agent-3.4.0-exec.jar collection-agent.yml
2023-08-26 22:27:11.801 [main] INFO  com.itrsgroup.collection.ca.CollectionAgent - Java version: 17.0.8
2023-08-26 22:27:11.812 [main] INFO  com.itrsgroup.collection.ca.CollectionAgent - JVM arguments: []
2023-08-26 22:27:11.814 [main] INFO  com.itrsgroup.collection.ca.CollectionAgent - JVM heap: current=504MB max=7912MB
2023-08-26 22:27:11.814 [main] INFO  com.itrsgroup.collection.ca.CollectionAgent - Username: root
2023-08-26 22:27:11.814 [main] INFO  com.itrsgroup.collection.ca.CollectionAgent - Launched from jar /usr/local/geneos/netprobe/collection_agent/collection-agent-3.4.0-exec.jar
2023-08-26 22:27:11.817 [main] INFO  com.itrsgroup.collection.ca.CollectionAgent - Application version 3.4.0 revision 5f5e2cda@2023-05-24T16:19:03.985Z
2023-08-26 22:27:11.874 [main] INFO  com.itrsgroup.platform.daemon.config.ConfigLoader - Loading config file /usr/local/geneos/netprobe/collection_agent/collection-agent.yml
2023-08-26 22:27:11.917 [main] WARN  com.itrsgroup.collection.ca.config.AgentYamlConfigConstructor - Environment variable 'HEALTH_CHECK_PORT' is referenced in the configuration but its value is empty
2023-08-26 22:27:12.249 [main] WARN  com.itrsgroup.collection.ca.config.AgentYamlConfigConstructor - Environment variable 'TCP_REPORTER_PORT' is referenced in the configuration but its value is empty
2023-08-26 22:27:12.354 [main] INFO  com.itrsgroup.collection.ca.config.AgentYamlConfigConstructor - Loaded plugin [statsd-plugin] version 3.0.0 revision 600972e2@2022-05-31T15:51:07.963Z from /usr/local/geneos/netprobe/collection_agent/plugins/statsd-plugin-3.0.0.jar
2023-08-26 22:27:12.354 [main] INFO  com.itrsgroup.collection.ca.config.AgentYamlConfigConstructor - Loaded class com.itrsgroup.collection.plugins.statsd.StatsdServerConfig from plugin [statsd-plugin]
2023-08-26 22:27:12.358 [main] INFO  com.itrsgroup.collection.ca.config.AgentYamlConfigConstructor - Loaded plugin [prometheus-plugin] version 3.1.1 revision 51720738@2023-01-27T00:52:27.595Z from /usr/local/geneos/netprobe/collection_agent/plugins/prometheus-plugin-3.1.1.jar
2023-08-26 22:27:12.358 [main] INFO  com.itrsgroup.collection.ca.config.AgentYamlConfigConstructor - Loaded class com.itrsgroup.collection.plugins.prom.PrometheusRemoteWriteCollectorConfig from plugin [prometheus-plugin]
2023-08-26 22:27:12.474 [main] INFO  com.itrsgroup.collection.ca.workflow.pipelines.WorkflowPipeline(metrics) - Using in-memory store with capacity 8192



Collection Agent yaml:
root@Helsing:/usr/local/geneos/netprobe/collection_agent# more collection-agent.yml
plugin-directory: ${env:CA_PLUGIN_DIR}

monitoring:
  reporting-interval: 10000
  health-probe:
    enabled: true
    listen-port: ${env:HEALTH_CHECK_PORT}
  self-metrics:
    enabled: false
    dimensions:
      app: collection-agent
reporters:
  - type: tcp
    name: tcp
    hostname: localhost
    port: ${env:TCP_REPORTER_PORT}
collectors:
  - name: statsd
    type: plugin
    class-name: StatsdServer
  - name: prometheus
    type: plugin
    class-name: PrometheusRemoteWriteCollector
    port: 7654

#  PrometheusRemoteWriteCollector plugin


# Azure Monitor collector
#  - name: azure
#    type: plugin
#    class-name: AzureMonitorCollector
#
# Interval (in millis) between publications (optional, defaults to five minutes)
#    collection-interval: 300000
#
# The Azure client id that can be used for this application (required)
#    client-id: <CLIENT_ID>
#
# The Azure secret associated with the client id (required)
#    client-secret: <CLIENT_SECRET>
#
# The Azure tenant id to be monitored (required)
#    tenant-id: <TENANT_ID>
#
# The Azure subscription id to be used for monitoring (required)
#    subscription-id: <SUBSCRIPTION_ID>
#
# Filter resources by resource group name according to the provided Java regex
#    resource-group-filter: (UAT-group)|(PROD-group)
#
# Specify a list of key or value pairs which correspond to Azure resource tags and values.
#    tag-filter:
#      Dev: (Name 1)|(Name 2)
#      Owner: .*
#
# Specify a list of tags which will be published as a datapoint property
#    published-tags:
#      - Environment
#      - Purpose
#
# Lists the resource type(s) that will be monitored (optional, defaults to listing all available resource types)
#    enabled-resources:
#      - microsoft.compute/disks
#      - Microsoft.Network/azurefirewalls

# Azure Event Hub collector
#  - name: eventhub
#    type: plugin
#    class-name: AzureEventHubCollector
#
# The connection string of the Azure Event Hub namespace to be used by the application (required)
#    connection-string: <CONNECTION_STRING>
#
# The instance name of the Azure Event Hub namespace to be used by the application (required)
#    event-hub: <EVENT_HUB_NAME>
#
# The consumer group name of the Azure Event Hub instance to be used by the application (required)
#    consumer-group-name: <CONSUMER_GROUP_NAME>

#  PrometheusRemoteWriteCollector plugin
#   - type: plugin
#     class-name: PrometheusRemoteWriteCollector
#     name: prometheus
#     port: 7654

# AlertManagerWebhookCollector plugin
# - type: plugin
#   class-name: AlertManagerWebhookCollector
#   name: alertmanager
#   port: 5001
#   firing-severities:
#     firing: ERROR
#     resolved: INFO

# AWS Collector
# - name: aws-collector
#   type: plugin
#   class-name: AwsCollector
#
# Interval (in millis) between collections (optional, defaults to five minutes).
#   collection-interval: 300000
#
# AWS regions from which metrics will be collected
#   regions:
#    - ap-southeast-1
#    - ap-southeast-2
#
# List of services to collect metrics from (optional, case-sensitive, and defaults to all metrics)
#   enabled-services:
#    - AWS/EC2
#    - AWS/EBS
#    - AWS/EKS
#    - AWS/RDS
#    - AWS/ECS

# Aws Custom Namespace Collector
#  - name: awscustom
#    type: plugin
#    class-name: AwsCustomNamespaceCollector
#
# Interval (in millis) between collections (optional, defaults to five minutes).
#    collection-interval: 300000
#
# AWS regions from which metrics will be collected
#   regions:
#    - ap-southeast-1
#    - ap-southeast-2
#
# List of custom namespaces to collect metrics from
#   custom-monitored-namespaces:
#      - namespace: ECS/ContainerInsights
# List of metrics to collect from the custom namespace (optional, defaults to collect all available metrics if not specified)
#        custom-monitored-metrics:
# Regex pattern to match the metrics to collect from the namespace
#          - name-includes: Network*
# Length of time used to aggregate the metric (optional, defaults to 300 seconds)
#            period: 300
# Aggregation to be used (optional, defaults to "average")
#            statistic: average

# AWS Billing Collector
# - name: aws-billing
#   type: plugin
#   class-name: AwsBillingCollector
#
# Interval (in millis) between collections (optional, defaults to 6 hours).
#   collection-interval: 21600000

# AWS API Destination collector
# - name: apidestination
#   type: plugin
#   class-name: ApiDestinationCollector
#
# AWS region from which alarm notifications are expected
#   sns-region: ap-southeast-1
#
# Port on which to receive API destination events
#   port: 9000
#
# Acceptor thread pool size (optional, defaults to 2)
#   acceptor-thread-pool-size: 2
#
# Worker thread pool size (optional, defaults to 4)
#   worker-thread-pool-size: 4
#
# TLS configuration (TLS is required by AWS API Destination to be a valid endpoint)
#   tls-config:
#     cert-file: ${env:CERT_FILE}
#     key-file: ${env:KEY_FILE}
#     trust-chain-file: ${env:TRUST_CHAIN_FILE}
#
# Authentication type (at the moment, only basic authentication for EventBridge is supported)
#   authentication:
#
# The basic authentication credentials here should match the ones set in EventBridge
#    basic-authentication:
#      username: ${env:BASIC_AUTH_USERNAME}
#      password: ${env:BASIC_AUTH_PASSWORD}

workflow:
  store-directory: .
  attributes:
    reporter: tcp
  metrics:
    reporter: tcp
  events:
    reporter: tcp
  logs:
    reporter: tcp
  traces:
    enabled: false
```

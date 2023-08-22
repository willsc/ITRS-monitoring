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

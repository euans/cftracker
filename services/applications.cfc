<cfcomponent output="false">
	<cffunction name="init" output="false">
		<cfscript>
			var lc = {};
			lc.cfcPath = 'cftracker.';
			if (application.settings.demo) {
				lc.cfcPath &= 'demo.';
			}
			variables.appTracker = CreateObject('component', lc.cfcPath & 'applications').init(application.settings.security.password);
			variables.sessTracker = CreateObject('component', lc.cfcPath & 'sessions').init(application.settings.security.password);
		</cfscript>
	</cffunction>

	<cffunction name="default" output="false">
		<cfscript>
			var lc = {};
			lc.apps = {};
			lc.apps = variables.appTracker.getAppsInfo();
			return lc.apps;
		</cfscript> 
	</cffunction>
	
	<cffunction name="getInfo" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="wc" type="string" required="true" />
		<cfscript>
			if (application.settings.demo) {
				return application.data.apps[arguments.name].metaData;
			} else {
				return variables.appTracker.getInfo(arguments.name, arguments.wc);
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="getApps" output="false">
		<cfscript>
			if (application.settings.demo) {
				return StructKeyArray(application.data.apps);
			} else {
				return variables.appTracker.getApps();
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="getScope" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="wc" type="string" required="true" />
		<cfscript>
			return variables.appTracker.getScope(arguments.name, arguments.wc);
		</cfscript>
	</cffunction>

	<cffunction name="getSettings" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfscript>
			return variables.appTracker.getSettings(arguments.name);
		</cfscript>
	</cffunction>

	<cffunction name="stopsessions" output="false">
		<cfargument name="apps" />
		<cfset var lc = {} />
		<cfif Not application.settings.demo>
			<cfloop array="#arguments.apps#" index="lc.a">
				<cfset lc.wc = ListFirst(lc.a, Chr(9)) />
				<cfset lc.app = ListDeleteAt(lc.a, 1, Chr(9)) />
				<cfset variables.sessTracker.stopByApp(lc.app, lc.wc) />
			</cfloop>
		</cfif>
	</cffunction>

	<cffunction name="stopboth" output="false">
		<cfargument name="apps" />
		<cfset var lc = {} />
		<cfif Not application.settings.demo>
			<cfloop array="#arguments.apps#" index="lc.a">
				<cfset lc.wc = ListFirst(lc.a, Chr(9)) />
				<cfset lc.app = ListDeleteAt(lc.a, 1, Chr(9)) />
				<cfset variables.appTracker.stop(lc.app, lc.wc) />
				<cfset variables.sessTracker.stopByApp(lc.app, lc.wc) />
			</cfloop>
		</cfif>
	</cffunction>
	
	<cffunction name="stop" output="false">
		<cfargument name="apps" />
		<cfset var lc = {} />
		<cfif Not application.settings.demo>
			<cfloop array="#arguments.apps#" index="lc.a">
				<cfset lc.wc = ListFirst(lc.a, Chr(9)) />
				<cfset lc.app = ListDeleteAt(lc.a, 1, Chr(9)) />
				<cfset variables.appTracker.stop(lc.app, lc.wc) />
			</cfloop>
		</cfif>
	</cffunction>

	<cffunction name="restart" output="false">
		<cfargument name="apps" />
		<cfset var lc = {} />
		<cfif Not application.settings.demo>
			<cfloop array="#arguments.apps#" index="lc.a">
				<cfset lc.wc = ListFirst(lc.a, Chr(9)) />
				<cfset lc.app = ListDeleteAt(lc.a, 1, Chr(9)) />
				<cfset variables.appTracker.restart(lc.app, lc.wc) />
			</cfloop>
		</cfif>
	</cffunction>

	<cffunction name="refresh" output="false">
		<cfargument name="apps" />
		<cfset var lc = {} />
		<cfif Not application.settings.demo>
			<cfloop array="#arguments.apps#" index="lc.a">
				<cfset lc.wc = ListFirst(lc.a, Chr(9)) />
				<cfset lc.app = ListDeleteAt(lc.a, 1, Chr(9)) />
				<cfset variables.appTracker.touch(lc.app, lc.wc) />
			</cfloop>
		</cfif>
	</cffunction>

</cfcomponent>
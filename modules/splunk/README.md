## Splunk Enterprise and HashiCorp Demo

This repository will deploy a Splunk Enterprise instance into AWS and pre-configure some indexes and dashboards to collect logging and telemetry from HashiCorp Vault, HCP Vault and Terraform Cloud for Business.

### Get Started
1. Clone the repo to your own github account
1. Connect the repo to a new TFC worksapce using the VCS workflow
1. Ensure that the essential variables are configured:
    1. AWS Credentials
    1. Prefix, Email, ttl and name
    1. splunk_domain 
1. Create an initial plan via the TFC UI
1. If all the above is done correctly, you'll have a working splunk environment at the output of the `splunk_url` 

### Adding the HashiCorp Splunk Dashboards
1. There are three main integration points for Splunk Dashboards:
    1. HCP Only
    1. On-Premises Vault
    1. Terraform Cloud
1. For a HashiCorp SE - the easist method is to collect the zipped files and deploy them directly to splunk. You'll need to collect these from a colleague and they should not be shared. 


#### Configure the TFC Dashboard
1. Login to the splunk dashboard
1. In the left-hand-side navigation, click the cog next to `Apps`
1. Click `Install App From File` and upload the zipped file
1. Restart Splunk as part of the process
1. Navigate to Terraform Cloud for Splunk App
1. Continue to app setup page
1. Create a TFC Organization Token and apply it into the setup
1. Start using the dashboards, etc


#### Configure the HCP Vault Dashboard
1. Login to the splunk dashboard
1. In the left-hand-side navigation, click the cog next to `Apps`
1. Click `Install App From File` and upload the zipped file
1. Restart Splunk as part of the process
1. Within the Splunk UI ensure that the collector token is enabled: 
    1. Settings -> Data Inputs -> HTTP Event Collector -> Global Settings -> All Tokens = Enabled
    1. Collect the Token Value for the `HCP_Vault_Events`
1. Open HCP Dashboard and navigate to your Vault cluster and then Metrics
1. Configure the Splunk app with your HEC and token from above
    1. HEC Might look something like `https://splunk.cameron.aws.hashidemos.io:8088` 
    1. Note: there is no need to use the example from the HCP-V tutorial or from Splunk website!

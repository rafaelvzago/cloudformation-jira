# CSS Training Lab Environments #

This repository makes use of CloudFormation templates and Ansible to help deploy and maintain various lab environments for CSS training. Instructions here are targeted towards CSS and the CSS AWS account.

On this page:
[TOC]

### Before you start ###
Ensure you are familiar with the [CSS AWS Bootstrapper and Guide](https://hello.atlassian.net/wiki/spaces/C4L/pages/248795907/CSS+AWS+Bootstrapper+and+Guide)

Ensure you can access AWS and have an existing keypair:
* https://hello.atlassian.net/wiki/spaces/C4L/pages/248816898/Accessing+the+AWS+Dashboard

Create a [PSI ticket](https://hello.atlassian.net/servicedesk/customer/portal/85/group/405/create/3405), which will be used to monitor and track the instance

### How do I get set up? ###
If not already done so, please first create a [PSI ticket](https://hello.atlassian.net/servicedesk/customer/portal/85/group/405/create/3405)
* This will be used for the *Ticket* field during deployment

Deployment is done via CloudFormation templates. This can be done by one of 2 methods:
* Uploading the *css-training-cf_template.yaml* template
* Or use the S3 URL to build the stack. Using the S3 URL will also ensure you are always on the latest version of the template as the URL doesn't change when the version increments.

Complete the multiple fields that are required for deployment.

Click Next, the following screens can be skipped. Click through until you can "Create Stack."

You'll be presented with an "Events" screen where you click refresh and monitor the creation progress.
* The instances will be deployed fairly quickly, but setup will take up to 15 minutes.

Three instances would have been deployed:
* ServiceNode - this will contain all the services used by the products, including the NFS mount, HAProxy, and the PostgreSQL database.
* Node1 - this is a product node that will install and start your selected product
* Node2 - this node is used for Data Center deployments.  If the product type "server" was selected, this node will only have the basic instance requirements installed.


### How do I access the instances? ###
Still on the CloudFormation Events screen, wait until deployment completes. Once complete, click on "Resources".

You'll see the deployed instances. To connect to each one:
* Click on the *Physical-ID*, which will open a new browser tab with your resource.
* Select the resource and choose to *Connect*
* You'll be presented with the instances IP address and an example of how to connect via *ssh*.


### Who do I talk to? ###
* David Chan, Rafael Zago, Jeff Curry
* Slack: #css-training-ansible #css-awshelp
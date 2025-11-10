# Write-up Template

### Analyze, choose, and justify the appropriate resource option for deploying the app.

*For **both** a VM or App Service solution for the CMS app:*
- *Analyze costs, scalability, availability, and workflow*

Cost: VM - Requires paying for full compute instance 24/7 even when idle, higher maintenance cost. 
      App services - Operates on Pay-as-you-go model, only charges for runtime usage. It automatically scales and generally results in lower total cost for a small web app.
Scalability: VM - Requires manual setup of load balancers and autoscaling, more control but complex. 
             App services - Provides built-in autoscaling and deployment slots make it highly scalable with minimal configuration.
Availability: VM - Depends on your setup configuring fault tolerance, backups, and uptime monitoring manually.
              App services - Ensures high availability built-in with Azure-managed infrastructure, redundancy, and monitoring. 
Workflow: VM - Offers full control of OS, dependencies, and network — but requires manual updates and configuration for Python, Flask, and libraries.
          App services - Provides seamless CI/CD integration via GitHub Actions or Azure Portal, no OS-level management required. Perfect for fast deployments.


- *Choose the appropriate solution (VM or App Service) for deploying the app*

I choose Azure App Service for deploying the Flask CMS app.  
It provides the best balance between ease of use, scalability, and cost.  
App Service integrates smoothly with Azure SQL, Azure Blob Storage, and Azure Entra ID, which this project already uses.  
It also supports automatic deployment from GitHub and requires no OS maintenance, making it more efficient than running a VM for a small web app.

- *Justify your choice*

If the application required: Custom server configurations (e.g., special system libraries or background daemons), High-performance processing (e.g., ML workloads or GPU access), greater OS-level control for network routing or container orchestration,

then deploying on a Virtual Machine would make sense.  
For this lightweight CMS app, which doesn’t need such custom configurations, Azure App Service remains the optimal and most cost-effective solution.


### Assess app changes that would change your decision.

*Detail how the app and any other needs would have to change for you to change your decision in the last section.* 

considering Cost,Scalability,Maintenance App Service cheaper for small-scale apps, has built-in autoscaling, its easier to manage
in future VM can be used if more control or processing power is needed.
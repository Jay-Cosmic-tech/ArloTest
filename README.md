# ArloTest
Creating this repository for Arlo Platform Job Interview. 

## **Problem 1 - Question 2**

**Q:**How would you ensure that the above setup is configured to be deployed to multiple environments via a pipeline. No need to come up with   
  pipeline related code, just a brief description with a strategy and what needs to be considered, would do.
  
**A:** Terraform, a tool for managing infrastructure, lets us organize configurations into modules. Modules are like building blocks for managing parts of our infrastructure. These modules can be customized for different environments, such as Dev, Non-prod, UAT, and Prod.

To manage settings that vary between environments (like server sizes or database configurations), Terraform uses variable files. These files contain values that change depending on the environment we're working in. This helps ensure our infrastructure remains consistent across different stages of development and deployment.

## **Problem 2**

**Q:** Describe a way to provide access to AWS resources for various engineers in a company doing a variety of operations like support, development, testing etc.
  How can you expand upon this to accommodate new needs within the company?
   
**A:** In organizations, whether they're big or small, managing who can do what with their systems and data is really important. I use a method called "RBAC" (Role-Based Access Control) to handle this.

  Here's how it works: Instead of giving each person individual permissions, I group people into roles based on their job responsibilities. For example, developers might have    
  permissions to create and manage things like virtual servers (EC2 instances) and storage (S3 buckets), while testers might only have permission to look at things without making         changes.

  Now, there are always exceptions to rules. If a developer needs extra permissions for a specific task, like more administrative control over a system, I can give them that 
  temporarily by adding a special policy to their access.

  This approach works well for both small and large organizations. It helps with keeping track of who has access to what, makes it easier to follow rules for checking and managing 
  access, and ensures everything meets the standards for how systems and data should be used and protected.

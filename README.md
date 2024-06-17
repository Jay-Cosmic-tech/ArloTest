# ArloTest
Creating this repository for Arlo Platform Job Interview. 

Q: How would you ensure that the above setup is configured to be deployed to multiple environments via a pipeline. No need to come up with   
   pipeline related code, just a brief description with a strategy and what needs to be considered, would do.
A:Varible Files: We can use varible files to define environment-specific Values.
  Terraform allows us to organize its configurations into modules, which are like building   blocks for managing different parts of our infrastructure. These modules can be     
  customized based on different environments like Dev, Non-prod,UAT , and Prod.

  To handle settings specific to each environment (like different server sizes or database   configurations), Terraform lets us use variable files. These files contain values that   
  change depending on the environment we're working with. This helps keep our 
  infrastructure consistent across different stages of development and deployment.

# Terraform Infra launch using the modules 

## Step 1 
create a directory, in my case , the main directory named as terraform and create a main.tf file , in which we are going to create every resourse using the refrence of the modules that we will create in different files 

## Step 2
Create a folder named as modules and then create seperate folders for the resources in the working directory 

in each file , we can mention the variables or we can create the variable.tf file in each single resource directory 

Here, we created 

- one directory named as EC2 and created the ec2 module and variable in the same file to create the EC2 from the resourse 

- Second for the ELB and created the elb.tf file in that directory for the load balancer creation 

- Third directory named as pubsub, in this, we are creating the two subnets in different availability zone to attach the load balancer in it ,internet gateway , Route table, route table assosiation 

all the file structure we can see in the tree structure in the image attached below, we can create the variable file seperately for the variables or we can mention in the same tf file as well 

![image](https://user-images.githubusercontent.com/67600604/190068823-f283f89b-ad26-4735-87d0-46ba7e2588df.png)


Note - for the provider in terrafor, take the aws access and secret key and paste into the credentials file in the system 

![image](https://user-images.githubusercontent.com/67600604/190069709-71594566-cae9-4b46-812e-7a7e1baacd71.png)




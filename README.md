# Terraform Infra Launch Using the Modules 

```main.tf``` file , we have all the modules reference to be created from the resources , that are in the diffrenet folders , according to the resource formation

In ```main.tf``` file , we have the modules , in which , we have -  

- one directory named as EC2 and created the ec2 module and variable in the same file to create the EC2 from the resourse 

- Second for the ELB and created the elb.tf file in that directory for the load balancer creation 

- Third directory named as pubsub, in this, we are creating the two subnets in different availability zone to attach the load balancer in it ,internet gateway , Route table, route table assosiation 

- EC2 

![image](https://user-images.githubusercontent.com/67600604/190131968-194d8df0-89f2-4b12-9778-4338a1246b74.png)
 
It will create the ec2 resource using the source file ec2.tf (in the module folder), instance_type, image, key_pair, and subnet_id we have to mention in the module itself

### ec2.tf

![image](https://user-images.githubusercontent.com/67600604/190144360-1100349b-12ec-43b3-964b-f37a95915454.png)


- VPC

![image](https://user-images.githubusercontent.com/67600604/190132477-b23a164c-b9fe-457d-a8c6-8f34bd5d6be3.png)

This module VPC is taking the resource refrence from the source , VPC and cidr_block is the required field in the VPC module 

### vpc.tf

![image](https://user-images.githubusercontent.com/67600604/190144600-f11ffb2b-28fa-4980-9c0e-ebac32418951.png)

- Public Subnet

![image](https://user-images.githubusercontent.com/67600604/190133612-a1cb5128-7943-4f79-9b67-3c59206cd13a.png)

here , it is taking reference from the pubsub folder files for the creation of the two diffrent subnet in diffrenet availability zones 

### pubsub.tf 

![image](https://user-images.githubusercontent.com/67600604/190145078-04ce8856-2bc2-48fc-82b9-69cc41a0eb86.png)

here, we are using the count function for creating the 2 different subnet. (count is to access the index in the list , as we have taken the variable for the elb az in "list" format)

- output function in terraform 

![image](https://user-images.githubusercontent.com/67600604/190146232-245ef47d-18de-4463-ba9e-4571df8e77f0.png)

we have taken two output in the pub-sub block for the creation of 2 subnets, and can use this output in the main.tf file for the input 

- ELB 

![image](https://user-images.githubusercontent.com/67600604/190143706-44f9894a-fdef-4074-a0c0-7a1a20cfd8b4.png)

For the ELB , we have to create the Subnets in 2 diffrent AZs, so here, we are creating the ELB , taking reference from the ELB folder 

### elb.tf

![image](https://user-images.githubusercontent.com/67600604/190145244-700b4135-9be8-49fb-b31f-74ad0bb929f1.png)

creating target groups in it

- All the file structure we can see in the tree structure in the image attached below, we can create the variable file seperately for the variables or we can mention in the same tf file as well 

![image](https://user-images.githubusercontent.com/67600604/190068823-f283f89b-ad26-4735-87d0-46ba7e2588df.png)


```Note``` For the provider in terraform file , we have to create the secret and access key from the aws console and have to add the keys in the given directory as shown in the Image given below 

![image](https://user-images.githubusercontent.com/67600604/190069709-71594566-cae9-4b46-812e-7a7e1baacd71.png)

And then, give the provider as shown in the below image in the ```main.tf``` file 

![image](https://user-images.githubusercontent.com/67600604/190129724-80065a8b-5d9e-48ab-a078-ac0d2ff060cb.png)

### Terraform state lock file 

![image](https://user-images.githubusercontent.com/67600604/190143987-6c9580d2-89e9-4237-b6f0-ec57f03451e3.png)

- Why do we need State locking and what is it ?

If the state file is stored remotely so that many people can access it, then you risk multiple people attempting to make changes to the same file at the exact same time. So we need to provide a mechanism that will “lock” the state if its currently in-use by another user. We can accomplish this by creating a dynamoDB table for terraform to use.

- create the s3 backend resource - 

![image](https://user-images.githubusercontent.com/67600604/190147578-3ed6da8a-33df-4ecd-a940-75d4ff3472c7.png)

then create a backend association like this - 

![image](https://user-images.githubusercontent.com/67600604/190147834-c1f23a69-fad0-4dcc-a4b1-ac4fcfb6c85a.png)

- Create the dynamoDB table and modified the Terraform S3 backend resource and add in the dynamoDB table - 

![image](https://user-images.githubusercontent.com/67600604/190148169-7277e6d3-f7c7-4fd8-8ce7-63525aa1319b.png)

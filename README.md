# Solution1
Reqiurements:
- VPC with 3 subnets. One public (SUB_DMZ_0), two private (SUB_PRIV_0, SUB_PRIV_1)
- One VM per subnet.
- Internet access only from SUB_DMZ_0 and SUB_PRIV_0
- Access to VM's in private subnets only from Jump Host
- SSH only access to Jump Host and VM's in private subnets. 
- Acces to Jump Host restricted to specified ip's.

Solution:
Infrastructure is buid with self-written reused terraform modules code. Additional template module creates ansible hosts file populated with vm's ip. 
Resources - 1xVPC, 1xPublic subnet, 2xPrivate subnets, 2xNACL(Front, Back), 3xSecurity groups, 3xEC2 instances(JumpHost,VM_DEV0,VM_DEV1), 3xRT, 3xRT assocciations,
            IGW,NAT+EIP, local_file(ansible inventory-hosts).
 
 ![Solution1](https://user-images.githubusercontent.com/81967558/120902727-499b7c80-c642-11eb-8cf3-9ed476f10985.jpeg)

 
- Jump Host RT points IGW
- Jump Host can be accessed with ssh. Open ports 22,ICMP,80 (intentionally, blocked with acl rule)
- Access from Jump_Host to VM_DEV0 and VM_DEV1 with ssh. Open ports 22,ICMP.
- VM_DEV0 instance can access web via NAT.
- VM_DEV1 router can connect with Jump Host and VM_DEV0
- Set of NACL rules as additional security layer. 

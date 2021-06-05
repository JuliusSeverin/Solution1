# Solution1
Reqiurements:
- VPC with 3 subnets. One public (SUB_DMZ_0), two private (SUB_PRIV_0, SUB_PRIV_1)
- One VM per subnet.
- Internet access only from SUB_DMZ_0 and SUB_PRIV_0
- Access to VM's in private subnets only via Jump Host
- SSH only access to Jump Host and VM's in private subnets. 
- Acces to Jump Host restricted to specified ip's.

Solution:


#!/bin/bash

COMMAND=$1
shift

case $COMMAND in
"aws-ssh-instance")
	exec aws ssm start-session --target "$(aws autoscaling describe-auto-scaling-instances --output text --query 'AutoScalingInstances[*].[InstanceId,AutoScalingGroupName]' | peco --select-1 | cut -f1)"
	;;

"terraform-show-state")
	exec terraform state show "$(terraform state list | peco --select-1)"
	;;
*)
	cat <<EOS
USAGE:
  ox [sub-command]

SUB COMMANDS:
  aws-ssh-instance        SSH into an AWS EC2 instance selected by peco
  terraform-show-state    Show terraform state selected by peco
EOS
	;;
esac

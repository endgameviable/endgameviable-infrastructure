# Sometimes SNS subscriptions get stuck in a "Pending Confirmation"
# state on the AWS Console, if it sent an email confirmation,
# but it wasn't confirmed before the underlying resource gets deleted.
# This will display them.
# As far as I know there's no way to actually remove them.
aws sns list-subscriptions --output text | grep PendingConfirmation | awk '{print $NF}' | while read -r arn; do
  echo "still a pending confirmation for subscription $arn"
done

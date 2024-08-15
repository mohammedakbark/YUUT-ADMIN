enum OrderStatus { pending, cancelled, completed,

 processed 
 }

checkOrderStatus(String status) {
  switch (status) {
    case 'Pending':
      {
        return OrderStatus.pending;
      }
    case 'Cancelled':
      {
        return OrderStatus.cancelled;
      }
    case 'Completed':
      {
        return OrderStatus.completed;
      }
    case 'Processed':
      {
        return OrderStatus.processed;
      }
  }
}

String convertOrderStatusToString(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      {
        return 'Pending';
      }
    case OrderStatus.cancelled:
      {
        return 'Cancelled';
      }
    case OrderStatus.completed:
      {
        return 'Completed';
      }
    case OrderStatus.processed:
      {
        return 'Processed';
      }
  }
}


// xs,s,m,l,xl,
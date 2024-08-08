enum OrderStatus { succesful, canceled, completed }

checkOrderStatus(String status) {
  switch (status) {
    case 'Succesful':
      {
        return OrderStatus.succesful;
      }
    case 'Canceled':
      {
        return OrderStatus.canceled;
      }
    case 'Completed':
      {
        return OrderStatus.completed;
      }
  }
}


String orderStatus(OrderStatus status) {
  switch (status) {
    case OrderStatus.succesful:
      {
        return 'Succesful';
      }
    case OrderStatus.canceled:
      {
        return 'Canceled';
      }
    case OrderStatus.completed:
      {
        return 'Completed';
      }
  }
}

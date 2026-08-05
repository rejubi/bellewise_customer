enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  assigned,
  pickedUp,
  delivered,
  cancelled,
  unknown,
}

extension OrderStatusExtension on OrderStatus {
  static OrderStatus fromString(
      String status,
      ) {
    switch (status.toLowerCase()) {
      case "pending":
        return OrderStatus.pending;

      case "confirmed":
        return OrderStatus.confirmed;

      case "preparing":
        return OrderStatus.preparing;

      case "ready":
        return OrderStatus.ready;

      case "assigned":
        return OrderStatus.assigned;

      case "picked_up":
        return OrderStatus.pickedUp;

      case "picked up":
        return OrderStatus.pickedUp;

      case "delivered":
        return OrderStatus.delivered;

      case "cancelled":
        return OrderStatus.cancelled;

      case "canceled":
        return OrderStatus.cancelled;

      default:
        return OrderStatus.unknown;
    }
  }
}

extension OrderStatusHelpers on OrderStatus {
  String get title {
    switch (this) {
      case OrderStatus.pending:
        return "Pending";

      case OrderStatus.confirmed:
        return "Confirmed";

      case OrderStatus.preparing:
        return "Preparing";

      case OrderStatus.ready:
        return "Ready";

      case OrderStatus.assigned:
        return "Rider Assigned";

      case OrderStatus.pickedUp:
        return "Picked Up";

      case OrderStatus.delivered:
        return "Delivered";

      case OrderStatus.cancelled:
        return "Cancelled";

      default:
        return "Unknown";
    }
  }

  bool get canCancel {
    return this == OrderStatus.pending;
  }

  bool get isCompleted {
    return this == OrderStatus.delivered;
  }

  bool get isActive {
    return !isCompleted &&
        this != OrderStatus.cancelled;
  }
}
import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/widgets/error_view.dart';

import '../controllers/notification_controller.dart';
import '../models/notification_model.dart';
import '../widgets/notification_tile.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    super.key,
  });

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  final NotificationController controller =
  NotificationController();

  late Future<List<NotificationModel>> _future;

  List<NotificationModel> _notifications = [];

  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();

    _future = _loadInitialNotifications();
  }

  // ==========================================================
  // INITIAL LOAD
  // ==========================================================

  Future<List<NotificationModel>>
  _loadInitialNotifications() async {
    final result =
    await controller.loadNotifications();

    if (mounted) {
      setState(() {
        _notifications = List<NotificationModel>.from(result);
        _hasLoaded = true;
      });
    }

    return result;
  }

  // ==========================================================
  // REFRESH
  // ==========================================================

  Future<void> _refresh() async {
    try {
      final result =
      await controller.loadNotifications();

      if (!mounted) return;

      setState(() {
        _notifications =
        List<NotificationModel>.from(result);
        _hasLoaded = true;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ErrorHandler.getMessage(e),
          ),
        ),
      );
    }
  }

  // ==========================================================
  // MARK AS READ
  // ==========================================================

  Future<void> _markRead(
      NotificationModel notification,
      ) async {
    if (notification.isRead) {
      return;
    }

    try {
      await controller.markRead(
        notification.id,
      );

      if (!mounted) return;

      // Update the item locally without reloading
      // the entire notification list.
      final index = _notifications.indexWhere(
            (item) => item.id == notification.id,
      );

      if (index == -1) return;

      final updated =
      _notifications[index];

      _notifications[index] =
          NotificationModel(
            id: updated.id,
            title: updated.title,
            message: updated.message,
            type: updated.type,
            isRead: true,
            createdAt: updated.createdAt,
          );

      setState(() {});
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ErrorHandler.getMessage(e),
          ),
        ),
      );
    }
  }

  // ==========================================================
  // DELETE NOTIFICATION
  // ==========================================================

  Future<void> _delete(int id) async {
    // --------------------------------------------------------
    // Remove immediately from the UI.
    // --------------------------------------------------------

    final index = _notifications.indexWhere(
          (item) => item.id == id,
    );

    if (index == -1) {
      return;
    }

    final deletedNotification =
    _notifications[index];

    setState(() {
      _notifications.removeAt(index);
    });

    // --------------------------------------------------------
    // Delete from backend.
    // --------------------------------------------------------

    try {
      await controller.deleteNotification(id);
    } catch (e) {
      // If backend deletion fails, restore the
      // notification so the UI remains consistent.
      if (!mounted) return;

      setState(() {
        final restoreIndex =
        index.clamp(
          0,
          _notifications.length,
        );

        _notifications.insert(
          restoreIndex,
          deletedNotification,
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ErrorHandler.getMessage(e),
          ),
        ),
      );
    }
  }

  // ==========================================================
  // MARK ALL AS READ
  // ==========================================================

  Future<void> _markAllRead() async {
    try {
      await controller.markAllRead();

      if (!mounted) return;

      // Update everything locally instead of
      // triggering another full API reload.
      _notifications = _notifications
          .map(
            (notification) =>
            NotificationModel(
              id: notification.id,
              title: notification.title,
              message: notification.message,
              type: notification.type,
              isRead: true,
              createdAt: notification.createdAt,
            ),
      )
          .toList();

      setState(() {});
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ErrorHandler.getMessage(e),
          ),
        ),
      );
    }
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      AppColors.background,

      appBar: AppBar(
        title: const Text(
          "Notifications",
        ),
        actions: [
          TextButton(
            onPressed:
            _notifications.isEmpty
                ? null
                : _markAllRead,
            child: const Text(
              "Read all",
            ),
          ),
        ],
      ),

      body: !_hasLoaded
          ? FutureBuilder<
          List<NotificationModel>>(
        future: _future,
        builder:
            (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return ErrorView(
              message:
              ErrorHandler.getMessage(
                snapshot.error,
              ),
              onRetry:
              _refresh,
            );
          }

          return const SizedBox.shrink();
        },
      )
          : _notifications.isEmpty
          ? const Center(
        child: Text(
          "No notifications yet.",
        ),
      )
          : RefreshIndicator(
        onRefresh: _refresh,
        color: AppColors.primary,
        child: ListView.builder(
          padding:
          const EdgeInsets.all(16),
          physics:
          const AlwaysScrollableScrollPhysics(),
          itemCount:
          _notifications.length,
          itemBuilder:
              (context, index) {
            final item =
            _notifications[index];

            return NotificationTile(
              notification: item,

              onTap: () {
                _markRead(item);
              },

              onDelete: () {
                _delete(item.id);
              },
            );
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DialogsTab extends StatelessWidget {
  final bool isCupertino;
  const DialogsTab({super.key, required this.isCupertino});

  void _showAlert(BuildContext context) {
    if (!isCupertino) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Material Alert'),
          content: const Text('This is an example of a Material AlertDialog.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Cupertino Alert'),
          content: const Text(
            'This is an example of a Cupertino Alert Dialog.',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _showActionSheet(BuildContext context) {
    if (!isCupertino) {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () => Navigator.pop(ctx),
              ),
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('Copy Link'),
                onTap: () => Navigator.pop(ctx),
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                iconColor: Colors.red,
                textColor: Colors.red,
                onTap: () => Navigator.pop(ctx),
              ),
            ],
          ),
        ),
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (ctx) => CupertinoActionSheet(
          title: const Text('Actions'),
          message: const Text('Select an option below'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Share'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Copy Link'),
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Delete'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
        ),
      );
    }
  }

  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('This is a Snackbar popup!'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(label: 'Close', onPressed: () {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isCupertino
              ? CupertinoButton.filled(
                  onPressed: () => _showAlert(context),
                  child: const Text('Show Alert Dialog'),
                )
              : ElevatedButton(
                  onPressed: () => _showAlert(context),
                  child: const Text('Show Alert Dialog'),
                ),
          const SizedBox(height: 24),
          isCupertino
              ? CupertinoButton.filled(
                  onPressed: () => _showActionSheet(context),
                  child: const Text('Show Action Sheet'),
                )
              : ElevatedButton(
                  onPressed: () => _showActionSheet(context),
                  child: const Text('Show Bottom Sheet'),
                ),
          const SizedBox(height: 24),
          isCupertino
              ? CupertinoButton.filled(
                  onPressed: () => _showSnackbar(context),
                  child: const Text('Show Snackbar'),
                )
              : ElevatedButton(
                  onPressed: () => _showSnackbar(context),
                  child: const Text('Show Snackbar'),
                ),
          const SizedBox(height: 24),
          if (!isCupertino) ...[
            MenuAnchor(
              builder:
                  (
                    BuildContext context,
                    MenuController controller,
                    Widget? child,
                  ) {
                    return ElevatedButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      child: const Text('Open Menu'),
                    );
                  },
              menuChildren: [
                MenuItemButton(
                  onPressed: () {},
                  child: const Text('Menu Item 1'),
                ),
                MenuItemButton(
                  onPressed: () {},
                  child: const Text('Menu Item 2'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

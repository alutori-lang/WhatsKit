import 'package:flutter/material.dart';
import '../../../models/fake_chat.dart';
import '../../../theme/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final FakeMessage message;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const ChatBubble({
    super.key,
    required this.message,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isSent = message.isSent;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: GestureDetector(
              onTap: onTap,
              onLongPress: onLongPress,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.78,
                ),
                margin: EdgeInsets.only(
                  left: isSent ? 50 : 0,
                  right: isSent ? 0 : 50,
                ),
                padding: const EdgeInsets.fromLTRB(10, 6, 8, 8),
                decoration: BoxDecoration(
                  color: isSent ? AppColors.bubbleSent : AppColors.bubbleReceived,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isSent ? 8 : 0),
                    topRight: Radius.circular(isSent ? 0 : 8),
                    bottomLeft: const Radius.circular(8),
                    bottomRight: const Radius.circular(8),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x21000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Text(
                      message.text,
                      style: const TextStyle(
                        fontSize: 14.5,
                        color: AppColors.textPrimary,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            message.time,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          if (isSent) ...[
                            const SizedBox(width: 3),
                            Icon(
                              message.status.icon,
                              size: 14,
                              color: message.status.color,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

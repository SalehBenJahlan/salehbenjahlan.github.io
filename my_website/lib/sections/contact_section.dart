import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_breakpoints.dart';
import '../core/state/app_state.dart';
import '../core/localization/app_localizations.dart';
import '../widgets/section_title.dart';
import '../widgets/gradient_button.dart';
import '../widgets/cursor_spotlight.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(BuildContext context, bool isArabic) {
    if (_nameController.text.isEmpty && _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'شكراً لتواصلك! سيتم الرد عليك قريباً.'
                : 'Thank you for reaching out! I will reply shortly.',
          ),
          backgroundColor: AppColors.purple,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    _nameController.clear();
    _emailController.clear();
    _messageController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isArabic
              ? 'تم إرسال رسالتك بنجاح!'
              : 'Your message has been sent successfully!',
        ),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isDark = state.isDarkMode;
    final l10n = AppLocalizations(isArabic: state.isArabic);
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = screenW < 960;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 56 : 96,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              SectionTitle(
                normalText: l10n.contactTitle,
                gradientText: l10n.contactGradient,
                subtitle: l10n.contactDescription,
              ),
              const SizedBox(height: 56),

              isMobile
                  ? Column(
                      children: [
                        _ContactDetails(
                          l10n: l10n,
                          isDark: isDark,
                          isArabic: state.isArabic,
                        ),
                        const SizedBox(height: 36),
                        _ContactFormCard(
                          nameCtrl: _nameController,
                          emailCtrl: _emailController,
                          msgCtrl: _messageController,
                          onSend: () => _sendMessage(context, state.isArabic),
                          isDark: isDark,
                          l10n: l10n,
                          isArabic: state.isArabic,
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: _ContactDetails(
                            l10n: l10n,
                            isDark: isDark,
                            isArabic: state.isArabic,
                          ),
                        ),
                        const SizedBox(width: 48),
                        Expanded(
                          flex: 6,
                          child: _ContactFormCard(
                            nameCtrl: _nameController,
                            emailCtrl: _emailController,
                            msgCtrl: _messageController,
                            onSend: () => _sendMessage(context, state.isArabic),
                            isDark: isDark,
                            l10n: l10n,
                            isArabic: state.isArabic,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactDetails extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isDark;
  final bool isArabic;

  const _ContactDetails({
    required this.l10n,
    required this.isDark,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.contactLetsTalk,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.white : AppColors.dark900,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.contactDescription,
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: isDark ? AppColors.grey300 : AppColors.dark500,
          ),
        ),
        const SizedBox(height: 32),

        // Direct Info items
        _ContactInfoItem(
          icon: Icons.email_outlined,
          title: isArabic ? 'البريد الإلكتروني' : 'Email',
          value: l10n.contactEmail,
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _ContactInfoItem(
          icon: Icons.phone_outlined,
          title: isArabic ? 'الهاتف' : 'Phone',
          value: l10n.contactPhone,
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _ContactInfoItem(
          icon: Icons.location_on_outlined,
          title: isArabic ? 'الموقع' : 'Location',
          value: l10n.contactLocation,
          isDark: isDark,
        ),
        const SizedBox(height: 32),

        // Social Media Buttons
        Text(
          isArabic ? 'تابعني على' : 'Connect with me',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.white : AppColors.dark900,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _SocialChip(
              icon: Icons.hub_outlined,
              label: 'GitHub',
              isDark: isDark,
            ),
            _SocialChip(
              icon: Icons.link_rounded,
              label: 'LinkedIn',
              isDark: isDark,
            ),
            _SocialChip(
              icon: Icons.tag,
              label: 'Twitter / X',
              isDark: isDark,
            ),
          ],
        ),
      ],
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isDark;

  const _ContactInfoItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.purple.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.purple, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.grey500 : AppColors.dark500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.white : AppColors.dark900,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialChip extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isDark;

  const _SocialChip({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  @override
  State<_SocialChip> createState() => _SocialChipState();
}

class _SocialChipState extends State<_SocialChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.purple.withValues(alpha: 0.15)
              : (widget.isDark ? AppColors.cardDark : AppColors.surfaceLight),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _hovered
                ? AppColors.purple
                : (widget.isDark ? AppColors.borderDark : AppColors.borderLight),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 16,
              color: _hovered
                  ? AppColors.purple
                  : (widget.isDark ? AppColors.grey300 : AppColors.dark700),
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _hovered
                    ? AppColors.purple
                    : (widget.isDark ? AppColors.white : AppColors.dark900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactFormCard extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController msgCtrl;
  final VoidCallback onSend;
  final bool isDark;
  final AppLocalizations l10n;
  final bool isArabic;

  const _ContactFormCard({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.msgCtrl,
    required this.onSend,
    required this.isDark,
    required this.l10n,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppColors.cardDark : AppColors.cardLight;
    final borderColor =
        isDark ? AppColors.borderDark : AppColors.borderLight;

    return CursorSpotlight(
      borderRadius: BorderRadius.circular(20),
      radius: 220,
      color: AppColors.purple.withValues(alpha: 0.1),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.contactSendMessage,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.white : AppColors.dark900,
              ),
            ),
            const SizedBox(height: 24),

            // Name field
            _CustomTextField(
              controller: nameCtrl,
              label: isArabic ? 'الاسم الكامل' : 'Your Name',
              hint: isArabic ? 'مثال: محمد' : 'e.g. John Doe',
              icon: Icons.person_outline,
              isDark: isDark,
            ),
            const SizedBox(height: 16),

            // Email field
            _CustomTextField(
              controller: emailCtrl,
              label: isArabic ? 'البريد الإلكتروني' : 'Email Address',
              hint: 'you@example.com',
              icon: Icons.alternate_email,
              isDark: isDark,
            ),
            const SizedBox(height: 16),

            // Message field
            _CustomTextField(
              controller: msgCtrl,
              label: isArabic ? 'الرسالة' : 'Your Message',
              hint: isArabic
                  ? 'اكتب رسالتك هنا...'
                  : 'Write your message here...',
              icon: Icons.chat_bubble_outline,
              isDark: isDark,
              maxLines: 4,
            ),
            const SizedBox(height: 28),

            // Submit Button
            GradientButton(
              text: l10n.contactSendMessage,
              icon: Icons.send_rounded,
              style: GradientButtonStyle.filled,
              onTap: onSend,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool isDark;
  final int maxLines;

  const _CustomTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.isDark,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.grey300 : AppColors.dark700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppColors.white : AppColors.dark900,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.grey500 : AppColors.dark500,
            ),
            prefixIcon: Icon(
              icon,
              size: 18,
              color: isDark ? AppColors.grey500 : AppColors.dark500,
            ),
            filled: true,
            fillColor:
                isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.purple,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


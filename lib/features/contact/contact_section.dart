import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:devolio_flutter/core/constants/app_constants.dart';
import 'package:devolio_flutter/core/theme/app_colors.dart';
import 'package:devolio_flutter/core/theme/app_typography.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';
import 'package:devolio_flutter/shared/layout/app_container.dart';
import 'package:devolio_flutter/shared/widgets/section_title.dart';

// ─────────────────────────────────────────────────────────────────────────────

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      color: isDark ? AppColors.surface : AppColors.lightCard,
      child: AppContainer(
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left — title + form
                  Expanded(flex: 5, child: _FormColumn(isDark: isDark)),
                  const SizedBox(width: 72),
                  // Right — contact details + social links
                  Expanded(flex: 4, child: _SideColumn(isDark: isDark)),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FormColumn(isDark: isDark),
                  const SizedBox(height: 56),
                  _divider(isDark),
                  const SizedBox(height: 56),
                  _SideColumn(isDark: isDark),
                ],
              ),
      ),
    );
  }

  Widget _divider(bool isDark) => Container(
        height: 1,
        color: isDark ? AppColors.border : AppColors.lightBorder,
      );
}

// ── Left column: title + form ─────────────────────────────────────────────────

class _FormColumn extends StatelessWidget {
  final bool isDark;
  const _FormColumn({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          AppConstants.contactHeading,
          subtitle: 'Have a project in mind or want to collaborate?',
        ),
        SizedBox(height: 36),
        _ContactForm(),
      ],
    );
  }
}

// ── Right column: contact info + social ──────────────────────────────────────

class _SideColumn extends StatelessWidget {
  final bool isDark;
  const _SideColumn({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? AppColors.border : AppColors.lightBorder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Quick contact info ────────────────────────────────────────────
        const _Label('QUICK INFO'),
        const SizedBox(height: 20),
        const _ContactRow(
          icon: Icons.email_outlined,
          label: 'Email',
          value: AppConstants.email,
          url: 'mailto:${AppConstants.email}',
        ),
        const SizedBox(height: 14),
        const _ContactRow(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: AppConstants.location,
        ),
        const SizedBox(height: 14),
        const _ContactRow(
          icon: Icons.circle,
          label: 'Status',
          value: AppConstants.availabilityStatus,
          isStatus: true,
        ),

        const SizedBox(height: 40),
        Container(height: 1, color: borderColor),
        const SizedBox(height: 40),

        // ── Social links ──────────────────────────────────────────────────
        const _Label('FIND ME ONLINE'),
        const SizedBox(height: 12),
        Text(
          'I share open-source work, engineering insights, and the occasional '
          'project update — reach out on any of these platforms.',
          style: AppTypography.bodySm.copyWith(
            color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
          ),
        ).animate().fadeIn(delay: 300.ms, duration: 450.ms),
        const SizedBox(height: 24),
        _SocialCard(
          icon: Icons.code_rounded,
          platform: 'GitHub',
          handle: AppConstants.githubUrl
              .replaceFirst('https://github.com/', '@'),
          url: AppConstants.githubUrl,
          isDark: isDark,
          delay: 350.ms,
        ),
        const SizedBox(height: 12),
        _SocialCard(
          icon: Icons.people_outline_rounded,
          platform: 'LinkedIn',
          handle: AppConstants.linkedinUrl
              .replaceFirst('https://linkedin.com/in/', ''),
          url: AppConstants.linkedinUrl,
          isDark: isDark,
          delay: 430.ms,
        ),
      ],
    );
  }
}

// ── Small section label (all-caps accent) ────────────────────────────────────

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.categoryLabel,
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }
}

// ── Contact row (icon tile + label + value) ───────────────────────────────────

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? url;
  final bool isStatus;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.url,
    this.isStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.accentDim,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: isStatus ? 8 : 16,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.contactMetaLabel,
            ),
            if (url != null)
              GestureDetector(
                onTap: () async {
                  final uri = Uri.parse(url!);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    value,
                    style: AppTypography.contactLink,
                  ),
                ),
              )
            else
              Text(
                value,
                style: AppTypography.contactMetaValue.copyWith(
                  color: isStatus
                      ? AppColors.accent
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 250.ms, duration: 400.ms);
  }
}

// ── Social platform card ──────────────────────────────────────────────────────

class _SocialCard extends StatefulWidget {
  final IconData icon;
  final String platform;
  final String handle;
  final String url;
  final bool isDark;
  final Duration delay;

  const _SocialCard({
    required this.icon,
    required this.platform,
    required this.handle,
    required this.url,
    required this.isDark,
    required this.delay,
  });

  @override
  State<_SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<_SocialCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.isDark
        ? (_hovered ? AppColors.cardHover : AppColors.card)
        : (_hovered ? AppColors.lightBorder : AppColors.lightSurface);
    final border = widget.isDark
        ? (_hovered
            ? AppColors.accent.withValues(alpha: 0.4)
            : AppColors.border)
        : (_hovered
            ? AppColors.accent.withValues(alpha: 0.4)
            : AppColors.lightBorder);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              // Icon box
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.accent.withValues(alpha: 0.15)
                      : AppColors.accentDim,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.icon,
                  size: 18,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 14),
              // Platform + handle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.platform,
                      style: AppTypography.socialPlatform.copyWith(
                        color: _hovered
                            ? AppColors.accent
                            : (widget.isDark
                                ? AppColors.textPrimary
                                : AppColors.lightTextPrimary),
                      ),
                    ),
                    Text(
                      widget.handle,
                      style: AppTypography.socialHandle.copyWith(
                        color: widget.isDark
                            ? AppColors.textSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow
              AnimatedSlide(
                offset: _hovered ? const Offset(0.15, 0) : Offset.zero,
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: _hovered
                      ? AppColors.accent
                      : (widget.isDark
                          ? AppColors.textMuted
                          : AppColors.lightTextMuted),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: widget.delay, duration: 400.ms);
  }
}

// ── Contact Form ──────────────────────────────────────────────────────────────

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _key  = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _mail = TextEditingController();
  final _msg  = TextEditingController();
  bool _loading = false;
  bool _sent    = false;

  @override
  void dispose() {
    _name.dispose();
    _mail.dispose();
    _msg.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_key.currentState!.validate()) return;
    setState(() => _loading = true);

    // TODO: replace with EmailJS or your preferred form backend
    final sub  = Uri.encodeComponent('Portfolio — ${_name.text}');
    final body = Uri.encodeComponent(
        'From: ${_name.text} <${_mail.text}>\n\n${_msg.text}');
    final uri  = Uri.parse(
        'mailto:${AppConstants.email}?subject=$sub&body=$body');

    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (await canLaunchUrl(uri)) await launchUrl(uri);
    if (mounted) setState(() { _loading = false; _sent = true; });
  }

  @override
  Widget build(BuildContext context) {
    if (_sent) {
      return _SuccessCard(
        onReset: () => setState(() {
          _sent = false;
          _name.clear();
          _mail.clear();
          _msg.clear();
        }),
      );
    }

    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Field(
            ctrl: _name,
            label: AppConstants.formName,
            validator: (v) => v?.trim().isEmpty == true ? 'Required' : null,
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 16),
          _Field(
            ctrl: _mail,
            label: AppConstants.formEmail,
            type: TextInputType.emailAddress,
            validator: (v) {
              if (v?.trim().isEmpty == true) return 'Required';
              if (v?.contains('@') == false) return 'Invalid email';
              return null;
            },
          ).animate().fadeIn(delay: 180.ms),
          const SizedBox(height: 16),
          _Field(
            ctrl: _msg,
            label: AppConstants.formMessage,
            maxLines: 6,
            validator: (v) => v?.trim().isEmpty == true ? 'Required' : null,
          ).animate().fadeIn(delay: 260.ms),
          const SizedBox(height: 24),
          _SendButton(loading: _loading, onTap: _loading ? null : _submit)
              .animate().fadeIn(delay: 340.ms),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final int maxLines;
  final TextInputType? type;
  final String? Function(String?)? validator;

  const _Field({
    required this.ctrl,
    required this.label,
    this.maxLines = 1,
    this.type,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: type,
      validator: validator,
      style: AppTypography.formInput,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: maxLines > 1,
      ),
    );
  }
}

class _SendButton extends StatefulWidget {
  final bool loading;
  final VoidCallback? onTap;
  const _SendButton({required this.loading, this.onTap});

  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accentLight : AppColors.accent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.loading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : Text(
                  AppConstants.ctaSendMessage,
                  style: AppTypography.ctaLabel.copyWith(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

class _SuccessCard extends StatelessWidget {
  final VoidCallback onReset;
  const _SuccessCard({required this.onReset});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.accentDim,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.check_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 20),
          Text(
            'Message sent!',
            style: AppTypography.successTitle,
          ),
          const SizedBox(height: 8),
          Text(
            "Thanks for reaching out. I'll get back to you within 24 hours.",
            style: AppTypography.successDesc.copyWith(
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: onReset,
            child: Text(
              'Send another message →',
              style: AppTypography.successLink,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.05, end: 0, duration: 500.ms);
  }
}

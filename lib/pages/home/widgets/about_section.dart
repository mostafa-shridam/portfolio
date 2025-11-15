import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/models/about.dart';
import '../../../core/models/education.dart';
import '../../../core/models/experience.dart';
import '../../../core/services/helper.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/my_chip.dart';
import '../../../providers/about.dart';
/// About Section Widget
/// Displays user's bio, availability status, work experience, and education
/// in a responsive grid layout with all experience fields
class AboutSection extends ConsumerWidget {
  const AboutSection({super.key, required this.selectedColor});

  /// Theme color for accent elements
  final int selectedColor;

  // Cache commonly used values to avoid repeated computations
  static const double _mobileHorizontalPadding = 16.0;
  static const double _tabletHorizontalPadding = 24.0;
  static const double _desktopHorizontalPadding = 32.0;
  static const double _mobileVerticalPadding = 16.0;
  static const double _desktopVerticalPadding = 24.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;
    final isTablet = responsive.isTablet;

    // Watch provider state for reactive updates
    final aboutState = ref.watch(aboutProviderProvider);

    // Show loading indicator early
    if (aboutState.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(48.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Extract data once (null safety with default values)
    final aboutData = aboutState.about ?? AboutModel();
    final workExperience = aboutState.workExperience ?? [];
    final education = aboutState.education ?? [];
    // Calculate padding once
    final horizontalPadding = isMobile
        ? _mobileHorizontalPadding
        : (isTablet ? _tabletHorizontalPadding : _desktopHorizontalPadding);
    final verticalPadding =
        isMobile ? _mobileVerticalPadding : _desktopVerticalPadding;
    log('aboutData : ${aboutState.hasData}');
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: !aboutState.hasData
          ? Center(child: Text('You can add about you here'))
          : isMobile
              ? _buildMobileLayout(
                  context: context,
                  aboutData: aboutData,
                  workExperience: workExperience,
                  education: education,
                  theme: theme,
                  isDark: isDark,
                )
              : _buildDesktopLayout(
                  context: context,
                  aboutData: aboutData,
                  workExperience: workExperience,
                  education: education,
                  theme: theme,
                  isDark: isDark,
                  isMobile: isMobile,
                  isTablet: isTablet,
                ),
    );
  }

  // Separated layout builders for better readability
  Widget _buildMobileLayout({
    required BuildContext context,
    required AboutModel aboutData,
    required List<Experience> workExperience,
    required List<Education> education,
    required ThemeData theme,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Education on top for mobile
        if (education.isNotEmpty) ...[
          _buildSectionTitle(context, 'Education'),
          const SizedBox(height: 16),
          _educationPanel(
            education: education,
            theme: theme,
            isDark: isDark,
            context: context,
          ),
          const SizedBox(height: 16),
        ],
        // About + Work Experience
        _rightContentPanel(
          context: context,
          aboutData: aboutData,
          workExperience: workExperience,
          theme: theme,
          isDark: isDark,
          isMobile: true,
          isTablet: false,
        ),
      ],
    );
  }

  Widget _buildDesktopLayout({
    required BuildContext context,
    required AboutModel aboutData,
    required List<Experience> workExperience,
    required List<Education> education,
    required ThemeData theme,
    required bool isDark,
    required bool isMobile,
    required bool isTablet,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Right: About + Work Experience
        Expanded(
          child: _rightContentPanel(
            context: context,
            aboutData: aboutData,
            workExperience: workExperience,
            theme: theme,
            isDark: isDark,
            isMobile: isMobile,
            isTablet: isTablet,
          ),
        ),
        const SizedBox(width: 12),
        // Left: Education
        if (education.isNotEmpty)
          Expanded(
            child: _educationPanel(
              education: education,
              theme: theme,
              isDark: isDark,
              context: context,
            ),
          ),
      ],
    );
  }

  /// Builds the bio section with location and availability status
  Widget _buildBioSection({
    required BuildContext context,
    required ThemeData theme,
    required bool isDark,
    required AboutModel aboutData,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        _buildSectionTitle(context, 'About Me'),
        const SizedBox(height: 12),

        // Bio Text - only render if not empty
        if (aboutData.bio?.isNotEmpty ?? false)
          Text(
            aboutData.bio!,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.8,
              color: isDark ? Colors.white70 : Colors.black87,
              fontSize: 16,
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

        const SizedBox(height: 16),

        // Location and Availability Row
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            // Location - only render if not empty
            if (aboutData.location?.isNotEmpty ?? false)
              _buildInfoChip(
                icon: Icons.location_on_outlined,
                label: aboutData.location!,
                isDark: isDark,
                theme: theme,
              ),

            // Availability Status
            _buildAvailabilityChip(
              isAvailable: aboutData.isAvailableForWork ?? false,
              isDark: isDark,
              theme: theme,
            ),
          ],
        ),
      ],
    );
  }

  /// Right panel: About + Work Experience (scrollable)
  Widget _rightContentPanel({
    required BuildContext context,
    required AboutModel aboutData,
    required List<Experience> workExperience,
    required ThemeData theme,
    required bool isDark,
    required bool isMobile,
    required bool isTablet,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBioSection(
          context: context,
          theme: theme,
          isDark: isDark,
          aboutData: aboutData,
        ),
        const SizedBox(height: 16),
        // Only build work experience section if data exists
        if (workExperience.isNotEmpty)
          _buildWorkExperienceSection(
            context: context,
            theme: theme,
            isDark: isDark,
            workExperience: workExperience,
          ),
      ],
    );
  }

  /// Builds the work experience section with grid
  Widget _buildWorkExperienceSection({
    required BuildContext context,
    required ThemeData theme,
    required bool isDark,
    required List<Experience> workExperience,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Work Experience'),
        const SizedBox(height: 8),
        // Work Experience Grid
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView.builder(
            itemCount: workExperience.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _buildWorkExperienceCard(
                  context: context,
                  experience: workExperience[index],
                  theme: theme,
                  isDark: isDark,
                  delay: Duration(milliseconds: 100 * index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Left education panel (scrollable, tight to content)
  Widget _educationPanel({
    required List<Education> education,
    required ThemeData theme,
    required bool isDark,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Education'),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            education.length,
            (index) => _buildEducationCard(
              context: context,
              education: education[index],
              theme: theme,
              isDark: isDark,
              delay: Duration(milliseconds: 100 * index),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds section title with animation
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0);
  }

  /// Builds info chip for location display
  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required bool isDark,
    required ThemeData theme,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: isDark ? Colors.white70 : Colors.black54),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
      ],
    );
  }

  /// Builds availability status chip
  Widget _buildAvailabilityChip({
    required bool isAvailable,
    required bool isDark,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isAvailable
            ? greenColor.withValues(alpha: 0.1)
            : accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isAvailable
              ? greenColor.withValues(alpha: 0.3)
              : accentColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            color: isAvailable ? Colors.green : Colors.orange,
            size: 10,
          ),
          const SizedBox(width: 8),
          Text(
            isAvailable
                ? 'Available for new projects'
                : 'Not available currently',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds work experience card with all fields
  Widget _buildWorkExperienceCard({
    required BuildContext context,
    required Experience experience,
    required ThemeData theme,
    required bool isDark,
    required Duration delay,
  }) {
    // Pre-calculate date range to avoid repeated calls
    final dateRange = formatDateRange(
      experience.startDate,
      experience.endDate,
      experience.isCurrent ?? false,
    );

    // Pre-calculate color with alpha to reuse
    final crrentColor = Color(selectedColor);
    final accentColorLight = crrentColor.withValues(alpha: 0.05);
    final accentColorBorder = crrentColor.withValues(alpha: 0.2);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accentColorLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColorBorder, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company Logo and Name Row
          _buildCompanyHeader(experience, theme, isDark, crrentColor),
          const SizedBox(height: 12),

          // Position Title
          Text(
            experience.position ?? 'Position',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: crrentColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Location
          if (experience.location?.isNotEmpty ?? false)
            _buildIconTextRow(
              icon: Icons.location_on_outlined,
              text: experience.location!,
              theme: theme,
              isDark: isDark,
            ),

          const SizedBox(height: 4),

          // Date Range
          _buildIconTextRow(
            icon: Icons.calendar_today_outlined,
            text: dateRange,
            theme: theme,
            isDark: isDark,
          ),

          const SizedBox(height: 12),

          // Description
          if (experience.description?.isNotEmpty ?? false) ...[
            Text(
              experience.description!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.white70 : Colors.black87,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
          ],

          // Responsibilities Section
          if (experience.responsibilities?.isNotEmpty ?? false)
            _buildChipSection(
              title: 'Key Responsibilities:',
              items: experience.responsibilities!,
              maxItems: 4,
              theme: theme,
              isDark: isDark,
              backgroundColor: crrentColor.withValues(alpha: 0.1),
              borderColor: crrentColor.withValues(alpha: 0.3),
              textColor: crrentColor,
            ),

          // Technologies Section
          if (experience.technologies?.isNotEmpty ?? false)
            _buildChipSection(
              title: 'Technologies:',
              items: experience.technologies!,
              maxItems: 6,
              theme: theme,
              isDark: isDark,
              backgroundColor: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.grey.shade200,
              borderColor: isDark
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.grey.shade400,
              textColor: isDark ? Colors.white70 : Colors.black87,
            ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: delay, duration: 600.ms)
        .slideY(begin: 0.2, end: 0);
  }

  /// Builds company header with logo and name
  Widget _buildCompanyHeader(
    Experience experience,
    ThemeData theme,
    bool isDark,
    Color accentColor,
  ) {
    return Row(
      children: [
        // Company Logo
        _buildCompanyLogo(experience, isDark, accentColor),
        const SizedBox(width: 12),

        // Company Name
        Expanded(
          child: Text(
            experience.company ?? 'Company',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Builds company logo container
  Widget _buildCompanyLogo(
    Experience experience,
    bool isDark,
    Color accentColor,
  ) {
    final hasLogo = experience.companyLogo?.isNotEmpty ?? false;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: hasLogo ? Colors.white : accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: hasLogo
            ? Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.grey.shade300,
              )
            : null,
      ),
      child: hasLogo
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                experience.companyLogo!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.business, color: accentColor, size: 24),
              ),
            )
          : Icon(Icons.business, color: accentColor, size: 24),
    );
  }

  /// Builds a row with icon and text (reusable)
  Widget _buildIconTextRow({
    required IconData icon,
    required String text,
    required ThemeData theme,
    required bool isDark,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: isDark ? Colors.white60 : Colors.black54),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white60 : Colors.black54,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Builds a chip section with title and chips (reusable)
  Widget _buildChipSection({
    required String title,
    required List<String> items,
    required int maxItems,
    required ThemeData theme,
    required bool isDark,
    required Color backgroundColor,
    required Color borderColor,
    required Color textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: items
              .take(maxItems)
              .map((item) => MyChip(title: item, selectedColor: selectedColor))
              .toList(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  /// Builds education card with animation
  Widget _buildEducationCard({
    required BuildContext context,
    required Education education,
    required ThemeData theme,
    required bool isDark,
    required Duration delay,
  }) {
    // Pre-calculate values
    final dateRange = formatDateRange(
      education.startDate,
      education.endDate,
      education.isCurrent ?? false,
    );

    final accentColor = Color(selectedColor);
    log('selectedColor in education card: ${education.toJson()}');
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Degree
              Text(
                education.institution ?? 'Institution',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Institution
              Text(
                education.field ?? 'Field of Study',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.white70 : Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Date Range
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: isDark ? Colors.white60 : Colors.black45,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  dateRange,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white60 : Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: delay, duration: 600.ms)
        .slideY(begin: 0.2, end: 0);
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'dart:convert';
import '../../../../providers/skills.dart';
import '../../../constants.dart';

class SkillsSection extends ConsumerStatefulWidget {
  const SkillsSection({super.key, required this.selectedColor});
  final int selectedColor;
  @override
  ConsumerState<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends ConsumerState<SkillsSection> {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isLoading = ref.watch(skillsProvider).isLoading ;
    final color = Color(widget.selectedColor);

    final skills = ref.watch(skillsProvider.select((e) => e.skills));
    return Container(
      color: color.withValues(alpha: 0.2),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 32,
      ),
      child: Column(
        children: [
          Text('Skills', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'The skills, tools, and technologies I\'m really good at :',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (skills.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'No skills added yet',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            )
          else
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: skills.map((skill) {
                final prof = (skill.proficiency ?? 0.5).clamp(0.0, 1.0);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 96,
                      height: 96,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 96,
                            height: 96,
                            child: CircularProgressIndicator(
                              value: prof,
                              strokeWidth: 6,
                              backgroundColor: color.withValues(alpha: 0.05),
                              padding: EdgeInsets.all(2),
                              color: color.withValues(alpha: 0.8),
                            ),
                          ),
                          // inner content: icon or image or fallback
                          ClipOval(
                            child: SizedBox(
                              width: 64,
                              height: 64,
                              child: (() {
                                if (skill.iconName?.isNotEmpty ?? false) {
                                  final icon = FontAwesomeMapper.iconFromName(
                                    skill.iconName!,
                                  );
                                  if (icon != null) {
                                    return Center(
                                      child: FaIcon(
                                        icon,
                                        size: 28,
                                        color: color,
                                      ),
                                    );
                                  }
                                }
                                if (skill.image != null &&
                                    skill.image!.isNotEmpty) {
                                  // handle base64 data urls or network images
                                  log('skills length: ${skill.image}');

                                  if (skill.image!.startsWith('data:')) {
                                    try {
                                      final comma = skill.image!.indexOf(',');
                                      final b64 = (comma > 0)
                                          ? skill.image!.substring(comma + 1)
                                          : skill.image!;
                                      final bytes = base64Decode(b64);
                                      return Image.memory(
                                        bytes,
                                        fit: BoxFit.cover,
                                      );
                                    } catch (_) {
                                      return const SizedBox.shrink();
                                    }
                                  }
                                  return Image.network(
                                    skill.image!,
                                    fit: BoxFit.cover,
                                  );
                                }
                                return Center(
                                  child: Icon(Icons.psychology, color: color),
                                );
                              })(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(skill.name ?? ''),
                    Text('${(prof * 100).round()}%'),
                  ],
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

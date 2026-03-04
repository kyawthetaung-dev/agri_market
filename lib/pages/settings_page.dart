import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const SettingsPage({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = false;
  String _language = 'English';
  String _currency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Tablet/Desktop layout - two column
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildSectionTitle(context, 'Appearance'),
                      _buildThemeSelector(context),
                      const SizedBox(height: 24),
                      _buildSectionTitle(context, 'Preferences'),
                      _buildLanguageSelector(context),
                      _buildCurrencySelector(context),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildSectionTitle(context, 'Notifications'),
                      _buildNotificationToggle(context),
                      _buildLocationToggle(context),
                      const SizedBox(height: 24),
                      _buildSectionTitle(context, 'Account'),
                      _buildAccountOptions(context),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // Mobile layout - single column
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSectionTitle(context, 'Appearance'),
                _buildThemeSelector(context),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'Preferences'),
                _buildLanguageSelector(context),
                _buildCurrencySelector(context),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'Notifications'),
                _buildNotificationToggle(context),
                _buildLocationToggle(context),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'Account'),
                _buildAccountOptions(context),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'About'),
                _buildAboutSection(context),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme Mode', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: Icon(Icons.light_mode),
                  label: Text('Light'),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: Icon(Icons.dark_mode),
                  label: Text('Dark'),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: Icon(Icons.settings_suggest),
                  label: Text('System'),
                ),
              ],
              selected: {widget.themeMode},
              onSelectionChanged: (Set<ThemeMode> newSelection) {
                widget.onThemeChanged(newSelection.first);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.language),
        title: const Text('Language'),
        subtitle: Text(_language),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          _showLanguageDialog(context);
        },
      ),
    );
  }

  Widget _buildCurrencySelector(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.attach_money),
        title: const Text('Currency'),
        subtitle: Text(_currency),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          _showCurrencyDialog(context);
        },
      ),
    );
  }

  Widget _buildNotificationToggle(BuildContext context) {
    return Card(
      child: SwitchListTile(
        secondary: const Icon(Icons.notifications),
        title: const Text('Push Notifications'),
        subtitle: const Text('Receive order updates'),
        value: _notificationsEnabled,
        onChanged: (bool value) {
          setState(() {
            _notificationsEnabled = value;
          });
        },
      ),
    );
  }

  Widget _buildLocationToggle(BuildContext context) {
    return Card(
      child: SwitchListTile(
        secondary: const Icon(Icons.location_on),
        title: const Text('Location Services'),
        subtitle: const Text('Enable location for delivery'),
        value: _locationEnabled,
        onChanged: (bool value) {
          setState(() {
            _locationEnabled = value;
          });
        },
      ),
    );
  }

  Widget _buildAccountOptions(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Edit Profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Payment Methods'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('English'),
                value: 'English',
                groupValue: _language,
                onChanged: (value) {
                  setState(() => _language = value!);
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('Myanmar'),
                value: 'Myanmar',
                groupValue: _language,
                onChanged: (value) {
                  setState(() => _language = value!);
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('Chinese'),
                value: 'Chinese',
                groupValue: _language,
                onChanged: (value) {
                  setState(() => _language = value!);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCurrencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Currency'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('USD - US Dollar'),
                value: 'USD',
                groupValue: _currency,
                onChanged: (value) {
                  setState(() => _currency = value!);
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('MMK - Myanmar Kyat'),
                value: 'MMK',
                groupValue: _currency,
                onChanged: (value) {
                  setState(() => _currency = value!);
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('CNY - Chinese Yuan'),
                value: 'CNY',
                groupValue: _currency,
                onChanged: (value) {
                  setState(() => _currency = value!);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

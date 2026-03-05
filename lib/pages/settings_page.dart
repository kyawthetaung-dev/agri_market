import 'package:flutter/material.dart';
import '../models/models.dart' as models;
import '../theme/app_theme.dart';

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
  bool _locationEnabled = true;
  String _language = 'English';
  String _currency = 'USD';
  // String _defaultAddress = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
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
                      _buildSectionTitle(context, 'Delivery'),
                      _buildDefaultAddressCard(context),
                      const SizedBox(height: 24),
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
                      const SizedBox(height: 24),
                      _buildSectionTitle(context, 'Support'),
                      _buildSupportOptions(context),
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
                // Profile Section
                _buildProfileCard(context),
                const SizedBox(height: 16),

                _buildSectionTitle(context, 'Delivery'),
                _buildDefaultAddressCard(context),
                _buildSavedAddresses(context),
                const SizedBox(height: 16),

                _buildSectionTitle(context, 'Appearance'),
                _buildThemeSelector(context),
                const SizedBox(height: 16),

                _buildSectionTitle(context, 'Preferences'),
                _buildLanguageSelector(context),
                _buildCurrencySelector(context),
                const SizedBox(height: 16),

                _buildSectionTitle(context, 'Notifications'),
                _buildNotificationToggle(context),
                _buildLocationToggle(context),
                const SizedBox(height: 16),

                _buildSectionTitle(context, 'Account'),
                _buildAccountOptions(context),
                const SizedBox(height: 16),

                _buildSectionTitle(context, 'Support'),
                _buildSupportOptions(context),
                const SizedBox(height: 16),

                _buildSectionTitle(context, 'About'),
                _buildAboutSection(context),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppTheme.primaryColor,
              child: const Icon(Icons.person, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Min Aung',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    '+95 987 654 321',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              color: AppTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDefaultAddressCard(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.home, color: AppTheme.primaryColor),
        ),
        title: const Text('Default Delivery Address'),
        subtitle: Text(
          models.SampleData.savedAddresses.first.fullAddress,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }

  Widget _buildSavedAddresses(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ...models.SampleData.savedAddresses.map((address) {
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: address.isDefault
                      ? AppTheme.primaryColor.withOpacity(0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  address.label == 'Home' ? Icons.home : Icons.work,
                  color: address.isDefault
                      ? AppTheme.primaryColor
                      : Colors.grey,
                ),
              ),
              title: Text(address.label),
              subtitle: Text(address.fullAddress),
              trailing: address.isDefault
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Default',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
              onTap: () {},
            );
          }),
          const Divider(),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add, color: Colors.grey),
            ),
            title: const Text('Add New Address'),
            onTap: () {},
          ),
        ],
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
            const Text(
              'Theme Mode',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
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
            leading: const Icon(Icons.credit_card),
            title: const Text('Saved Cards'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorite Shops'),
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

  Widget _buildSupportOptions(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help Center'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text('Live Chat'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Contact Us'),
            trailing: const Icon(Icons.chevron_right),
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
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text(
              'Delete Account',
              style: TextStyle(color: Colors.red),
            ),
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

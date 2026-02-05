import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isTablet = size.width > 600;

    // Responsive padding
    final horizontalPadding = isTablet ? 80.0 : (isSmallScreen ? 24.0 : 32.0);

    // Responsive spacing
    final topSpacing = isSmallScreen ? 40.0 : (isTablet ? 80.0 : 60.0);
    final logoSize = isSmallScreen ? 80.0 : (isTablet ? 120.0 : 100.0);
    final mainSpacing = isSmallScreen ? 32.0 : (isTablet ? 80.0 : 60.0);
    final fieldSpacing = isSmallScreen ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  maxWidth: isTablet ? 500 : double.infinity,
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: topSpacing),

                        // Logo Container with shadow
                        Container(
                          width: logoSize,
                          height: logoSize,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/logo.png', // Replace with your logo
                            fit: BoxFit.contain,
                            width: logoSize,
                            height: logoSize,
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 16 : 24),

                        // ICA CORP text
                        Text(
                          'ICA CORP',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            letterSpacing: isSmallScreen ? 2.0 : 3.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[400],
                          ),
                        ),

                        SizedBox(height: mainSpacing),

                        // Welcome Back text
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 28 : (isTablet ? 36 : 32),
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 8 : 12),

                        // Subtitle text
                        Text(
                          'Please enter your details to sign in',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: isSmallScreen ? 32 : 48),

                        // Username label
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Username',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 8 : 12),

                        // Username field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _usernameController,
                            style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                            decoration: InputDecoration(
                              hintText: 'e.g. Sagar',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.grey[400],
                                size: isSmallScreen ? 20 : 24,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 16 : 20,
                                vertical: isSmallScreen ? 16 : 20,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: fieldSpacing),

                        // Password label and reset password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Reset Password',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 13 : 15,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF00897B),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: isSmallScreen ? 8 : 12),

                        // Password field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                            decoration: InputDecoration(
                              hintText: '••••••••',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: isSmallScreen ? 18 : 20,
                                letterSpacing: 2,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey[400],
                                size: isSmallScreen ? 20 : 24,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.grey[400],
                                  size: isSmallScreen ? 20 : 24,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 16 : 20,
                                vertical: isSmallScreen ? 16 : 20,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 24 : 32),

                        // Sign In button
                        SizedBox(
                          width: double.infinity,
                          height: isSmallScreen ? 52 : (isTablet ? 64 : 60),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/dashboard');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 16 : 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(width: isSmallScreen ? 8 : 12),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: isSmallScreen ? 18 : 20,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: isSmallScreen ? 40 : (isTablet ? 100 : 80),
                        ),

                        // Footer - Responsive layout
                        isSmallScreen
                            ? Column(
                                children: [
                                  Text(
                                    '© 2026 ICA CORP',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[400],
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: Text(
                                          'PRIVACY',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[400],
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: Text(
                                          'TERMS',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[400],
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '© 2026 ICA CORP',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[400],
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  SizedBox(width: isTablet ? 60 : 40),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(0, 0),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'PRIVACY',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(0, 0),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'TERMS',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                        SizedBox(height: isSmallScreen ? 24 : 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

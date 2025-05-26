import 'package:famlimited/reusables/socialmedia.dart';
import 'package:flutter/material.dart';

import '../../reusables/reuseconf.dart';

class DektopFooter extends StatelessWidget {
  final String? mobile;
  
  const DektopFooter({super.key, this.mobile});

  static const TextStyle footerText = TextStyle(
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF140354),
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(thickness: 0.5, color: Colors.white60),
          _buildContent(),
          const Divider(thickness: 0.5, color: Colors.white60),
          _buildCopyright(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            width: 100,
            height: 80,
            child: Image.asset("assets/images/logo.jpg"),
          ),
        ),
        SocialMedia(),
      ],
    );
  }

  Widget _buildContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildContactInfo(),
        _buildNavigationLinks(),
        if (mobile != "true") _buildBookVisitButton(),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactRow(Icons.call, '+254 716 544 543'),
        const SizedBox(height: 20),
        _buildContactRow(Icons.email, 'sales@famlimited.co.ke'),
        const SizedBox(height: 20),
        _buildContactRow(Icons.location_history, 'Spur Mall 2nd floor suite 006.'),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 20),
        Text(text, style: footerText),
      ],
    );
  }

  Widget _buildNavigationLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNavLink('About Us'),
        const SizedBox(height: 20),
        _buildNavLink('Now Selling'),
        const SizedBox(height: 20),
        _buildNavLink('Our Team'),
        const SizedBox(height: 20),
        _buildNavLink('Gallery'),
      ],
    );
  }

  Widget _buildNavLink(String text) {
    return Row(
      children: [
        const Icon(Icons.circle, color: Colors.white, size: 5),
        const SizedBox(width: 20),
        Text(text, style: footerText),
      ],
    );
  }

  Widget _buildBookVisitButton() {
    return InkWell(
      onTap: () => launchwhtsapp("Hello, i Would like to view some of your property sites"),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blueAccent,
        ),
        child: const Center(
          child: Text(
            'Book a site visit',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildCopyright() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.copyright, color: Colors.white),
          Text('${DateTime.now().year}', style: footerText),
          const SizedBox(width: 10),
          const Text('FAM LIMITED All Rights Reserved', style: footerText),
        ],
      ),
    );
  }
}

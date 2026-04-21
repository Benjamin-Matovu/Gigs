// ============================================================
// lib/data/mock_data.dart
// MOCK DATA — Hard-coded data that makes the app look fully
// populated for a live demo. In production, this would come
// from a real backend API (e.g., Firebase or REST).
// ============================================================

class ProWorker {
  final String id;
  final String name;
  final String initials;
  final String role;
  final String experience;
  final double rating;
  final int jobsCompleted;
  final int communityVouches;
  final String ratePerHour;
  final String badge;
  final String location;
  final String about;
  final List<String> services;
  final int color; // stored as int for const support

  const ProWorker({
    required this.id,
    required this.name,
    required this.initials,
    required this.role,
    required this.experience,
    required this.rating,
    required this.jobsCompleted,
    required this.communityVouches,
    required this.ratePerHour,
    required this.badge,
    required this.location,
    required this.about,
    required this.services,
    required this.color,
  });
}

class MockData {
  // ── PRO WORKERS ──────────────────────────────────────────
  static const List<ProWorker> workers = [
    ProWorker(
      id: 'w1',
      name: 'Joseph S.',
      initials: 'JS',
      role: 'Handyman & Plumber',
      experience: '8 yrs exp',
      rating: 4.8,
      jobsCompleted: 45,
      communityVouches: 120,
      ratePerHour: 'UGX 15,000',
      badge: 'VERIFIED',
      location: 'Kampala',
      about: 'Professional handyman with over 8 years serving the Kampala metropolitan area. I specialise in home maintenance, electrical repairs, and moving logistics.',
      services: ['Handyman', 'Moving', 'Electrical', 'Plumbing'],
      color: 0xFF1565C0,
    ),
    ProWorker(
      id: 'w2',
      name: 'Grace Nakato',
      initials: 'GN',
      role: 'Professional Cleaner',
      experience: '5 yrs exp',
      rating: 4.9,
      jobsCompleted: 120,
      communityVouches: 89,
      ratePerHour: 'UGX 12,000',
      badge: 'PREMIUM',
      location: 'Kampala',
      about: 'Dedicated professional cleaner specialising in deep cleaning, apartment organisation, and office sanitation. Trusted by over 100 families in Kampala.',
      services: ['Cleaning', 'Organisation', 'Laundry'],
      color: 0xFF006064,
    ),
    ProWorker(
      id: 'w3',
      name: 'David Okello',
      initials: 'DO',
      role: 'Expert Plumber',
      experience: '6 yrs exp',
      rating: 4.9,
      jobsCompleted: 50,
      communityVouches: 67,
      ratePerHour: 'UGX 18,000',
      badge: 'VERIFIED',
      location: 'Kampala',
      about: 'Licensed plumber with expertise in leak detection, pipe installation, and bathroom fitting. Fast response times across all Kampala parishes.',
      services: ['Plumbing', 'Electrical', 'Handyman'],
      color: 0xFF6A1B9A,
    ),
    ProWorker(
      id: 'w4',
      name: 'Brian Musoke',
      initials: 'BM',
      role: 'Moving Specialist',
      experience: '4 yrs exp',
      rating: 5.0,
      jobsCompleted: 32,
      communityVouches: 44,
      ratePerHour: 'UGX 20,000',
      badge: 'VERIFIED',
      location: 'Kampala',
      about: 'Home and office moving specialist. I handle packing, transport, and unpacking with care. Available 7 days a week across greater Kampala.',
      services: ['Moving', 'Errands', 'Handyman'],
      color: 0xFFD4830A,
    ),
  ];

  // ── SERVICE CATEGORIES ────────────────────────────────────
  static const List<Map<String, dynamic>> categories = [
    {'label': 'Cleaning',  'icon': 0xe3b0, 'color': 0xFF006064}, // cleaning_services
    {'label': 'Moving',    'icon': 0xe558, 'color': 0xFF1565C0}, // local_shipping
    {'label': 'Printing',  'icon': 0xe8ad, 'color': 0xFF6A1B9A}, // print
    {'label': 'Handyman',  'icon': 0xf00b3, 'color': 0xFFD4830A}, // handyman
    {'label': 'Errands',   'icon': 0xe566, 'color': 0xFFC62828}, // directions_run
  ];

  // ── WORKER DASHBOARD DATA ─────────────────────────────────
  static const Map<String, dynamic> dashboardData = {
    'workerName': 'Joseph S.',
    'initials': 'JS',
    'weeklyEarnings': 'UGX 180,000',
    'earningsGrowth': '+12% vs last week',
    'activeTasks': 4,
    'nextTask': '2:00 PM',
    'rating': 4.9,
    'ratingRank': 'Top 5% in Kampala',
    'profileProgress': 0.75,
    'nearbyJobs': 12,
    'schedule': [
      {
        'title': 'Residential Plumbing',
        'location': 'Kiwatule, Plot 42',
        'amount': 'UGX 45,000',
        'status': 'IN PROGRESS',
        'time': 'Ends in 1h 20m',
      },
      {
        'title': 'AC Maintenance',
        'location': 'Naguru Skyz Area',
        'amount': 'UGX 25,000',
        'status': 'UPCOMING',
        'time': 'Today, 4:30 PM',
      },
    ],
  };
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationPickerMap extends StatefulWidget {
  /// Callback — selected lat, lng, address
  final void Function(double lat, double lng, String address)? onLocationSelected;

  /// Initial map center (default: London)
  final LatLng initialCenter;

  /// Initial zoom level
  final double initialZoom;

  /// Map height
  final double height;

  /// Your app's package name for OSM tile usage policy
  final String userAgentPackageName;

  const LocationPickerMap({
    super.key,
    this.onLocationSelected,
    this.initialCenter = const LatLng(51.509364, -0.128928),
    this.initialZoom = 13.0,
    this.height = 280,
    this.userAgentPackageName = 'com.example.app',
  });

  @override
  State<LocationPickerMap> createState() => _LocationPickerMapState();
}

class _LocationPickerMapState extends State<LocationPickerMap> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  late LatLng _selectedLatLng;
  String _selectedAddress = '';
  bool _isSearching = false;
  bool _isLoadingLocation = false;
  double _currentZoom = 13.0;

  @override
  void initState() {
    super.initState();
    _selectedLatLng = widget.initialCenter;
    _currentZoom = widget.initialZoom;
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ─── Zoom Controls ────────────────────────────────────────────────────────────
  void _zoomIn() {
    _currentZoom = (_currentZoom + 1).clamp(1.0, 18.0);
    _mapController.move(_selectedLatLng, _currentZoom);
  }

  void _zoomOut() {
    _currentZoom = (_currentZoom - 1).clamp(1.0, 18.0);
    _mapController.move(_selectedLatLng, _currentZoom);
  }

  // ─── Current Location ────────────────────────────────────────────────────────
  Future<void> _getCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnack('Location permission denied');
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        _showSnack('Permission permanently denied. Enable from settings.');
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final LatLng currentLatLng =
      LatLng(position.latitude, position.longitude);

      setState(() {
        _selectedLatLng = currentLatLng;
        _currentZoom = 14.0;
      });
      _mapController.move(currentLatLng, 14.0);
      await _reverseGeocode(position.latitude, position.longitude);
    } catch (e) {
      _showSnack('Could not get location');
    } finally {
      setState(() => _isLoadingLocation = false);
    }
  }

  // ─── Reverse Geocode (lat,lng → address) ─────────────────────────────────────
  Future<void> _reverseGeocode(double lat, double lng) async {
    try {
      final List<Placemark> placemarks =
      await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final Placemark p = placemarks.first;
        final String address = [p.street, p.locality, p.country]
            .where((e) => e != null && e.isNotEmpty)
            .join(', ');

        setState(() => _selectedAddress = address);

        // ✅ lat/lng শুধু console এ print — UI তে দেখাবে না
        debugPrint('📍 Selected Location → Lat: $lat, Lng: $lng');
        debugPrint('🏠 Address → $address');

        widget.onLocationSelected?.call(lat, lng, address);
      }
    } catch (_) {}
  }

  // ─── Search (address → lat,lng) ──────────────────────────────────────────────
  Future<void> _searchLocation(String query) async {
    if (query.trim().isEmpty) return;
    setState(() => _isSearching = true);

    try {
      final List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        final LatLng newLatLng = LatLng(loc.latitude, loc.longitude);
        setState(() {
          _selectedLatLng = newLatLng;
          _currentZoom = 14.0;
        });
        _mapController.move(newLatLng, 14.0);
        FocusScope.of(context).unfocus();
        await _reverseGeocode(loc.latitude, loc.longitude);
      } else {
        _showSnack('Location not found');
      }
    } catch (_) {
      _showSnack('Search failed. Try again.');
    } finally {
      setState(() => _isSearching = false);
    }
  }

  // ─── Map Tap ──────────────────────────────────────────────────────────────────
  void _onMapTapped(TapPosition tapPosition, LatLng latLng) {
    setState(() => _selectedLatLng = latLng);
    _reverseGeocode(latLng.latitude, latLng.longitude);
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Search Bar ────────────────────────────────────────────────────────
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onSubmitted: _searchLocation,
                onChanged: (_) => setState(() {}),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search location...',
                  hintStyle:
                  const TextStyle(fontSize: 13, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFFE4E4E4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  prefixIcon:
                  const Icon(Icons.search, color: Colors.grey, size: 20),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear,
                        color: Colors.grey, size: 18),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  )
                      : null,
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Search Button
            _isSearching
                ? const SizedBox(
              width: 44,
              height: 44,
              child:
              Center(child: CircularProgressIndicator(strokeWidth: 2)),
            )
                : _iconButton(
              icon: Icons.search,
              color: const Color(0xFF0071BC),
              onTap: () => _searchLocation(_searchController.text),
            ),
            const SizedBox(width: 8),

            // Current Location Button
            _isLoadingLocation
                ? const SizedBox(
              width: 44,
              height: 44,
              child:
              Center(child: CircularProgressIndicator(strokeWidth: 2)),
            )
                : _iconButton(
              icon: Icons.my_location,
              color: const Color(0xFF003456),
              onTap: _getCurrentLocation,
            ),
          ],
        ),
        const SizedBox(height: 10),

        // ── Flutter Map + Zoom Buttons ────────────────────────────────────────
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: widget.height,
            child: Stack(
              children: [
                // Map
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _selectedLatLng,
                    initialZoom: _currentZoom,
                    onTap: _onMapTapped,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: widget.userAgentPackageName,
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _selectedLatLng,
                          width: 45,
                          height: 45,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap: () => launchUrl(Uri.parse(
                              'https://openstreetmap.org/copyright')),
                        ),
                      ],
                    ),
                  ],
                ),

                // ✅ Zoom In / Out — map এর ডান নিচে
                Positioned(
                  right: 10,
                  bottom: 40,
                  child: Column(
                    children: [
                      _zoomButton(icon: Icons.add, onTap: _zoomIn),
                      const SizedBox(height: 4),
                      _zoomButton(icon: Icons.remove, onTap: _zoomOut),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // ── Selected Address only (lat/lng শুধু console এ) ───────────────────
        if (_selectedAddress.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F4FD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on,
                    size: 14, color: Color(0xFF0071BC)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _selectedAddress,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF0071BC)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ── Zoom Button ───────────────────────────────────────────────────────────────
  Widget _zoomButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }

  // ── Icon Button (Search / Location) ──────────────────────────────────────────
  Widget _iconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
// ignore_for_file: public_member_api_docs, sort_constructors_first

enum AnalyticExternalService {
  firebase,
  // amplitude,
  // mixpanel,
  // facebook,
  // appsflyer,
  // adjust,
  // branch,
  // localytics,
  // adobe,
  // snowplow,
  // googleAnalytics,
  // googleTagManager,
  // custom
}

abstract class AnalyticEvent {
  String get name;
}

abstract class AnalyticService {
  AnalyticService();

  void logEvent(AnalyticEvent event, {Map<String, dynamic>? parameters});
}

enum APIEnvironment { dev, staging, live }

class CommonAPIEnvironment {
  static APIEnvironment environment = APIEnvironment.dev;

  static bool get isLive => environment == APIEnvironment.live;

  static void setEnv(APIEnvironment e) {
    environment = e;
  }
}

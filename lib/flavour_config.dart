enum Environment { dev, uat, prod }

abstract class AppEnvironment {
  static late String baseUrl;
  static late String environmentName;

  static late Environment _environment;

  static Environment get environment => _environment;

  static void setUpEnv(Environment environment) {
    switch (environment) {
      case Environment.dev:
        baseUrl = "http://localhost:3000";
        environmentName = "DEV";
        break;

      case Environment.uat:
        baseUrl = "http://localhost:3000";
        environmentName = "UAT";
        break;

      case Environment.prod:
        baseUrl = "http://localhost:3000";
        environmentName = "PROD";
        break;
    }
  }
}

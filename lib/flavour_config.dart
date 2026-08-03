enum Environment { dev, uat, prod }

abstract class AppEnvironment {
  static late String baseUrl;
  static late String environmentName;

  static late Environment _environment;

  static Environment get environment => _environment;

  static void setUpEnv(Environment environment) {
    switch (environment) {
      case Environment.dev:
        baseUrl = "API BASE URL FOR DEV";
        environmentName = "DEV";
        break;

      case Environment.uat:
        baseUrl = "API BASE URL FOR UAT";
        environmentName = "UAT";
        break;

      case Environment.prod:
        baseUrl = "API BASE URL FOR PROD";
        environmentName = "PROD";
        break;
    }
  }
}

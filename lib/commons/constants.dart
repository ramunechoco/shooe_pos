const String kFlavor = String.fromEnvironment('app.flavor');
const bool isProduction = kFlavor != "staging";

const ShooeHost =
    isProduction ? "http://localhost:8000/" : "http://localhost:8000/";

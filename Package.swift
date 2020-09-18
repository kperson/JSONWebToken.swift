// swift-tools-version:5.0.0
import PackageDescription

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
//Apple
#if canImport(CommonCrypto)
let dependencies: [Package.Dependency] = [
    Package.Dependency.package(url: "https://github.com/IBM-Swift/BlueECC.git", .upToNextMinor(from: "1.2.4"))
]
#else
let dependencies = [
  Package.Dependency.package(url: "https://github.com/kylef-archive/CommonCrypto.git", from: "1.0.0"),
  Package.Dependency.package(url: "https://github.com/IBM-Swift/BlueECC.git", .upToNextMinor(from: "1.2.4"))
]
#endif
let excludes = ["HMAC/HMACCryptoSwift.swift"]
let targetDependencies: [Target.Dependency] = ["CryptorECC"]
#else
//Linux
let dependencies = [
  Package.Dependency.package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMinor(from: "1.1.0")),
  Package.Dependency.package(url: "https://github.com/IBM-Swift/BlueECC.git", .upToNextMinor(from: "1.2.4"))
]
let excludes = ["HMAC/HMACCommonCrypto.swift"]
let targetDependencies: [Target.Dependency] = ["CryptoSwift", "CryptorECC"]
#endif


let package = Package(
  name: "JWT",
  products: [
    .library(name: "JWT", targets: ["JWT"]),
  ],
  dependencies: dependencies,
  targets: [
    .target(name: "JWA", dependencies: targetDependencies, exclude: excludes),
    .target(name: "JWT", dependencies: ["JWA"]),
    .testTarget(name: "JWATests", dependencies: ["JWA"]),
    .testTarget(name: "JWTTests", dependencies: ["JWT"]),
  ]
)

enum PaywallVersion {
  versionA('version_a'),
  versionB('version_b');

  const PaywallVersion(this.value);
  final String value;

  bool get isVersionA => this == PaywallVersion.versionA;
  bool get isVersionB => this == PaywallVersion.versionB;
}

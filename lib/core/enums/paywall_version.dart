enum PaywallVersion {
  versionA('0'),
  versionB('1');

  const PaywallVersion(this.value);
  final String value;

  bool get isVersionA => this == PaywallVersion.versionA;
  bool get isVersionB => this == PaywallVersion.versionB;
}

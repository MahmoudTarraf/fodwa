enum AccountType {
  personal,
  company,
}

extension AccountTypeX on AccountType {
  String get label {
    switch (this) {
      case AccountType.personal:
        return 'Personal';
      case AccountType.company:
        return 'Company';
    }
  }
}

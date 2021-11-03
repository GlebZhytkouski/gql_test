const String readAccounts = r'''
query readAccounts {
  accounts {
    edges {
      node {
        id
        city
        name
      }
    }
  }
}
''';

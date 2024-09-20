int? checkDiscount(String code) {
  switch (code) {
    case 'PROMO99':
      return 9000;
    case 'MOVIEKEREN':
      return 5000;
    default:
      return null;
  }
}

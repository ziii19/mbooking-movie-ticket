String capitalize(String name) {
  return name.split(' ').map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ');
}

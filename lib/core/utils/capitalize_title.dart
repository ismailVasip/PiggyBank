String capitalizeTitle(String title) {
    return title.isNotEmpty
        ? title[0].toUpperCase() + title.substring(1)
        : title;
  }
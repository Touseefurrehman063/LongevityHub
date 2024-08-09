class LiveWellModel {
  String? context;
  String? type;
  String? name;
  CopyrightHolder? copyrightHolder;
  String? license;
  Author? author;
  About? about;
  String? description;
  String? url;
  List<dynamic>? genre;
  String? keywords;
  String? dateModified;
  List<dynamic>? hasPart;
  Breadcrumb? breadcrumb;
  String? headline;
  List<dynamic>? contentSubTypes;
  List<MainEntityOfPage>? mainEntityOfPage;
  String? webpage;

  LiveWellModel(
      {this.context,
      this.type,
      this.name,
      this.copyrightHolder,
      this.license,
      this.author,
      this.about,
      this.description,
      this.url,
      this.genre,
      this.keywords,
      this.dateModified,
      this.hasPart,
      this.breadcrumb,
      this.headline,
      this.contentSubTypes,
      this.mainEntityOfPage,
      this.webpage});

  LiveWellModel.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    name = json['name'];
    copyrightHolder = json['copyrightHolder'] != null
        ? CopyrightHolder.fromJson(json['copyrightHolder'])
        : null;
    license = json['license'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    about = json['about'] != null ? About.fromJson(json['about']) : null;
    description = json['description'];
    url = json['url'];
    if (json['genre'] != null) {
      genre = <dynamic>[];
      json['genre'].forEach((v) {
        genre!.add(v);
      });
    }
    keywords = json['keywords'];
    dateModified = json['dateModified'];
    if (json['hasPart'] != null) {
      hasPart = <dynamic>[];
      json['hasPart'].forEach((v) {
        hasPart!.add(v);
      });
    }
    breadcrumb = json['breadcrumb'] != null
        ? Breadcrumb.fromJson(json['breadcrumb'])
        : null;
    headline = json['headline'];
    if (json['contentSubTypes'] != null) {
      contentSubTypes = <dynamic>[];
      json['contentSubTypes'].forEach((v) {
        contentSubTypes!.add(v);
      });
    }
    if (json['mainEntityOfPage'] != null) {
      mainEntityOfPage = <MainEntityOfPage>[];
      json['mainEntityOfPage'].forEach((v) {
        mainEntityOfPage!.add(MainEntityOfPage.fromJson(v));
      });
    }
    webpage = json['webpage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@context'] = context;
    data['@type'] = type;
    data['name'] = name;
    if (copyrightHolder != null) {
      data['copyrightHolder'] = copyrightHolder!.toJson();
    }
    data['license'] = license;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (about != null) {
      data['about'] = about!.toJson();
    }
    data['description'] = description;
    data['url'] = url;
    if (genre != null) {
      data['genre'] = genre;
    }
    data['keywords'] = keywords;
    data['dateModified'] = dateModified;
    if (hasPart != null) {
      data['hasPart'] = hasPart;
    }
    if (breadcrumb != null) {
      data['breadcrumb'] = breadcrumb!.toJson();
    }
    data['headline'] = headline;
    if (contentSubTypes != null) {
      data['contentSubTypes'] = contentSubTypes;
    }
    if (mainEntityOfPage != null) {
      data['mainEntityOfPage'] =
          mainEntityOfPage!.map((v) => v.toJson()).toList();
    }
    data['webpage'] = webpage;
    return data;
  }
}

class CopyrightHolder {
  String? name;
  String? type;

  CopyrightHolder({this.name, this.type});

  CopyrightHolder.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['@type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['@type'] = type;
    return data;
  }
}

class Author {
  String? url;
  String? logo;
  String? email;
  String? type;
  String? name;

  Author({this.url, this.logo, this.email, this.type, this.name});

  Author.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    logo = json['logo'];
    email = json['email'];
    type = json['@type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['logo'] = logo;
    data['email'] = email;
    data['@type'] = type;
    data['name'] = name;
    return data;
  }
}

class About {
  String? type;
  String? name;
  String? alternateName;

  About({this.type, this.name, this.alternateName});

  About.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    name = json['name'];
    alternateName = json['alternateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['name'] = name;
    data['alternateName'] = alternateName;
    return data;
  }
}

class Breadcrumb {
  String? context;
  String? type;
  List<ItemListElement>? itemListElement;

  Breadcrumb({this.context, this.type, this.itemListElement});

  Breadcrumb.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    if (json['itemListElement'] != null) {
      itemListElement = <ItemListElement>[];
      json['itemListElement'].forEach((v) {
        itemListElement!.add(ItemListElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@context'] = context;
    data['@type'] = type;
    if (itemListElement != null) {
      data['itemListElement'] =
          itemListElement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemListElement {
  String? type;
  int? position;
  Item? item;

  ItemListElement({this.type, this.position, this.item});

  ItemListElement.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    position = json['position'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['position'] = position;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}

class Item {
  String? id;
  String? name;
  List<dynamic>? genre;

  Item({this.id, this.name, this.genre});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['@id'];
    name = json['name'];
    if (json['genre'] != null) {
      genre = <dynamic>[];
      json['genre'].forEach((v) {
        genre!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@id'] = id;
    data['name'] = name;
    if (genre != null) {
      data['genre'] = genre;
    }
    return data;
  }
}

class MainEntityOfPage {
  String? identifier;
  String? type;
  String? name;
  String? headline;
  String? text;
  String? url; // Added url field
  List<MainEntityOfPage>? mainEntityOfPage;

  MainEntityOfPage(
      {this.identifier,
      this.type,
      this.name,
      this.headline,
      this.text,
      this.url, // Added url field
      this.mainEntityOfPage});

  MainEntityOfPage.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    type = json['@type'];
    name = json['name'];
    headline = json['headline'];
    text = json['text'];
    url = json['url']; // Parse url from JSON
    if (json['mainEntityOfPage'] != null) {
      mainEntityOfPage = <MainEntityOfPage>[];
      json['mainEntityOfPage'].forEach((v) {
        mainEntityOfPage!.add(MainEntityOfPage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['@type'] = type;
    data['name'] = name;
    data['headline'] = headline;
    data['text'] = text;
    data['url'] = url; // Convert url to JSON
    if (mainEntityOfPage != null) {
      data['mainEntityOfPage'] =
          mainEntityOfPage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

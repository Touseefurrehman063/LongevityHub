class HealthDetailModel {
  String? context;
  String? type;
  String? name;
  CopyrightHolder? copyrightHolder;
  String? license;
  Author? author;
  About? about;
  String? description;
  String? url;
  List<String>? genre;
  List<String>? keywords;
  String? dateModified;
  List<String>? lastReviewed;
  Breadcrumb? breadcrumb;
  List<HasPart>? hasPart;
  List<RelatedLink>? relatedLink;
  List<String>? contentSubTypes;
  List<MainEntityOfPage>? mainEntityOfPage;
  String? alternativeHeadline;
  String? webpage;
  List<Image>? image;
  HealthDetailModel(
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
      this.lastReviewed,
      this.breadcrumb,
      this.hasPart,
      this.relatedLink,
      this.contentSubTypes,
      this.mainEntityOfPage,
      this.alternativeHeadline,
      this.webpage,
      this.image});
  HealthDetailModel.fromJson(Map<String, dynamic> json) {
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
    genre = json['genre']?.cast<String>();
    keywords = json['keywords']?.cast<String>();
    dateModified = json['dateModified'];
    lastReviewed = json['lastReviewed']?.cast<String>();
    breadcrumb = json['breadcrumb'] != null
        ? Breadcrumb.fromJson(json['breadcrumb'])
        : null;
    if (json['hasPart'] != null) {
      hasPart = <HasPart>[];
      json['hasPart'].forEach((v) {
        hasPart!.add(HasPart.fromJson(v));
      });
    }
    if (json['relatedLink'] != null) {
      relatedLink = <RelatedLink>[];
      json['relatedLink'].forEach((v) {
        relatedLink!.add(RelatedLink.fromJson(v));
      });
    }
    contentSubTypes = json['contentSubTypes']?.cast<String>();
    if (json['mainEntityOfPage'] != null) {
      mainEntityOfPage = <MainEntityOfPage>[];
      json['mainEntityOfPage'].forEach((v) {
        mainEntityOfPage!.add(MainEntityOfPage.fromJson(v));
      });
    }
    alternativeHeadline = json['alternativeHeadline'];
    webpage = json['webpage'];
    if (json['image'] != null) {
      // Added image parsing
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(Image.fromJson(v));
      });
    }
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
    data['genre'] = genre;
    data['keywords'] = keywords;
    data['dateModified'] = dateModified;
    data['lastReviewed'] = lastReviewed;
    if (breadcrumb != null) {
      data['breadcrumb'] = breadcrumb!.toJson();
    }
    if (hasPart != null) {
      data['hasPart'] = hasPart!.map((v) => v.toJson()).toList();
    }
    if (relatedLink != null) {
      data['relatedLink'] = relatedLink!.map((v) => v.toJson()).toList();
    }
    data['contentSubTypes'] = contentSubTypes;
    if (mainEntityOfPage != null) {
      data['mainEntityOfPage'] =
          mainEntityOfPage!.map((v) => v.toJson()).toList();
    }
    data['alternativeHeadline'] = alternativeHeadline;
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
  List<String>? genre;
  Item({this.id, this.name, this.genre});
  Item.fromJson(Map<String, dynamic> json) {
    id = json['@id'];
    name = json['name'];
    genre = json['genre']?.cast<String>();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@id'] = id;
    data['name'] = name;
    data['genre'] = genre;
    return data;
  }
}

class HasPart {
  String? type;
  String? url;
  String? hasHealthAspect;
  String? headline;
  String? description;
  List<HasPart>? hasPart;
  List<Image>? image;
  HasPart(
      {this.type,
      this.url,
      this.hasHealthAspect,
      this.headline,
      this.description,
      this.hasPart,
      this.image});
  HasPart.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    url = json['url'];
    hasHealthAspect = json['hasHealthAspect'];
    headline = json['headline'];
    description = json['description'];
    if (json['hasPart'] != null) {
      hasPart = <HasPart>[];
      json['hasPart'].forEach((v) {
        hasPart!.add(HasPart.fromJson(v));
      });
    }
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(Image.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['url'] = url;
    data['hasHealthAspect'] = hasHealthAspect;
    data['headline'] = headline;
    data['description'] = description;
    if (hasPart != null) {
      data['hasPart'] = hasPart!.map((v) => v.toJson()).toList();
    }
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  String? type;
  String? url;
  Image({this.type, this.url});
  Image.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    url = json['url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['url'] = url;
    return data;
  }
}

class RelatedLink {
  String? url;
  String? text;
  RelatedLink({this.url, this.text});
  RelatedLink.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['text'] = text;
    return data;
  }
}

class MainEntityOfPage {
  int? position;
  String? identifier;
  String? text;
  String? type;
  String? name;
  String? headline;
  String? url;
  String? caption;
  String? provider;
  String? datePublished;
  List<String>? keywords;
  String? credit;
  MainEntityOfPage({
    this.position,
    this.identifier,
    this.text,
    this.type,
    this.name,
    this.headline,
    this.url,
    this.caption,
    this.provider,
    this.datePublished,
    this.keywords,
    this.credit,
  });
  MainEntityOfPage.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    identifier = json['identifier'];
    text = json['text'];
    type = json['@type'];
    name = json['name'];
    headline = json['headline'];
    url = json['url'];
    caption = json['caption'];
    provider = json['provider'];
    datePublished = json['datePublished'];
    keywords =
        json['keywords'] != null ? List<String>.from(json['keywords']) : null;
    credit = json['credit'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['position'] = position;
    data['identifier'] = identifier;
    data['text'] = text;
    data['@type'] = type;
    data['name'] = name;
    data['headline'] = headline;
    data['url'] = url;
    data['caption'] = caption;
    data['provider'] = provider;
    data['datePublished'] = datePublished;
    data['keywords'] = keywords;
    data['credit'] = credit;
    return data;
  }
}

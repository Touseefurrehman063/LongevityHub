import 'dart:convert';

LiveWellDetailModel liveWellDetailModelFromJson(String str) =>
    LiveWellDetailModel.fromJson(json.decode(str));

String liveWellDetailModelToJson(LiveWellDetailModel data) =>
    json.encode(data.toJson());

class LiveWellDetailModel {
  String context;
  String type;
  String name;
  CopyrightHolder copyrightHolder;
  String license;
  Author author;
  About about;
  String description;
  String url;
  List<String> genre;
  String keywords;
  DateTime dateModified;
  List<dynamic> hasPart;
  Breadcrumb breadcrumb;
  String? headline; // Allow headline to be null
  List<dynamic> contentSubTypes;
  List<MainEntityOfPage> mainEntityOfPage;
  String webpage;

  LiveWellDetailModel({
    required this.context,
    required this.type,
    required this.name,
    required this.copyrightHolder,
    required this.license,
    required this.author,
    required this.about,
    required this.description,
    required this.url,
    required this.genre,
    required this.keywords,
    required this.dateModified,
    required this.hasPart,
    required this.breadcrumb,
    this.headline, // Allow headline to be null
    required this.contentSubTypes,
    required this.mainEntityOfPage,
    required this.webpage,
  });

  factory LiveWellDetailModel.fromJson(Map<String, dynamic> json) =>
      LiveWellDetailModel(
        context: json["@context"] ?? '', // Default to empty string if null
        type: json["@type"] ?? '', // Default to empty string if null
        name: json["name"] ?? '', // Default to empty string if null
        copyrightHolder: CopyrightHolder.fromJson(
            json["copyrightHolder"] ?? {}), // Default to empty map if null
        license: json["license"] ?? '', // Default to empty string if null
        author: Author.fromJson(
            json["author"] ?? {}), // Default to empty map if null
        about:
            About.fromJson(json["about"] ?? {}), // Default to empty map if null
        description:
            json["description"] ?? '', // Default to empty string if null
        url: json["url"] ?? '', // Default to empty string if null
        genre: List<String>.from(json["genre"]?.map((x) => x) ??
            []), // Default to empty list if null
        keywords: json["keywords"] ?? '', // Default to empty string if null
        dateModified: DateTime.parse(json["dateModified"] ??
            DateTime.now()
                .toIso8601String()), // Default to current time if null
        hasPart: List<dynamic>.from(json["hasPart"]?.map((x) => x) ??
            []), // Default to empty list if null
        breadcrumb: Breadcrumb.fromJson(
            json["breadcrumb"] ?? {}), // Default to empty map if null
        headline: json["headline"], // Allow null
        contentSubTypes: List<dynamic>.from(
            json["contentSubTypes"]?.map((x) => x) ??
                []), // Default to empty list if null
        mainEntityOfPage: List<MainEntityOfPage>.from(json["mainEntityOfPage"]
                ?.map((x) => MainEntityOfPage.fromJson(x)) ??
            []), // Default to empty list if null
        webpage: json["webpage"] ?? '', // Default to empty string if null
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@type": type,
        "name": name,
        "copyrightHolder": copyrightHolder.toJson(),
        "license": license,
        "author": author.toJson(),
        "about": about.toJson(),
        "description": description,
        "url": url,
        "genre": List<dynamic>.from(genre.map((x) => x)),
        "keywords": keywords,
        "dateModified": dateModified.toIso8601String(),
        "hasPart": List<dynamic>.from(hasPart.map((x) => x)),
        "breadcrumb": breadcrumb.toJson(),
        "headline": headline,
        "contentSubTypes": List<dynamic>.from(contentSubTypes.map((x) => x)),
        "mainEntityOfPage":
            List<dynamic>.from(mainEntityOfPage.map((x) => x.toJson())),
        "webpage": webpage,
      };
}

class About {
  String type;
  String name;
  String alternateName;

  About({
    required this.type,
    required this.name,
    required this.alternateName,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
        type: json["@type"] ?? '', // Default to empty string if null
        name: json["name"] ?? '', // Default to empty string if null
        alternateName:
            json["alternateName"] ?? '', // Default to empty string if null
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
        "name": name,
        "alternateName": alternateName,
      };
}

class Author {
  String url;
  String logo;
  String email;
  String type;
  String name;

  Author({
    required this.url,
    required this.logo,
    required this.email,
    required this.type,
    required this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        url: json["url"] ?? '', // Default to empty string if null
        logo: json["logo"] ?? '', // Default to empty string if null
        email: json["email"] ?? '', // Default to empty string if null
        type: json["@type"] ?? '', // Default to empty string if null
        name: json["name"] ?? '', // Default to empty string if null
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "logo": logo,
        "email": email,
        "@type": type,
        "name": name,
      };
}

class Breadcrumb {
  String context;
  String type;
  List<ItemListElement> itemListElement;

  Breadcrumb({
    required this.context,
    required this.type,
    required this.itemListElement,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
        context: json["@context"] ?? '', // Default to empty string if null
        type: json["@type"] ?? '', // Default to empty string if null
        itemListElement: List<ItemListElement>.from(
            json["itemListElement"]?.map((x) => ItemListElement.fromJson(x)) ??
                []), // Default to empty list if null
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@type": type,
        "itemListElement":
            List<dynamic>.from(itemListElement.map((x) => x.toJson())),
      };
}

class ItemListElement {
  String type;
  int position;
  Item item;

  ItemListElement({
    required this.type,
    required this.position,
    required this.item,
  });

  factory ItemListElement.fromJson(Map<String, dynamic> json) =>
      ItemListElement(
        type: json["@type"] ?? '', // Default to empty string if null
        position: json["position"] ?? 0, // Default to 0 if null
        item: Item.fromJson(json["item"] ?? {}), // Default to empty map if null
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
        "position": position,
        "item": item.toJson(),
      };
}

class Item {
  String id;
  String name;
  List<String> genre;

  Item({
    required this.id,
    required this.name,
    required this.genre,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["@id"] ?? '', // Default to empty string if null
        name: json["name"] ?? '', // Default to empty string if null
        genre: List<String>.from(json["genre"]?.map((x) => x) ??
            []), // Default to empty list if null
      );

  Map<String, dynamic> toJson() => {
        "@id": id,
        "name": name,
        "genre": List<dynamic>.from(genre.map((x) => x)),
      };
}

class CopyrightHolder {
  String name;
  String type;

  CopyrightHolder({
    required this.name,
    required this.type,
  });

  factory CopyrightHolder.fromJson(Map<String, dynamic> json) =>
      CopyrightHolder(
        name: json["name"] ?? '', // Default to empty string if null
        type: json["@type"] ?? '', // Default to empty string if null
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "@type": type,
      };
}

class MainEntityOfPage {
  String identifier;
  String type;
  String name;
  String? headline; // Allow headline to be null
  String? text; // Allow text to be null
  List<MainEntityOfPage>? mainEntityOfPage;
  String? url;

  MainEntityOfPage({
    required this.identifier,
    required this.type,
    required this.name,
    this.headline,
    this.text,
    this.mainEntityOfPage,
    this.url,
  });

  factory MainEntityOfPage.fromJson(Map<String, dynamic> json) =>
      MainEntityOfPage(
        identifier: json["identifier"] ?? '', // Default to empty string if null
        type: json["@type"] ?? '', // Default to empty string if null
        name: json["name"] ?? '', // Default to empty string if null
        headline: json["headline"], // Allow null
        text: json["text"], // Allow null
        mainEntityOfPage: json["mainEntityOfPage"] == null
            ? []
            : List<MainEntityOfPage>.from(json["mainEntityOfPage"]!
                .map((x) => MainEntityOfPage.fromJson(x))),
        url: json["url"], // Allow null
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "@type": type,
        "name": name,
        "headline": headline,
        "text": text,
        "mainEntityOfPage": mainEntityOfPage == null
            ? []
            : List<dynamic>.from(mainEntityOfPage!.map((x) => x.toJson())),
        "url": url,
      };
}

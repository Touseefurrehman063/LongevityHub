// To parse this JSON data, do
//
//     final healthAzModel = healthAzModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

HealthAzModel healthAzModelFromJson(String str) =>
    HealthAzModel.fromJson(json.decode(str));

String healthAzModelToJson(HealthAzModel data) => json.encode(data.toJson());

class HealthAzModel {
  String context;
  HealthAzModelType type;
  String name;
  CopyrightHolder copyrightHolder;
  String license;
  Author author;
  About about;
  String description;
  String url;
  List<dynamic> genre;
  String keywords;
  DateTime dateModified;
  Breadcrumb breadcrumb;
  List<dynamic> contentSubTypes;
  List<SignificantLink> significantLink;
  List<RelatedLink> relatedLink;
  String webpage;

  HealthAzModel({
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
    required this.breadcrumb,
    required this.contentSubTypes,
    required this.significantLink,
    required this.relatedLink,
    required this.webpage,
  });

  factory HealthAzModel.fromJson(Map<String, dynamic> json) {
    return HealthAzModel(
      context: json["@context"] ?? "",
      type: json["@type"] != null
          ? healthAzModelTypeValues.map[json["@type"]] ??
              HealthAzModelType.WEB_PAGE
          : HealthAzModelType.WEB_PAGE,
      name: json["name"] ?? "",
      copyrightHolder: json["copyrightHolder"] != null
          ? CopyrightHolder.fromJson(json["copyrightHolder"])
          : CopyrightHolder(name: "", type: ""),
      license: json["license"] ?? "",
      author: json["author"] != null
          ? Author.fromJson(json["author"])
          : Author(url: "", logo: "", email: "", type: "", name: ""),
      about: json["about"] != null
          ? About.fromJson(json["about"])
          : About(
              type: HealthAzModelType.WEB_PAGE, name: "", alternateName: ""),
      description: json["description"] ?? "",
      url: json["url"] ?? "",
      genre: json["genre"] != null
          ? List<dynamic>.from(json["genre"].map((x) => x))
          : [],
      keywords: json["keywords"] ?? "",
      dateModified: json["dateModified"] != null
          ? DateTime.parse(json["dateModified"])
          : DateTime.now(),
      breadcrumb: json["breadcrumb"] != null
          ? Breadcrumb.fromJson(json["breadcrumb"])
          : Breadcrumb(context: "", type: "", itemListElement: []),
      contentSubTypes: json["contentSubTypes"] != null
          ? List<dynamic>.from(json["contentSubTypes"].map((x) => x))
          : [],
      significantLink: json["significantLink"] != null
          ? List<SignificantLink>.from(
              json["significantLink"].map((x) => SignificantLink.fromJson(x)))
          : [],
      relatedLink: json["relatedLink"] != null
          ? List<RelatedLink>.from(
              json["relatedLink"].map((x) => RelatedLink.fromJson(x)))
          : [],
      webpage: json["webpage"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@type": healthAzModelTypeValues.reverse[type],
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
        "breadcrumb": breadcrumb.toJson(),
        "contentSubTypes": List<dynamic>.from(contentSubTypes.map((x) => x)),
        "significantLink":
            List<dynamic>.from(significantLink.map((x) => x.toJson())),
        "relatedLink": List<dynamic>.from(relatedLink.map((x) => x.toJson())),
        "webpage": webpage,
      };
}

class About {
  HealthAzModelType type;
  String name;
  String alternateName;

  About({
    required this.type,
    required this.name,
    required this.alternateName,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
        type: healthAzModelTypeValues.map[json["@type"]]!,
        name: json["name"],
        alternateName: json["alternateName"],
      );

  Map<String, dynamic> toJson() => {
        "@type": healthAzModelTypeValues.reverse[type],
        "name": name,
        "alternateName": alternateName,
      };
}

enum HealthAzModelType { MEDICAL_WEB_PAGE, WEB_PAGE }

final healthAzModelTypeValues = EnumValues({
  "MedicalWebPage": HealthAzModelType.MEDICAL_WEB_PAGE,
  "WebPage": HealthAzModelType.WEB_PAGE
});

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
        url: json["url"],
        logo: json["logo"],
        email: json["email"],
        type: json["@type"],
        name: json["name"],
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
        context: json["@context"],
        type: json["@type"],
        itemListElement: List<ItemListElement>.from(
            json["itemListElement"].map((x) => ItemListElement.fromJson(x))),
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
        type: json["@type"],
        position: json["position"],
        item: Item.fromJson(json["item"]),
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
  List<dynamic> genre;

  Item({
    required this.id,
    required this.name,
    required this.genre,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["@id"],
        name: json["name"],
        genre: List<dynamic>.from(json["genre"].map((x) => x)),
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
        name: json["name"],
        type: json["@type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "@type": type,
      };
}

class RelatedLink {
  RelatedLinkType type;
  String url;
  String name;
  String description;
  String linkRelationship;

  RelatedLink({
    required this.type,
    required this.url,
    required this.name,
    required this.description,
    required this.linkRelationship,
  });

  factory RelatedLink.fromJson(Map<String, dynamic> json) => RelatedLink(
        type: relatedLinkTypeValues.map[json["@type"]]!,
        url: json["url"],
        name: json["name"],
        description: json["description"],
        linkRelationship: json["linkRelationship"],
      );

  Map<String, dynamic> toJson() => {
        "@type": relatedLinkTypeValues.reverse[type],
        "url": url,
        "name": name,
        "description": description,
        "linkRelationship": linkRelationship,
      };
}

enum RelatedLinkType { LINK_ROLE }

final relatedLinkTypeValues =
    EnumValues({"LinkRole": RelatedLinkType.LINK_ROLE});

class SignificantLink {
  String description;
  LinkRelationship linkRelationship;
  RelatedLinkType type;
  ArticleStatus articleStatus;
  MainEntityOfPage mainEntityOfPage;
  String url;
  String name;

  SignificantLink({
    required this.description,
    required this.linkRelationship,
    required this.type,
    required this.articleStatus,
    required this.mainEntityOfPage,
    required this.url,
    required this.name,
  });

  factory SignificantLink.fromJson(Map<String, dynamic> json) =>
      SignificantLink(
        description: json["description"],
        linkRelationship: linkRelationshipValues.map[json["linkRelationship"]]!,
        type: relatedLinkTypeValues.map[json["@type"]]!,
        articleStatus: articleStatusValues.map[json["articleStatus"]]!,
        mainEntityOfPage: MainEntityOfPage.fromJson(json["mainEntityOfPage"]),
        url: json["url"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "linkRelationship": linkRelationshipValues.reverse[linkRelationship],
        "@type": relatedLinkTypeValues.reverse[type],
        "articleStatus": articleStatusValues.reverse[articleStatus],
        "mainEntityOfPage": mainEntityOfPage.toJson(),
        "url": url,
        "name": name,
      };
}

enum ArticleStatus { PUBLISHED }

final articleStatusValues = EnumValues({"published": ArticleStatus.PUBLISHED});

enum LinkRelationship { RESULT }

final linkRelationshipValues = EnumValues({"Result": LinkRelationship.RESULT});

class MainEntityOfPage {
  HealthAzModelType type;
  List<String> genre;
  DateTime datePublished;
  DateTime dateModified;
  List<DateTime> lastReviewed;
  DateTime reviewDue;
  String keywords;
  List<Code> code;
  List<String>? alternateName;

  MainEntityOfPage({
    required this.type,
    required this.genre,
    required this.datePublished,
    required this.dateModified,
    required this.lastReviewed,
    required this.reviewDue,
    required this.keywords,
    required this.code,
    this.alternateName,
  });

  factory MainEntityOfPage.fromJson(Map<String, dynamic> json) =>
      MainEntityOfPage(
        type: healthAzModelTypeValues.map[json["@type"]]!,
        genre: List<String>.from(json["genre"].map((x) => x)),
        datePublished: DateTime.parse(json["datePublished"]),
        dateModified: DateTime.parse(json["dateModified"]),
        lastReviewed: List<DateTime>.from(
            json["lastReviewed"].map((x) => DateTime.parse(x))),
        reviewDue: DateTime.parse(json["reviewDue"]),
        keywords: json["keywords"],
        code: List<Code>.from(json["code"].map((x) => Code.fromJson(x))),
        alternateName: json["alternateName"] == null
            ? []
            : List<String>.from(json["alternateName"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "@type": healthAzModelTypeValues.reverse[type],
        "genre": List<dynamic>.from(genre.map((x) => x)),
        "datePublished": datePublished.toIso8601String(),
        "dateModified": dateModified.toIso8601String(),
        "lastReviewed":
            List<dynamic>.from(lastReviewed.map((x) => x.toIso8601String())),
        "reviewDue": reviewDue.toIso8601String(),
        "keywords": keywords,
        "code": List<dynamic>.from(code.map((x) => x.toJson())),
        "alternateName": alternateName == null
            ? []
            : List<dynamic>.from(alternateName!.map((x) => x)),
      };
}

class Code {
  CodeType type;
  String codeValue;
  CodingSystem codingSystem;

  Code({
    required this.type,
    required this.codeValue,
    required this.codingSystem,
  });

  factory Code.fromJson(Map<String, dynamic> json) => Code(
        type: codeTypeValues.map[json["@type"]]!,
        codeValue: json["codeValue"],
        codingSystem: codingSystemValues.map[json["codingSystem"]]!,
      );

  Map<String, dynamic> toJson() => {
        "@type": codeTypeValues.reverse[type],
        "codeValue": codeValue,
        "codingSystem": codingSystemValues.reverse[codingSystem],
      };
}

enum CodingSystem { SNOMED_CT }

final codingSystemValues = EnumValues({"SNOMED-CT": CodingSystem.SNOMED_CT});

enum CodeType { MEDICAL_CODE }

final codeTypeValues = EnumValues({"MedicalCode": CodeType.MEDICAL_CODE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

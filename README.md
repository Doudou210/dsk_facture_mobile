# Module de Facturation Mobile – Flutter

Application mobile de facturation permettant de créer des factures dynamiques avec gestion d’articles, calcul automatique des montants et aperçu en temps réel.

## 📱 Fonctionnalités principales

- Formulaire de création de facture :
  - Nom du client
  - Email du client
  - Date de facture
- Gestion dynamique des articles :
  - Ajout / suppression d’articles
  - Description de l’article
  - Quantité (validation numérique)
  - Prix unitaire HT (validation numérique)
  - Calcul automatique du montant total HT par ligne (`quantité × prix unitaire`)
- Calculs automatiques :
  - Total HT
  - TVA (20 %)
  - Total TTC
- Aperçu de la facture en temps réel :
  - Informations client
  - Date de facture
  - Tableau des articles (description, quantité, PU, total HT)
  - Récapitulatif HT / TVA / TTC

## 🎨 UX / UI & Bonus implémentés

- Interface inspirée d’une facture réelle (alignements, espacements, lisibilité)
- Utilisation de `ListView`, `Card`, `Divider`, etc.
- Message conditionnel lorsqu’aucun article n’est ajouté (`"Aucun article ajouté"`)
- **Architecture modulaire** avec composants dédiés :
  - `InvoiceForm` : formulaire principal
  - `ArticleItem` : widget pour une ligne d’article
  - `InvoicePreview` : aperçu de la facture

> 💡 Si tu as aussi fait un thème clair/sombre ou du responsive paysage/portrait, ajoute ici :
> - Thème clair / sombre
> - Affichage optimisé paysage / portrait

## 🧠 Gestion de l’état

- State management simple basé sur :
  - `setState`
  - `List` pour stocker les articles
  - `TextEditingController` pour gérer les champs de saisie
- Recalcul automatique des totaux à chaque :
  - ajout d’article
  - suppression d’article
  - modification de quantité ou de prix unitaire

Les totaux sont recalculés à partir de la liste des articles afin de garantir la cohérence des montants affichés dans le formulaire et dans l’aperçu.

## 🛠️ Stack technique

- **Framework** : Flutter
- **Langage** : Dart
- **Widgets clés** : `Scaffold`, `ListView`, `Card`, `TextField`, `IconButton`, `DatePicker`, `Divider`
- **Gestion des formulaires** : `TextFormField`, validation simple sur les champs numériques

## 📂 Structure du projet (exemple)

```bash
lib/
├─ main.dart
├─ screens/
│  └─ invoice_screen.dart
├─ widgets/
│  ├─ invoice_form.dart
│  ├─ article_item.dart
│  └─ invoice_preview.dart
├─ models/
│  └─ invoice_item.dart
└─ utils/
   └─ formatters.dart

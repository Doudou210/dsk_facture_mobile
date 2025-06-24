import 'package:flutter/material.dart';
import '../models/article.dart';
import 'article_item.dart';

/// Construit le formulaire interactif pour saisir les informations de la facture.
/// Ce widget inclut : nom, email, date, ajout d'articles, et calcul des totaux.
Widget buildFactureForm({
  required BuildContext context,
  required TextEditingController nomController,
  required TextEditingController emailController,
  required DateTime dateFacture,
  required List<Article> articles,
  required VoidCallback onAddArticle,
  required void Function(int index) onDeleteArticle,
  required void Function(int index, Article article) onArticleChanged,
  required void Function(BuildContext) onDateChanged,
}) {
  // Calcul des montants
  final totalHT = articles.fold(0.0, (sum, a) => sum + a.totalHT);
  final tva = totalHT * 0.2;
  final totalTTC = totalHT + tva;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Champ : Nom du client
      TextField(
        controller: nomController,
        decoration: const InputDecoration(labelText: 'Nom du client'),
      ),

      // Champ : Email du client
      TextField(
        controller: emailController,
        decoration: const InputDecoration(labelText: 'Email du client'),
        keyboardType: TextInputType.emailAddress,
      ),

      // Sélecteur de date de facture
      Row(
        children: [
          Text('Date de facture : ${dateFacture.day}/${dateFacture.month}/${dateFacture.year}'),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => onDateChanged(context),
          ),
        ],
      ),

      const SizedBox(height: 16),

      // Titre + bouton pour ajouter un article
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Articles', style: TextStyle(fontWeight: FontWeight.bold)),
          ElevatedButton.icon(
            onPressed: onAddArticle,
            icon: const Icon(Icons.add),
            label: const Text('Ajouter un article'),
          ),
        ],
      ),

      // Liste des articles avec champs modifiables
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ArticleItem(
            article: articles[index],
            onDelete: articles.length > 1 ? () => onDeleteArticle(index) : null,
            onArticleChanged: (article) => onArticleChanged(index, article),
          );
        },
      ),

      const SizedBox(height: 16),
      const Divider(),

      // Affichage des totaux
      Text('Total HT : ${totalHT.toStringAsFixed(2)} €'),
      Text('TVA (20%) : ${tva.toStringAsFixed(2)} €'),
      Text('Total TTC : ${totalTTC.toStringAsFixed(2)} €'),
    ],
  );
}

/// Affiche un aperçu non modifiable de la facture, prêt à être imprimé ou exporté.
Widget buildFacturePreview({
  required TextEditingController nomController,
  required TextEditingController emailController,
  required DateTime dateFacture,
  required List<Article> articles,
}) {
  // Calcul des montants
  final totalHT = articles.fold(0.0, (sum, a) => sum + a.totalHT);
  final tva = totalHT * 0.2;
  final totalTTC = totalHT + tva;

  return Card(
    margin: const EdgeInsets.all(16),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Infos client
          Text('Client: ${nomController.text}'),
          Text('Email: ${emailController.text}'),
          Text('Date: ${dateFacture.day}/${dateFacture.month}/${dateFacture.year}'),

          const SizedBox(height: 16),
          const Text('Articles:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          // Tableau des articles
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3), // Description
              1: FlexColumnWidth(1), // Qté
              2: FlexColumnWidth(2), // Prix unitaire
              3: FlexColumnWidth(2), // Total
            },
            children: [
              // En-tête
              const TableRow(
                children: [
                  Text('Description'),
                  Text('Qté'),
                  Text('Prix HT'),
                  Text('Total HT'),
                ],
              ),

              // Lignes d’articles
              ...articles.map((article) => TableRow(
                children: [
                  Text(article.description),
                  Text(article.quantite.toString()),
                  Text('${article.prixUnitaire.toStringAsFixed(2)} €'),
                  Text('${article.totalHT.toStringAsFixed(2)} €'),
                ],
              )),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(),

          // Totaux
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Total HT: ${totalHT.toStringAsFixed(2)} €'),
                  Text('TVA (20%): ${tva.toStringAsFixed(2)} €'),
                  const SizedBox(height: 8),
                  Text(
                    'Total TTC: ${totalTTC.toStringAsFixed(2)} €',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

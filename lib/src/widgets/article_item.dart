import 'package:dsk_facture_mobile/src/models/article.dart';
import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  final VoidCallback ? onDelete;
  final Function (Article) onArticleChanged;

  const ArticleItem({
    super.key,
    required this.article,
    required this.onArticleChanged,
    this.onDelete,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                article.description = value;
                onArticleChanged(article);
              },
              controller: TextEditingController(text: article.description),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Quantité'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      article.quantite = int.tryParse(value) ?? 1;
                      onArticleChanged(article);
                    },
                    controller: TextEditingController(text: article.quantite.toString()),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Prix unitaire HT'),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      article.prixUnitaire = double.tryParse(value) ?? 0;
                      onArticleChanged(article);
                    },
                    controller: TextEditingController(text: article.prixUnitaire.toString()),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Total HT : ${article.totalHT.toStringAsFixed(2)} €'),
            ),
            if (onDelete != null)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ),
          ],
        ),
      ),
    );
  }
} 
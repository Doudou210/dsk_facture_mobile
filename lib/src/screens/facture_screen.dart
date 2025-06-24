// Import des widgets personnalisés de la facture
import 'package:dsk_facture_mobile/src/widgets/facture_widgets.dart';
// Import des composants Flutter de base
import 'package:flutter/material.dart';
// Import du modèle Article
import '../models/article.dart';

// Écran principal permettant de créer une facture
class FactureScreen extends StatefulWidget {
  const FactureScreen({super.key});

  @override
  State<FactureScreen> createState() => _FactureScreenState();
}

class _FactureScreenState extends State<FactureScreen> {
  // Contrôleurs pour les champs "nom" et "email"
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();

  // Date par défaut de la facture : aujourd’hui
  DateTime _dateFacture = DateTime.now();

  // Liste des articles présents dans la facture (au moins 1 par défaut)
  List<Article> _articles = [Article()];

  // Affiche ou non l’aperçu de la facture
  bool _showPreview = false;

  // Calcul du total HT (hors taxes)
  double get totalHT => _articles.fold(0, (sum, a) => sum + a.totalHT);

  // Calcul de la TVA (20 %)
  double get tva => totalHT * 0.2;

  // Calcul du total TTC (avec taxes)
  double get totalTTC => totalHT + tva;

  // Ajoute un nouvel article vide à la liste
  void _ajouterArticle() {
    setState(() {
      _articles.add(Article());
    });
  }

  // Supprime un article de la liste selon son index
  void _supprimerArticle(int index) {
    setState(() {
      _articles.removeAt(index);
    });
  }

  // Permet de changer la date de la facture via un sélecteur de date
  void _changerDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dateFacture,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _dateFacture = date;
      });
    }
  }

  // Met à jour les données d’un article spécifique dans la liste
  void _updateArticle(int index, Article article) {
    setState(() {
      _articles[index] = article;
    });
  }

  // Construction de l’interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer une facture'),

        // Bouton d’action pour basculer entre formulaire et aperçu
        actions: [
          IconButton(
            icon: Icon(_showPreview ? Icons.edit : Icons.preview),
            onPressed: () {
              setState(() {
                _showPreview = !_showPreview;
              });
            },
          ),
        ],
      ),

      // Contenu principal : soit le formulaire, soit l’aperçu
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _showPreview
            ? buildFacturePreview(
                nomController: _nomController,
                emailController: _emailController,
                dateFacture: _dateFacture,
                articles: _articles,
              )
            : buildFactureForm(
                context: context,
                nomController: _nomController,
                emailController: _emailController,
                dateFacture: _dateFacture,
                articles: _articles,
                onAddArticle: _ajouterArticle,
                onDeleteArticle: _supprimerArticle,
                onArticleChanged: _updateArticle,
                onDateChanged: _changerDate,
              ),
      ),
    );
  }

  // Libération des ressources des TextEditingControllers
  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

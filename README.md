# Carnet d’entretien — MVP Flutter

MVP coloré/convivial pour conducteurs particuliers, avec 3 écrans : Accueil, Ajout véhicule, Ajout entretien.
Stack : Flutter + Firebase (Auth, Firestore, Storage, Messaging).

## Démarrage
1) Installe **Flutter** et **Dart**.
2) `flutter pub get`
3) Configure Firebase (iOS/Android/web selon besoin) via `flutterfire configure` ou manuel.   Remplace `lib/firebase_options.dart` par celui généré.
4) Crée les règles Firestore & Storage depuis `firebase/`.
5) Lance : `flutter run`.

## Fonctionnalités incluses
- Auth anonyme (peut passer à email/Google).
- Ajout de véhicule (photo, marque, modèle, année, km).
- Ajout d’entretien (type, date, km, coût, garage, notes).
- Liste d’entretiens sur l’accueil, prochaine échéance simple.
- Modèles & service Firestore selon le plan technique.
- Placeholders pour FCM, PDF, IAP (à activer v2).

## À faire après clonage
- Connecter Firebase (App iOS/Android + `firebase_options.dart`).
- Activer Authentication (Anonymous au minimum).
- Créer index Cloud Functions (rappels/erase RGPD) si nécessaire.

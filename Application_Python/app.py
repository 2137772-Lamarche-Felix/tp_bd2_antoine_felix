import sys
from PyQt5.QtWidgets import QApplication, QMainWindow
# Importer la classe Ui_MainWindow du fichier MainWindow.py
from bd2_livre_hero import Ui_MainWindow
# sql
import mysql.connector

# Quand c'est Antoine

# mydb = mysql.connector.connect(
#   host="localhost",
#   user="root",
#   password="mysql",
#   database="bddeux_livre_hero"
# )


# Quand c'est félix
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="bddeux_livre_hero"
)


# En paramêtre de la classe MainWindow on va hériter des fonctionnalités
# de QMainWindow et de notre interface Ui_MainWindow
class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self, *args, obj=None, **kwargs):
        super(MainWindow, self).__init__(*args, **kwargs)
        # On va créer la fenêtre avec cette commande
        self.setupUi(self)

        # Loader les combobox de la Window
        self.PeuplerComboBoxNouvellePartieLivre()
        self.PeuplerComboBoxContinuerPartie()

        ### Evenements ################################################
        self.pushButton_NouvellePartie.clicked.connect(self.NouvellePartie)# pushButton_NouvellePartie = NouvellePartie()
        self.pushButton_ContinuerPartieDelete.clicked.connect(self.DeletePartie)# pushButton_ContinuerPartieDelete = DeletePartie()
        self.pushButton_ContinuerPartieLoad.clicked.connect(self.LoadPartie)
        self.lineEdit_SauvegarderNom.returnPressed.connect(self.SauvegarderChapitre)
        self.pushButton_SauvegarderSauvegarderChapitre.clicked.connect(self.SauvegarderChapitre)
        self.pushButton_ChapitreGo.clicked.connect(self.GoToChapitre)
        ### Fin de __init__() ###########################################

    ### Functions ################################################
    def NouvellePartie(self):
        # Clear l'application.
        #ClearApplication()

        # Read le livre choisi.
        idLivreChoisi = self.comboBox_NouvellePartieLivre.currentIndex() + 1

        # Select prologue du livre idLivreChoisi.
        mycursor = mydb.cursor()
        mycursor.execute('SELECT prologue FROM livre WHERE id=%(id_livre)s', {'id_livre' : idLivreChoisi})
        result = mycursor.fetchone()
        textePrologue = result[0]

        # Set le texte dans le widget Chapitre.
        self.textBrowser_ChapitreTexte.clear()
        self.textBrowser_ChapitreTexte.append(textePrologue)

        self.comboBox_ChapitreChapitre.addItem("1")

    def DeletePartie(self):
        # Clear l'application.
        #ClearApplication()

        # Read la Partie choisie.
        idPartieChoisie = self.comboBox_ContinuerPartiePartie.currentIndex() + 1

        mycursor = mydb.cursor()
        mycursor.execute('DELETE FROM sauvegarde WHERE id=%(id_sauvegarde)s', {'id_sauvegarde' : idPartieChoisie})

    def LoadPartie(self):
        # Clear l'application.
        #ClearApplication()

        # Read la Partie choisie.
        idPartieChoisie = self.comboBox_ContinuerPartiePartie.currentIndex + 1

        # Select nom, chapitre de la Sauvegarde.
        mycursor = mydb.cursor()
        mycursor.execute('SELECT nom, chapitre_id, livre_id FROM sauvegarde WHERE id=%(id_sauvegarde)s', {'id_sauvegarde' : idPartieChoisie})
        results = mycursor.fetchone()
        nomSauvegarde = results[0]
        idChapitreRendu = results[1]
        idLivreSauvegarde = results[2]

        # Select texte du Chapitre rendu.
        mycursor = mydb.cursor()
        mycursor.execute('SELECT texte FROM chapitre WHERE chapitre_id=%(id_chapitre)s AND livre_id=%(id_livre)s', {'id_chapitre' : idChapitreRendu, 'id_livre' : idLivreSauvegarde})
        result = mycursor.fetchone()
        texteChapitre = results[0]

        # Set le texte dans le widget Chapitre.
        self.textBrowser_ChapitreTexte.clear()
        self.textBrowser_ChapitreTexte.append(texteChapitre)

        # Set SauvegarderHint
        self.label_SauvegarderHint.text = "Sauvegarde actuelle: " + nomSauvegarde

    def SauvegarderChapitre(self, chapitreActuel):
        # Read le Nom choisi.
        nomSauvegardeChoisi = self.lineEdit_SauvegarderNom.text()

        # Insert un nouvelle Sauvegarde.
        mycursor = mydb.cursor()
        mycursor.execute('INSERT INTO sauvegarde(nom, chapitre_actuel) VALUES (%(nom)s, %(chapitre_actuel)s)', {'nom' : nomSauvegardeChoisi, 'chapitre_actuel' : chapitreActuel})

        # Set SauvegarderHint
        self.label_SauvegarderHint.text = "Sauvegarde actuelle: " + nomSauvegardeChoisi

    def GoToChapitre(self):
        # Read le livre choisi.
        idLivreChoisi = self.comboBox_NouvellePartieLivre.currentIndex() + 1
        # Read le chapitre choisi.
        idChapitreChoisi = self.comboBox_ChapitreChapitre.currentText()

        # Select prologue du livre idLivreChoisi.
        mycursor = mydb.cursor()
        mycursor.execute('SELECT texte FROM chapitre WHERE livre_id=%(id_livre)s AND no_chapitre=%(id_chapitre)s', {'id_livre' : idLivreChoisi, "id_chapitre" : idChapitreChoisi})
        result = mycursor.fetchone()
        texteChapitre = result[0]

        # Set le texte dans le widget Chapitre.
        self.textBrowser_ChapitreTexte.clear()
        self.textBrowser_ChapitreTexte.append(texteChapitre)

        self.PeuplerComboBoxChapitre(idChapitreChoisi)

    def PeuplerComboBoxContinuerPartie(self):
        #select
        mycursor = mydb.cursor()
        mycursor.execute('SELECT nom FROM sauvegarde')
        resultSql = mycursor.fetchall()
        # set comboBox
        for row in resultSql:#foreach row in resultSql:
            self.comboBox_ContinuerPartiePartie.addItem(row[0])#dans la row, va chercher le 'champ 0'.

    def ClearApplication(self):
        # Clear les listes, le chapitre et SauvegarderHint.
        #...
        self.label_SauvegarderHint.text = "Sauvegarde actuelle: [jamais sauvegardé]"
        # Remove la Partie des comboBox.
        #...
    
    def PeuplerComboBoxNouvellePartieLivre(self):
        #select
        mycursor = mydb.cursor()
        mycursor.execute('SELECT nom FROM livre')
        resultSql = mycursor.fetchall()
        # set comboBox
        for row in resultSql:#foreach row in resultSql:
            self.comboBox_NouvellePartieLivre.addItem(row[0])#dans la row, va chercher le 'champ 0'.
    
    def PeuplerComboBoxChapitre(self, no_chapitre_actuel):
        self.comboBox_ChapitreChapitre.clear()
        #select
        mycursor = mydb.cursor()
        mycursor.execute('SELECT no_chapitre_destination FROM lien_chapitre WHERE no_chapitre_source=%(no_chapitre_source)s', {'no_chapitre_source' : no_chapitre_actuel})
        resultSql = mycursor.fetchall()
        # set comboBox
        for row in resultSql:#foreach row in resultSql:
            self.comboBox_ChapitreChapitre.addItem(str(row[0]))#dans la row, va chercher le 'champ 0'.

    ### Fin de MainWindow ###########################################

app = QApplication(sys.argv)

window = MainWindow()
window.show()
app.exec()
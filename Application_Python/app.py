import sys
from PyQt5.QtWidgets import QApplication, QMainWindow
# Importer la classe Ui_MainWindow du fichier MainWindow.py
from bd2_livre_hero import Ui_MainWindow
# sql
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="mysql",
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
        self.livreActuel = idLivreChoisi
        self.chapitreActuel = 0

        # Select prologue du livre idLivreChoisi.
        mycursor = mydb.cursor()
        mycursor.execute('SELECT prologue FROM livre WHERE id=%(id_livre)s', {'id_livre' : idLivreChoisi})
        result = mycursor.fetchone()
        textePrologue = result[0]

        # Set le texte dans le widget Chapitre.
        self.textBrowser_ChapitreTexte.clear()
        self.textBrowser_ChapitreTexte.append(textePrologue)

        self.label_ChapitreTitle.setText("Prologue")
        self.comboBox_ChapitreChapitre.addItem("1")

    def DeletePartie(self):
        # Clear l'application.
        #ClearApplication()

        # Read la Partie choisie.
        idPartieChoisie = self.comboBox_ContinuerPartiePartie.currentData()

        mycursor = mydb.cursor()
        mycursor.execute('DELETE FROM sauvegarde WHERE id=%(id_sauvegarde)s', {'id_sauvegarde' : idPartieChoisie})
        mydb.commit()

        # Clear l'application.
        
        # Refresh ComboBox_Load
        self.PeuplerComboBoxContinuerPartie()
        

    def LoadPartie(self):
        # Clear l'application.
        #ClearApplication()

        # Read la Partie choisie.
        idPartieChoisie = self.comboBox_ContinuerPartiePartie.currentData()

        # Select nom, chapitre de la Sauvegarde.
        mycursor = mydb.cursor()
        mycursor.execute('SELECT nom, no_chapitre_rendu, livre_id FROM sauvegarde WHERE id=%(id_sauvegarde)s', {'id_sauvegarde' : idPartieChoisie})
        results = mycursor.fetchone()
        nomSauvegarde = results[0]
        idChapitreRendu = results[1]
        idLivreSauvegarde = results[2]

        # Select texte du Chapitre rendu.
        mycursor = mydb.cursor()
        mycursor.execute('SELECT texte FROM chapitre WHERE no_chapitre=%(id_chapitre)s AND livre_id=%(id_livre)s', {'id_chapitre' : idChapitreRendu, 'id_livre' : idLivreSauvegarde})
        result = mycursor.fetchone()
        texteChapitre = result[0]

        # Set le texte dans le widget Chapitre.
        self.textBrowser_ChapitreTexte.clear()
        self.textBrowser_ChapitreTexte.append(texteChapitre)
        # Set le title du Chapitre
        self.label_ChapitreTitle.setText("Chapitre " + str(idChapitreRendu))
        # Set SauvegarderHint
        self.label_SauvegarderHint.setText("Sauvegarde actuelle: " + nomSauvegarde)

    def SauvegarderChapitre(self):
        # Read le Nom choisi.
        nomSauvegardeChoisi = self.lineEdit_SauvegarderNom.text()
        if (nomSauvegardeChoisi == ""):
            print("erreur: pas de nom de sauvegarde.")
            return
        elif (not hasattr(self, 'chapitreActuel')):
            print("erreur: pas de partie commencée.")
            return
        elif (self.chapitreActuel == 0):
            print("Erreur: Vous ne pouvez pas sauvegarder la progression au prologue.")
            return
        
        # Insert un nouvelle Sauvegarde.
        mycursor = mydb.cursor()
        mycursor.execute('INSERT INTO sauvegarde(nom, livre_id, no_chapitre_rendu) VALUES (%(nom)s, %(livre_id)s, %(no_chapitre_rendu)s)', {'nom' : nomSauvegardeChoisi, 'livre_id' : self.livreActuel, 'no_chapitre_rendu' : self.chapitreActuel})
        mydb.commit()

        # Set SauvegarderHint
        self.label_SauvegarderHint.setText("Sauvegarde actuelle: " + nomSauvegardeChoisi)
        # Refresh ComboBox_Load
        self.PeuplerComboBoxContinuerPartie()

    def GoToChapitre(self):
        # Read le livre choisi.
        idLivreChoisi = self.comboBox_NouvellePartieLivre.currentIndex() + 1
        # Read le chapitre choisi.
        idChapitreChoisi = self.comboBox_ChapitreChapitre.currentText()
        if (idChapitreChoisi == ""):
            return
        self.chapitreActuel = idChapitreChoisi

        # Select texte du livre idLivreChoisi.
        mycursor = mydb.cursor()
        mycursor.execute('SELECT texte FROM chapitre WHERE livre_id=%(id_livre)s AND no_chapitre=%(id_chapitre)s', {'id_livre' : idLivreChoisi, "id_chapitre" : idChapitreChoisi})
        result = mycursor.fetchone()
        texteChapitre = result[0]

        # Set le texte dans le widget Chapitre.
        self.label_ChapitreTitle.setText("Chapitre " + self.chapitreActuel)
        self.textBrowser_ChapitreTexte.clear()
        self.textBrowser_ChapitreTexte.append(texteChapitre)

        self.PeuplerComboBoxChapitre(idChapitreChoisi)

    def PeuplerComboBoxContinuerPartie(self):
        #select
        mycursor = mydb.cursor()
        mycursor.execute('SELECT nom, id FROM sauvegarde')
        resultSql = mycursor.fetchall()
        # set comboBox
        for row in resultSql:#foreach row in resultSql:
            self.comboBox_ContinuerPartiePartie.addItem(row[0], row[1])#dans la row, va chercher le 'champ 0'.

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
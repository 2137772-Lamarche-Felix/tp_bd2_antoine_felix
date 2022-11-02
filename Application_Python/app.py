import sys
from PyQt5.QtWidgets import QApplication, QMainWindow
# Importer la classe Ui_MainWindow du fichier MainWindow.py
from bd2_livre_hero import Ui_MainWindow

# En paramêtre de la classe MainWindow on va hériter des fonctionnalités
# de QMainWindow et de notre interface Ui_MainWindow
class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self, *args, obj=None, **kwargs):
        super(MainWindow, self).__init__(*args, **kwargs)
        # On va créer la fenêtre avec cette commande
        self.setupUi(self)
        
        ### Evenements ################################################
        self.pushButton_NouvellePartie.clicked.connect(self.NouvellePartie)# pushButton_NouvellePartie = NouvellePartie()
        self.pushButton_ContinuerPartieDelete.clicked.connect(self.DeletePartie)# pushButton_ContinuerPartieDelete = DeletePartie()
        self.pushButton_ContinuerPartieLoad.clicked.connect(self.LoadPartie)
        self.pushButton_SauvegarderSauvegarderChapitre.clicked.connect(self.SauvegarderChapitre)
        self.pushButton_ChapitreGo.clicked.connect(self.GoToChapitre)
        ### Fin de __init__ ###########################################

    ### Functions ################################################


    ### Fin de MainWindow ###########################################

app = QApplication(sys.argv)

window = MainWindow()
window.show()
app.exec()
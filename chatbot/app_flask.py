from flask import Flask

app = Flask(__name__)

MENU_DETAILS = {
    "schabowy": {"sklad": ["kotlet schabowy", "panierka z jajka i bułki tartej", "ziemniaki", "surówka z kapusty kiszonej"], "alergeny": ["gluten", "jaja"]},
    "żeberka": {"sklad": ["żeberka końskie", "marynata miodowo-musztardowa", "frytki"], "alergeny": ["gorczyca"]},
    "sum": {"sklad": ["filet z suma", "masło czosnkowe", "warzywa na parze"], "alergeny": ["ryby", "nabiał"]}
}

if __name__ == '__main__':
    app.run(port=5000, debug=True)
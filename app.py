from flask import Flask, url_for, render_template, session, request, flash, redirect, make_response
from flask_caching import Cache
import json
from datetime import timedelta
from flask_sqlalchemy import SQLAlchemy
import pyodbc
import random


def zippingg(func):
    def wrapper(*args, **kwargs):
        names = [   'Config_Id', 'CPU_Name', 'CPU_Cores', 'CPU_Threads', 'CPU_Multithreading', 'CPU_Integrated_GPU', 'CPU_Unlocked_multiplier', 'CPU_TDP_W', 'Motherboard_Name',
                    'CPU_Radiator_Name', 'CPU_Radiator_TDP_W', 'RAM_Name', 'RAM_Amount', 'RAM_Frequency', 'GPU_Name', 'GPU_RAM', 'GPU_RTX_Support', 'GPU_Series', 'PSU_Name',
                    'PSU_Output_capacity', 'HDD_Name', 'HDD_Size', 'SSD_Name', 'SSD_Type', 'SSD_Size', 'SSD_Read_Speed', 'SSD_Write_Speed', 'CPU_Price',
                    'CPU_Radiator_Price', 'Motherboard_Price', 'RAM_Price', 'GPU_Price', 'PSU_Price', 'HDD_Price', 'SSD_Price', 'Configuration_Price'
                ]

        return dict(zip(names, func(*args, **kwargs)))
    return wrapper    


@zippingg
def exeqution(filling):
    start = 'SELECT TOP 1 * FROM HardWare.dbo.configgg WHERE'
    end = 'ORDER BY Configuration_price'
    
    query = [start, ' '.join(filling), end]
    
    new_one = ' '.join(query)

    print(new_one)

    quu = db.engine.execute(new_one).fetchone()

    querry_data = [item for item in quu]

    return querry_data 


def check_config(check_list):
    gpu = ""
    
    for item in check_list:
        if "GPU_Name" not in item:
            pass
        else:
            if gpu == "":
                gpu = item
            else:
                check_list.pop(check_list.index(gpu))
                gpu = item
    print(check_list)

    ram = ""
    for item in check_list:
        if "RAM_Amount_GB" not in item:
            pass
        else:
            if ram == "":
                ram = item
            else:
                check_list.pop(check_list.index(ram))
                ram = item
    print(check_list)
    return check_list
    





with open("json_data.json", "r", encoding="utf-8") as read_file:
    questions = json.load(read_file)


app = Flask(__name__)

cache = Cache(app, config={'CACHE_TYPE': 'simple'})

app.config['SQLALCHEMY_DATABASE_URI'] = 'mssql+pyodbc://DESKTOP-214NDIH/HardWare?driver=SQL Server?Trusted_Connection=yes' #?driver=SQL Server?Trusted_Connection=yes
db = SQLAlchemy(app)

SQLALCHEMY_TRACK_MODIFICATIONS = False

class Configgg(db.Model):
    Config_Id = db.Column(db.BIGINT, primary_key=True)
    CPU_Name = db.Column(db.NVARCHAR(50), nullable=True)
    CPU_Cores = db.Column(db.Integer, nullable=True)
    CPU_Threads = db.Column(db.Integer, nullable=True)
    CPU_Multithreading = db.Column(db.Boolean, nullable=True)
    CPU_Integrated_GPU = db.Column(db.Boolean, nullable=True)
    CPU_Unlocked_multiplier = db.Column(db.Boolean, nullable=True)
    CPU_TDP_W = db.Column(db.Integer, nullable=True)
    Motherboard_name = db.Column(db.NVARCHAR(100), nullable=True)
    CPU_Radiator_Name = db.Column(db.NVARCHAR(100), nullable=True)
    CPU_Radiator_TDP_W = db.Column(db.Integer, nullable=True)
    Ram_Name = db.Column(db.NVARCHAR(100), nullable=True)
    RAM_Amount_GB = db.Column(db.Integer, nullable=True)
    Ram_Frequency_MHz = db.Column(db.Integer, nullable=True)
    GPU_Name = db.Column(db.NVARCHAR(50), nullable=True)
    GPU_RAM_GB = db.Column(db.Integer, nullable=True)
    GPU_RTX_Support = db.Column(db.Boolean, nullable=True)
    GPU_Series = db.Column(db.NVARCHAR(50), nullable=True)
    PSU_Name = db.Column(db.NVARCHAR(50), nullable=True)
    PSU_Output_capacity_W = db.Column(db.Integer, nullable=True)
    HDD_Name = db.Column(db.NVARCHAR(50), nullable=True)
    HDD_size_GB = db.Column(db.Integer, nullable=True)
    SSD_Name = db.Column(db.NVARCHAR(50), nullable=True)
    SSD_Type = db.Column(db.NVARCHAR(50), nullable=True)
    SSD_Size = db.Column(db.Integer, nullable=True)
    SSD_Read_Speed_MBpS = db.Column(db.Integer, nullable=True)
    SSD_Write_Speed_MBpS = db.Column(db.Integer, nullable=True)
    CPU_Price_UAH = db.Column(db.Integer, nullable=True)
    CPU_Radiator_Price_UAH = db.Column(db.Integer, nullable=True)
    Motherboard_Price_UAH = db.Column(db.Integer, nullable=True)
    RAM_Price_UAH = db.Column(db.Integer, nullable=True)
    GPU_Price_UAH = db.Column(db.Integer, nullable=True)
    PSU_Price_UAH = db.Column(db.Integer, nullable=True)
    HDD_Price_UAH = db.Column(db.Integer, nullable=True)
    SSD_Price_UAH = db.Column(db.Integer, nullable=True)
    Configuration_Price = db.Column(db.Integer, nullable=True)

    def __repr__(self):
        return '<Config %r>' %self.Config_Id





#app.secret_key = "secret_key"
app.secret_key = str(random.randint(0, 100))


app.permanent_session_lifetime = timedelta(days=7)

with app.app_context():
            cache.clear()

answers = []
request_answers = []

passed_questions = []




@app.route('/', methods=['GET', 'POST'])
def index():
    
    if request.method == "GET":
        session.pop("current_question", "1")
        request_answers.clear()
        passed_questions.clear()

        


    if request.method == "POST":

        entered_answer = request.form.get('answer_python', '')
        
        if not entered_answer:
            flash('Ви не вiдповiли на запитання!')
        
        else:
            current_answer = request.form['answer_python']
            
            if  session["current_question"] == "1":
                if current_answer == "Так":
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('GPU_Series = \'Gaming\'') 
                    request_answers.append('AND CPU_Cores >= 6')
                    request_answers.append('AND RAM_Amount_GB >= 8')
                    session["current_question"] = str(int(session["current_question"])+1)

                    if session["current_question"] in questions:
                        redirect(url_for('index'))

                elif current_answer == "Ні":
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    session["current_question"] = str(int(session["current_question"])+7)

                    if session["current_question"] in questions:
                        redirect(url_for('index'))

            elif session["current_question"] == "8":
                if current_answer == "Так":
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('CPU_Cores >= 4') 
                    request_answers.append('AND CPU_Multithreading = 1')
                    request_answers.append('AND RAM_Amount_GB >= 16')
                    request_answers.append('AND CPU_Integrated_GPU = 1') 
                    request_answers.append('AND GPU_Name = \'Integrated\'') 
                    request_answers.append('AND SSD_Size >= 250')

                    result = check_config(request_answers)
                    result = exeqution(result)
                    return render_template("quiz_result.html", final_questions=passed_questions, summary=answers, config_query=request_answers, fin=result)
                else:
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    session["current_question"] = str(int(session["current_question"])+1)

                    if session["current_question"] in questions:
                        redirect(url_for('index'))

            elif  session["current_question"] == "9":
                if current_answer == "Так":
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('CPU_Cores >= 6')
                    request_answers.append('AND RAM_Amount_GB >= 16') 
                    request_answers.append('AND GPU_Series = \'Professional\'') 
                    request_answers.append('AND SSD_Size >= 250') 
                    request_answers.append('AND HDD_Size_GB >= 500')

                    result = check_config(request_answers)
                    result = exeqution(result)
                    return render_template("quiz_result.html", final_questions=passed_questions, summary=answers, config_query=request_answers, fin=result)
                
                else:
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('CPU_Cores >= 4') 
                    request_answers.append('AND RAM_Amount_GB >= 4') 
                    request_answers.append('AND CPU_Integrated_GPU = 1') 
                    request_answers.append('AND GPU_Name = \'Integrated\'') 
                    request_answers.append('AND HDD_Size_GB >= 320')
                    result = check_config(request_answers)
                    result = exeqution(result)
                    return render_template("quiz_result.html", final_questions=passed_questions, summary=answers, config_query=request_answers, fin=result)

            elif session["current_question"] == "2":
                if current_answer == "Високі":
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('AND GPU_Ram_GB >= 6')
                    request_answers.append('AND GPU_Name LIKE \'%70%\'') 
                    request_answers.append('AND RAM_Amount_GB >= 16')
                    session["current_question"] = str(int(session["current_question"])+1)

                    if session["current_question"] in questions:
                        redirect(url_for('index'))
                else:
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('AND HDD_size_GB >= 320')
                    result = check_config(request_answers)
                    result = exeqution(result)
                    return render_template("quiz_result.html", final_questions=passed_questions, summary=answers, config_query=request_answers, fin=result)

            elif session["current_question"] == "3":
                if current_answer == "FullHD та нижче":
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    session["current_question"] = str(int(session["current_question"])+2)

                    if session["current_question"] in questions:
                        redirect(url_for('index'))
                else:
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    session["current_question"] = str(int(session["current_question"])+1)

                    if session["current_question"] in questions:
                        redirect(url_for('index'))

            elif session["current_question"] == "5":

                if current_answer == "Так":
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('AND SSD_Size >= 120') 
                    request_answers.append('AND HDD_Size_GB >= 320')
                    result = check_config(request_answers)
                    result = exeqution(result)
                    return render_template("quiz_result.html", final_questions=passed_questions, summary=answers, config_query=request_answers, fin=result)
                
                else:
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('AND HDD_Size_GB >= 320')
                    result = check_config(request_answers)
                    result = exeqution(result)
                    return render_template("quiz_result.html", final_questions=passed_questions, summary=answers, config_query=request_answers, fin=result)
            
            elif session["current_question"] == "4":
                if current_answer == "Ні":
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('AND SSD_Size >= 250') 
                    request_answers.append('AND HDD_Size_GB >= 320')
                    result = check_config(request_answers)
                    result = exeqution(result)
                    return render_template("quiz_result.html", final_questions=passed_questions, summary=answers, config_query=request_answers, fin=result)
                else:
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('AND CPU_Multithreading = 1')
                    request_answers.append('AND GPU_Name LIKE \'%80%\'')
                    session["current_question"] = str(int(session["current_question"])+2)

                    if session["current_question"] in questions:
                        redirect(url_for('index'))

            elif session["current_question"] == "6":
                if current_answer == "Ні":
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('AND CPU_Unlocked_multiplier = 0')
                    request_answers.append('AND SSD_Size >= 250') 
                    request_answers.append('AND HDD_Size_GB >= 320')
                    result = check_config(request_answers)
                    result = exeqution(result)
                    return render_template("quiz_result.html", final_questions=passed_questions, summary=answers, config_query=request_answers, fin=result)
                else:
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('AND CPU_Unlocked_multiplier = 1')
                    session["current_question"] = str(int(session["current_question"])+1)

                    if session["current_question"] in questions:
                        redirect(url_for('index'))
            
            elif session["current_question"] == "7":
                if current_answer == "Так":
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('AND SSD_Size >= 250')
                    request_answers.append('AND HDD_Size_GB >= 1000')
                    result = check_config(request_answers)
                    result = exeqution(result)
                    return render_template("quiz_result.html", final_questions=passed_questions, summary=answers, config_query=request_answers, fin=result)
                else:
                    passed_questions.append(questions[session["current_question"]]["question"])
                    answers.append(current_answer)
                    request_answers.append('AND SSD_Size >= 250') 
                    request_answers.append('AND HDD_Size_GB >= 320')
                    result = check_config(request_answers)
                    result = exeqution(result)
                    return render_template("quiz_result.html", final_questions=passed_questions, summary=answers, config_query=request_answers, fin=result)

            

                    
                


    if 'current_question' not in session:
        session["current_question"] = "1"


    elif session["current_question"] not in session:
        pass
        


    current_question = questions[session["current_question"]]["question"]
    a1, a2 = questions[session["current_question"]]["answers"]
    description = questions[session["current_question"]]["description"]

    return render_template('index.html', current_question=current_question, ans1=a1, ans2=a2, description=description)

    
@app.route('/check', methods=['GET', 'POST'])
def check():

    if request.method == 'POST':
        
        
        '''
        query.extend(request_answers)

        new_one = ' '.join(query)
        exequted = db.engine.execute(new_one)
        #final_config = [part for part in exequted]
        '''
        
        result = check_config(request_answers)
        result = exeqution(result)

        print(result)
        
        return render_template('quiz_result.html',
                                final_questions=passed_questions, 
                                summary=answers, 
                                config_query=request_answers,  
                                fin=result
                                )

        
    


@app.route('/front', methods=['GET', 'POST'])
def new_build():
    if request.method == 'POST':
        return render_template('/')
    
    return render_template('start_page.html')





if __name__ == '__main__':
    app.run(debug=True)
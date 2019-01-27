import pymongo

client = pymongo.MongoClient("mongodb://tamuhack:tamuhack@cluster0-shard-00-00-stavr.gcp.mongodb.net:27017,cluster0-shard-00-01-stavr.gcp.mongodb.net:27017,cluster0-shard-00-02-stavr.gcp.mongodb.net:27017/test?ssl=true&replicaSet=Cluster0-shard-0&authSource=admin&retryWrites=true")
db = client["tamuhack"]
mycollection = db["tamuhack"]

import smtplib
import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BOARD)
GPIO.setup(8,GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(10,GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(12,GPIO.IN, pull_up_down=GPIO.PUD_UP)

state = [100,100,100]

while True:

        uid = 'smartfridge0000@gmail.com'
        pwd = 'tamuHACK0000'

        subject ='fridge data'
        if GPIO.input(8)==False:
            state[0] = state[0] - 10
            header = 'To: ' + uid + '\n' + 'From: ' + uid + '\n' + 'Subject: '+ str(state[0])
            s = smtplib.SMTP('smtp.gmail.com', 587)
            s.ehlo()
            s.starttls()
            s.login(uid, pwd)
            s.sendmail(uid,uid,header + '\n' +str(state[0]))
            s.quit()
            print('Email sent!')
            mydict = {"id":"data","id2":"apple", "value": str(state[0])}
            db.smartfridge.update({"id": "data", "id2":"apple"},mydict, upsert= True)
            if state[0]==0:
                state[0]=100
                mydict = {"id":"data","id2":"apple", "value": str(state[0])}
                db.smartfridge.update({"id": "data", "id2":"apple"},mydict, upsert= True)
        if GPIO.input(10)==False:
            state[1] = state[1] - 10
            header = 'To: ' + uid + '\n' + 'From: ' + uid + '\n' + 'Subject: '+ str(state[1])
            s = smtplib.SMTP('smtp.gmail.com', 587)
            s.ehlo()
            s.starttls()
            s.login(uid, pwd)
            s.sendmail(uid,uid,header + '\n' +str(state[1]))
            s.quit()
            print('Email sent!')
            mydict = {"id":"data","id2":"banana", "value": str(state[1])}
            db.smartfridge.update({"id": "data","id2":"banana"},mydict, upsert= True)
            if state[1]==0:
                state[1]=100
                mydict = {"id":"data","id2":"banana", "value": str(state[1])}
                db.smartfridge.update({"id": "data","id2":"banana"},mydict, upsert= True)
        if GPIO.input(12)==False:
            state[2] = state[2] - 10
            header = 'To: ' + uid + '\n' + 'From: ' + uid + '\n' + 'Subject: '+ str(state[2])
            s = smtplib.SMTP('smtp.gmail.com', 587)
            s.ehlo()
            s.starttls()
            s.login(uid, pwd)
            s.sendmail(uid,uid,header + '\n' +str(state[2]))
            s.quit()
            print('Email sent!')
            mydict = {"id":"data","id2":"mango", "value": str(state[2])}
            db.smartfridge.update({"id": "data","id2":"mango"},mydict, upsert= True)
            if state[1]==0:
                state[1]=100
                mydict = {"id":"data","id2":"mango", "value": str(state[2])}
                db.smartfridge.update({"id": "data","id2":"mango"},mydict, upsert= True)




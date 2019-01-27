import smtplib
import imaplib
import email

while True:
    obj = imaplib.IMAP4_SSL('imap.gmail.com', 993)
    obj.login('smartfridge0000@gmail.com', 'tamuHACK0000')
    obj.select('inbox')
    type, data = obj.search(None, 'all')
    num = data[0].split()[-1]
    #for num in data[0].split():
    type2, data2 = obj.fetch(num, '(RFC822)' )
    msg2 = email.message_from_bytes(data2[0][1])
    print(msg2['Subject'])
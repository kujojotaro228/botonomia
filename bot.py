import telebot
from telebot import types

home_work = '0'
bot = telebot.TeleBot('1018335187:AAEiqQblGcb8h6cs_vNgKj9hT5aWJyKuhf0')


@bot.message_handler(commands=['start'])
def start(message):
    bot.send_message(message.chat.id, home_work, parse_mode='html')


@bot.message_handler(commands=['write'])
def write(message):
    bot.send_message(message.chat.id, 'введите дз', parse_mode='html')
    bot.register_next_step_handler(message, reg_home)


def reg_home(message):
    global home_work
    home_work = message.text
    bot.send_message(message.chat.id, 'принято', parse_mode='html')


bot.polling(none_stop=True)

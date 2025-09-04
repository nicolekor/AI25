import tkinter as tk
import tkinter.messagebox as msgbox
import sys
import os


def resource_path(relative_path):
    """ Get absolute path to resource, works for dev and for PyInstaller """
    try:
        # PyInstaller creates a temp folder and stores path in _MEIPASS
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.abspath(".")
    return os.path.join(base_path, relative_path)


def click_button():
    msgbox.showinfo("알림", "버튼을 클릭했습니다.")


root = tk.Tk()
img = tk.PhotoImage(file=resource_path("images/back.gif"))
button = tk.Button(root, image=img, command=click_button)
button.pack()

root.mainloop()
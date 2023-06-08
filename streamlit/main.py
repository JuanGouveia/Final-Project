import streamlit as st
import pandas as pd
from PIL import Image
#import pylab as plt
import webbrowser
import base64
import io



circuits = pd.read_csv('clean_data/circuits_clean.csv')



st.sidebar.image(Image.open('images/formula_one.png'))


def show_home():
    st.title('Formula One Data Visualization')

def show_calendar():
    st.title('Calendar')

def show_races():
    st.title('Races')


sel_page = st.sidebar.radio('Information', ('Home', 'Calendar', 'Races'))

if sel_page == 'Home':
    show_home()

elif sel_page == 'Calendar':
    show_calendar()

elif sel_page == 'Races':
    show_races()
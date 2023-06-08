import streamlit as st
import pandas as pd
from PIL import Image
#import pylab as plt
import webbrowser
import base64
import io


st.set_page_config(page_title='F1 Race Record', page_icon='🏎️', layout='wide', initial_sidebar_state='expanded')


st.sidebar.image(Image.open('images/formula_one.png'))

def show_home():
    st.title('Formula One Race Record')
    st.subheader('¡Welcome to Formula One Race Record!')
    st.write('---')
    st.write('')
    st.write('- Explore the race history and calendar of Formula 1')
    st.write('- Our project offers detailed visualizations of past races, as well as information about the dates and locations of upcoming races.')
    st.write('- Discover interesting statistics, such as the most successful drivers and iconic circuits in the history of Formula 1.')
    st.write('- With this project, you can dive into the exciting world of Formula 1 and learn more about its legacy and current competitions.')


calendar = pd.read_csv('streamlit_data/calendar.csv')
calendar = calendar.sort_values('year', ascending=False)

def show_calendar():
    st.title('Calendar')
    st.write('---')
    st.write('')

    years = calendar['year'].unique()

    selected_year = st.selectbox('**Seasons**', years)

    filtered_calendar = calendar[calendar['year'] == selected_year].sort_values('Round', ascending=True)

    hide_table_row_index = """
                <style>
                thead tr th:first-child {display:none}
                tbody th {display:none}
                </style>
                """

    st.markdown(hide_table_row_index, unsafe_allow_html=True)

    st.table(filtered_calendar[['Round', 'Race', 'Date', 'Circuit', 'Location']])


def show_races():
    st.title('Races')
    st.write('---')
    st.write('')




sel_page = st.sidebar.radio('Information', ('Home', 'Calendar', 'Races'))

if sel_page == 'Home':
    show_home()

elif sel_page == 'Calendar':
    show_calendar()

elif sel_page == 'Races':
    show_races()
import streamlit as st
import pandas as pd
import numpy as np
from PIL import Image


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

    if st.button('Submit'):
        filtered_calendar = calendar[calendar['year'] == selected_year].sort_values('Round', ascending=True)

        hide_table_row_index = '''
                    <style>
                    thead tr th:first-child {display:none}
                    tbody th {display:none}
                    </style>
                    '''

        st.markdown(hide_table_row_index, unsafe_allow_html=True)

        st.table(filtered_calendar[['Round', 'Race', 'Date', 'Circuit', 'Location']])


races = pd.read_csv('streamlit_data/races.csv')
races = races.sort_values('Seasons', ascending=False)

def show_races():
    st.title('Races')
    st.write('---')
    st.write('')

    
    seasons = races['Seasons'].unique()

    selected_season = st.selectbox('Seasons', seasons)
    
    filtered_races = races.loc[races['Seasons'] == selected_season].sort_values('Round')['Races'].unique()

    selected_race = st.selectbox('Races', filtered_races)
    

    if st.button('Submit'):
        selected_circuit = races[(races['Seasons'] == selected_season) & (races['Races'] == selected_race)]['Circuit'].values[0]
        
        selected_location = races[(races['Seasons'] == selected_season) & (races['Races'] == selected_race)]['Location'].values[0]

        pole_sitter = races[(races['Seasons'] == selected_season) & (races['Races'] == selected_race) & (races['Grid Position'] == 1)]['Driver'].values[0]

        pole_time = races[(races['Seasons'] == selected_season) & (races['Races'] == selected_race) & (races['Grid Position'] == 1)]['Q3'].values[0]

        race_winner = races[(races['Seasons'] == selected_season) & (races['Races'] == selected_race) & (races['Position'] == 1)]['Driver'].values[0]

        race_time = races[(races['Seasons'] == selected_season) & (races['Races'] == selected_race) & (races['Position'] == 1)]['Time'].values[0]
        

        col1, col2, col3 = st.columns(3)
        
        with col1:
            st.subheader('Circuit')
            st.write(selected_circuit)
            st.write(f'Location: {selected_location}')
        
        with col2:
            st.subheader('Pole Sitter')
            st.write(pole_sitter)
            st.write(f'Pole time: {pole_time}')
        
        with col3:
            st.subheader('Race Winner')
            st.write(race_winner)
            st.write(f'Total time: {race_time}')


        st.write('')
        st.write('---')
        st.title('Qualification results')
        st.write('---')
        st.write('')

        filtered_details = races[(races['Seasons'] == selected_season) & (races['Races'] == selected_race)][['Grid Position', 'Driver', 'Driver Number', 'Team', 'Q1', 'Q2', 'Q3']]
        filtered_details = filtered_details.sort_values('Grid Position', ascending=True)
        
        hide_table_row_index = '''
                    <style>
                    thead tr th:first-child {display:none}
                    tbody th {display:none}
                    </style>
                    '''

        st.markdown(hide_table_row_index, unsafe_allow_html=True)

        st.table(filtered_details)


        st.write('')
        st.write('---')
        st.title('Race results')
        st.write('---')
        st.write('')

        filtered_results = races[(races['Seasons'] == selected_season) & (races['Races'] == selected_race)][['Position', 'Driver', 'Driver Number', 'Grid Position', 'Team', 'Status', 'Time']]
        filtered_results = filtered_results.sort_values('Position', ascending=True)

        hide_table_row_index = """
                    <style>
                    thead tr th:first-child {display:none}
                    tbody th {display:none}
                    </style>
                    """

        st.markdown(hide_table_row_index, unsafe_allow_html=True)

        st.table(filtered_results)


sel_page = st.sidebar.radio('**Information**', ('Home', 'Calendar', 'Races'))

if sel_page == 'Home':
    show_home()

elif sel_page == 'Calendar':
    show_calendar()

elif sel_page == 'Races':
    show_races()
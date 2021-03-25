import spotipy
from spotipy.oauth2 import SpotifyOAuth

scope = 'user-top-read'

auth = spotipy.Spotify(auth_manager=SpotifyOAuth(scope=scope))

ranges = ['short_term', 'medium_term', 'long_term']

for sp_tracks in ranges:
    print("range:", sp_tracks)
    results = auth.current_user_top_tracks(time_range=sp_tracks, limit=10)
    for i, item in enumerate(results['items']):
        print(i, item['name'], '||', item['artists'][0]['name'])
    print()

for sp_artists in ranges:
    print("top artists:", sp_artists)
    results = auth.current_user_top_artists(time_range=sp_artists, limit=10)
    for i, item in enumerate(results['items']):
        print(i, item['name'])
    print()
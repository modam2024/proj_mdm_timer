import datetime

import pytz
from waitress import serve

from proj_mdm_timer.wsgi import application

print("Django Server Started")

try:
    serve(application, host='0.0.0.0', port=8003)
except Exception as e:
    print("Server Error : ", e)

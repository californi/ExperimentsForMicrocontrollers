import os
import datetime

try:
    arr = os.listdir('./')
    for fileName in arr:
        print("Reading file: " + fileName)

        dtEvent = datetime.datetime.now()
        initialTime = dtEvent.strftime("%Y%m%d_%H%M%S")   
        
        if fileName.endswith(".log"):
            pass

except:
    pass

finally:
    pass
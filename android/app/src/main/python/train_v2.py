from architecture import * 
import cv2
import numpy as np 
from sklearn.preprocessing import Normalizer
from face_detection import RetinaFace
import os
import base64
# print("===========================------", os.getcwd())
# files = os.listdir()
# print("------------------------------------------------------:   ", files)
# for dir in os.listdir():
#     try:
#
#         if os.path.isdir(dir) and dir != 'efs' and dir != 'factory':
#             print("================================================================================================= ", os.listdir(dir) )
#
#             for dir2 in os.listdir(dir):
#                 if os.path.isdir(dir2):
#                     print("+++++++++++++++++++++++++======-----------------: ",os.listdir(os.path.join(dir, dir2)))
#     except:
#         pass

#print("=======----------------------------------------------", os.listdir())
import database as db
import uuid
v = db.create
import os
package_file = os.path.abspath(os.path.dirname(__file__))
######pathsandvairables#########

required_shape = (160,160)
face_encoder = InceptionResNetV2()
path = "facenet_keras_weights.h5"
face_encoder.load_weights(os.path.join(package_file, path))
encodes = []
l2_normalizer = Normalizer('l2')
###############################
face_detector = RetinaFace()
def change_box_value(bbox):
    
    return int(bbox[0]), int(bbox[1]), int(bbox[2] - bbox[0]), int(bbox[3] - bbox[1])

def normalize(img):
    mean, std = img.mean(), img.std()
    return (img - mean) / std

def get_econding(path_list):

    try:

        for image_path in path_list:
            

            #img_BGR = cv2.imread(image_path)
            img_RGB = base64_to_image(image_path)
            img_RGB = cv2.cvtColor(img_RGB, cv2.COLOR_BGR2RGB)

            #x = face_detector.detect_faces(img_RGB)
            x = face_detector(img_RGB)
            x1, y1, width, height = change_box_value(x[0][0])
            x1, y1 = abs(x1) , abs(y1)
            x2, y2 = x1+width , y1+height
            face = img_RGB[y1:y2 , x1:x2]
            
            face = normalize(face)
            face = cv2.resize(face, required_shape)
            face_d = np.expand_dims(face, axis=0)
            encode = face_encoder.predict(face_d)[0]
            encodes.append(encode)

        if encodes:
            encode = np.sum(encodes, axis=0 )
            encode = l2_normalizer.transform(np.expand_dims(encode, axis=0))[0]
            return encode
        return None
    except Exception as e:
        print("issue in training: ", e)
        return None
    
def image_to_bytes(image_path):
    rr = base64.b64decode(image_path)
    bytes_re = rr.decode('ascii')
    return bytes_re


# Function to convert bytes to image

def base64_to_image(image_bytes):
    rr = base64.b64decode(image_bytes)
    nparr = np.frombuffer(rr, np.uint8)
    array = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    return cv2.cvtColor(array, cv2.COLOR_BGR2RGB)


def update_train(data):

    print("------------===============----------------========--------------", data)
    print("======-00---------------------", type(data))
    #try:
    data = eval(data)
    uu_id = str(uuid.uuid4())
    ref_no_exists = db.check_ref_no_exists(data["ref"])
    print("||||||||||||||||||||||||||||||||||||||||||||||||||||=============------------")
    if ref_no_exists:
        return "ref_no already exists in the Database."
    else:
        image_encodes = get_econding(data["images"])
        image_bytes = data["images"][0]#image_to_bytes(data["path"][0])
        print("||||||||||||||||||||||||||||||||||||||||||||||||||||=============aaaaaaaaaaaaaaa")
        status = db.insert_data(uu_id, data["name"], data["ref"], data["summary"], image_bytes, image_encodes)
        print("||||||||||||||||||||||||||||||||||||||||||||||||||||------------bbbbbbbbbbbbbbbbb",status)
        return status
    # except Exception as e:
    #     return "issue in train" + e
    






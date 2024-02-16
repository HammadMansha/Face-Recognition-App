import cv2
import numpy as np
from architecture import InceptionResNetV2
from scipy.spatial.distance import cosine
from sklearn.preprocessing import Normalizer
from face_detection import RetinaFace
import database as db
import base64
import os
package_file = os.path.abspath(os.path.dirname(__file__))



l2_normalizer = Normalizer('l2')
def normalize(img):
    mean, std = img.mean(), img.std()
    return (img - mean) / std

confidence_t = 0.97
recognition_t = 0.50
required_size = (160, 160)

#face_detector = mtcnn.MTCNN()
face_encoder = InceptionResNetV2()
encoding_dict = {}

def get_face(img, box):
    x1, y1, width, height = box
    x1, y1 = abs(x1), abs(y1)
    x2, y2 = x1 + width, y1 + height
    face = img[y1:y2, x1:x2]
    return face, (x1, y1), (x2, y2)

def get_encode(face_encoder, face, size):
    face = normalize(face)
    face = cv2.resize(face, size)
    encode = face_encoder.predict(np.expand_dims(face, axis=0))[0]
    return encode

def load_pickle(path):
    with open(path, 'rb') as f:
        encoding_dict = pickle.load(f)
    return encoding_dict

def change_box_value(bbox):
    
    return [int(bbox[0]), int(bbox[1]), int(bbox[2] - bbox[0]), int(bbox[3] - bbox[1])]

def detect(image_bytes, detector, encoder, data_enconding_list):
    face_matching = []
    img = base64_to_image(image_bytes)
    img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    #results = detector.detect_faces(img_rgb)
    results = detector(img_rgb)
    print("---------------------------------------$$$$$$$$$$$$$$$-------------", results )
    for res in results:
        #print(res)

        if res[2] < confidence_t:
            continue
        bbox = change_box_value(res[0])
        face, pt_1, pt_2 = get_face(img_rgb, bbox)
        #face, pt_1, pt_2 = get_face(img_rgb, res['box'])
        encode = get_encode(encoder, face, required_size)
        encode = l2_normalizer.transform(encode.reshape(1, -1))[0]
        name = 'unknown'

        distance = float("inf")
        #print("-----------------===========$$$$$$$$$$$$$$$$$$$4===========----------------------", data_enconding_list)
        for result in data_enconding_list:
            
            min_dic = dict()
            #result_image_encodes = np.frombuffer(result[5], dtype=np.float32)
            dist = cosine(result[5], encode)
            print("==========--------------------=-=-=-=-=-=============------------", dist)
            if dist < recognition_t:
                min_dic['name'] = result[1]
                min_dic['ref_no'] = result[2]
                min_dic['Summary'] = result[3]
                min_dic['image_bytes'] = result[4]
                face_matching.append(min_dic)
                name = result[1]


                distance = dist
        #print(face_matching)
        if name == 'unknown':
            cv2.rectangle(img, pt_1, pt_2, (0, 0, 255), 2)
            cv2.putText(img, name, pt_1, cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 1)
        else:
            cv2.rectangle(img, pt_1, pt_2, (0, 255, 0), 2)
            cv2.putText(img, name + f'__{distance:.2f}', (pt_1[0], pt_1[1] - 5), cv2.FONT_HERSHEY_SIMPLEX, 1,
                        (0, 200, 200), 2)
    return image_to_bytes(img),  face_matching
def image_to_bytes(image):
    #image = cv2.imread(image_path)

    return base64.b64encode(image.tobytes())

# Function to convert bytes to image
def bytes_to_image(image_bytes):
    nparr = np.frombuffer(image_bytes, np.uint8)
    array = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    return cv2.imdecode(nparr, cv2.IMREAD_COLOR)
def base64_to_image(image_bytes):
    rr = base64.b64decode(image_bytes)
    nparr = np.frombuffer(rr, np.uint8)
    array = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    return cv2.cvtColor(array, cv2.COLOR_BGR2RGB)

def data_setting(data):
    data_final = []
    for re in data:
        result_image_encodes = np.frombuffer(re[5], dtype=np.float32)
        data_final.append((re[0], re[1], re[2], re[3], re[4], result_image_encodes))
    return data_final

face_encoder = InceptionResNetV2()
path_m = "facenet_keras_weights.h5"
face_encoder.load_weights(os.path.join(package_file, path_m))

#face_detector = mtcnn.MTCNN()
face_detector = RetinaFace()
def search_faces(frame):

    #images_bytes = image_to_bytes(frame)
    datas_s  = db.get_all_data()
    datas = data_setting(datas_s)
    #print("33333333333=--------------------------", datas)
    required_shape = (160, 160)
    
    return detect(frame, face_detector, face_encoder, datas)





# if __name__ == "__main__":
#     # required_shape = (160, 160)
#     # face_encoder = InceptionResNetV2()
#     # path_m = "facenet_keras_weights.h5"
#     # face_encoder.load_weights(path_m)
#     # encodings_path = 'encodings/encodings.pkl'
#     # #face_detector = mtcnn.MTCNN()
#     # face_detector = RetinaFace()
#     # encoding_dict = load_pickle(encodings_path)
#
#     cap = cv2.VideoCapture(0)
#
#     while cap.isOpened():
#         ret, frame = cap.read()
#
#         if not ret:
#             print("CAM NOT OPENED")
#             break
#
#         frame = search_faces(frame) #detect(frame, face_detector, face_encoder, encoding_dict)
#
#         cv2.imshow('camera', frame)
#
#         if cv2.waitKey(1) & 0xFF == ord('q'):
#             break


## DigiDoc
The app is a disease prediction and doctor search tool that helps patients identify their health issues and find appropriate medical help nearby. Patients can input their symptoms using a text input field with autocomplete or suggestion functionality, and the app uses machine learning algorithms to provide a list of potential diseases. The app also suggests doctors located nearby based on the patient's location and helps them schedule an appointment with the doctor. Doctors can also register their location, specialty, and availability in the app, making it easier for patients to find them. The app provides an intuitive and user-friendly interface to help patients manage their health and get the care they need.

## Problem Statement
The increasing burden of disease and the need for prompt and accurate diagnosis is a major concern in the healthcare industry. With the rapid advancements in technology, there is a growing need for a mobile application that can help patients diagnose their symptoms and find a suitable doctor in their vicinity. The current system of seeking medical advice often involves visiting multiple doctors, waiting in long queues, and facing limitations in terms of time and availability.

Therefore, there is a need for an application that can provide a comprehensive and personalized solution to the patient's health problems. The app should be able to predict the disease of a patient based on their symptoms and provide suggestions for the most suitable doctor nearby. The app should be user-friendly and accessible to all, regardless of their location or technical expertise. It should also be able to provide accurate and up-to-date information to the users, and help bridge the gap between patients and healthcare providers.

## Tech Stack :paperclip:

The app uses a variety of technologies to provide a seamless and efficient user experience. Here are some of the technologies used in this app:

* Flutter: Flutter is a cross-platform development framework and because of the fact that flutter is very good for rapid prototyping we decided to use it for development of our application.

* Firebase: Firebase is a cloud-based backend service provided by Google that offers various features, including authentication, database, hosting, and storage. The app uses Firebase to store and manage user data, including doctor and patient information and most importantly storing their geo location.

* Machine Learning: We have used Logistic Regression to develop the ML model for predicting the disease. The dataset we have used for this model contains 4.5K+ combinations of 133 symptoms and based on these symptoms their mapping to different disease.

* Geolocation: The app uses geolocation technology to determine the user's location and suggest nearby doctors based on their location. This is implemented using the geolocator package of flutter.

* REST APIs: The app uses REST APIs to communicate with the backend server and retrieve and store data. This allows for efficient data transfer and management between the app and the server. The ML model we have developed has been written in Python and to connect that ML model with flutter app we used Flask and hosted that flask server using ngrok.


## Some Screenshots :card_index:

<table>
<tr>
<td>
<img src="https://user-images.githubusercontent.com/83654180/222330447-bdeac7ae-de8b-4b7f-af07-8fb0a91999ae.jpeg">
</td>
<td>
<img src="https://user-images.githubusercontent.com/83654180/222330455-95c8c888-d9d6-445f-bd10-f1349007bb4e.jpeg">
</td>
<td>
<img src="https://user-images.githubusercontent.com/83654180/222330460-3da8e113-4a5f-4463-85cc-1c598cf7a08e.jpeg">
</td>
<td>
<img src="https://user-images.githubusercontent.com/83654180/222330466-78756449-010b-4a16-bc83-f0ccc793b06b.jpeg">
</td>
</tr>
</table>

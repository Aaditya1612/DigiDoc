## DigiDoc

<img src="https://github.com/Aaditya1612/DigiDoc/assets/83654180/38356f0f-6b20-42cd-9e69-2f4889522fd5" height=50% width=50% />


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
<img src="https://github.com/Aaditya1612/DigiDoc/assets/83654180/5d533e74-70b7-44b4-98a0-8fc18baba7f9">
</td>
  </tr>
  <tr>
<td>
<img src="https://github.com/Aaditya1612/DigiDoc/assets/83654180/5d41dcf9-964c-477c-8865-9eadfd518ae5">
</td>

</tr>
   <tr>

<td>
<img src="https://github.com/Aaditya1612/DigiDoc/assets/83654180/80333447-9f11-43a7-9177-ae4407d7d42e">
</td>

</tr>
</table>

<a name="readme-top"></a>

<p align="center">
  <img width="100" height="100" src="https://raw.githubusercontent.com/gdgcloudkol/ccd2022-app/main/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png">
</p>

<br>

# CCD Kolkata Event App 

This repo contains source code for the official Flutter app of Cloud Community Days Kolkata. 

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <br>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#screenshots">Screenshots</a></li>
        <li><a href="#doc">Documentation</a></li>
        <li><a href="#features">Features</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#project-setup">Project Setup</a></li>
        <li><a href="#how-to-contribute">How to contribute</a></li>
      </ul>
    </li>
    <!-- <li><a href="#roadmap">Roadmap</a></li> -->
    <li><a href="#contact-us">Contact</a></li>
    <!-- <li><a href="#acknowledgments">Acknowledgments</a></li> -->
  </ol>
</details>

<br><br>

## About the project

 &emsp; :construction:**Actively under development**:construction:
 
- ### Built With

  [![Flutter][flutter-image]][flutter-url] &emsp; [![Firebase][firebase-image]][firebase-url]
 
- <details>
  <summary id="screenshots"><b>Screenshots :iphone: </b></summary>
  <br>
  
  <img width = "200" height = "400" src="https://raw.githubusercontent.com/gdgcloudkol/ccd2022-app/main/data/Screenshots/Google%20Pixel%204%20XL%20Screenshot%201.png">
  &nbsp;
  <img width = "200" height = "400" src="https://raw.githubusercontent.com/gdgcloudkol/ccd2022-app/main/data/Screenshots/Google%20Pixel%204%20XL%20Screenshot%202.png">
  &nbsp;
  <img width = "200" height = "400" src="https://raw.githubusercontent.com/gdgcloudkol/ccd2022-app/main/data/Screenshots/Google%20Pixel%204%20XL%20Screenshot%203.png">
  &nbsp;
  <img width = "200" height = "400" src="https://raw.githubusercontent.com/gdgcloudkol/ccd2022-app/main/data/Screenshots/Google%20Pixel%204%20XL%20Screenshot%204.png">
  
</details>

- #### <p id = "doc"> Documentation :notebook: </p>

  * This project uses [Effective Dart Principles]() for documentation
  * Run `dart doc .` from root of project directory to generate documentation webpage.

- #### Features

  * Sessionize Api Integrated for speakers profile and schedule management
  * Support for multiple sessions in same timeslot
  * Self Hosted using Firebase
  * FCM for notification
  * Built using [Provider Architecture](https://pub.dev/packages/provider) for clean state management
  * Google Auth for User Authentication
  * Custom user management logic using Firestore
  * Data caching for optimised network calls
  * Ticket application and view
  * Dashboard Screen (**Bonus : Refer & Earn Logic Integrated**)
  * Profile Screen for event participants
  * Dynamic Partners Screen Using GitHub Hosted Json
  * Fluid animations
  * Custom Navigation Stack
  * Modern, Material UI (we all love this!)
  * Heavyily documented code (who doesn't like clean code)
 
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Getting Started

- This project depends heavily on firebase. A few resources to get you started if this is your first Firebase project:

  * [Lab: Firebase for Flutter](https://firebase.google.com/codelabs/firebase-get-to-know-flutter#0)
  * [FlutterFire Plugins](https://firebase.flutter.dev/)

- A few resources to get you started if this is your first Flutter project:

  * [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
  * [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

&emsp; For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- #### Project Setup

  * Flutter App:
    * [Install Flutter](https://docs.flutter.dev/get-started/install)
    * [Setting up your ide](https://flutter.io/ide-setup/)
    * Fork and clone this repository.
    * cd into `ccd2022-app` directory.
    * Run `flutter clean` command.
    * Run `flutter pub get` command.
    * Run `flutter run` command.
  
  * Firebase:
    * Create a firebase project
    * Add android app with your package name in firebase console.
    * Enable Google Auth from `Authentication` menu in Firebase.
    * Generate `SHA-1 key hash` for your debug keystore from your pc. This needs to be added to `SHA certificate fingerprints` section under your android app in `Firebase project settings`. Without this step **Google login** won't work.
    * Enable ***Cloud Firestore***
      * Recommended rules for Firestore 

          ```JS
            rules_version = '2';
            service cloud.firestore {
              match /databases/{database}/documents {

               match /tickets/{ticket} {
                allow read : if request.auth != null;
                allow write: if false;
               }

              match /{document=**} {
                allow read, write: if request.auth != null;
              }

            }
           }
         ```
         
      * Recommended Rules for Cloud Storage

          ```JS
            rules_version = '2';
            service firebase.storage {
              match /b/{bucket}/o {
                match /{allPaths=**} {
                  allow read: if true;
                  allow write: if false;
                  allow create: if false;
                  allow update: if false;
                }
              }
            }
          ```

    * Enable ***Cloud Storage***
    * Download `google_services.json` from `Console` -> `Project Settings`. File is present in app section. SDK instructions found in the same page
    * (Optional) Enable ***Cloud Messaging*** from Firebase Console if you wan't notifications to work in your app
    * (Optional) If released to play store get `SHA-1 key hash` from playstore and upload them to firebase, otherwise google sign in won't work in play store app.

* #### How to Contribute?
  
    Check [Contributing.md](https://github.com/gdgcloudkol/ccd2022-app/blob/main/CONTRIBUTING.md) for guidelines on contributing to this repo.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contact Us

&emsp; If you have a question, please feel free to contact us through [email](mailto:gdgcloudkol@gmail.com) or our [telegram community channel](https://telegram.me/gdgcloudkol).

<br><br><br><br>

<p align="center">
  Made with ❤️ by GDG Cloud Kolkata
  <br><br>
  <a href="https://opensource.org/licenses/MIT"> <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=plastic" /> </a>
</p>






<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[flutter-image]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=plastic&logo=Flutter&logoColor=5cc8f8
[flutter-url]: https://flutter.dev
[firebase-image]: https://img.shields.io/badge/firebase-%23039BE5.svg?style=plastic&logo=firebase
[firebase-url]: https://firebase.com/

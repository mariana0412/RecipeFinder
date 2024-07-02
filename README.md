# RecipeFinder

RecipeFinder is an iOS app that helps you find recipes based on the ingredients you have. 
Just take a photo of your ingredients, and the app will suggest recipes using those items.

<table>
  <tr>
    <td><img src="https://res.cloudinary.com/df9uihxz1/image/upload/v1719947473/RecipeFinder_home_ankxbl.png" alt="Home Screen" width="200"></td>
    <td><img src="https://res.cloudinary.com/df9uihxz1/image/upload/v1719947474/RecipeFinder_ingredients_j24nrp.png" alt="Ingredients Screen" width="200"/></td>
    <td><img src="https://res.cloudinary.com/df9uihxz1/image/upload/v1719947475/RecipeFinder_recipesList_qxmzgt.png" alt="Recipes List Screen" width="200"/></td>
    <td><img src="https://res.cloudinary.com/df9uihxz1/image/upload/v1719947476/RecipeFinder_recipe_bjmu6x.png" alt="Recipe Page" width="200"/></td>
  </tr>
</table>

## Features

- <b>Ingredient Detection:</b> Use your camera to take a picture of your ingredients. The app uses machine learning to identify them
- <b>Manual Input:</b> Add ingredients manually if needed
- <b>Recipe Suggestions:</b> Get recipe ideas based on the identified ingredients
- <b>Sort Recipes:</b> Sort recipes by cooking time
- <b>Favorites:</b> Save recipes you like for easy access later
- <b>Dark and Light Mode:</b> The app supports both dark and light modes to match your device settings

## Technologies Used
UIKit: For the user interface
Create ML: For training the object detection model
Core ML: For the machine learning model integration

## Data Sources

- **[Recipes](https://www.kaggle.com/datasets/shuyangli94/food-com-recipes-and-user-interactions)**: The recipes are sourced from Food.com Recipes and Interactions Dataset
- **[Model Training](https://www.kaggle.com/datasets/sainikhileshreddy/food-recognition-2022)**: The ingredient detection model is trained using the Food Recognition 2022 Dataset

## Requirements

- iOS 16.0 or later
- Xcode 15.0 or later

## Installation

To install RecipeFinder on your iOS device, follow these steps:

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Connect your iOS device to your computer and select it as the build destination.
4. Build and run the application on your device.
Ensure that your iOS device runs a compatible version of iOS.

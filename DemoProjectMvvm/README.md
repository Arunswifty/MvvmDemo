Fetching peoples list from Json MockApi :(Display,Persistence,Filter and Details)
------------------------------------------------------
  Descriptions: DemoProject is a example of a MVVM design pattern like Model, ViewModel, Worker using Realm Framework. Downloading the data from server and storing on Persistence storage which displays List of peoples with Company name, Gender, Phoneno, and about thier company. It also has filtering option which is used to filter data by making an distinct function with Gender and Company. Delete specific index and also view details of selected person.
  
 MockLab link : https://www.mocklab.io/docs/getting-started/
 
 MockApi: http://88774.mocklab.io/peoples 

 Screens :
 
 1. ViewController : Displaying Data fetched from Api which displays Name,Phonenumber,Company name and Gender.
 
 2. FilterDataVc : Displaying persistence data which is fetched from server and displaying on Tableview using distinct predicates.
 
 3. DetailVc: Displays any selected index of object with about company from ViewController tableview.
 
 Classes :
 
 1. ContactConstants : Contains all the constants needed for Contact module.
 
 2. ContactWorker: "FetchContact" is responsible for fetching products from server by passsing generic T  and saving it on Realm objects.

 3. ViewContactModel:  1. ViewContactModel parse the api from ContactWorker and save it on Realm database and that piece of object are passed with protocol process.
                                       2. Activity loading.
                                       3. Barbutton creations.
                                       4. Handling delete functionalities.
  
  4. ContactModel: Business logics data to communicate with viewmodel  which is extender with @objc member class to store Realm database.
                                                                                                                   
 Orientation: supports Landscape and potratit both.

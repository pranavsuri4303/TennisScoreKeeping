//
//  NewUserView.swift
//  Tennis
//
//  Created by Sameer Suri on 22/1/21.
//

import SwiftUI

struct NewUserView: View {
    @Binding var isPresented : Bool
    @StateObject var vm : RegisterVM
    @State var startAnimate = false
    @State var isPickerPresented : Bool  = false
    @State var pickedUIImage : UIImage? = nil
    @State var country : String? = nil
    @State var arrCountry = ["India","USA","France"] //Here Add Your data
    @State var selectionIndex = 0
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Group{
                    if let pickedUIImage = pickedUIImage {
                        
                        Image(uiImage: pickedUIImage)
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                    }
                    else {
                        
                        if vm.gender == "Male"{
                            Circle()
                                .fill(Color.blue.opacity(1))
                                .overlay(Image("Male")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            //Dynamic Frame...
                                            .padding([.all],5))

                        }else{
                            Circle()
                                .fill(Color.white.opacity(1))
                                .overlay(Image("Female")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            //Dynamic Frame...
                                            .padding([.all],5))
                        }
                        
                        
                        
                    }
                }
                .onTapGesture {
                    isPickerPresented.toggle()
                }
                .sheet(isPresented: $isPickerPresented, content: {
                    ImagePicker(selectedImage: $pickedUIImage)
                })
                HStack{
                    
                    VStack(alignment: .leading, spacing: 12, content: {
                        
                        Text("New user details")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Please enter the following details for a more personalized experience.")
                            .foregroundColor(Color.white.opacity(0.5))
                    })
                    .padding(.bottom)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.leading,15)
                HStack{
                    Image(systemName: "person")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    TextField("Name", text: $vm.name)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(vm.name == "" ? 0.02 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                HStack{
                    Image(systemName: "calendar")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextField("Year of Birth", text: $vm.yob)
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
                }
                .padding()
                .background(Color.white.opacity(vm.yob == "" ? 0.02 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                HStack{
                    Image(systemName: "flag")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextFieldWithInputView(data: Nationalities().list, placeholder: "Select your country", selectionIndex: self.$selectionIndex, selectedText: $vm.nationality)
                        .frame(height: 0)
                }
                .padding()
                .background(Color.white.opacity(vm.nationality == nil ? 0.02 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                Picker(selection: $vm.gender, label: Text(""), content: {
                    Text("Male").tag("Male")
                        .foregroundColor(Color.white)
                    Text("Female").foregroundColor(Color.white).tag("Female")
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding(.all)
                
                HStack(spacing: 15){
                    
                    Button(action: {
                        
                        isPresented.toggle()
                        DispatchQueue.main.async {
                            
                            vm.configProfileImageDataFrom(UIImage: pickedUIImage)
                            vm.createUser()
                        }
                        
                    }, label: {
                        Text("Create account")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color("green"))
                            .clipShape(Capsule())
                    })
                    .opacity(vm.name != "" && vm.yob != "" && vm.nationality != "" ? 1 : 0.5)
                    .disabled(vm.name != "" && vm.yob != "" && vm.nationality != "" ? false : true)
                    .alert(isPresented: $vm.alert, content: {
                        Alert(title: Text("Error"), message: Text(vm.alertMsg), dismissButton: .destructive(Text("Ok")))
                    })
                    
                }
                .padding(.vertical)
                Spacer()
            }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
            .animation(startAnimate ? .easeOut : .none)
            
            if vm.isLoading{
                LoadingScreenView()
            }
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.startAnimate.toggle()
            }
        })
        
        
        
    }
}

struct Register_Preview : PreviewProvider {
    static var previews: some View {
        NewUserView(isPresented: .constant(false), vm: RegisterVM.init())
    }
    
    
}

struct Nationalities {
    let list = [
        "Afghanistan",
        "Albania",
        "Algeria",
        "American Samoa",
        "Andorra",
        "Angola",
        "Anguilla",
        "Antarctica",
        "Antigua and Barbuda",
        "Argentina",
        "Armenia",
        "Aruba",
        "Australia",
        "Austria",
        "Azerbaijan",
        "Bahamas",
        "Bahrain",
        "Bangladesh",
        "Barbados",
        "Belarus",
        "Belgium",
        "Belize",
        "Benin",
        "Bermuda",
        "Bhutan",
        "Bolivia (Plurinational State of)",
        "Bonaire, Sint Eustatius and Saba",
        "Bosnia and Herzegovina",
        "Botswana",
        "Bouvet Island",
        "Brazil",
        "British Indian Ocean Territory",
        "Brunei Darussalam",
        "Bulgaria",
        "Burkina Faso",
        "Burundi",
        "Cabo Verde",
        "Cambodia",
        "Cameroon",
        "Canada",
        "Cayman Islands",
        "Central African Republic",
        "Chad",
        "Chile",
        "China",
        "Christmas Island",
        "Cocos Islands",
        "Colombia",
        "Comoros",
        "The Democratic Republic of Congo",
        "Congo",
        "Cook Islands",
        "Costa Rica",
        "Croatia",
        "Cuba",
        "Curaçao",
        "Cyprus",
        "Czechia",
        "Côte d'Ivoire",
        "Denmark",
        "Djibouti",
        "Dominica",
        "The Dominican Republic",
        "Ecuador",
        "Egypt",
        "El Salvador",
        "Equatorial Guinea",
        "Eritrea",
        "Estonia",
        "Eswatini",
        "Ethiopia",
        "Falkland Islands",
        "Faroe Islands",
        "Fiji",
        "Finland",
        "France",
        "French Guiana",
        "French Polynesia",
        "French Southern Territories",
        "Gabon",
        "Gambia",
        "Georgia",
        "Germany",
        "Ghana",
        "Gibraltar",
        "Greece",
        "Greenland",
        "Grenada",
        "Guadeloupe",
        "Guam",
        "Guatemala",
        "Guernsey",
        "Guinea",
        "Guinea-Bissau",
        "Guyana",
        "Haiti",
        "Heard Island and McDonald Islands",
        "Holy See",
        "Honduras",
        "Hong Kong",
        "Hungary",
        "Iceland",
        "India",
        "Indonesia",
        "Iran",
        "Iraq",
        "Ireland",
        "Isle of Man",
        "Israel",
        "Italy",
        "Jamaica",
        "Japan",
        "Jersey",
        "Jordan",
        "Kazakhstan",
        "Kenya",
        "Kiribati",
        "DPRK",
        "Korea",
        "Kuwait",
        "Kyrgyzstan",
        "Lao People's Democratic Republic",
        "Latvia",
        "Lebanon",
        "Lesotho",
        "Liberia",
        "Libya",
        "Liechtenstein",
        "Lithuania",
        "Luxembourg",
        "Macao",
        "Madagascar",
        "Malawi",
        "Malaysia",
        "Maldives",
        "Mali",
        "Malta",
        "Marshall Islands",
        "Martinique",
        "Mauritania",
        "Mauritius",
        "Mayotte",
        "Mexico",
        "Micronesia",
        "Moldova",
        "Monaco",
        "Mongolia",
        "Montenegro",
        "Montserrat",
        "Morocco",
        "Mozambique",
        "Myanmar",
        "Namibia",
        "Nauru",
        "Nepal",
        "Netherlands",
        "New Caledonia",
        "New Zealand",
        "Nicaragua",
        "Niger (the)",
        "Nigeria",
        "Niue",
        "Norfolk Island",
        "Northern Mariana Islands",
        "Norway",
        "Oman",
        "Pakistan",
        "Palau",
        "Palestine",
        "Panama",
        "Papua New Guinea",
        "Paraguay",
        "Peru",
        "Philippines",
        "Pitcairn",
        "Poland",
        "Portugal",
        "Puerto Rico",
        "Qatar",
        "Republic of North Macedonia",
        "Romania",
        "Russian Federation",
        "Rwanda",
        "Réunion",
        "Saint Barthélemy",
        "Saint Helena, Ascension and Tristan da Cunha",
        "Saint Kitts and Nevis",
        "Saint Lucia",
        "Saint Martin",
        "Saint Pierre and Miquelon",
        "Saint Vincent and the Grenadines",
        "Samoa",
        "San Marino",
        "Sao Tome and Principe",
        "Saudi Arabia",
        "Senegal",
        "Serbia",
        "Seychelles",
        "Sierra Leone",
        "Singapore",
        "Sint Maarten",
        "Slovakia",
        "Slovenia",
        "Solomon Islands",
        "Somalia",
        "South Africa",
        "South Georgia and the South Sandwich Islands",
        "South Sudan",
        "Spain",
        "Sri Lanka",
        "Sudan (the)",
        "Suriname",
        "Svalbard and Jan Mayen",
        "Sweden",
        "Switzerland",
        "Syrian Arab Republic",
        "Taiwan",
        "Tajikistan",
        "Tanzania",
        "Thailand",
        "Timor-Leste",
        "Togo",
        "Tokelau",
        "Tonga",
        "Trinidad and Tobago",
        "Tunisia",
        "Turkey",
        "Turkmenistan",
        "Turks and Caicos Islands",
        "Tuvalu",
        "Uganda",
        "Ukraine",
        "United Arab Emirates",
        "United Kingdom of Great Britain and Northern Ireland",
        "United States Minor Outlying Islands",
        "United States of America",
        "Uruguay",
        "Uzbekistan",
        "Vanuatu",
        "Venezuela (Bolivarian Republic of)",
        "Viet Nam",
        "Virgin Islands (British)",
        "Virgin Islands",
        "Wallis and Futuna",
        "Western Sahara",
        "Yemen",
        "Zambia",
        "Zimbabwe",
        "Åland Islands"
    ]
}

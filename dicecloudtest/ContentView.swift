//
//  ContentView.swift
//  dicecloudtest
//
//  Created by Tucker on 11/10/21.
//

import SwiftUI
import Firebase



class Di : Hashable{

    var name: String
    var choices = [String]()
    var items = 0
    
    init(name: String, choices: [String]){
        self.name = name
        self.choices = choices
        self.items = choices.count
    }
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(name.hashValue)
        hasher.combine(choices.hashValue)
    }
    static func == (lhs: Di, rhs: Di) -> Bool {
        return lhs.name == rhs.name
    }
  
}

class roller {
    var counter = 0
    var number = "hey"
    
    
    //Types of Dice
    var colors = Di(name: "Colors", choices: ["blue", "yellow", "red", "green", "orange", "grey"])
    var roommates = Di(name: "Roommates", choices:["Tucker", "Nathan", "Zach", "Devon", "Christian", "Chris"])
    var fastFood = Di(name: "Fast Food", choices:["McDonalds", "Wendy's", "Taco Bell", "Burger King", "Panda Express", "Del Taco"])
    var coin = Di(name:"coin", choices: ["Heads", "Tails"])
    
    
    /*
    var postData = [String]()
    var listoft = ["no", "n"]
    var chores = Di(name: "Chores", choices: ["didnt work", "haha you suck"])
    
    init() {
        if postData.count < 0{
            chores.choices = postData
            
        }
        else {
            chores.choices = ["hey at least it runs", "you bet ya!"]
        }
    
    }
    */
 
    
    
    func countit(){
        counter += 1
        print(counter)
        number = String(counter)
    }
}


var myRoller = roller()


struct ContentView: View {
    
    @State var count: Int = 0
    let colors = ["blu\\e", "ye", "r", "n", "nge", "gy"]
    
    @State var choice = 0
    @State var actualRoll = "none"
        
    @State  var selectedDi = myRoller.colors
    
    
    //DATA BASE  STUFF
    @State var ref:DatabaseReference?
    @State var databaseHandle:DatabaseHandle?
    @State var postData = [String]()
    
    @State var animationAmount = 1.0
    @State var animationAngle = 0.0
    @State var currentX = 0.0
    @State var currentY = 0.0
    @State var startX = 0.0
    @State var startY = 0.0
    
    var body: some View {
        VStack {
                    Text(actualRoll)
                        .frame(width: 120, height: 120)
                        .font(.title)
                        .padding(0)
                        .background(.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        //.scaleEffect(animationAmount)
                        .rotationEffect(.degrees(animationAngle))
                        .position(x: currentX ,y: currentY)
                        .animation(.easeInOut(duration: 1), value: animationAmount)
                        
            
                    //Text(selectedDi.name)
                    Picker(selection: $selectedDi, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                        
                       
                        Text("Room mates").tag(myRoller.roommates)
                        Text("Colors").tag(myRoller.colors)
                       // Text("Chores").tag(myRoller.chores)
                        Text("Fast Food").tag(myRoller.fastFood)
                        Text("coin").tag(myRoller.coin)
                        
                        
                    }
            Button(action: {
                            self.choice = Int.random(in: 1...selectedDi.items)
                            self.actualRoll = selectedDi.choices[choice - 1]
                animationAmount += 0.3
                animationAngle += 720
               
                //Centerish is 175, 275
                currentX = Double.random(in:50..<300)
                currentY = Double.random(in: 50..<450)
                //Set database referencecl
                self.ref = Database.database().reference()
                
                //retrieve post and listen for changes
                self.databaseHandle = self.ref?.child("Dice/Chores").observe(.childAdded, with: {(snapshot) in
                   //Code to execute when a child is added under "Dice"
                    //Take value from snapshot and addit to postData array
                    //Convert data to string
                    let post = snapshot.value as? String
                    
                    
                    
                    if let actualPost = post {
                    //append the data to postdata array
                        //myRoller.chores.choices.append(actualPost)
                        
                    }
                })
                            
                        }) {
                            Text("Roll")
                        }
        }
        
        //THis is all from https://www.hackingwithswift.com/books/ios-swiftui/customizing-animations-in-swiftui
    }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}


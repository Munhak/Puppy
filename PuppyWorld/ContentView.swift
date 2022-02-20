//
//  ContentView.swift
//  PuppyWorld
//
//  Created by Munhak on 2021/11/03.
//

import SwiftUI
import MapKit
import NMapsMap
import Combine


/*
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let naverMapView = NMFNaverMapView(frame: view.frame)
        view.addSubview(naverMapView)
    }
}
*/

struct MapScene: View {
    var body: some View {
        MapView()
    }
}

struct MapView: UIViewRepresentable {
    @ObservedObject var viewModel = MapSceneViewModel()

    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
            view.showZoomControls = false
            view.mapView.zoomLevel = 17
            //view.mapView.mapType = .hybrid
            //view.positionMode = .direction

        return view
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {

    }
}

class MapSceneViewModel: ObservableObject {
    
}

struct ContentView: View{
    
    @State var showDetails = false
    
    var body: some View {
        
        // text
        Text("Hello, world!")
            .padding()
        
        // button
        Button(action: {
            // action
            self.showDetails.toggle()
        }, label: {
            // display
            Text("Show details")
        })
        
        if showDetails {
            Text("You should see me in a crown")
                .font(.largeTitle)
                .lineLimit(nil)
        }
    }
}

struct NextNavigationView: View {
    
    // value
    @State var ShowGreeting = false
    @State var id = ""
    @State var pwd = ""
    
    var body: some View {
        
        VStack
        {
            // toggle
            Toggle(isOn: $ShowGreeting)
            {
                Text("Toggle")
            }
            if ShowGreeting {
                Text("Toggle is on")
            }
            
            // text field
            TextField("Input id", text: $id)
                .extenstionTextFieldView(roundedCornes: 6, startColor: .white, endColor: .purple)
            SecureField("Input pwd", text: $pwd)
            
            Text("Input id: \(id)")
            Text("Input pwd: \(pwd)")
        }

        
    }
}

extension TextField
{
    func extenstionTextFieldView(roundedCornes: CGFloat, startColor:Color, endColor:Color)-> some View {
        self
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .shadow(color: .purple, radius: 10)
    }
}

// navigation view
struct TestNavigationView: View {
    var body: some View
    {
        NavigationView
        {
            Text("Navigation view")
                .navigationBarTitle(Text("Intro"))
                .navigationBarItems(trailing:NavigationLink(destination: NextNavigationView())
                {
                    Text("Click here")
                }
            )
        }
    }
}

//
struct ListView: View{
    
    @State var users = ["aaa", "bbb", "ccc"]
    
//    var body: some View
//    {
//        List
//        {
//            ForEach(users, id: \.self)
//            {
//                user in Text(user)
//            }
//            .onMove(perform: move)
//        }
//        .navigationBarItems(trailing: EditButton())
//    }
//
//    func move(from source: IndexSet, to destination: Int)
//    {
//        let reversedSource = source.sorted()
//
//        for index in reversedSource.reversed()
//        {
//            users
//                .insert(users.remove(at: index), at: destination)
//        }
//    }
    
    var body: some View
    {
        List
        {
            ForEach(users, id: \.self)
            {
                user in Text(user)
            }
            .onDelete(perform: delete)
        }
    }

    func delete(at offsets: IndexSet)
    {
        if let first = offsets.first
        {
            users.remove(at: first)
        }
    }
}

struct ScrollViewTest : View {
    
    @State var users = ["aaa", "bbb", "ccc"]
    
    var body: some View
    {
        NavigationView()
        {
                NavigationLink(
                    destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                    isActive: /*@START_MENU_TOKEN@*/.constant(true)/*@END_MENU_TOKEN@*/,
                    label: {
                        /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/
                    }
                )
        }
        
        ScrollView()
        {
            ForEach(users, id: \.self)
            {
                user in Text(user)
            }
        }
    }
}


struct Nav1 : View {
    
    var body: some View
    {
        NavigationView()
        {
                NavigationLink(
                    destination: Nav2())
                {
                    Text("nav1")
                }.navigationBarTitle("move")
        }
    }
}

struct Nav2 : View {
    
    var body: some View
    {
        Text("hi")
        
//        VStack()
//        {
//            Text("hi")
//        }.navigationBarTitle("우이")
        
    }
}



struct TabView_Test: View {
    var body: some View{
        TabView{
            ListView().tabItem { Text("List") }
            Nav2().tabItem { Text("Nav2") }
        }
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            //TestNavigationView()
            //ListView()
        }
    }
}
#endif

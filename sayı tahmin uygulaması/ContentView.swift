//
//  ContentView.swift
//  sayı tahmin uygulaması
//
//  Created by Mert AKBAŞ on 11.10.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            VStack(spacing:100){
                 
                Text("Tahmin Oyunu")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                
                Image("zar_resim")
                    .resizable()
                    .frame(width:200,height: 200)
                
                NavigationLink(destination:TahminEkrani()){
                    Text("Oyuna Başla")
                    .frame(width:300,height: 100)
                    .font(.largeTitle)
                    .background(Color.pink)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                }
            }.navigationBarTitle("Anasayfa")
        }
        
       
    }
}

struct TahminEkrani: View {
    
    @State private var tahminGirdisi = ""
    
    @State private var sayfaAcilsinmi:Bool = false
    
    @State private var sonuc = false
    
    @State private var kalanHak = 5
    
    @State private var yonlendirme = ""
    
    @State private var rasgeleSayi = 0
    
    var body: some View {
        
       VStack(spacing:50){
        
          Text("Kalan Hak : \(kalanHak)")
          .font(.largeTitle)
          .foregroundColor(Color.pink)
        
          Text("\(yonlendirme)")
          .font(.largeTitle)
        
        TextField("Tahmin giriniz",text:$tahminGirdisi)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .font(.largeTitle)
        .padding()
        
        Button(action:{
            self.kalanHak-=1//Her tahminde bir azalacak
            
            if let tahmin  = Int(self.tahminGirdisi){//String ifadeyi kontrol ederek int ifadeye dönüştürürüz.
            
                    if tahmin > self.rasgeleSayi {//Tahmin edilen sayı büyük ise
                        self.yonlendirme = "Azalt"
                    }
                    
                    if tahmin < self.rasgeleSayi {//Tahmin edilen sayı küçük ise
                        self.yonlendirme = "Arttır"
                    }
                    
                    if tahmin == self.rasgeleSayi {//Tahmin rasgele sayıya eşitse kazanılır.
                        self.sonuc = true
                        self.sayfaAcilsinmi = true
                        self.oyunuSifirla()

                    }
                    
                    if self.kalanHak == 0 {//Tahmin hakkı kalmaz ise
                        self.sonuc = false
                        self.sayfaAcilsinmi = true
                        self.oyunuSifirla()
                    }
            }
            self.tahminGirdisi = ""
        }){
            Text("TAHMİN ET")
            .frame(width:300,height: 100)
            .font(.largeTitle)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }
        
       }.navigationBarTitle("Tahmin Ekranı")
        .sheet(isPresented:$sayfaAcilsinmi){
            SonucEkrani(gelenSonuc:self.sonuc)
       }.onAppear(){ // Sayfa göründüğü  zaman çalışan fonksiyon onappear()
        
        self.rasgeleSayi = Int.random(in: 0...100)//0 - 100
        
        print("Rasgele Sayı : \(self.rasgeleSayi)")
        
        }
    }
    
    func oyunuSifirla(){
        self.rasgeleSayi = Int.random(in: 0...100)//0 - 100
        
        print("Rasgele Sayı : \(self.rasgeleSayi)")
        
        self.kalanHak = 5
        
        self.yonlendirme = ""
    }
}

struct SonucEkrani: View {
    
    @Environment(\.presentationMode) var sunumModu
    
    var gelenSonuc:Bool?
    
    var body: some View {
        
        VStack(spacing:50){
         
            if gelenSonuc! {
                Image("mutlu_resim")
                    .resizable()
                    .frame(width:200,height: 200)
                 
                Text("Kazandınız")
                        .font(.largeTitle).foregroundColor(Color.pink)
            }else{
                Image("uzgun_resim")
                    .resizable()
                    .frame(width:200,height: 200)
                 
                Text("Kaybetttiniz")
                        .font(.largeTitle).foregroundColor(Color.gray)
            }
           
         Button(action:{
            self.sunumModu.wrappedValue.dismiss()
         }){
             Text("TEKRAR DENE")
             .frame(width:300,height: 100)
             .font(.largeTitle)
             .background(Color.pink)
             .foregroundColor(Color.white)
             .cornerRadius(10)
         }
         
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

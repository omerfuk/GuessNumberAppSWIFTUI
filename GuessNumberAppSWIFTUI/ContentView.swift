//
//  ContentView.swift
//  GuessNumberAppSWIFTUI
//
//  Created by Ömer Faruk Kılıçaslan on 9.05.2022.
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
                    .resizable().frame(width:200,height: 200)
                
                NavigationLink(destination:TahminEkrani()){
                    Text("Oyuna Başla")
                        .frame(width:300,height: 100)
                        .font(.largeTitle)
                        .background(Color.pink)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                }
            }.navigationTitle("AnaSayfa")
        }
    }
}

struct TahminEkrani: View {
    @State private var tahminGirdisi = ""
    @State private var sayfaAcilsinMi = false
    
    @State private var sonuc = false
    
    @State private var kalanHak = 5
    
    @State private var yonlendirme = ""
    
    @State private var rastgeleSayi = 0
    
    
    
    var body: some View {
        
        VStack(spacing:50){
            Text("Kalan Hak : \(kalanHak)")
                .font(.largeTitle)
                .foregroundColor(Color.pink)
            
            Text("\(yonlendirme)")
                .font(.largeTitle)
                
            
            TextField("Tahmin Giriniz", text: $tahminGirdisi)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.largeTitle)
                .padding()
            
            Button(action:{
                self.kalanHak -= 1
                
                print("Tahmin : \(self.tahminGirdisi)")
                
                if let tahmin = Int(self.tahminGirdisi) {
                    
                    if self.kalanHak != 0 {
                        
                        if tahmin > self.rastgeleSayi {
                            self.yonlendirme = "Azalt"
                        }
                        if tahmin < self.rastgeleSayi {
                            self.yonlendirme = "Artır"
                        }
                        
                        if tahmin == self.rastgeleSayi {
                            self.sonuc = true
                            self.sayfaAcilsinMi = true
                            self.oyunuSifirla()
                        }
                    }
                    else{
                        //Haklar bitti
                        self.sonuc = false
                        self.sayfaAcilsinMi = true
                        self.oyunuSifirla()
                    }
                }
                
                
                
                self.tahminGirdisi = ""
                
                
                
            }) {
                Text("TAHMİN ET")
                    .frame(width:300,height: 100)
                    .font(.largeTitle)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
            }
            
            
            
        }.navigationTitle("Tahmin Ekranı")
            .sheet(isPresented: $sayfaAcilsinMi) {
                SonucEkrani(gelenSonuc:self.sonuc)
            }.onAppear(){
                self.rastgeleSayi = Int.random(in: 0...100)
                
                print("Rastgele Sayı : \(self.rastgeleSayi)")
            }
        
        }
    func oyunuSifirla(){
        self.rastgeleSayi = Int.random(in: 0...100)
        
        print("Rastgele Sayi : \(rastgeleSayi)")
        
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
                    .resizable().frame(width:200,height: 200)
                
                Text("Kazandınız")
                    .font(.largeTitle)
                    .foregroundColor(Color.pink)
            }
            else{
                Image("uzgun_resim")
                    .resizable().frame(width:200,height: 200)
                
                Text("Kaybettiniz")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
            }
            
                
            
            Button(action:{
                print("TEKRAR DENE TIKLANDI")
                self.sunumModu.wrappedValue.dismiss()
            }) {
                Text("TEKRAR DENE")
                    .frame(width:300,height: 100)
                    .font(.largeTitle)
                    .background(Color.pink)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
            }
            
            
            
        }.navigationTitle("Sonuç Ekranı")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  BeersDummyData.swift
//  BringMyOwnBeer🍺Tests
//
//  Created by Boyoung Park on 11/07/2019.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Foundation
@testable import BringMyOwnBeer_

struct BeersDummayData {
    static let beerJSONString = """
    [{"id":316,"name":"SOS! (May Day!)","tagline":"Dry-Hopped Maibock.","first_brewed":"2018","description":"BrewDog vs Brlo. One of a series of collaborations with European craft breweries, aimed at promoting engagement and market growth. Our German collaboration is with BRLO, and the beer is a dry- hopped Maibock; a new world take on a strong pale lager.","image_url":null,"abv":6.4,"ibu":34,"target_fg":1014,"target_og":1060,"ebc":21,"srm":11,"ph":4.2,"attenuation_level":77,"volume":{"value":20,"unit":"litres"},"boil_volume":{"value":25,"unit":"litres"},"method":{"mash_temp":[{"temp":{"value":64,"unit":"celsius"},"duration":60}],"fermentation":{"temp":{"value":10,"unit":"celsius"}},"twist":null},"ingredients":{"malt":[{"name":"Pilsner","amount":{"value":4.2,"unit":"kilograms"}},{"name":"Munich Type 1 Light","amount":{"value":0.96,"unit":"kilograms"}},{"name":"Carapils","amount":{"value":0.06,"unit":"kilograms"}},{"name":"Acidulated Malt","amount":{"value":0.06,"unit":"kilograms"}}],"hops":[{"name":"Magnum","amount":{"value":4,"unit":"grams"},"add":"70","attribute":"Bittering"},{"name":"Hallertauer Mittelfrüh","amount":{"value":10,"unit":"grams"},"add":"10","attribute":"Flavour"},{"name":"Hallertauer Mittelfrüh","amount":{"value":20,"unit":"grams"},"add":"0","attribute":"Aroma"},{"name":"Hallertauer Mittelfrüh","amount":{"value":20,"unit":"grams"},"add":"0","attribute":"Aroma"},{"name":"Mandarina Bavaria","amount":{"value":40,"unit":"grams"},"add":"0","attribute":"Aroma"},{"name":"Motueka","amount":{"value":20,"unit":"grams"},"add":"0","attribute":"Aroma"},{"name":"Hallertauer Mittelfrüh","amount":{"value":20,"unit":"grams"},"add":"Dry Hop","attribute":"Aroma"},{"name":"Mandarina Bavaria","amount":{"value":30,"unit":"grams"},"add":"Dry Hop","attribute":"Aroma"},{"name":"Motueka","amount":{"value":20,"unit":"grams"},"add":"Dry Hop","attribute":"Aroma"}],"yeast":"Wyeast 2126 - Bohemian Lager™"},"food_pairing":["Honey ham sandwich Gruyère cheese","Steamed mussels","Carrot cake"],"brewers_tips":"Traditional German brewing is awesome and deserving of respect. If you brew this during spring time, call it a Maibock, any other time of the year and it should be called an Helles Bock.","contributed_by":"John Jenkman <johnjenkman>"}]
    """
}

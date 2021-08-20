import 'package:PanayTranslator/model/region.dart';
import 'package:PanayTranslator/page/wiki/wikibuttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WikiPage extends StatelessWidget {
  final Region region;
  WikiPage(this.region);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        timeDilation = 1;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Wiki - ' + region.regionName!)),
        body: Container(
          child: Column(children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Center(
              child: PhotoHero(
                photo: region.logo,
                width: 300.0,
              ),
            ),
            Text(antique)
          ]),
        ),
      ),
    );
  }
}

String antique = """
Antique - Officially the Province of Antique, is a province in the Philippines located in the Western Visayas region. Its capital is San Jose de Buenavista, the most populous town in Antique. The province is situated in the western section of Panay Island and borders Aklan, Capiz and Iloilo to the east, while facing the Sulu Sea to the west.
The province is home to the indigenous Iraynun-Bukidnon, speakers of a dialect of the Kinaray-a language, who have crafted the only rice terrace clusters in the Visayas through indigenous knowledge and sheer vernacular capabilities. The rice terraces of the Iraynun-Bukidnon are divided into four terraced fields, namely, General Fullon Rice Terraces, Lublub rice terraces, Bakiang rice terraces, and San Agustin rice terraces. All of the rice terrace clusters have been researched by the National Commission for Culture and the Arts and various scholars from the University of the Philippines. There have been campaigns to nominate the Iraynun-Bukidnon Rice Terraces, along with the Central Panay Mountain Range, into the UNESCO World Heritage List.
Antique was one of the three sakups (districts) of Panay before Spanish colonizers arrived on the islands. The province was known at that time as Hantík, the local name for the large black ants found on the island. The Spanish chroniclers, influenced by the French, recorded the region's name as Hantique with the (silent 'h'), but this was only adopted in areas near Malandog River in present Hamtic town which then became the provincial capital (shortly before Bugason and San Jose). The province bearing its former capital's name is spelled and pronounced as "Antique" (än-ti-ké), without 'h' and pronounced in (Kinaray-a) dialectic way.
Historical Background
The story starts in Panay, an early semi-historical account tells of the coming of ten Bornean Datus led by Datu Puti at the mouth of Siwaragan (also, Sirwagan or Sirawagan) River near Andonna Creek in Sinogbuhan now San Joaquin, Iloilo. As stated in Hamtique Igcabuhi of 1981, their arrival was described as a story of flight which can be easily misinterpreted as an act of cowardice because they wanted to sail for greener pastures away from the cruelty of the governance in the Kingdom of Bulunay (now Brunei).
Along with the entourage of Datu Puti was Datu Sumakwel, a chieftain, who was sent to find a better place because Sinogbuhan fell below their expectations having too little to offer in food and water. Datu Sumakwel eventually landed further north at Malandog, now a barangay of Hamtic, Antique. He carried out the barter of Panay plains with one sadok of gold and a long gold necklace called manangyad, with Ati Chieftain Marikudo portrayed in late Amorsolo’s painting entitled the “Barter of Panay”.
As written by Amedo:
“On settling at Malandog, the wise Sumakwel engraved history- the first Malay settlement seeded the sprouting of Philippine civilized society.  A mini- Filipino state was born. The barangay served as the political base ruled by a benign monarchy, the datu, whose word was law but later wrote down a code of laws to govern the conduct of his people.”
To expound, datus Paiburong, Bangkaya and Sumakwel, designed the Confederation of Madya-as which came to govern Panay island and its districts: Hamtic, now Antique; Irong-irong now Iloilo, and Aklan formerly Capiz and now divided into Capiz and Aklan. This is according to the Visayan epic the “Maragtas”.
“While not every detail of the Maragtas account should be considered as truth, the fact is, we have a historical linkage with Borneo or Burnay (Brunei) through Raja Sulayman and Lakandula who established their kingdoms in Tondo and Manila”, stated in one of the articles of Dr. Alicia P. Magos.
The Code of Sumakwel was enacted to direct the constituents of Bornays in 1250. It served as a set of rules for the inhabitants of Panay Island. The island was divided into three sakops each headed by a datu all tailored into a formed confederation with Datu Sumakwel as the supreme lawgiver who was known as a busalian, a respected man with extraordinary competence.
In 1433, the Code of Kalantiao came out, which dealt to a more congested island state and had much wider range of providing strong penalties against criminal acts. It had 18 articles made by Datu Kalantiao, a descendant of Datu Bangkaya.
The thriving settlements of the Panay provinces were among the highlights of Antique’s pre-colonial life. The communities were usually located along the sea coast and near the rivers.
In the 16th century, Spaniards came to conquer Panay. The expedition of Miguel Lopez de Legaspi arrived in the Philippines in 1965 and landed in Cebu. Legaspi heard of the bountiful Panay and sent his men to explore the place for food. When they arrived, they discovered that indeed the island was booming. The streams and rivers were flowing in abundance and the people were very happy. The climate was refreshing and those sick from among the Spaniards were sent to Panay to rest for recovery. These statements were found in the accounts of Loarca, Collins, and Morga who attested to the high degree of civilization in the island.
During the Spanish regime, the Augustinians were the first group of missionaries who came to Antique. In 1581, the mission was fully established in the village of Hamtic with the Royal Decree making it a parish and putting up a religious house or convento. In 1596, the next parish founded was Nalupa (now Barbaza). In the early part of the 17th century, Hamtic was faced with the problem regarding a group of natives called the Mundos and the Cascados who refused to be converted to a Christian faith, dwelt to the mountains and also refused to leave their abodes located either inland or upland to be transferred to cabeceras. Hence, the imposition of the Spanish sovereignty in Antique was not eagerly welcomed by all Antiquenos.
Meanwhile, the eighteenth century was a significant period in the history of the province of Antique. Raids were conducted by the Muslims on some villages of Antique. Furthermore, parishes and towns were established by the Augustinians. Antique became a province separated from Iloilo in 1796.
In 1806, the parishes founded by the Augustinians were turned over to the seculars. Administration of the parishes or towns of Bugasong, Patnongon, Culasi, Cagayancillo, Sibalom, Hamtic, Dao and San Jose de Buenavista were carried over. Cabeceras were put up in southern places of Anini-y, San Remigio and Cagayancillo.
Discontentment was also observed in the nineteenth century. Intermittent disturbances interrupted the peace and order situation of the towns with regard to how some Spanish civil-ecclesiastical authorities governed them.
The “Maragtas” tells that there were revolts staged to abuses and cruelties of some Spanish officials and Agustinian friars. Earlier in 1828, a revolt was staged by secular priests against Señor Ureta who was a corrupt governor. Señor Antonio Ganos, another cruel and mean governor who replaced Ureta was chased away by the natives. It was in 1845 when Ramon Maza took the reins of the government signaling the start of civil rule by a governor of native descent.
Shortly before the Philippine Revolution, the “Igbaong Revolt” ignited in 1888 in San Remigio led by Gregorio Palermo. The revolt was a vain attempt to kill the priests in Hamtic for the rebels were repulsed on their way by civil guards. The secret activities continued until 1894.
Antique’s role in the Philippine Revolution of the 1890’s was also significant. In Antique, there were no signs of revolutionary activities until the arrival of General Leandro Fullon on September 6, 1898. It took General Fullon, who spent most of his time in Manila, to stir up the revolutionary activities in Antique. He courageously and successfully occupied the towns of Pandan, Culasi, Bugasong and eventually San Jose de Buenavista. He was ably supported by other Antiqueno revolutionary officers. Among the officers were Capt. Silvestre Salvio, 1st Lt. Felix Armada, 2nd Lt. Ruperto Abellon, Corporal Demetrio Nava, Col. Angel Salazar, Sr., Lt. Agustin Alcayre, Sgt. Juan Espino, Lt. Ignacio Pacete, and Lt. Manuel Gamo.
In April 13, 1901, a civil government under the Americans was put up in Antique to replace the military government. Two days after that Gen. Fullon was appointed provincial governor, the position which he held up to his death on October 16, 1904.
Remarkable bravery and native boldness had been expressed recurringly during the Philippine revolution against Spain and America and during the Guerilla movement against the Japanese.

""";

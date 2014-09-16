// Imports
//----------------------------------------------------

import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
import toxi.color.*;
import toxi.color.theory.*;
import toxi.util.datatypes.*;



//Canvas
PGraphics canvas;
int canvas_width, canvas_height;
float chartWidth, chartHeight;
float ratioWidth   = 1;
float ratioHeight  = 1;
float ratio        = 1;
int dpi             = 300;
float print_width   = 16;
int print_height    = 6;

JSONObject json;

int albumLength = 0;
String[] rappers = new String[10];

ColorList wutang           = new ColorList();
ColorList rappingSpeaking  = new ColorList();

float snippetMultiplier;
int dividerWidth = 5;

//Measurements
float xLabelWidthInches = 0;

void setup() {

  //background(255,255,255);
  
  canvas_width = int(print_width*dpi);
  canvas_height = int(print_height*dpi);

  float xLabelWidth = xLabelWidthInches*dpi;
  chartWidth = canvas_width-xLabelWidth;

  canvas = createGraphics(canvas_width, canvas_height);
  calculateResizeRatio(); 
   
  size(canvas_width/3,canvas_height/3);
  snippetMultiplier = (chartWidth/(3499.0+60.0));
  println(snippetMultiplier*(3499.0+60.0));
  
  //Assign rappers
  wutangClan();
  rappingSpeakingChorus();
  
  canvas.beginDraw();  
  canvas.colorMode(HSB, 1, 1, 1);
  canvas.noStroke();
  

  TColor background = TColor.newHSV(0.00, 0.00, 0.00);  
  canvas.background(background.hue(), background.saturation(), background.brightness()); 
  
  json = loadJSONObject("enterTheWutang.json");

       float rowHeight = canvas.height/rappers.length;
       float barPercentage = 0.7;
       float barHeight = rowHeight * barPercentage;
       float barMarginPercentage = (1-barPercentage)/2;
       float barMargin = rowHeight * barMarginPercentage;
       float totalHeight = (barHeight*rappers.length);
       float fontSize = barHeight*.5;
       
//Print xAxis Labels
//  for (int i = 0; i < rappers.length; i++) {
//   
//  RG.init(this);
//  
//      
//      int fontY = int(barMargin+barHeight-(fontSize/2));
//      RFont font = new RFont("FuturaStd-Medium.ttf", int(fontSize), RFont.RIGHT);
//  
//      canvas.fill(0.0, 0.0, 1.0);
//      canvas.pushMatrix();
//      canvas.translate(xLabelWidth - 50, (rowHeight*i)+fontY);
//      //println(rowHeight*i);
//      font.draw(rappers[i], canvas);
//      canvas.popMatrix(); 
//    
//}

//

  JSONArray enterTheWutang = json.getJSONArray("enterTheWutang");
  
  for (int i = 0; i < enterTheWutang.size(); i++) {
    
    JSONObject song = enterThe36Chambers.getJSONObject(i); 

    String songs = song.getString("song");
    int songMinutes = song.getInt("lengthMinute");
    int songSeconds = song.getInt("lengthSeconds");
    int songLength = songMinutes*60+songSeconds;
    
    String minutes = nf(albumLength/60, 0);
    String seconds = nf(albumLength%60, 2);
    String yTitle = songs + " (" + minutes + ":" + seconds + ")";
    yTitle = yTitle.toUpperCase();
    println(enterTheWutang.size());
    
//    //Print yAxis Label
//    
//      
//      RFont font = new RFont("FuturaStd-Medium.ttf", int(fontSize), RFont.LEFT);
//  
//      canvas.fill(0.0, 0.0, 1.0);
//      canvas.pushMatrix();
//      canvas.translate(xLabelWidth + albumLength, i*200);
//      //println(rowHeight*i);
//      RGroup group = font.toGroup(yTitle);
//      font.rotate(90.0);
//      font.draw(yTitle, canvas);
//      canvas.popMatrix(); 
    
    
    JSONArray snippets = song.getJSONArray("snippets");
     TColor dividers = TColor.newHSV(0.00, 0.00, 1.00);
     canvas.beginShape();
     canvas.pushMatrix();
     canvas.translate(xLabelWidth, 0);
     canvas.fill(dividers.hue(), dividers.saturation(), dividers.brightness());
     canvas.rect(0, 0, dividerWidth*snippetMultiplier, canvas.height);
     canvas.popMatrix();
     canvas.endShape(CLOSE);
   
    for (int j = 0; j < snippets.size(); j++) {
      
     JSONObject snippet = snippets.getJSONObject(j);     
     String artist = snippet.getString("artist");
     String type = snippet.getString("type");
     int startTimeMinute = snippet.getInt("startTimeMinute");
     int startTimeSecond = snippet.getInt("startTimeSecond");
     int endTimeMinute = snippet.getInt("endTimeMinute"); 
     int endTimeSecond = snippet.getInt("endTimeSecond"); 
     int startTime = (startTimeMinute*60)+startTimeSecond;
     int endTime = (endTimeMinute*60)+endTimeSecond;     
     int snippetLength = endTime-startTime+1;
     
     int artistMultiplier = 0;

     if (artist.equals("Ghostface")) {
       artistMultiplier = 0;
     }
          else if (artist.equals("GZA")) {
       artistMultiplier = 1;
     }
     
          else if (artist.equals("Inspectah Deck")) {
       artistMultiplier = 2;
     }
     
          else if (artist.equals("Masta Killa")) {
       artistMultiplier = 3;
     }
     
    else if (artist.equals("Method Man")) {
       artistMultiplier = 4;
     }

     else if (artist.equals("ODB")) {
       artistMultiplier = 5;
     }
     
          else if (artist.equals("Raekwon")) {
       artistMultiplier = 6;
     }
     
               else if (artist.equals("RZA")) {
       artistMultiplier = 7;
     }
     
     else if (artist.equals("U-God")) {
       artistMultiplier = 8;
     }
     
     else if (artist.equals("Shaolin")) {
       artistMultiplier = 9;
     }
     canvas.beginShape();
     
     TColor c;
     int rapSpeak=0;
     
     if (type.equals("rap")) {
      
     rapSpeak = 0;
}
     else if (type.equals("speaking")) {
     rapSpeak = 1;
     }
     
     else if (type.equals("chorus")) {
     rapSpeak = 2;
     }
      c = rappingSpeaking.get(rapSpeak);
      canvas.fill(c.hue(), c.saturation(), c.brightness());
      
      canvas.pushMatrix();
      canvas.translate(xLabelWidth+((albumLength+(dividerWidth*i))*snippetMultiplier), rowHeight*artistMultiplier);
      
      //int barX = int((albumLength+startTime)*snippetMultiplier);
      
    
      int barX = int((startTime)*snippetMultiplier);
//      int barY = int((rowHeight*artistMultiplier)+(barMargin));
      int barY = int(barMargin);
      //println(barY);
      canvas.rect(barX, barY, (snippetLength*snippetMultiplier), barHeight);
      canvas.popMatrix();
      
     canvas.endShape(CLOSE);
     

    }
  
albumLength = albumLength + songLength;
//println (albumLength);
if (i < enterThe36Chambers.size()-1) {
canvas.beginShape();
    
     canvas.pushMatrix();
     //canvas.translate(xLabelWidth, 0);
     canvas.translate(xLabelWidth+((albumLength+(dividerWidth*i))*snippetMultiplier), 0);
     canvas.fill(dividers.hue(), dividers.saturation(), dividers.brightness());
     canvas.rect(0, 0, dividerWidth*snippetMultiplier, canvas.height);
     canvas.popMatrix();
canvas.endShape(CLOSE);
}
}

  
       canvas.endDraw();
//     cham
        canvas.save("wutang" + year()+day()+hour()+minute()+ ".tif");
        image(canvas, 0, 0, width, height);
}

void calculateResizeRatio()
{
  ratioWidth = (float) width / (float) canvas.width;
  ratioHeight = (float) height / (float) canvas.height;

  if (ratioWidth < ratioHeight)  ratio = ratioWidth;
  else                          ratio = ratioHeight;
}

void rappingSpeakingChorus() {
  
  rappingSpeaking.add(TColor.newHSV(0.947, 1, 1));        //RAPPING
  rappingSpeaking.add(TColor.newHSV(0.547, 1.0, 0.5));    //SPEAKING/SKIT/INTERLUDE
  rappingSpeaking.add(TColor.newHSV(0.263, .67, .8));     //CHORUS     

}

void wutangClan() {

  rappers[0] = "GHOSTFACE KILLAH";
  rappers[1] = "GZA";
  rappers[2] = "INSPECTAH DECK";
  rappers[3] = "MASTA KILLA";
  rappers[4] = "METHOD MAN";
  rappers[5] = "OL' DIRTY BASTARD";
  rappers[6] = "RAEKWON";
  rappers[7] = "RZA";
  rappers[8] = "U-GOD";
  rappers[9] = "SHAOLIN SAMPLE";
}






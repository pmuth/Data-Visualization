import toxi.color.*;
import toxi.color.theory.*;
import toxi.util.datatypes.*;

JSONObject json;

PGraphics canvas;

int canvas_width = 2432;  
int canvas_height = 3206; 

float ratioWidth = 1;
float ratioHeight = 1;
float ratio = 1;

void setup() {

  //background(255,255,255);
  
  canvas = createGraphics(canvas_width, canvas_height);
  calculateResizeRatio(); 
   
   size(550,450);
  canvas.beginDraw();
  
  canvas.colorMode(HSB, 360, 100, 100);
  canvas.background(0, 0, 0); 
  
  json = loadJSONObject("drakefeaturingdrake1.json");

  JSONArray drakeSongs = json.getJSONArray("drakeSongs");
  
  for (int i = 0; i < drakeSongs.size(); i++) {
  //for (int i = 0; i < 1; i++) {  
    
    JSONObject song = drakeSongs.getJSONObject(i); 

    String songs = song.getString("song");
    String mainArtist = song.getString("mainArtist");
    String feature = song.getString("feature");
    
    println(songs + " - " + mainArtist + " (feat. " + feature + ")");
    
     int drakeTotal = 0;
     int twoChainzTotal = 0;
     int rickRossTotal = 0;
     int meekMillTotal = 0;
     int frenchMontanaTotal = 0;
     int lilWayneTotal = 0;
     int rockyTotal = 0;
     int kendrickLamarTotal = 0;
     int rihannaTotal = 0;
     int futureTotal = 0;
    
    JSONArray snippets = song.getJSONArray("snippets");
    println("SNIPPETS");  
    for (int j = 0; j < snippets.size(); j++) {
     
     JSONObject snippet = snippets.getJSONObject(j);     
     String artist = snippet.getString("artist");
     int startTime = snippet.getInt("startTime");
     int endTime = snippet.getInt("endTime"); 
     int snippetLength = endTime-startTime+1;
     HSBColor color1 = new HSBColor(0, 100, 100);
  

   if (artist.equals("Drake")) {
       drakeTotal += snippetLength;
     } 

     else if (artist.equals("2 Chainz")) {
       twoChainzTotal += snippetLength;
     }
     
     else if (artist.equals("Rick Ross")) {
      rickRossTotal += snippetLength;
     }
          else if (artist.equals("Meek Mill")) {
    meekMillTotal += snippetLength;
     }
     
     else if (artist.equals("French Montana")) {
          frenchMontanaTotal += snippetLength;
     }
     else if (artist.equals("Lil Wayne")) {
            lilWayneTotal += snippetLength;
     }
     
     else if (artist.equals("A$AP Rocky")) {
            rockyTotal += snippetLength;
     }
          else if (artist.equals("Kendrick Lamar")) {
   kendrickLamarTotal += snippetLength;
     }
     
     else if (artist.equals("Rihanna")) {
rihannaTotal += snippetLength;
     }
          else if (artist.equals("Future")) {
futureTotal += snippetLength;
     }
     
    }
    
       int totalLength = 0;
       float lengthMultiplier = 8;
       int barHeight = 200;
       int leftMargin = 0;
       float gutterSize = barHeight*0.67;
       float totalBar = barHeight+gutterSize;
       float totalHeight = (barHeight*10)+(gutterSize*10);
       println(totalHeight);
       
       canvas.beginShape();
       
       HSBColor color1 = new HSBColor(0, 100, 100);
       HSBColor drake = color1; 
       drake.display((totalLength)+leftMargin, (i*totalBar), drakeTotal*lengthMultiplier, barHeight);
       totalLength += drakeTotal*lengthMultiplier;
       
       HSBColor twoChainz = new HSBColor((color1.h+(2*36))%360, 100, 100); 
       twoChainz.display((totalLength)+leftMargin, (i*totalBar), twoChainzTotal*lengthMultiplier, barHeight); 
       totalLength += twoChainzTotal*lengthMultiplier;
  
       HSBColor rickRoss = new HSBColor((color1.h+(4*36))%360, 100, 100); 
       rickRoss.display((totalLength)+leftMargin, (i*totalBar), rickRossTotal*lengthMultiplier, barHeight);
       totalLength += rickRossTotal*lengthMultiplier;
       
       HSBColor meekMill = new HSBColor((color1.h+(3*36))%360, 100, 100); 
       meekMill.display((totalLength)+leftMargin, (i*totalBar), meekMillTotal*lengthMultiplier, barHeight);
       totalLength += meekMillTotal*lengthMultiplier;
     
       HSBColor frenchMontana = new HSBColor((color1.h+(1*36))%360, 100, 100); 
        frenchMontana.display((totalLength)+leftMargin, (i*totalBar), frenchMontanaTotal*lengthMultiplier, barHeight);
       totalLength += frenchMontanaTotal*lengthMultiplier;
    
             HSBColor lilWayne = new HSBColor((color1.h+(5*36))%360, 100, 100); 
       lilWayne.display((totalLength)+leftMargin, (i*totalBar), lilWayneTotal*lengthMultiplier, barHeight); 
       totalLength += lilWayneTotal*lengthMultiplier;
       
       HSBColor rocky = new HSBColor((color1.h+(6*36))%360, 100, 100); 
       rocky.display((totalLength)+leftMargin, (i*totalBar), rockyTotal*lengthMultiplier, barHeight);
       totalLength += rockyTotal*lengthMultiplier;
       
       HSBColor kendrickLamar = new HSBColor((color1.h+(7*36))%360, 100, 100); 
       kendrickLamar.display((totalLength)+leftMargin, (i*totalBar), kendrickLamarTotal*lengthMultiplier, barHeight);
       totalLength += kendrickLamarTotal*lengthMultiplier;
       
              HSBColor rihanna = new HSBColor((color1.h+(8*36))%360, 100, 100); 
       rihanna.display((totalLength)+leftMargin, (i*totalBar), rihannaTotal*lengthMultiplier, barHeight);
       totalLength += rihannaTotal*lengthMultiplier;
 
        HSBColor future = new HSBColor((color1.h+(9*36))%360, 100, 100); 
       future.display((totalLength)+leftMargin, (i*totalBar), futureTotal*lengthMultiplier, barHeight);
       totalLength += futureTotal*lengthMultiplier;
       
       if (i == drakeSongs.size()-1) {
       println(totalLength);
       }
       canvas.endShape(CLOSE);
       
       canvas.endDraw();
     
       canvas.save("makerbot" + year()+day()+hour()+minute()+ ".tif");
       image(canvas, 0, 0, width, height);
    
    println(drakeTotal);
  }
}

void calculateResizeRatio()
{
  ratioWidth = (float) width / (float) canvas.width;
  ratioHeight = (float) height / (float) canvas.height;

  if (ratioWidth < ratioHeight)  ratio = ratioWidth;
  else                          ratio = ratioHeight;
}






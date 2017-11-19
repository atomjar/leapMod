//importing in libraries
import ddf.minim.*;
import ddf.minim.ugens.*;
import de.voidplus.leapmotion.*;

//setting global variables
LeapMotion leap;
Finger finger_index;
Minim minim;
AudioOutput out;
Oscil fm;


void setup() {
  size(800, 800);
  background(0);

  minim = new Minim(this);
  out   = minim.getLineOut();
  leap  = new LeapMotion(this);
  
  // Make the Oscil we will hear. Arguments are frequency, amplitude, and waveform
  Oscil wave = new Oscil(200, 0.8, Waves.SINE);
  
  // Make the Oscil we will use to modulate the frequency of wave.
  // the frequency of this Oscil will determine how quickly the
  // frequency of wave changes and the amplitude determines how much.
  fm   = new Oscil(10, 2, Waves.TRIANGLE);
  
  // set the offset of fm so that it generates values centered around 200 Hz
  fm.offset.setLastValue(200);
  
  // patch it to the frequency of wave so it controls it
  fm.patch(wave.frequency);
  
  // and patch wave to the output
  wave.patch(out);

}


void draw() {
  background(0);
  
  for(Hand hand : leap.getHands()) { 
   finger_index = hand.getIndexFinger();
   
    moveFinger();
  } 
} 


void moveFinger () {
  
  float modulateAmount = map(finger_index.getPosition().y, 0, height, 1, 220 );
  float modulateFrequency = map(finger_index.getPosition().x, 0, width, 0.1, 800 );

  
  fm.setFrequency(modulateFrequency);
  fm.setAmplitude(modulateAmount);
}


 
 
 
 
    //pushMatrix();
    //translate(finger_index.getPosition().x, finger_index.getPosition().y, -200);
    //noFill();
    //stroke(255);
    //sphere(88);
    //popMatrix();
    
    // draw the waveforms
    //stroke( 255 );
    //for( int i = 0; i < out.bufferSize() - 1; i++ ) {
    //  // find the x position of each buffer value
    //  float x1  =  map( i, 0, out.bufferSize(), 0, width );
    //  float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
      
    //  // draw a line from one buffer position to the next for both channels
    //  line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    //  line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
    //}  
/**
 * Based on EditTextControls
 */

import g4p_controls.*;

matriz simplex;

GTabManager tt;

int condiciones=3;
int variables=2;
int paso=0;
GButton btnMdialog;
float[][] matrizOriginal;
float[][] pasoActual;
GLabel lblReply;
ArrayList<float[][]> matrices;
  
public void setup() {
  size(800, 600);
  G4P.setGlobalColorScheme(GCScheme.RED_SCHEME);
  simplex=new matriz(condiciones, variables,this);
  matrizOriginal=new float[simplex.cantFilasOriginal()][simplex.cantColumnasOriginal()];
  pasoActual=new float[simplex.cantFilasSimplex()][simplex.cantColumnasSimplex()];//Agrego las 'S'
  simplex.recorreMatrixY("dibujaInputMatrix", matrizOriginal);
  btnMdialog = new GButton(this, 50, 200, 80, 20,  "Calc");
  matrices = new ArrayList();
//  btnMdialog = new GButton(this, 100, 200, 80, 20, "Next");
//  btnMdialog = new GButton(this, 150, 200, 80, 20, "Prev");
  
}

public void draw() {
  background(240, 240, 200);
  // Draw tab order
  stroke(0);
  strokeWeight(2);
  switch(paso) {
  case 1: 
    pasoActual=simplex.devuelveMatrizIngresada();
    simplex.recorreMatrixY("dibujaOutputMatrix",pasoActual);
    matrices.add(simplex);
    break;
  default:
    break;
  }
}

public void handleTextEvents(GEditableTextControl tc, GEvent event) { 
  System.out.print("\n" + tc.tag + "   Event type: ");
  switch(event) {
  case CHANGED:
    System.out.println("CHANGED");
    break;
  case SELECTION_CHANGED:
    System.out.println("SELECTION_CHANGED");
    System.out.println(tc.getSelectedText() + "\n");
    break;
  case ENTERED:
    System.out.println("ENTER KEY TYPED");
    System.out.println(tc.getSelectedText() + "\n");
    break;
  default:
    System.out.println("UNKNOWN");
  }
}

public void handleButtonEvents(GButton button, GEvent event) { 
  if(button == btnMdialog) {
   paso=1;
  }
}
 

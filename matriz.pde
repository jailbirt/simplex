//Clase usada para dibujar la matriz y los resultados en pantalla.

class matriz {
  GTextField[][] camposIngresar;
  GLabel[][]     camposMostrar;
  float[][]      simplex;
  PApplet        parent;  
  //Cantidad de condiciones y variables
  int cantFilasOriginal, cantColumnasOriginal, cantFilasSimplex,cantColumnasSimplex;
  GTabManager tt;

  //START Funcion constructora del panelIngreso2, ingreso uno son restricciones y tipo de problema. TODO!!!!!HERE!!!!
  matriz (int condiciones, int variables, PApplet parent) {
    this.parent=parent;
    cantFilasOriginal=cantFilasSimplex=condiciones;
    cantColumnasOriginal=variables+1;
    cantColumnasSimplex=(variables+condiciones+1);//Las 'S' y la condición última.
    
    camposIngresar = new GTextField[cantColumnasOriginal][cantColumnasOriginal];
    camposMostrar    = new GLabel[cantFilasSimplex][cantColumnasSimplex];
  }
  //END funcion Constructora

  //Getters.
  int cantFilas () {
    return cantFilasSimplex;
  }
  int cantColumnas () {
    return cantColumnasSimplex;
  }

  String devuelveValorFilaColumna(int fila, int columna) {
    return this.camposIngresar[fila][columna].getText();
  }
   
  //Fin Getters.
  //Setters.
  //Fin Setters.

  void dibujaInputMatrix(int fila,int columna) {  
    System.out.println("c "+fila+"v "+columna+"Cant C "+cantColumnasOriginal+" Cant F "+cantFilasOriginal);
    this.camposIngresar[fila][columna]= new GTextField(parent, fila*20*4, columna*20*4, 60, 40); 
    this.camposIngresar[fila][columna].tag = "F"+fila+"C"+columna;
    this.camposIngresar[fila][columna].setDefaultText("F"+(fila+1)+"C"+(columna+1));
  }
  void recorreMatrixY(String operacion, float [][] matriz) {
    tt = new GTabManager();
    for (int fila=0;fila<matriz.length;fila++) {
      for (int columna=0;columna<matriz[0].length  ;columna++) {
       if (operacion == "dibujaInputMatrix"){
          dibujaInputMatrix(fila,columna);
          // Create the tab manager and add these controls to it
          tt.addControl(camposIngresar[fila][columna]);     
       }
        else if("dibujaOutputMatrix" == operacion) {
          dibujaOutputMatrix(fila,columna,matriz);
          parent.line(300, cantColumnasSimplex*20*4, 300+(cantFilasSimplex*20*4), cantColumnasSimplex*20*4);
          parent.line(300+(cantFilasSimplex*20*4), 1, 300+(cantFilasSimplex*20*4), cantColumnasSimplex*20*4);
        }
        else {

        } 
      }
    }
  }

 void dibujaOutputMatrix(int fila,int columna,float[][] pasoActual) {
          parent.line(300+(fila*20*4), columna*20*4, 380+(fila*20*4), columna*20*4);
          parent.line(300+(fila*20*4), columna*20*4, 300+(fila*20*4), 70+(columna*20*4));
          camposMostrar[fila][columna] = new GLabel(parent, 300+(fila*20*4), columna*20*4, 60, 40);   
          camposMostrar[fila][columna].setText(Float.toString(pasoActual[fila][columna]));
          camposMostrar[fila][columna].setLocalColorScheme(G4P.GREEN_SCHEME);
          camposMostrar[fila][columna].setTextAlign(GAlign.CENTER, GAlign.MIDDLE); 
 }
}

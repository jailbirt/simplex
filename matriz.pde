//Clase usada para dibujar la matriz y los resultados en pantalla.

class matriz {
  GTextField[][] camposIngresar;
  GLabel[][]     camposMostrar;
  float[][]      simplex;
  PApplet        parent;  
  //Cantidad de condiciones y variables
  int cantFilasSimplex,cantColumnasSimplex,cantVariables;
  GTabManager tt;

  //START Funcion constructora del panelIngreso2, ingreso uno son restricciones y tipo de problema. TODO!!!!!HERE!!!!
  matriz (int condiciones, int variables, PApplet parent) {
    this.parent=parent;
    cantFilasSimplex=condiciones;
    cantColumnasSimplex=(variables+condiciones+1);//Las 'S' y la condición última.
    cantVariables=variables;
    
    camposIngresar  = new GTextField[cantFilasSimplex][cantColumnasSimplex]; //Input
    camposMostrar   = new GLabel[cantFilasSimplex][cantColumnasSimplex];//lavels que se muestran
    simplex         = new float[cantFilasSimplex][cantColumnasSimplex];  //Operaciones aca.
  }
  //END funcion Constructora

  //Getters.
  int cantFilasSimplex () {
    return cantFilasSimplex;
  }
  int cantColumnasSimplex () {
    return cantColumnasSimplex;
  }
  String devuelveValorFilaColumna(int fila, int columna) {
    return this.camposIngresar[fila][columna].getText();
  }
  GLabel[][] devuelveMatrizAMostrar(){
    return this.camposMostrar;
  }
  float[][] devuelveMatrizIngresada(){
    for (int fila=0;fila<cantFilasSimplex;fila++) 
      for (int columna=0;columna<cantColumnasSimplex;columna++) 
        if(camposIngresar[fila][columna].getText()!=null && !camposIngresar[fila][columna].getText().equals("") )
         simplex[fila][columna]=Float.parseFloat(camposIngresar[fila][columna].getText());
        else
         simplex[fila][columna]=0;
    return simplex;
  }
  //Fin Getters.
  //Setters.
  //Fin Setters.
 void dibujaOutputMatrix(int fila,int columna,PApplet parent) {
          //parent.line(columna*20*4,360+(fila*20*4) , columna*20*4,440+(fila*20*4) );
          //parent.line(columna*20*4,360+(fila*20*4) ,  70+(columna*20*4),360+(fila*20*4));
          camposMostrar[fila][columna] = new GLabel(parent, columna*20*4,60+(fila*20*4) , 60, 40);   
          camposMostrar[fila][columna].setText(Float.toString(simplex[fila][columna]));
          camposMostrar[fila][columna].setLocalColorScheme(G4P.GREEN_SCHEME);
          camposMostrar[fila][columna].setTextAlign(GAlign.CENTER, GAlign.MIDDLE); 
          camposMostrar[fila][columna].setVisible(true);
          
          camposMostrar[fila][columna].setOpaque(true);
 }
 
  void dibujaInputMatrix(int fila,int columna) {  
    this.camposIngresar[fila][columna]= new GTextField(parent,columna*20*4 ,(fila*20*4)+60 , 60, 40); 
    this.camposIngresar[fila][columna].tag = "F"+fila+"C"+columna;
    this.camposIngresar[fila][columna].setDefaultText("F"+(fila+1)+"C"+(columna+1));
    camposIngresar[fila][columna].setVisible(true);
  }
    void disableInputMatrix(int fila,int columna) {  
    // System.out.println(" Filas"+fila+" columnas "+columna);
    this.camposIngresar[fila][columna].setVisible(false);
  }
      void disableOutputMatrix(int fila,int columna) {  
    // System.out.println(" Filas"+fila+" columnas "+columna);
    this.camposMostrar[fila][columna].setVisible(false);
  }
  void recorreMatrixY(String operacion, float [][] matriz, PApplet parent) {
    tt = new GTabManager();
    for (int fila=0;fila<matriz.length;fila++) {
      for (int columna=0;columna<matriz[0].length  ;columna++) {
         // System.out.println(" Filas"+fila+" columnas "+columna);
         if (fila == 0) {
           muestraLabelsMatrix(30,fila,columna,matriz,parent);
         }
       if ("dibujaInputMatrix" == operacion){
          dibujaInputMatrix(fila,columna);
          // Create the tab manager and add these controls to it
          tt.addControl(camposIngresar[fila][columna]);     
       }
        else if("dibujaOutputMatrix" == operacion) { //convierte a simplex.
          simplex[fila][columna]=matriz[fila][columna];
          dibujaOutputMatrix(fila,columna,parent);
          //parent.line( cantColumnasSimplex*20*4, 360, cantColumnasSimplex*20*4, 360+(cantFilasSimplex*20*4));
          //parent.line( 1,360+(cantFilasSimplex*20*4), cantColumnasSimplex*20*4, 360+(cantFilasSimplex*20*4));
        }
        else if("disableInputMatrix" == operacion)  //convierte a simplex.
          disableInputMatrix(fila,columna);
       
         else if("disableOutputMatrix" == operacion)  //convierte a simplex.
          disableOutputMatrix(fila,columna);
       
        else {}

        
      }
    }
  }
  //Metodo que agrega titulos, poner el offset de Y como parametro.
  void muestraLabelsMatrix(int offset,int fila,int columna,float [][] matriz,PApplet parent){
           fill(0);
           GLabel rotulos=new GLabel(parent, columna*20*4,offset+(fila*20*4) , 60, 40);
           String texto="";
           if ((columna+1)==(matriz[0].length)){
            texto="b";
           }
           else if((columna+1)>cantVariables){
            texto="S"+(columna+1-cantVariables);
           }
           else{
            texto="X"+(columna+1);
           }

           //System.out.println("Sacando.."+texto+"para f "+fila+"col "+(columna+1)+" cant mat"+matriz[0].length+ "cant col"+cantColumnasSimplex);
           rotulos.setText(texto);
           textSize(32);
           //fin
  }

}

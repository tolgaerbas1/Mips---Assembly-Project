public class MyClass {
    
    public static void main(String args[]) {
      
      int [] matrixA = { 1, 2, 3, 4,
                         5, 6, 7, 8, 
                         9, 10, 11, 12 }; // matrix A is a 3 x 4 matrix.
      
      int [] matrixB = { 1, 2,
                         3, 4,
                         5, 6,
                         7, 8 }; // matrix B is a 4 x 2 matrix.
      
      int [] matrixC = new int [ 3 * 2 ]; // matrix C is a 3 x 2 matrix 
      
      int a = 3; // row length matrix A.
      int b = 4; // row length matrix B # this is column length of matrix A at the same time. 
      int c = 2; // column length of matrix B
      
      for (int i = 0; i < a; i++){
          for(int j = 0; j < c; j++){
              for(int k = 0; k < b; k++){
                
                matrixC [ i * c + j ] += matrixA [ b * i + k ] * matrixB [ c * k + j ];
                   
              }
              
              System.out.print(matrixC [ i * c + j ] + " ");
              
          }
         System.out.println();
      }
      
      /* int lengthC = matrixC.length;
      
      for( int i = 0; i < lengthC; i++){
          
        System.out.println( matrixC[i] + " ");    
          
      } */
      
      
      
    }
}
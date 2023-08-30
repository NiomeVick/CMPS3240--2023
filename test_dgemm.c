#include <stdio.h>
#include <stdlib.h>

void dgemm(int n, double *A, double *B, double *C) {

    for( int i = 0; i < n; ++i )
        for (int j = 0; j < n; ++j) {
            double cij = C[i+j*n]; /* cij = C[i][j] */
            for (int k = 0; k < n; k++ )
                cij += A[i+k*n] * B[k+j*n]; /* cij += A[i][k]*B[k][j] */
            C[i+j*n] = cij; /* C[i][j] = cij */
        }
}

//  The benchmark
int main( void ) {
  const int N = 1024; // The benchmark runs on a fixed size of work
  printf( "Running DGEMM operation of size %d x 1\n", N );

  double *A = (double *) malloc( N * N * sizeof(double) );      // First vector
  double *B = (double *) malloc( N * N * sizeof(double) );      // Second vector
  double *C = (double *) malloc( N * N * sizeof(double) );      // Third vector
 
   dgemm(N, A, B, C); 
   
   // Free up the memory
   free( A );
   free( B );
   free( C );

   return 0;
}

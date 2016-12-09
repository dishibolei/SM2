#ifndef SM3_H
#define SM3_H

#ifndef DWORD
typedef unsigned long DWORD;
#endif
#ifndef BYTE
typedef unsigned char BYTE;
#endif

#ifdef __cplusplus
extern "C" {
#endif

void SM3_Init();
void SM3_Update(BYTE *message, DWORD length);
void SM3_Final_dword(DWORD *out_hash);
void SM3_Final_byte(BYTE *out_hash);
void SM3_Final(DWORD *out_hash);

/*
 * output = SM3( input buffer )
 */
void sm3( unsigned char *input, long ilen,
         unsigned char output[32] );

#ifdef __cplusplus
}
#endif
    
#endif

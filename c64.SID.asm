; ------------------------------------------------------------------------------------------------------------- ;
; MOS6581 Sound Interface Device (SID) Registers - $D400-$D41C
; ------------------------------------------------------------------------------------------------------------- ;
SID                         = $D400             ; Base Address
SID_LEN                       = $1d             ; SID possible address space (32) - $1d (29) used / remaining $03 (03) unused
; ------------------------------------------------------------------------------------------------------------- ;
; Mclk: C64 master clock      PAL : Mclk = 17.734475 MHz          NTSC: Mclk = 14.318180 MHz
; Fclk: CPU input frequency   PAL : Fclk = Mclk/18 = 985.248 Hz   NTSC: Fclk = Mclk/14 = 1.022.727 Hz
; Fout: Desired frequency
; Fn  : 16-bit number in the freq registers --> 0-65535 ($0000-$ffff)
; ------------------------------------------------------------------------------------------------------------- ;
; The SID has an internal 24-bit accumulator for the waveforms
; One period of a waveform has $ff.ffff (16.777.216) defined values
; The Oscillator frequency is calculated:
; 
;   Fout = (Fn * Fclk / 16777216) Hz
; 
;   PAL:  Fout = (Fn * 0,05873) Hz  -->  range of possible output freqs is 0-3849 Hz
;   NTSC: Fout = (Fn * 0,06096) Hz  -->  range of possible output freqs is 0-3995 Hz
; ------------------------------------------------------------------------------------------------------------- ;
; 12 semitones = 1 octave (c c# d d# e f f# g g# a a# b)
; Any two adjacent notes differ in freq by a factor of 2^1/12 or 1,05946
; The freq of the next higher note will be equal to the current note freq * 1,05946
; The freq of the next lower  note will be equal to the current note freq / 1,05946
; 
; The freq of a note in one octave and that of a note with the same letter in a higher or
; lower octave will differ by a factor of 2 times the number of octaves between the notes
; 
; Example: 
;   The freq of the concert pitch a' is in octave 3 (count starts at octave 0) at 440 Hz
;   The A in octave 2 has a freq of 220 Hz (440 / 2) and the A in octave 4 has a freq of  880 Hz (440 * 2)
;   The A in octave 1 has a freq of 110 Hz (440 / 4) and the A in octave 5 has a freq of 1760 Hz (440 * 4)
; 
;   The concert pitch a' is the 10th tone in the 4th octave (4*12 + 10 - 1 = 57)
;   freq=2^(num/12)*16.35 hz  (16.35=freq lowest tone) --> 2^(57/12)*16.35=439.957 hz
; 
;   num +  1 = set next next semitone (0=C, 1=C#, 3=D, ...)
;   num + 12 = set next octave
; ------------------------------------------------------------------------------------------------------------- ;
; Voice 1 - all registers WRITE only
; ------------------------------------------------------------------------------------------------------------- ;
FREQLO1                     = SID + $00         ; 16 Bit Frequency Control Number Low-Byte
FRELO1                      = FREQLO1           ; 
; ------------------------------------------------------------------------------------------------------------- ;
;       Fout = (Fn * Fclk / 16777216) Hz
; PAL:  Fout = (Fn * 0,05873) Hz  -->  range of possible output freqs is 0-3849 Hz
; NTSC: Fout = (Fn * 0,06096) Hz  -->  range of possible output freqs is 0-3995 Hz
; ------------------------------------------------------------------------------------------------------------- ;
FREQLO1_F0                    = %00000001       ; 
FREQLO1_F1                    = %00000010       ; 
FREQLO1_F2                    = %00000100       ; 
FREQLO1_F3                    = %00001000       ; 
FREQLO1_F4                    = %00010000       ; 
FREQLO1_F5                    = %00100000       ; 
FREQLO1_F6                    = %01000000       ; 
FREQLO1_F7                    = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
FREQHI1                     = SID + $01         ; 16 Bit Frequency Control Number High-Byte
FREHI1                      = FREQHI1           ; 
FREQHI1_F8                    = %00000001       ; 
FREQHI1_F9                    = %00000010       ; 
FREQHI1_F10                   = %00000100       ; 
FREQHI1_F11                   = %00001000       ; 
FREQHI1_F12                   = %00010000       ; 
FREQHI1_F13                   = %00100000       ; 
FREQHI1_F14                   = %01000000       ; 
FREQHI1_F15                   = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
PWLO1                       = SID + $02         ; 12 Bit Pulse Waveform Width (duty cycle) Low-Byte
; ------------------------------------------------------------------------------------------------------------- ;
; 12-bit resolution number linearly controls the width (duty cycle) of the Pulse waveform of Voice 1
; Voice 1 must be set to Pulse in order to have any audible effect
; 
; PWout = (PWn / 40.95) %
;   PWn = the 12-bit register value
; 
; PWout: percentage of the total waveform cycle spent in the max amplitude state
;   a Pulse waveform with a duty cycle of   0% ($000) is constantly off
;   a Pulse waveform with a duty cycle of 100% ($fff) is constantly at max amplitude
;   a Pulse waveform with a duty cycle of  50% ($800) is at max amplitude for half of the cycle
;                                                     and off for the remaining half resulting in a square wave
; ------------------------------------------------------------------------------------------------------------- ;
PWLO1_PW0                     = %00000001       ; 
PWLO1_PW1                     = %00000010       ; 
PWLO1_PW2                     = %00000100       ; 
PWLO1_PW3                     = %00001000       ; 
PWLO1_PW4                     = %00010000       ; 
PWLO1_PW5                     = %00100000       ; 
PWLO1_PW6                     = %01000000       ; 
PWLO1_PW7                     = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
PWHI1                       = SID + $03         ; 12 Bit Pulse Waveform Width (duty cycle) High Byte
PWHI1_PW8                     = %00000001       ; 
PWHI1_PW9                     = %00000010       ; 
PWHI1_PW10                    = %00000100       ; 
PWHI1_PW11                    = %00001000       ; 
                                                ; 
                              ; %00010000       ;   Bit 12: <unused>
                              ; %00100000       ;   Bit 13: <unused>
                              ; %01000000       ;   Bit 14: <unused>
                              ; %10000000       ;   Bit 15: <unused>
                                                ; 
PWHI1_MASK                    = %00001111       ;   Bit  8-12: high nibble
PWHI1_MASK_NOUSE              = %11110000       ;   Bit 12-15: unused
; ------------------------------------------------------------------------------------------------------------- ;
CNTRL1                      = SID + $04         ; Control Register
VCREG1                      = CNTRL1            ; 
CNTRL1_GATE                   = %00000001       ;   Bit 0: Gates (triggers) the Envelope Generator
CNTRL1_GATE_ADS                 = %00000001     ;                              (1=Start ATTACK/DECAY/SUSTAIN cycle)                 
CNTRL1_GATE_REL                 = %11111110     ;                              (0=Start RELEASE cycle)
CNTRL1_SYNC                   = %00000010       ;   Bit 1: Sync voice 1 and 3: (1=On)
                                                ;          Varying the frequency of Voice 1 with respect to Voice 3
                                                ;          produces a wide range of complex harmonic structures
                                                ;          from Voice 1 at the frequency of Voice 3 ('Hard Sync' effects)
                                                ;          In order for SYNC to occur
                                                ;            Voice 3 must be set to some frequency other than zero
                                                ;            but preferably lower than the frequency of Voice 1
                                                ;              No other parameters of Voice 3 have any effect on SYNC
CNTRL1_RINGMOD                = %00000100       ;   Bit 2: Ring Modulation:    (1=Ring modulate Voices 1 and 3)
                                                ;          Replace the Triangle waveform output of Voice 1 
                                                ;          with a 'Ring Modulated' combination of Voice 1 and 3
                                                ;          Produces a wide range of non-harmonic overtone structures
                                                ;          for creating bell or gong sounds and for special effects
                                                ;          In order for ring modulation to be audible
                                                ;            Select Triangle waveform of Voice 1
                                                ;            Voice 3 must be set to some frequency other than zero
                                                ;              No other parameters of Voice 3 have any effect on RINGMOD
CNTRL1_TEST                   = %00001000       ;   Bit 3: Test Bit:           (1=Lock Voice 1, 0=Unlock Voice 1)
                                                ;          When set resets and locks Voice 1 at zero until the bit is cleared
                                                ;          The Noise waveform output of Voice 1 is also reset
                                                ;          The Pulse waveform output is held at a DC level
                                                ;          Normally used for testing purposes but can be used to sync Voice 1 
                                                ;          to external events allowing the generation of highly complex
                                                ;          waveforms under real-time software control
; ------------------------------------------------------------------------------------------------------------- ;
; If more than one output waveform is selected simultaneously the result will be a logical AND of the waveforms
; This technique can be used to generate additional waveforms but must be used with care:
;   If any other waveform is selected while Noise is on the Noise output can 'lock up' and 
;   will remain silent until reset by the TEST bit or by bringing RES (pin 5) low
; ------------------------------------------------------------------------------------------------------------- ;
CNTRL1_TRI                    = %00010000       ;   Bit 4: Select waveform triangle
                                                ;          Low in harmonics / mellow flute-like quality
CNTRL1_SAW                    = %00100000       ;   Bit 5: Select waveform sawtooth
                                                ;          Rich in even and odd harmonics / bright brassy quality
CNTRL1_PULSE                  = %01000000       ;   Bit 6: Select waveform pulse
                                                ;          The harmonic content can be adjusted by the Pulse Width regs
                                                ;          Creates tones from a bright hollow square wave to a nasal reedy pulse
CNTRL1_NOISE                  = %10000000       ;   Bit 7: Select waveform random noise
                                                ;          Outputs a random signal which changes at the frequency of Voice 1
                                                ;          Can be varied from a low rumbling to hissing white noise via the Voice 1 freq
                                                ;          Creates explosions/gunshots/jet engines/wind/surf/snare drums/cymbals
; ------------------------------------------------------------------------------------------------------------- ;
; The Envelope Generator can be Gated and Released at any point without restriction
; If the Gate bit is reset before the envelope has finished the ATTACK cycle
; the RELEASE cycle will immediately begin starting from whatever amplitude had been reached
; If the envelope is then Gated again before the RELEASE cycle has reached zero amplitude
; another ATTACK cycle will begin starting from whatever amplitude had been reached
; ------------------------------------------------------------------------------------------------------------- ;
ATKDCY1                     = SID + $05         ; ATTACK/DECAY Control Register
ATDCY1                      = ATKDCY1           ; 
                                                ;   Bits 0…3: DECAY cycle duration
                                                ;             The DECAY cycle follows the ATTACK cycle
                                                ;             The DECAY rate determines how rapidly the output falls
                                                ;             from the peak amplitude to the selected SUSTAIN level
ATKDCY1_DCY_MASK              = %00001111       ;-------------------------------------------------------------- ;
ATKDCY1_DCY0                  = %00000001       ;   $00 - 0.006 sec  $04 - 0.114 sec  $08 -  0.300 sec  $0c -  3.000 sec
ATKDCY1_DCY1                  = %00000010       ;   $0l - 0.024 sec  $05 - 0.168 sec  $09 -  0.750 sec  $0d -  9.000 sec
ATKDCY1_DCY2                  = %00000100       ;   $02 - 0.048 sec  $06 - 0.204 sec  $0a -  1.500 sec  $0e - 15.000 sec
ATKDCY1_DCY3                  = %00001000       ;   $03 - 0.072 sec  $07 - 0.240 sec  $0b -  2.400 sec  $0f - 24.000 sec
                                                ;-------------------------------------------------------------- ;
                                                ;   Bits 4…7: ATTACK cycle duration
                                                ;             The amount of time required for the sound output to rise
                                                ;             from zero amplitude (silence) to peak amplitude
ATKDCY1_ATK_MASK              = %11110000       ;-------------------------------------------------------------- ;
ATKDCY1_ATK0                  = %00010000       ;   $00 - 0.002 sec   $40 - 0.038 sec   $80 - 0.100 sec   $c0 - 1.00 sec
ATKDCY1_ATK1                  = %00100000       ;   $10 - 0.008 sec   $50 - 0.056 sec   $90 - 0.250 sec   $d0 - 3.00 sec
ATKDCY1_ATK2                  = %01000000       ;   $20 - 0.016 sec   $60 - 0.068 sec   $a0 - 0.500 sec   $e0 - 5.00 sec
ATKDCY1_ATK3                  = %10000000       ;   $30 - 0.024 sec   $70 - 0.080 sec   $b0 - 0.800 sec   $f0 - 8.00 sec
; ------------------------------------------------------------------------------------------------------------- ;
STNRIS1                     = SID + $06         ; SUSTAIN/RELEASE Control Register
SUREL1                      = STNRIS1           ; 
                                                ;   Bits 0…3: SUSTAIN volume percentage of peak output
                                                ;             The SUSTAIN cycle follows the DECAY cycle
                                                ;             The output of Voice 1 will remain at the selected SUSTAIN
                                                ;             amplitude as long as the Gate bit remains set
STNRIS1_STN_MASK              = %11110000       ;-------------------------------------------------------------- ;
STNRIS1_STN0                  = %00010000       ;   $00 -  0% (no output)  $40 - 27%   $80 - 53%   $c0 -  80%
STNRIS1_STN1                  = %00100000       ;   $10 -  7%              $50 - 33%   $90 - 60%   $d0 -  87%
STNRIS1_STN2                  = %01000000       ;   $20 - 13%              $60 - 40%   $a0 - 67%   $e0 -  93%
STNRIS1_STN3                  = %10000000       ;   $30 - 20%              $70 - 47%   $b0 - 73%   $f0 - 100% (peak output)
                                                ;-------------------------------------------------------------- ;
                                                ;   Bits 4…7: RELEASE length
                                                ;             The RELEASE cycle follows the SUSTAIN cycle
                                                ;             when the Gate bit is reset to zero
                                                ;             The output of Voice 1 will fall from the SUSTAIN amplitude
                                                ;             to zero amplitude (silence) at the selected RELEASE rate
STNRIS1_RIS_MASK              = %00001111       ;-------------------------------------------------------------- ;
STNRIS1_RIS0                  = %00000001       ;   $00 - 0.006 sec   $04 - 0.114 sec   $08 -  0.300 sec  $0c -  3 sec
STNRIS1_RIS1                  = %00000010       ;   $0l - 0.024 sec   $05 - 0.168 sec   $09 -  0.750 sec  $0d -  9 sec
STNRIS1_RIS2                  = %00000100       ;   $02 - 0.048 sec   $06 - 0.204 sec   $0a -  1.5   sec  $0e - 15 sec
STNRIS1_RIS3                  = %00001000       ;   $03 - 0.072 sec   $07 - 0.240 sec   $0b -  2.4   sec  $0f - 24 sec
; ------------------------------------------------------------------------------------------------------------- ;
; Voice 2 - all registers WRITE only
; ------------------------------------------------------------------------------------------------------------- ;
; Registers $07-$0D are functionally identical to registers $00-$06 with these exceptions:
;   - SYNC synchronizes Voice 2 with Voice 1
;   - RING MOD replaces the Triangle output of Voice 2 with the ring modulated combination of Voices 2 and 1
; ------------------------------------------------------------------------------------------------------------- ;
FREQLO2                     = SID + $07         ; 16 Bit Frequency Control Number Low-Byte
FRELO2                      = FREQLO2           ; 
FREQLO2_F0                    = %00000001       ; 
FREQLO2_F1                    = %00000010       ; 
FREQLO2_F2                    = %00000100       ; 
FREQLO2_F3                    = %00001000       ; 
FREQLO2_F4                    = %00010000       ; 
FREQLO2_F5                    = %00100000       ; 
FREQLO2_F6                    = %01000000       ; 
FREQLO2_F7                    = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
FREQHI2                     = SID + $08         ; 16 Bit Frequency Control Number High-Byte
FREHI2                      = FREQHI2           ; 
FREQHI2_F8                    = %00000001       ; 
FREQHI2_F9                    = %00000010       ; 
FREQHI2_F10                   = %00000100       ; 
FREQHI2_F11                   = %00001000       ; 
FREQHI2_F12                   = %00010000       ; 
FREQHI2_F13                   = %00100000       ; 
FREQHI2_F14                   = %01000000       ; 
FREQHI2_F15                   = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
PWLO2                       = SID + $09         ; 12 Bit Pulse Waveform Width (duty cycle) Low Byte
PWLO2_PW0                     = %00000001       ; 
PWLO2_PW1                     = %00000010       ; 
PWLO2_PW2                     = %00000100       ; 
PWLO2_PW3                     = %00001000       ; 
PWLO2_PW4                     = %00010000       ; 
PWLO2_PW5                     = %00100000       ; 
PWLO2_PW6                     = %01000000       ; 
PWLO2_PW7                     = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
PWHI2                       = SID + $0a         ; 12 Bit Pulse Waveform Width (duty cycle) High Byte
PWHI2_PW8                     = %00000001       ; 
PWHI2_PW9                     = %00000010       ; 
PWHI2_PW10                    = %00000100       ; 
PWHI2_PW11                    = %00001000       ; 
                                                ; 
                              ; %00010000       ;   Bit 12: <unused>
                              ; %00100000       ;   Bit 13: <unused>
                              ; %01000000       ;   Bit 14: <unused>
                              ; %10000000       ;   Bit 15: <unused>
                                                ; 
PWHI2_MASK                    = %00001111       ;   Bit  8…12: high nibble
PWHI2_MASK_NOUSE              = %11110000       ;   Bit 12…15: unused
; ------------------------------------------------------------------------------------------------------------- ;
CNTRL2                      = SID + $0b         ; Control Register
VCREG2                      = CNTRL2            ; 
CNTRL2_GATE                   = %00000001       ;   Bit  0: Gates (triggers) the Envelope Generator
CNTRL2_GATE_ADS                 = %00000001     ;                            (1=Init  ATTACK/DECAY/SUSTAIN cycle)                 
CNTRL2_GATE_REL                 = %11111110     ;                            (0=Start RELEASE cycle)
CNTRL2_SYNC                   = %00000010       ;   Bit  1: Sync voice 1 and 3: (1=On)
CNTRL2_RINGMOD                = %00000100       ;   Bit  2: Ring Modulation:    (1=Ring modulate Voices 1 and 3)
CNTRL2_TEST                   = %00001000       ;   Bit  3: Test Bit:           (1=Lock Voice 1, 0=Unlock Voice 1)
; ------------------------------------------------------------------------------------------------------------- ;
CNTRL2_TRI                    = %00010000       ;   Bit  4: Select waveform triangle
CNTRL2_SAW                    = %00100000       ;   Bit  5: Select waveform sawtooth
CNTRL2_PULSE                  = %01000000       ;   Bit  6: Select waveform pulse
CNTRL2_NOISE                  = %10000000       ;   Bit  7: Select waveform random noise
; ------------------------------------------------------------------------------------------------------------- ;
ATKDCY2                     = SID + $0c         ; ATTACK/DECAY Control Register
ATDCY2                      = ATKDCY2           ;-------------------------------------------------------------- ; 
                                                ;   Bits 0…3: DECAY cycle duration
ATKDCY2_DCY_MASK              = %00001111       ;-------------------------------------------------------------- ;
ATKDCY2_DCY0                  = %00000001       ;   $00 - 0.006 sec  $04 - 0.114 sec  $08 -  0.300 sec  $0c -  3.000 sec
ATKDCY2_DCY1                  = %00000010       ;   $0l - 0.024 sec  $05 - 0.168 sec  $09 -  0.750 sec  $0d -  9.000 sec
ATKDCY2_DCY2                  = %00000100       ;   $02 - 0.048 sec  $06 - 0.204 sec  $0a -  1.500 sec  $0e - 15.000 sec
ATKDCY2_DCY3                  = %00001000       ;   $03 - 0.072 sec  $07 - 0.240 sec  $0b -  2.400 sec  $0f - 24.000 sec
                                                ;-------------------------------------------------------------- ;
                                                ;   Bits 4…7: ATTACK cycle duration
ATKDCY2_ATK_MASK              = %11110000       ;-------------------------------------------------------------- ;
ATKDCY2_ATK0                  = %00010000       ;   $00 - 0.002 sec   $40 - 0.038 sec   $80 - 0.100 sec   $c0 - 1.00 sec
ATKDCY2_ATK1                  = %00100000       ;   $10 - 0.008 sec   $50 - 0.056 sec   $90 - 0.250 sec   $d0 - 3.00 sec
ATKDCY2_ATK2                  = %01000000       ;   $20 - 0.016 sec   $60 - 0.068 sec   $a0 - 0.500 sec   $e0 - 5.00 sec
ATKDCY2_ATK3                  = %10000000       ;   $30 - 0.024 sec   $70 - 0.080 sec   $b0 - 0.800 sec   $f0 - 8.00 sec
; ------------------------------------------------------------------------------------------------------------- ;
STNRIS2                     = SID + $0d         ; SUSTAIN/RELEASE Control Register
SUREL2                      = STNRIS2           ;-------------------------------------------------------------- ;
                                                ;   Bits 0…3: SUSTAIN volume percentage of peak output
STNRIS2_STN_MASK              = %11110000       ;-------------------------------------------------------------- ;
STNRIS2_STN0                  = %00010000       ;   $00 -  0% (no output)  $40 - 27%   $80 - 53%   $c0 -  80%
STNRIS2_STN1                  = %00100000       ;   $10 -  7%              $50 - 33%   $90 - 60%   $d0 -  87%
STNRIS2_STN2                  = %01000000       ;   $20 - 13%              $60 - 40%   $a0 - 67%   $e0 -  93%
STNRIS2_STN3                  = %10000000       ;   $30 - 20%              $70 - 47%   $b0 - 73%   $f0 - 100% (peak output)
                                                ;-------------------------------------------------------------- ;
                                                ; Bits 4…7: RELEASE length
STNRIS2_RIS_MASK              = %00001111       ;-------------------------------------------------------------- ;
STNRIS2_RIS0                  = %00000001       ;   $00 - 0.006 sec   $04 - 0.114 sec   $08 -  0.300 sec  $0c -  3 sec
STNRIS2_RIS1                  = %00000010       ;   $0l - 0.024 sec   $05 - 0.168 sec   $09 -  0.750 sec  $0d -  9 sec
STNRIS2_RIS2                  = %00000100       ;   $02 - 0.048 sec   $06 - 0.204 sec   $0a -  1.5   sec  $0e - 15 sec
STNRIS2_RIS3                  = %00001000       ;   $03 - 0.072 sec   $07 - 0.240 sec   $0b -  2.4   sec  $0f - 24 sec
; ------------------------------------------------------------------------------------------------------------- ;
; Voice 3 - all registers WRITE only
; ------------------------------------------------------------------------------------------------------------- ;
; Registers $0e-$14 are functionally identical to registers $00-$06 with these exceptions:
;   - SYNC synchronizes Voice 3 with Voice 2
;   - RING MOD replaces the Triangle output of Voice 3 with the ring modulated combination of Voices 3 and 2
; ------------------------------------------------------------------------------------------------------------- ;
FREQLO3                     = SID + $0e         ; 16 Bit Frequency Control Number Low-Byte
FRELO3                      = FREQLO3           ; 
FREQLO3_F0                    = %00000001       ; 
FREQLO3_F1                    = %00000010       ; 
FREQLO3_F2                    = %00000100       ; 
FREQLO3_F3                    = %00001000       ; 
FREQLO3_F4                    = %00010000       ; 
FREQLO3_F5                    = %00100000       ; 
FREQLO3_F6                    = %01000000       ; 
FREQLO3_F7                    = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
FREQHI3                     = SID + $0f         ; 16 Bit Frequency Control Number High-Byte
FREHI3                      = FREQHI3           ; 
FREQHI3_F8                    = %00000001       ; 
FREQHI3_F9                    = %00000010       ; 
FREQHI3_F10                   = %00000100       ; 
FREQHI3_F11                   = %00001000       ; 
FREQHI3_F12                   = %00010000       ; 
FREQHI3_F13                   = %00100000       ; 
FREQHI3_F14                   = %01000000       ; 
FREQHI3_F15                   = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
PWLO3                       = SID + $10         ; 12 Bit Pulse Waveform Width (duty cycle) Low Byte
PWLO3_PW0                     = %00000001       ; 
PWLO3_PW1                     = %00000010       ; 
PWLO3_PW2                     = %00000100       ; 
PWLO3_PW3                     = %00001000       ; 
PWLO3_PW4                     = %00010000       ; 
PWLO3_PW5                     = %00100000       ; 
PWLO3_PW6                     = %01000000       ; 
PWLO3_PW7                     = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
PWHI3                       = SID + $11         ; 12 Bit Pulse Waveform Width (duty cycle) High Byte
PWHI3_PW8                     = %00000001       ; 
PWHI3_PW9                     = %00000010       ; 
PWHI3_PW10                    = %00000100       ; 
PWHI3_PW11                    = %00001000       ; 
                                                ; 
                              ; %00010000       ;   Bit 12: <unused>
                              ; %00100000       ;   Bit 13: <unused>
                              ; %01000000       ;   Bit 14: <unused>
                              ; %10000000       ;   Bit 15: <unused>
                                                ; 
PWHI3_MASK                    = %00001111       ;   Bit  8…12: high nibble
PWHI3_MASK_NOUSE              = %11110000       ;   Bit 12…15: <unused>
; ------------------------------------------------------------------------------------------------------------- ;
CNTRL3                      = SID + $12         ; Control Register
VCREG3                      = CNTRL3            ; 
CNTRL3_GATE                   = %00000001       ;   Bit  0: Gates (triggers) the Envelope Generator
CNTRL3_GATE_ADS                 = %00000001     ;                            (1=Init  ATTACK/DECAY/SUSTAIN cycle)                 
CNTRL3_GATE_REL                 = %11111110     ;                            (0=Start RELEASE cycle)
CNTRL3_SYNC                   = %00000010       ;   Bit  1: Sync voice 1 and 3: (1=On)
CNTRL3_RINGMOD                = %00000100       ;   Bit  2: Ring Modulation:    (1=Ring modulate Voices 1 and 3)
CNTRL3_TEST                   = %00001000       ;   Bit  3: Test Bit:           (1=Lock Voice 1, 0=Unlock Voice 1)
; ------------------------------------------------------------------------------------------------------------- ;
CNTRL3_TRI                    = %00010000       ;   Bit  4: Select waveform triangle
CNTRL3_SAW                    = %00100000       ;   Bit  5: Select waveform sawtooth
CNTRL3_PULSE                  = %01000000       ;   Bit  6: Select waveform pulse
CNTRL3_NOISE                  = %10000000       ;   Bit  7: Select waveform random noise
; ------------------------------------------------------------------------------------------------------------- ;
ATKDCY3                     = SID + $13         ; ATTACK/DECAY Control Register
ATDCY3                      = ATKDCY3           ;-------------------------------------------------------------- ;
                                                ;   Bits 0…3: DECAY cycle duration
ATKDCY3_DCY_MASK              = %00001111       ;-------------------------------------------------------------- ;
ATKDCY3_DCY0                  = %00000001       ;   $00 - 0.006 sec  $04 - 0.114 sec  $08 -  0.300 sec  $0c -  3.000 sec
ATKDCY3_DCY1                  = %00000010       ;   $0l - 0.024 sec  $05 - 0.168 sec  $09 -  0.750 sec  $0d -  9.000 sec
ATKDCY3_DCY2                  = %00000100       ;   $02 - 0.048 sec  $06 - 0.204 sec  $0a -  1.500 sec  $0e - 15.000 sec
ATKDCY3_DCY3                  = %00001000       ;   $03 - 0.072 sec  $07 - 0.240 sec  $0b -  2.400 sec  $0f - 24.000 sec
                                                ;-------------------------------------------------------------- ;
                                                ;   Bits 4…7: ATTACK cycle duration
ATKDCY3_ATK_MASK              = %11110000       ;-------------------------------------------------------------- ;
ATKDCY3_ATK0                  = %00010000       ;   $00 - 0.002 sec   $40 - 0.038 sec   $80 - 0.100 sec   $c0 - 1.00 sec
ATKDCY3_ATK1                  = %00100000       ;   $10 - 0.008 sec   $50 - 0.056 sec   $90 - 0.250 sec   $d0 - 3.00 sec
ATKDCY3_ATK2                  = %01000000       ;   $20 - 0.016 sec   $60 - 0.068 sec   $a0 - 0.500 sec   $e0 - 5.00 sec
ATKDCY3_ATK3                  = %10000000       ;   $30 - 0.024 sec   $70 - 0.080 sec   $b0 - 0.800 sec   $f0 - 8.00 sec
; ------------------------------------------------------------------------------------------------------------- ;
STNRIS3                     = SID + $14         ; SUSTAIN/RELEASE Control Register
SUREL3                      = STNRIS3           ;-------------------------------------------------------------- ;
                                                ;   Bits 0…3: SUSTAIN volume percentage of peak output
STNRIS3_STN_MASK              = %11110000       ;-------------------------------------------------------------- ;
STNRIS3_STN0                  = %00010000       ;   $00 -  0% (no output)  $40 - 27%   $80 - 53%   $c0 -  80%
STNRIS3_STN1                  = %00100000       ;   $10 -  7%              $50 - 33%   $90 - 60%   $d0 -  87%
STNRIS3_STN2                  = %01000000       ;   $20 - 13%              $60 - 40%   $a0 - 67%   $e0 -  93%
STNRIS3_STN3                  = %10000000       ;   $30 - 20%              $70 - 47%   $b0 - 73%   $f0 - 100% (peak output)
                                                ;-------------------------------------------------------------- ;
                                                ;   Bits 4…7: RELEASE length
STNRIS3_RIS_MASK              = %11110000       ;-------------------------------------------------------------- ;
STNRIS3_RIS0                  = %00000001       ;   $00 - 0.006 sec   $04 - 0.114 sec   $08 -  0.300 sec  $0c -  3 sec
STNRIS3_RIS1                  = %00000010       ;   $0l - 0.024 sec   $05 - 0.168 sec   $09 -  0.750 sec  $0d -  9 sec
STNRIS3_RIS2                  = %00000100       ;   $02 - 0.048 sec   $06 - 0.204 sec   $0a -  1.5   sec  $0e - 15 sec
STNRIS3_RIS3                  = %00001000       ;   $03 - 0.072 sec   $07 - 0.240 sec   $0b -  2.4   sec  $0f - 24 sec
; ------------------------------------------------------------------------------------------------------------- ;
; Filter - all registers WRITE only
; ------------------------------------------------------------------------------------------------------------- ;
; 11-bit number which linearly controls the Cutoff (or Center) Frequency of the programmable Filter
; The approximate Cutoff Frequency ranges between 30Hz and 10KHz with the recommended capacitor values of 2200pF for CAP1 and CAP2
; ------------------------------------------------------------------------------------------------------------- ;
FCLO                        = SID + $15         ; Filter cutoff Frequency (Low Byte)   : FREQUENCY = (REGISTER VALUE * 5.8) + 30Hz
CUTLO                       = FCLO              ; 
FCLO_FC0                      = %00000001       ;   Bit  0: Low portion of filter cutoff frequency
FCLO_FC1                      = %00000010       ;   Bit  1: Low portion of filter cutoff frequency
FCLO_FC2                      = %00000100       ;   Bit  2: Low portion of filter cutoff frequency
                                                ; 
                              ; %00001000       ;   Bit  3: <unused>
                              ; %00010000       ;   Bit  4: <unused>
                              ; %00100000       ;   Bit  5: <unused>
                              ; %01000000       ;   Bit  6: <unused>
                              ; %10000000       ;   Bit  7: <unused>
; ------------------------------------------------------------------------------------------------------------- ;
FCHI                        = SID + $16         ; Filter cutoff Frequency High Byte     : FREQUENCY = (REGISTER VALUE * 5.8) + 30Hz
CUTHI                       = FCHI              ; 
FCHI_FC3                      = %00000001       ;   Bit  3: High portion of filter cutoff frequency
FCHI_FC4                      = %00000010       ;   Bit  4: High portion of filter cutoff frequency
FCHI_FC5                      = %00000100       ;   Bit  5: High portion of filter cutoff frequency
FCHI_FC6                      = %00001000       ;   Bit  6: High portion of filter cutoff frequency
FCHI_FC7                      = %00010000       ;   Bit  7: High portion of filter cutoff frequency
FCHI_FC8                      = %00100000       ;   Bit  8: High portion of filter cutoff frequency
FCHI_FC9                      = %01000000       ;   Bit  9: High portion of filter cutoff frequency
FCHI_FC10                     = %10000000       ;   Bit 10: High portion of filter cutoff frequency
; ------------------------------------------------------------------------------------------------------------- ;
; 0=Voice 1-3/Ex appears directly (no Filter) at the audio output
; 1=Voice 1-3/Ex will be processed through the Filter
;                the harmonic content of Voice 1-3 will be altered according to the selected Filter parameters
; ------------------------------------------------------------------------------------------------------------- ;
RESFILT                     = SID + $17         ; Filter Resonance Control Register
RESON                       = RESFILT           ; 
RESFILT_FILT_MASK            = %00001111        ;   Bits 0…3: Determine which signals will be routed through the Filter
RESFILT_FILT1                = %00000001        ;   Bit  0: Filter the output of voice 1  (1=yes)
RESFILT_FILT2                = %00000010        ;   Bit  1: Filter the output of voice 2  (1=yes)
RESFILT_FILT3                = %00000100        ;   Bit  2: Filter the output of voice 3  (1=yes)
RESFILT_FILTEX               = %00001000        ;   Bit  3: Filter the output from the external audio input pin 26 (1=yes)
; ------------------------------------------------------------------------------------------------------------- ;
; Emphasizes frequency components at the Cutoff Frequency of the Filter causing a sharper sound
; ------------------------------------------------------------------------------------------------------------- ;
RESFILT_RES_MASK             = %11110000        ;   Bits 4…7: Control the Resonance of the Filter
RESFILT_RES0                 = %00010000        ;   
RESFILT_RES1                 = %00100000        ;   
RESFILT_RES2                 = %01000000        ;   
RESFILT_RES3                 = %10000000        ;   

; ------------------------------------------------------------------------------------------------------------- ;
MODEVOL                     = SID + $18         ; Volume and Filter Select Register
SIGVOL                      = MODEVOL           ; 
MODEVOL_VOL_MASK              = %00001111       ;   Bits 0…3: Select output volume (0-15)
MODEVOL_VOL0                  = %00000001       ; 
MODEVOL_VOL1                  = %00000010       ; 
MODEVOL_VOL2                  = %00000100       ; 
MODEVOL_VOL3                  = %00001000       ; 
                              
MODEVOL_MODE_MASK             = %11110000       ;   Bits 4…7: Select various Filter mode and output options
; ------------------------------------------------------------------------------------------------------------- ;
; The Filter output modes are additive and multiple Filter modes may be selected simultaneously
; ------------------------------------------------------------------------------------------------------------- ;
MODEVOL_LP                    = %00010000       ;   Bit 4:  Select Low Pass filter  (1=Low Pass on)
; ------------------------------------------------------------------------------------------------------------- ;
; All frequency components below the Filter Cutoff Frequency are passed unaltered
; All frequency components above the Cutoff are attenuated at a rate of 12 dB/Octave
; The Low Pass mode produces full-bodied sounds
; ------------------------------------------------------------------------------------------------------------- ;
MODEVOL_BP                    = %00100000       ;   Bit 5:  Select Band Pass filter (1=Band Pass on)
; ------------------------------------------------------------------------------------------------------------- ;
; All frequency components above and below the Cutoff are attenuated at a rate of 6 dB/Octave
; The Band Pass mode produces thin open sounds
; ------------------------------------------------------------------------------------------------------------- ;
MODEVOL_HP                    = %01000000       ;   Bit 6:  Select High Pass filter (1=High Pass on)
; ------------------------------------------------------------------------------------------------------------- ;
; All frequency components above the Cutoff are passed unaltered
; All frequency components below the Cutoff are attenuated at a rate of 12 dB/Octave
; The High Pass mode produces tinny buzzy sounds
; ------------------------------------------------------------------------------------------------------------- ;
MODEVOL_3OFF                  = %10000000       ;   Bit 7:  Mute Voice 3 - 1=off
; ------------------------------------------------------------------------------------------------------------- ;
; Setting Voice 3 to bypass the Filter (FILT 3 = 0) and setting 3OFF prevents Voice 3 from reaching the audio output
; Allows Voice 3 to be used for modulation purposes without any undesirable output
; ------------------------------------------------------------------------------------------------------------- ;
; Misc - all registers READ only    
; ------------------------------------------------------------------------------------------------------------- ;
POTX                        = SID + $19         ; Read Game Paddle 1 (or 3) Position - Updated every 512 clock cycles
POTX_PX0                      = %00000001       ; 
POTX_PX1                      = %00000010       ; 
POTX_PX2                      = %00000100       ; 
POTX_PX3                      = %00001000       ; 
POTX_PX4                      = %00010000       ; 
POTX_PX5                      = %00100000       ; 
POTX_PX6                      = %01000000       ; 
POTX_PX7                      = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
POTY                        = SID + $1a         ; Read Game Paddle 2 (or 4) Position - Updated every 512 clock cycles
POTY_PY0                      = %00000001       ; 
POTY_PY1                      = %00000010       ; 
POTY_PY2                      = %00000100       ; 
POTY_PY3                      = %00001000       ; 
POTY_PY4                      = %00010000       ; 
POTY_PY5                      = %00100000       ; 
POTY_PY6                      = %01000000       ; 
POTY_PY7                      = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
; This register allows the microprocessor to read the upper 8 output bits of Voice 3
; The numbers generated are related to the selected waveform
;   - Sawtooth: A series of numbers incrementing from $00 to $ff
;               at a rate determined by the frequency of Oscillator 3
;   - Triangle: The output will increment from $00 up to $ff then decrement down to $00
;   - Pulse   : The output will jump between $00 and $ff
;   - Noise   : A series of random numbers which can be used as a random number generator for games
; ------------------------------------------------------------------------------------------------------------- ;
OSC3                         = SID + $1b        ; Current State of Voice 3's Wave / Random Number Generator
RANDOM                       = OSC3             ; 
OSC3_00                        = %00000001      ; 
OSC3_01                        = %00000010      ; 
OSC3_02                        = %00000100      ; 
OSC3_03                        = %00001000      ; 
OSC3_04                        = %00010000      ; 
OSC3_05                        = %00100000      ; 
OSC3_06                        = %01000000      ; 
OSC3_07                        = %10000000      ; 
; ------------------------------------------------------------------------------------------------------------- ;
; Same as OSC3
; Allows the microprocessor to read the output of the Voice 3 Envelope Generator
; ------------------------------------------------------------------------------------------------------------- ;
ENV3                        = SID + $1c         ; Current State of Voice 3's Envelope
ENV3_E0                       = %00000001       ; 
ENV3_E1                       = %00000010       ; 
ENV3_E2                       = %00000100       ; 
ENV3_E3                       = %00001000       ; 
ENV3_E4                       = %00010000       ; 
ENV3_E5                       = %00100000       ; 
ENV3_E6                       = %01000000       ; 
ENV3_E7                       = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
; $D41D-$D41F                                   ; Not Connected - always $ff when read even after writes
; ------------------------------------------------------------------------------------------------------------- ;
; $D420-$D7FF                                   ; SID Register Images - Mirror of $D400-$D41F
; ------------------------------------------------------------------------------------------------------------- ;

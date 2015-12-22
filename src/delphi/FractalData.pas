unit FractalData;

interface

Type FractalType = Array[1..4,1..7] of Real;
Const binary : FractalType = (
        { Probability, a, b, c, d, e, f }
        ( 0.333333, 0.5,  0.0, 0.0, 0.5, -2.563477, -0.000003),
        ( 0.333333, 0.5,  0.0, 0.0, 0.5,  2.436544, -0.000003),
        ( 0.333333, 0.0, -0.5, 0.5, 0.0,  4.873085,  7.563492),
        ( 0, 0, 0, 0, 0, 0, 0));

      coral : FractalType = (
        ( 0.40, 0.307692, -0.531469, -0.461538, -0.293706,  5.401953, 8.655175),
        ( 0.15, 0.307692, -0.076923,  0.153846, -0.447552, -1.295248, 4.152990),
        ( 0.45, 0.000000,  0.545455,  0.692308, -0.195804, -4.893637, 7.269794),
        ( 0, 0, 0, 0, 0, 0, 0));

      crystal : FractalType = (
        ( 0.747826, 0.696970, -0.481061, -0.393939, -0.662879, 2.147003, 10.310288),
        ( 0.252174, 0.090909, -0.443182,  0.515152, -0.094697, 4.286558, 2.925762),
        ( 0, 0, 0, 0, 0, 0, 0),
        ( 0, 0, 0, 0, 0, 0, 0));

      dragon : FractalType = (
        ( 0.787473, 0.824074, 0.281482, -0.212346,  0.864198, -1.882290, -0.110607),
        ( 0.212527, 0.088272, 0.520988, -0.463889, -0.377778,  0.785360,  8.095795),
        ( 0, 0, 0, 0, 0, 0, 0),
        ( 0, 0, 0, 0, 0, 0, 0));

      fern : FractalType = (
        ( 0.01,  0.00,  0.00,  0.00, 0.16, 0, 0),
        ( 0.86,  0.85,  0.04, -0.04, 0.85, 0, 1.6),
        ( 0.07,  0.20, -0.26,  0.23, 0.22, 0, 1.6),
        ( 0.07, -0.15,  0.28,  0.26, 0.24, 0, 0.44));

      floor : FractalType = (
        ( 0.333333, 0.0, -0.5,  0.5, 0.0, -1.732366, 3.366182),
        ( 0.333333, 0.5,  0.0,  0.0, 0.5, -0.027891, 5.014877),
        ( 0.333333, 0.0,  0.5, -0.5, 0.0,  1.620804, 3.310401),
        ( 0, 0, 0, 0, 0, 0, 0));

      spiral : FractalType = (
        ( 0.895652,  0.787879, -0.424242, 0.242424, 0.859848,  1.758647, 1.408065),
        ( 0.052174, -0.121212,  0.257576, 0.151515, 0.053030, -6.721654, 1.377236),
        ( 0.052174,  0.181818, -0.136364, 0.090909, 0.181818,  6.086107, 1.568035),
        ( 0, 0, 0, 0, 0, 0, 0));

      swirl : FractalType = (
        ( 0.912675,  0.745455, -0.459091,  0.406061,  0.887121, 1.460279, 0.691072),
        ( 0.087325, -0.424242, -0.065152, -0.175758, -0.218182, 3.809567, 6.741476),
        ( 0, 0, 0, 0, 0, 0, 0),
        ( 0, 0, 0, 0, 0, 0, 0));

      tree : FractalType = (
        ( 0.05, 0.00,  0.00,  0.00, 0.50, 0, 0.0),
        ( 0.40, 0.42, -0.42,  0.42, 0.42, 0, 0.2),
        ( 0.40, 0.42,  0.42, -0.42, 0.42, 0, 0.2),
        ( 0.15, 0.10,  0.00,  0.00, 0.10, 0, 0.2));

      triangle : FractalType = (
        ( 0.33, 0.5, 0, 0, 0.5,	0, 0),
        ( 0.33, 0.5, 0, 0, 0.5,	0, 1),
        ( 0.34, 0.5, 0, 0, 0.5,	1, 1),
        ( 0, 0, 0, 0, 0, 0, 0));

      zigzag : FractalType = (
        ( 0.888128, -0.632407, -0.614815, -0.545370, 0.659259, 3.840822, 1.282321),
        ( 0.111872, -0.036111,  0.444444,  0.210185, 0.037037, 2.071081, 8.330552),
        ( 0, 0, 0, 0, 0, 0, 0),
        ( 0, 0, 0, 0, 0, 0, 0));

  Procedure CreateIFSFractal(TextureData : Pointer; FractalNo : Integer; ReDrawBG : Boolean);
  procedure CreateMandelBrot(TextureData : Pointer; Factor : Integer);

implementation

const FractalCenter : Array[0..9, 1..2] of Real = (
  (128, 16), (51, 26),  (128, 26), (128, 26), (128, 36),
  (118, 16), (128, 46), (128, 26), (128, 26), (128, 26));

      FractalScale : Array[0..9, 1..2] of Real = (
  (475, 475), (91, 91), (18, 18), (20, 20), (18, 18),
  (22, 22),   (18, 18), (16, 18), (18, 18), (18, 18));


{-----------------------------------------------------------------------}
{  Procedure draws another image in the same memory space as the first  }
{  The code assumes width and height = 256                              }
{-----------------------------------------------------------------------}
Procedure CreateIFSFractal(TextureData : Pointer; FractalNo : Integer; ReDrawBG : Boolean);
type pPixel = Record
       R, G, B : Byte;
     end;
var X, Y, NewX, NewY : Real;
    Rnd : Real;
    I, Seed : Integer;
    XCoord, YCoord : Integer;
    Pixel : ^pPixel;
    Fractal : FractalType;
begin
  FractalNo :=(FractalNo MOD 10);

  case FractalNo of
    0 : Fractal :=Tree;
    1 : Fractal :=Triangle;
    2 : Fractal :=Binary;
    3 : Fractal :=Crystal;
    4 : Fractal :=Dragon;
    5 : Fractal :=Fern;
    6 : Fractal :=Floor;
    7 : Fractal :=Spiral;
    8 : Fractal :=Swirl;
    9 : Fractal :=ZigZag;
  end;

  if ReDrawBG then
    FillChar(TextureData^, 256*256*3, 64);        // Fill image with dard grey

  // Create an IFS Fern
  X :=0;
  Y :=0;
  For I :=1 to 25000 do
  Begin
    Rnd :=Random(10000)/10000;
    If rnd <= Fractal[1,1] then Seed :=1;
    If rnd > Fractal[1,1]  then Seed :=2;
    If rnd > Fractal[2,1]+Fractal[1,1] then Seed :=3;
    If rnd > Fractal[3,1]+Fractal[2,1]+Fractal[1,1] then Seed :=4;

    NewX :=Fractal[Seed,2]*x + Fractal[Seed,3]*y + Fractal[Seed,6];
    Newy :=Fractal[Seed,4]*x + Fractal[Seed,5]*y + Fractal[Seed,7];
    X :=NewX;
    Y :=NewY;

    // Calculate and X coord + margins
    XCoord :=Round(X*FractalScale[FractalNo, 1] + FractalCenter[FractalNo, 1]);
    YCoord :=Round(Y*FractalScale[FractalNo, 2] + FractalCenter[FractalNo, 2]);

    // Set the Pixel Values
    Pixel :=Pointer(Integer(TextureData) + 3*(XCoord + YCoord*256));
    Pixel.G :=200;
  end;

  // Add light grey border lines to make it easier to see cube
  FillChar(TextureData^, 768, 128);                                // bottom line
  FillChar(Pointer(Integer(TextureData) + 3*255*256)^, 768, 128);  // top line
  For I :=0 to 255 do
    FillChar(Pointer(Integer(TextureData) + I*768-3)^, 6, 128);    // Left and Right lines
end;


{------------------------------------------------------------------}
{  Procedure used to create a Mandelbrot Texture                   }
{------------------------------------------------------------------}
procedure CreateMandelBrot(TextureData : Pointer; Factor : Integer);
const maxX=1.25;
      minX=-2;
      maxY=1.25;
      minY=-1.25;
type pPixel = Record
       R, G, B : Byte;
     end;
var Pixel : ^pPixel;
    X, Y  : Integer;
    Sa, Sbi, dx, dy    : extended;
    Xlo, Xhi, Ylo, Yhi : extended;

  function IsMandel(CA,CBi:extended) : Integer;
  const MAX_ITERATION=64;
  var OldA, A, B :extended;
      LengthZ   :extended;
      Iteration :integer;
  begin
    A:=0;
    B:=0;
    Iteration:=0;		  {initialize iteration}
    Repeat
      OldA := A;
      A:= A*A - B*B + CA;
      B:= 2*OldA*B + CBi;
      Iteration := Iteration + 1;
      LengthZ:= A*A + B*B;
    until (LengthZ >= 4) OR (Iteration > MAX_ITERATION);
    result := Iteration;
  end;

begin
  FillChar(TextureData^, 256*256*3, 0);        // Fill image with dard grey
  dx := (MaxX-MinX)/256;
  dy := (Maxy-MinY)/256;
  for y:=0 to 255 do
  begin
    for x:=0 to 255 do
    begin
      Pixel := Pointer(Integer(TextureData) + 3*(X + Y*256));
      if IsMandel(MinX+x*dx -0.3, MinY+y*dy) > factor then
      begin
        Pixel.R :=Y;
        Pixel.G :=X DIV 2;
        Pixel.B :=(Y*X) DIV 2;
      end
      else
      begin
        Pixel.R :=X;
        Pixel.G :=X;
        Pixel.B :=X;
      end;
    end;
  end;
end;


{------------------------------------------------------------------}
{  Procedure used to emboss any texture at runtime                 }
{------------------------------------------------------------------}
procedure EmbossTexture(Width, Height : Integer; TextureData : Pointer);
type pPixel = Record
       R, G, B : Byte;
     end;
var x,y : Integer;
    Pixel1, Pixel2 : ^pPixel;
begin
  for y:=0 to Height-2 do
  begin
    for x:=0 to Width-4 do
    begin
      Pixel1 :=Pointer(Integer(TextureData) + 3*(X + Y*Width));
      Pixel2 :=Pointer(Integer(TextureData) + 3*(X+3 + (Y+1)*Width));
      Pixel2.R :=Pixel2.R XOR $FF;
      Pixel2.G :=Pixel2.G XOR $FF;
      Pixel2.B :=Pixel2.B XOR $FF;

      Pixel1.R :=(Pixel1.R + Pixel2.R) SHR 1;
      Pixel1.G :=(Pixel1.G + Pixel2.G) SHR 1;
      Pixel1.B :=(Pixel1.B + Pixel2.B) SHR 1;
    end;
  end;
end;


end.


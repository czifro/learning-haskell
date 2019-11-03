module IOMonad where
  
  import Data.Char
  
  offsetIntToA = (+) 65

  getChar_0 :: Char
  getChar_0 = 'A'
  
  get2Chars_0 = [getChar_0, getChar_0]
  
  getChar_1 :: Int -> Char
  getChar_1 x = chr $ offsetIntToA x
  
  get2Chars_1 _ = [getChar_1 0, getChar_1 1]
  
  getChar_2 :: Int -> (Char, Int)
  getChar_2 x = (chr $ offsetIntToA x, x+1)
  
--  get2Chars_2 _ = [a,b] where (a,i) = getChar_2 0
--                              (b,_) = getChar_2 i

  get2Chars_2 i0 = [a,b] where (a,i1) = getChar_2 i0
                               (b,i2) = getChar_2 i1

  get4Chars_0 = [get2Chars_2 0, get2Chars_2 2]
  
  get2Chars_3 :: Int -> (String, Int)
  get2Chars_3 i0 = ([a,b], i2) where (a,i1) = getChar_2 i0
                                     (b,i2) = getChar_2 i1
                                     
  get4Chars_1 i0 = (a++b) where (a,i1) = get2Chars_3 i0
                                (b,i2) = get2Chars_3 i1
                                
  type RealWorld = Int
  
  real :: RealWorld -> ((), RealWorld)
--  real r = ((), r)
  
  type IO a = RealWorld -> (a, RealWorld)
  
  getChar_3 :: RealWorld -> (Char, RealWorld)
  getChar_3 r = (chr $ offsetIntToA r, r+1)
  
  real world0 = let (a, world1) = getChar_3 world0
                    (b, world2) = getChar_3 world1
                in ((), world2)
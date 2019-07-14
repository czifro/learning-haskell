module Chapter003.BookStore where
  data BookInfo = Book Int String [String]
                  deriving (Show)
                  
  data MagazineInfo = Magazine Int String [String]
                      deriving (Show)

           
  type CustomerID = Int
  type ReviewBody = String
  
  data BookReview = BookReview BookInfo CustomerID ReviewBody
  
  type BookRecord = (BookInfo, BookReview)
  
  type CardHolder = String
  type CardNumber = String
  type Address = [String]
  
  data BillingInfo = CreditCard CardNumber CardHolder Address
                   | CashOnDelivery
                   | Invoice CustomerID
                     deriving (Show)
                     
  bookId      (Book id _     _      ) = id
  bookTitle   (Book _  title _      ) = title
  bookAuthors (Book _  _     authors) = authors
  
  data Customer = Customer {
        customerId      :: CustomerID
      , customerName    :: String
      , customerAddress :: Address
      } deriving (Show)
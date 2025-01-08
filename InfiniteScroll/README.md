# Infinite Scrolling
In this mini app, the ScrollView functionality, inherited by UITableView, is utilized to implement an infinite scrolling experience. This approach ensures smooth handling of data fetching as the user scrolls through the content seamlessly.

## Demo:
![infinitescrolldemo](https://github.com/user-attachments/assets/fdbf0b11-1aff-4904-9620-3808d3262a29)

### Service
```swift
var fetchedAmount = 0
    
func getMorePhotos(amount: Int , completion : @escaping (Result<[Model],Error>) -> () ){
    let session = URLSession.shared
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else{completion(.failure(ErrorCase.urlError)) ; return}
    session.dataTask(with: url) { data, response, error in
        if let error = error{
            completion(.failure(error))
        }else if let data = data{
            do{
                let decoder = JSONDecoder()
                let modeledData = try decoder.decode([Model].self, from: data)
                
                // ***************** CRUCUIAL FOR THE Infinite Scroll   ***********************************
                //                                                                                        *
                let initial = self.fetchedAmount // the last position that we were currently on.          *
                var twentyMore : [Model] = [] // new array of Model to be inserted.                       *
                for row in modeledData[initial...initial+amount]{//                                       *
                    twentyMore.append(row)//                                                              *
                } //                                                                                      *
                self.fetchedAmount += amount+1 // updating the final position                             *
                //                                                                                        *
                completion(.success(twentyMore)) // returns the next 'x' amount of data on completion     *
                //                                                                                        *
                // ****************************************************************************************

            }catch{
                completion(.failure(error))
            }
        }else{
            completion(.failure(ErrorCase.unknownError))
        }
    }
    .resume() // gas pedal
}
```
The service provides the next specified number of photos upon completion. The exact number of photos to be fetched is determined by the 'amount' parameter passed to the function mentioned above.

### Infinite Scrolling Logic:

The primary function of the code below is to add 5 more items to the photos array of type [Model], which is defined within the code. The photos array is equipped with a didSet property observer, ensuring that the data is automatically reloaded whenever its contents change.roperty observer.

```swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let frameHeight = scrollView.frame.size.height
    
    let bottomOfTable = contentHeight - frameHeight

    // Identicates that user scrolled to the bottom of the table view and beyond.
    if offsetY > bottomOfTable + 100 && !isScrolled{
        isScrolled = true
        print("Bottom Reached")
        fetchMorePhotos(amount: 5)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.isScrolled = false
        }
    }
}

// [---OPTIONAL PART---]
func setupTableViewFooter() {
    let spinner = UIActivityIndicatorView(style: .medium)
    spinner.startAnimating()
    spinner.hidesWhenStopped = true
    spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
    tableView.tableFooterView = spinner
}
// Made, in order to show the user that the data is being reloaded. If it takes too long to reload the data.
```

To manage data fetching efficiently, a boolean variable isScrolled is utilized. When the user scrolls to the bottom of the content, isScrolled is set to true, ensuring that the function is triggered only once during each scroll action. After the function is executed, isScrolled is set back to false, introducing a delay mechanism. This design ensures that a fetch request can only be sent once every 2 seconds, preventing excessive or redundant calls.

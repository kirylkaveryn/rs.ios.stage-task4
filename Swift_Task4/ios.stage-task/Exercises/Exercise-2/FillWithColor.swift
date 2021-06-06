import Foundation

final class FillWithColor {
    
    var stack: [[Int]] = []
    var imageModified: [[Int]] = []
    var m: Int = 0
    var n: Int = 0
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        
        // check for empty image
        if image == [] {
            return image
        }
        
        // проверка на одинаковые длины входящих массивов (например 1й из 4 чисел, а второй из 3х)
        for i in image {
            if i.count != image[0].count {
                return image
            }
        }
        
        m = image.count
        n = image[0].count
        
        // create an arrays
        imageModified = image
        stack = image
        
        // check for m, n constriants
        if n < 1 || n > 50 || m < 1 || m > 50 {
            return image
        }
        
        // check for input of Row of Column number
        if row > m - 1 || row < 0 || column > n - 1 || column < 0 {
            return image
        }
        
        // check for input New Color or pixel number
        for i in image {
            for j in i {
                if j < 0 || j >= 65536 || newColor >= 65536 {
                    return image
                }
            }
        }
        
        // set all values for stack array to 0
        for i in 0..<m {
            for j in 0..<n {
                self.stack[i][j] = 0
            }
        }
        
        // execute recursive filling
        imageModified = fillPixelsAround(image, row, column, newColor)
        
        print("Unmodified image:")
        for i in 0..<m {
            print(image[i])
        }
        print("Stack:")
        for i in 0..<m {
            print(self.stack[i])
        }
        print("Modified image:")
        for i in 0..<m {
            print(imageModified[i])
        }
    
        return imageModified
    }
    
    // recursive function for filling the pixel
    func fillPixelsAround(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        
        // check for out of borders
        if row < 0 || row > m - 1 || column < 0 || column > n - 1 {
            return imageModified
        }
        
        // set new color to current pixel and mark a checked element
        imageModified[row][column] = newColor
        stack[row][column] = 1
        
        // move through the image
        if column > 0 {
            if image[row][column] == image[row][column - 1] && stack[row][column - 1] == 0 {
                imageModified = fillPixelsAround(image, row, column - 1, newColor)
            }
        }
        if row > 0 {
            if image[row][column] == image[row - 1][column] && stack[row - 1][column] == 0 {
                imageModified = fillPixelsAround(image, row - 1, column, newColor)
            }
        }
        if column < n - 1 {
            if image[row][column] == image[row][column + 1] && stack[row][column + 1] == 0 {
                imageModified = fillPixelsAround(image, row, column + 1, newColor)
            }
        }
        if row < m - 1 {
            if image[row][column] == image[row + 1][column] && stack[row + 1][column] == 0 {
                imageModified = fillPixelsAround(image, row + 1, column, newColor)
            }
        }
        return imageModified
    }
}



//
//
//import Foundation
//
//final class FillWithColor {
//
//    var stack: [[Int]] = []
//    var m: Int = 0
//    var n: Int = 0
//
//    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
//
//        // check for empty image
//        if image == [] {
//            return image
//        }
//
//        // проверка на одинаковые длины входящих массивов (например 1й из 4 чисел, а второй из 3х)
//        for i in image {
//            if i.count != image[0].count {
//                return image
//            }
//        }
//
//        m = image.count
//        n = image[0].count
//
//        // create an arrays
//        var imageMoodified = image
//        stack = image
//
//        // check for m, n constriants
//        if n < 1 || n > 50 || m < 1 || m > 50 {
//            return image
//        }
//
//        // check for input of Row of Column number
//        if row > m - 1 || row < 0 || column > n - 1 || column < 0 {
//            return image
//        }
//
//        // check for input New Color or pixel number
//        for i in image {
//            for j in i {
//                if j < 0 || j >= 65536 || newColor >= 65536 {
//                    return image
//                }
//            }
//        }
//
//        // set all values for stack array to 0
//        for i in 0..<m {
//            for j in 0..<n {
//                self.stack[i][j] = 0
//            }
//        }
//
//        // execute recursive filling
//        imageMoodified = fillPixelsAround(image, image, row, column, newColor)
//
//        print("Unmodified image:")
//        for i in 0..<m {
//            print(image[i])
//        }
//        print("Stack:")
//        for i in 0..<m {
//            print(self.stack[i])
//        }
//        print("Modified image:")
//        for i in 0..<m {
//            print(imageMoodified[i])
//        }
//
//        return imageMoodified
//    }
//
//    // recursive function for filling the pixel
//    func fillPixelsAround(_ image: [[Int]], _ imageModified: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
//
//        var imageMoodifiedAroundPixel = imageModified
//
//        if row < 0 || row > m - 1 || column < 0 || column > n - 1 {
//            return imageModified
//        }
//
//        imageMoodifiedAroundPixel[row][column] = newColor
//        stack[row][column] = 1
//
//        if column > 0 {
//            if image[row][column] == image[row][column - 1] && self.stack[row][column - 1] == 0 {
//                imageMoodifiedAroundPixel = fillPixelsAround(image, imageMoodifiedAroundPixel, row, column - 1, newColor)
//            }
//        }
//        if row > 0 {
//            if image[row][column] == image[row - 1][column] && self.stack[row - 1][column] == 0 {
//                imageMoodifiedAroundPixel = fillPixelsAround(image, imageMoodifiedAroundPixel, row - 1, column, newColor)
//            }
//        }
//        if column < n - 1 {
//            if image[row][column] == image[row][column + 1] && self.stack[row][column + 1] == 0 {
//                imageMoodifiedAroundPixel = fillPixelsAround(image, imageMoodifiedAroundPixel, row, column + 1, newColor)
//            }
//        }
//        if row < m - 1 {
//            if image[row][column] == image[row + 1][column] && self.stack[row + 1][column] == 0 {
//                imageMoodifiedAroundPixel = fillPixelsAround(image, imageMoodifiedAroundPixel, row + 1, column, newColor)
//            }
//        }
//        return imageMoodifiedAroundPixel
//    }
//}


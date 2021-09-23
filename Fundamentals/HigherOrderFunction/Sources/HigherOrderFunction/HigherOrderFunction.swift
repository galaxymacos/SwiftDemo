extension Array where Element == String{
    typealias FormatSentence = (String)->String
    func printFormatted(format: FormatSentence){
        for string in self{
            let formattedString = format(string)
            print(formattedString)
        }
    }
}

let exampleSentences = ["Victory", "shall be mine"]



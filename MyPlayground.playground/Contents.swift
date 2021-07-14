import UIKit

class Operation1: Operation{
    override func main(){
        print("op1 about to start")
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {print("op1 is running")})
    }
}

class Operation2: Operation{
    override func main(){
        print("op3 about to start")
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute: {print("op2 is running")})
    }
}

let op1 = Operation1()
op1.completionBlock = {
    print("op1 finished")
}

let op2 = Operation2()
op2.completionBlock = {
    print("op2 finished")
}
op1.start()
op2.start()

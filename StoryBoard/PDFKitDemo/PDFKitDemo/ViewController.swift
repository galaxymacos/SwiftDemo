//
//  ViewController.swift
//  PDFKitDemo
//
//  Created by Xun Ruan on 2021/8/12.
//

import UIKit
import PDFKit

class ViewController: UIViewController, PDFViewDelegate  {

    let pdfView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let url = Bundle.main.url(forResource: "lalala", withExtension: "pdf") else {
            return
        }
        guard let document = PDFDocument(url: url) else {
            return
        }
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.document = document    // Create a brand new document
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pdfView.frame = view.bounds
        pdfView.delegate = self
    }
    
}


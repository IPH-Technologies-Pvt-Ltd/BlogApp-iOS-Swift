//
//  ArticleDetailViewController.swift
//  BlogHorizon
//
//  Created by IPH Technologies Pvt. Ltd. on 28/06/23.
//

import UIKit
import SwiftSoup
import WebKit
class ArticleDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var websiteLinkLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var blogDetailImageView: UIImageView!
    @IBOutlet weak var webViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headingLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var shareButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var blogContentWebView: WKWebView!
    @IBOutlet weak var blogDetailImageViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: Variables
    var blogList = [BlogDetailModel]()
    var url: URL?
    var titleOfBlog: String?
    var contentBlog: String?
    var date: String?
    var shareBlogUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { [self] in
            self.blogDetailImageView?.loadImage(from: url!)
            self.view.heroID = "animTransition"
            self.headingLabel.text = self.titleOfBlog?.capitalized
            self.dateLabel.text = self.date
        }
        setupUI()
        displayBlogContentInWebView()
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        let blogUrlToBeShared = self.shareBlogUrl!
        print("\(String(describing: blogUrlToBeShared))")
        let activityVc = UIActivityViewController(activityItems: [blogUrlToBeShared], applicationActivities: nil)
        activityVc.popoverPresentationController?.sourceView = sender
        self.present(activityVc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //for transition animation
        enableHero()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //for transition animation
        disableHero()
    }
    
    func setupUI(){
        let deviceType = UIDevice().name
        if deviceType.contains("iPad") {
            self.headingLabelTopConstraint.constant = 440
            self.webViewTopConstraint.constant = 550
            headingLabel.font = UIFont.boldSystemFont(ofSize: 30)
        }
        let screenSize: CGRect = UIScreen.main.bounds
        blogDetailImageViewHeightConstraint.constant = (screenSize.height * 0.27)
        //hiding scrollbars.
        myScrollView.showsHorizontalScrollIndicator = false
        myScrollView.showsVerticalScrollIndicator = false
        blogContentWebView.scrollView.showsHorizontalScrollIndicator = false
        blogContentWebView.scrollView.showsVerticalScrollIndicator = false
        let seconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
         //following code gets executed after a delay of 4 seconds.
             self.imageBgView.isHidden = true
             self.blogDetailImageView.isHidden = true
             self.headingLabelTopConstraint.constant = 1.0
             self.headingLabelTopConstraint.constant = 1.0
             self.shareButtonTopConstraint.constant = 2.1
             self.webViewTopConstraint.constant = 95.0
         }
        dateFormat()
        blogDetailImageView.layer.cornerRadius = 7.0
        blogDetailImageView.clipsToBounds = true
        imageBgView.layer.shadowColor = UIColor.black.cgColor
        imageBgView.layer.shadowRadius = 3.0
        imageBgView.layer.shadowOpacity = 0.5
        imageBgView.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageBgView.layer.masksToBounds = false
    }
    
    func displayBlogContentInWebView(){
        do{
            let htmlContent = self.contentBlog!
            let fontName =  "System Font Regular"
            let fontSize = 45
            let lineheight = 1.7
            let fontSetting = "<span style=\"font-family: \(fontName);font-size: \(fontSize);line-height: \(lineheight)\"</span>"
            let doc: Document = try SwiftSoup.parse(htmlContent)
            let body = try doc.body()!.attr("align", "justify")
            self.blogContentWebView.loadHTMLString(fontSetting + "\(String(describing: body))", baseURL: nil)
        }
        //for swift soup
        catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print("error")
        }
    }
    
    func dateFormat(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        let result = formatter.string(from: date)
        dateLabel.text = result
    }
}

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var filterName: UILabel!
    let context = CIContext()
    var original: UIImage!
    
    override func viewDidLoad() {
        filterName.text = ""
    }
    
    @IBAction func choosePhoto(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            self.navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func applySepia() {
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CISepiaTone")
        print("Sepia")
        filterName.text = "Filter added: Sepia"
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        display(filter: filter!)
    }

    @IBAction func applyNoir() {
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CIPhotoEffectNoir")
        print("Noir")
        filterName.text = "Filter added: Noir"
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        display(filter: filter!)
    }

    @IBAction func applyVintage() {
        if original == nil {
            return
        }
        
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        print("Vintage")
        filterName.text = "Filter added: Vintage"
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        display(filter: filter!)
    }


    
    @IBAction func applySomething() {
        if original == nil {
            return
        }
        
        let number = Int.random(in: 1 ... 4)
        switch number {
        case 1:
            print("Vignette")
            let filter = CIFilter(name: "CIVignette")
            filterName.text = "Filter added: Vignette"
            filter?.setValue(CIImage(image: original!), forKey: kCIInputImageKey)
            filter?.setValue(0.5, forKey: kCIInputRadiusKey)
            filter?.setValue(2.5, forKey: kCIInputIntensityKey)
            display(filter: filter!)
        case 2:
            print("Box Blur")
            let filter = CIFilter(name: "CIBoxBlur")
            filterName.text = "Filter added: Box Blur"
            filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
            filter?.setValue(30, forKey: kCIInputRadiusKey)
            display(filter: filter!)
        case 3:
            print("Crop")
            let filter = CIFilter(name: "CICrop")
            filterName.text = "Filter added: Crop"
            filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
            display(filter: filter!)
        case 4:
            print("Bloom")
            let filter = CIFilter(name: "CIBloom")
            filterName.text = "Filter added: Bloom"
            filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
            display(filter: filter!)
        default:
            let filter = CIFilter(name: "CISepiaTone")
            print("Sepia")
            filterName.text = "Filter added: Sepia"
            filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
            filter?.setValue(1.0, forKey: kCIInputIntensityKey)
            display(filter: filter!)
        }
    }
    
    @IBAction func savePhotoToAlbum() {
        if original == nil {
            return
        }
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("Error: \(error)")
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "Saved Successfully", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("Saved")
        }
    }
    
    func display(filter: CIFilter) {
        let output = filter.outputImage!
        imageView.image = UIImage(cgImage: self.context.createCGImage(output, from: output.extent)!)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        self.navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
    }
    
}

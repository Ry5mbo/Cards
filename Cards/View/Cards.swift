import UIKit

protocol FlippableView: UIView {
    var isFlipped: Bool { get set }
    var flipCompletionHandler: ((FlippableView) -> Void)? {get set}
    func flip()
}


class CardView<ShapeType: ShapeLayerProtocol>: UIView, FlippableView {
    var isFlipped: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var flipCompletionHandler: ((any FlippableView) -> Void)?
    func flip() {
        // определяем между какими представлениями осуществить переход
        let fromView = isFlipped ? frontSideView : backSideView
        let toView = isFlipped ? backSideView : frontSideView
        // запускаем анимированный переход
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionFlipFromTop], completion: {_ in
        // обработчки переворота
            self.flipCompletionHandler?(self)
        })
        
        isFlipped.toggle()
        
    }
    
    // цвет фигуры
    var color: UIColor!
    
    // радиус закругления
    var cornerRadius = 20
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.color = color
        

    setupBorders()
    }
    
    //настройк границ
    // настройка границ
    private func setupBorders() {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    override func draw(_ rect: CGRect) {
        // удаляем добавленные ранее дочерние представления
        backSideView.removeFromSuperview()
        frontSideView.removeFromSuperview()
        
        // добавляем новые представления
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
    }
    
    
    // внутренний отступ представления
    private let margin: Int = 10
    
    // представление с лицевой стороной карты
    lazy var frontSideView: UIView = self.getFrontSideView()
    // представление с обратной стороны карты
    lazy var backSideView: UIView = self.getBackSideView()
    
    // возвращает представление для лицевой стороны карточки
    private func getFrontSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        let shapeView = UIView(frame: CGRect(x: margin, y: margin, width: Int(self.bounds.width)-margin*2, height: Int(self.bounds.height)-margin*2))
        view.addSubview(shapeView)
        
        // создание слоя с фигурой
        let shapeLayer = ShapeType(size: shapeView.frame.size, fillColor: color.cgColor)
        shapeView.layer.addSublayer(shapeLayer)
        
        // скругляем углы корневого слоя
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }
    
    private func getBackSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        
        view.backgroundColor = .white
        
        // выбор случайного узора для рубашки
        switch ["circle", "line", "triangles"].randomElement()! {
        case "circle":
            let layer = BackSideCircle(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            let layerTwo = BackSideCircleTwo(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
            view.layer.addSublayer(layerTwo)
        case "line":
            let layer = BackSideLine(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        case "triangles":
            let layer = BackSideTriangles(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            let layerTwo = BackSideTrianglesTwo(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
            view.layer.addSublayer(layerTwo)
        default:
            break
        }
        // скругляем углы корневого слоя
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }

    
    // Точка привязки
    private var touchOffset: CGPoint = CGPoint(x: 0, y: 0)

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let superview = self.superview {
            let location = touch.location(in: superview)
            touchOffset.x = touches.first!.location(in: window).x - frame.minX
            touchOffset.y = touches.first!.location(in: window).y - frame.minY
        
            // сохраняем исходные координаты
            startTouchPoint = frame.origin
            
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.frame.origin == startTouchPoint {
            flip()
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let superview = self.superview {
            let location = touch.location(in: superview)
            self.frame.origin.x = location.x - touchOffset.x
            self.frame.origin.y = location.y - touchOffset.y
        }
    }

    
    private var startTouchPoint: CGPoint!
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

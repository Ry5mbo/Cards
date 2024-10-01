import UIKit


protocol ShapeLayerProtocol: CAShapeLayer {
    init(size: CGSize, fillColor: CGColor)
}
extension ShapeLayerProtocol {
    init() {
        fatalError("init() не может быть использован для создания экземпляра")
    }
}


class BackSideCircle: CAShapeLayer, ShapeLayerProtocol{
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let path = UIBezierPath()
        
        // рисуем 30 кругов
        for _ in 1...30 {
            
            // координаты центра очередного круга
            let randomX = Int.random(in: 0...Int(size.width))
            let randomY = Int.random(in: 0...Int(size.height))
            let center = CGPoint(x: randomX, y: randomY)
            // смещаем указатель к центру круга
            path.move(to: center)
            // определяем случайный радиус
            let radius = Int.random(in: 2...10)
            // рисуем круг
            path.addArc(withCenter: center, radius: CGFloat(radius), startAngle: 0, endAngle: .pi*2, clockwise: true)
        }
        
        // инциализируем созданный путь
        self.path = path.cgPath
        // изменяем цвет
        self.strokeColor = UIColor.gray.cgColor
        self.fillColor = UIColor.gray.cgColor
        self.lineWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imlemented")
    }
}

class BackSideCircleTwo: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let path = UIBezierPath()

        // рисуем 30 кругов
        for _ in 1...30 {
            
            // координаты центра очередного круга
            let randomX = Int.random(in: 0...Int(size.width))
            let randomY = Int.random(in: 0...Int(size.height))
            let center = CGPoint(x: randomX, y: randomY)
            // смещаем указатель к центру круга
            path.move(to: center)
            // определяем случайный радиус
            let radius = Int.random(in: 2...10)
            // рисуем круг
            path.addArc(withCenter: center, radius: CGFloat(radius), startAngle: 0, endAngle: .pi*2, clockwise: true)
        }
        
        // инциализируем созданный путь
        self.path = path.cgPath
        // изменяем цвет
        self.strokeColor = UIColor.black.cgColor
        self.fillColor = UIColor.black.cgColor
        self.lineWidth = 1
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imlemented")
    }
}

class BackSideTriangles: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let path = UIBezierPath()
        // Список boundingBoxes уже созданных треугольников
        var boundingBoxes: [CGRect] = []
        
        let numberOfTriangles = 15
        let maxAttemptsPerTriangle = 30 // Максимальное количество попыток генерации одного треугольника
        
        for _ in 1...numberOfTriangles {
            var triangleGenerated = false
            var attempts = 0
            
            while !triangleGenerated && attempts < maxAttemptsPerTriangle {
                attempts += 1
                
                // Генерируем три случайные точки для треугольника
                let point1 = CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
                let point2 = CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
                let point3 = CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
                
                // Создаём треугольник
                let tempPath = UIBezierPath()
                tempPath.move(to: point1)
                tempPath.addLine(to: point2)
                tempPath.addLine(to: point3)
                tempPath.close()
                
                // Получаем bounding box треугольника
                let triangleBoundingBox = tempPath.bounds
                
                // Проверяем пересечение с уже существующими bounding boxes
                var intersects = false
                for existingBox in boundingBoxes {
                    if triangleBoundingBox.intersects(existingBox.insetBy(dx: -5, dy: -5)) { // Добавляем небольшой отступ
                        intersects = true
                        break
                    }
                }
                
                if !intersects {
                    // Добавляем треугольник к основному пути
                    path.append(tempPath)
                    
                    // Сохраняем bounding box
                    boundingBoxes.append(triangleBoundingBox)
                    
                    triangleGenerated = true
                }
            }
            
            if !triangleGenerated {
                print("Не удалось сгенерировать треугольник после \(maxAttemptsPerTriangle) попыток.")
            }
        }
        
        // Устанавливаем путь слоя
        self.path = path.cgPath
        // Устанавливаем цвет обводки и заливки
        self.strokeColor = UIColor.gray.cgColor // Цвет линий
        self.fillColor = UIColor.gray.cgColor // Заполнение не требуется или можно задать другой цвет
        // Настраиваем толщину линии
        self.lineWidth = 2
        // Настраиваем стиль концов линий (опционально)
        self.lineCap = .round
        // Настраиваем стиль соединений (опционально)
        self.lineJoin = .round
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BackSideTrianglesTwo: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let path = UIBezierPath()
        // Список boundingBoxes уже созданных треугольников
        var boundingBoxes: [CGRect] = []
        
        let numberOfTriangles = 15
        let maxAttemptsPerTriangle = 30 // Максимальное количество попыток генерации одного треугольника
        
        for _ in 1...numberOfTriangles {
            var triangleGenerated = false
            var attempts = 0
            
            while !triangleGenerated && attempts < maxAttemptsPerTriangle {
                attempts += 1
                
                // Генерируем три случайные точки для треугольника
                let point1 = CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
                let point2 = CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
                let point3 = CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
                
                // Создаём треугольник
                let tempPath = UIBezierPath()
                tempPath.move(to: point1)
                tempPath.addLine(to: point2)
                tempPath.addLine(to: point3)
                tempPath.close()
                
                // Получаем bounding box треугольника
                let triangleBoundingBox = tempPath.bounds
                
                // Проверяем пересечение с уже существующими bounding boxes
                var intersects = false
                for existingBox in boundingBoxes {
                    if triangleBoundingBox.intersects(existingBox.insetBy(dx: -5, dy: -5)) { // Добавляем небольшой отступ
                        intersects = true
                        break
                    }
                }
                
                if !intersects {
                    // Добавляем треугольник к основному пути
                    path.append(tempPath)
                    
                    // Сохраняем bounding box
                    boundingBoxes.append(triangleBoundingBox)
                    
                    triangleGenerated = true
                }
            }
            
            if !triangleGenerated {
                print("Не удалось сгенерировать треугольник после \(maxAttemptsPerTriangle) попыток.")
            }
        }
        
        // Устанавливаем путь слоя
        self.path = path.cgPath
        // Устанавливаем цвет обводки и заливки
        self.strokeColor = UIColor.black.cgColor // Цвет линий
        self.fillColor = UIColor.black.cgColor // Цвет фона
        // Настраиваем толщину линии
        self.lineWidth = 2
        // Настраиваем стиль концов линий (опционально)
        self.lineCap = .round
        // Настраиваем стиль соединений (опционально)
        self.lineJoin = .round
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BackSideLine: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let path = UIBezierPath()
        
        // рисуем линии
        for _ in 1...15 {
            
            // координаты начала очередной линии
            let randomXStart = Int.random(in: 0...Int(size.width))
            let randomYStart = Int.random(in: 0...Int(size.height))
            // координаты конца одной линии
            let randomXEnd = Int.random(in: 0...Int(size.width))
            let randomYEnd = Int.random(in: 0...Int(size.height))
            
            // смещаем указатель к началу линии
            path.move(to: CGPoint(x: randomXStart, y: randomYStart))
            
            // рисуем линию
            path.addLine(to: CGPoint(x: randomXEnd, y: randomYEnd))

        }
        
        // инициализируем собственный путь
        self.path = path.cgPath
        // изменяем стиль линий
        self.strokeColor = fillColor
        self.lineWidth = 3
        self.lineCap = .round
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class CircleShape: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        // расчитываем данные для круга
        // радиус равен половине меньшей из сторон
        let radius = ([size.width, size.height].min() ?? 0) / 2
        // центр круга равен центрам каждой из сторон
        let centerX = size.width / 2
        let centerY = size.height / 2
        
        // рисуем круг
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: 0, endAngle: .pi*2, clockwise: true)
        path.close()
        // инициализируем созданный путь
        self.path = path.cgPath
        // изменяем цвет
        self.fillColor = fillColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
}


class SquareShape: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        // сторона равна меньшей из сторон
        let edgeSize = ([size.width, size.height].min() ?? 0)
        // рисуем квадрат
        let rect = CGRect(x: 0, y: 0, width: edgeSize, height: edgeSize)
        let path = UIBezierPath(rect: rect)
        path.close()
        // инициализируем созданный путь
        self.path = path.cgPath
        // изменяем цвет
        self.fillColor = fillColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CrossShape: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        // рисуем крест
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.move(to: CGPoint(x: size.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: size.height))
        
        // инициализируем созданный путь
        self.path = path.cgPath
        // изменяем цвет
        self.strokeColor = fillColor
        self.lineWidth = 5
    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class FillShape: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.path = path.cgPath
        self.fillColor = fillColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

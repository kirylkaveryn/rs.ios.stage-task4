import Foundation

final class CallStation {
    
    var userList: [User] = []
    var callList: [Call] = []
    
}

extension CallStation: Station {
    func users() -> [User] {
        return userList
    }
    
    // добавляем пользователя и проверяем - есть ли он уже есть в списке
    func add(user: User) {
        if !userList.contains(user) {
            userList.append(user)
        }
    }
    
    // удаляем пользовател по индексу
    func remove(user: User) {
        let index: Int = userList.firstIndex(of: user)!
        userList.remove(at: index)
    }
    
    func execute(action: CallAction) -> CallID? {
        
        switch action {
        
        case .start(let from, let to):
            
            // проверяем не пустая ли база пользователей
            if userList.count == 0 {
                return nil
            }
            
            // если одного из пользователей (задействованных в звонке) в базе нету, то звонок обрывается
            if !userList.contains(from) || !userList.contains(to) {
                let newCall = Call(id: UUID(), incomingUser: to, outgoingUser: from, status: .ended(reason: .error))
                callList.append(newCall)
                return newCall.id
            }
            
            // если кто-то из пользователей занят (находится в другом звонке, который не завершен - в состоянии .talk или .calling), то создаем звонок с ошибкой .busy
            for i in 0..<callList.count {
                if  from == callList[i].incomingUser ||
                    from == callList[i].outgoingUser ||
                    to == callList[i].incomingUser ||
                    to == callList[i].outgoingUser
                {
                    if callList[i].status == .talk || callList[i].status == .calling
                    {
                        let newCall = Call(id: UUID(), incomingUser: to, outgoingUser: from, status: .ended(reason: .userBusy))
                        callList.append(newCall)
                        return newCall.id
                    }
                }
            }
            
            // если нет проблем, то создаем звонок
            let newCall = Call(id: UUID(), incomingUser: to, outgoingUser: from, status: .calling)
            callList.append(newCall)
            return newCall.id
        
                
        case .answer(let from):
            
            // если звонок оборвался, то пользователь не может ответить. Меняем статс звонка и возвращаем nil
            if !userList.contains(from) {
                for i in 0..<callList.count {
                    if from == callList[i].incomingUser {
                        let newCall = Call(id: callList[i].id, incomingUser: callList[i].incomingUser, outgoingUser: callList[i].outgoingUser, status: .ended(reason: .error))
                        callList[i] = newCall
                        return nil
                    }
                }
            }

            // итерируюсь по массиву звонков, по входящему абоненту нахожу индекс звонка, создаю новый и меняю статус старого
            for i in 0..<callList.count {
                if from == callList[i].incomingUser {
                    let newCall = Call(id: callList[i].id, incomingUser: callList[i].incomingUser, outgoingUser: callList[i].outgoingUser, status: .talk)
                    callList[i] = newCall
                    return newCall.id
                }
            }
            return nil
            
        case .end(let from):
            
            // если трубка была снята status = .talk то .ended(reason: .end)
            // если трубка НЕ была снята status = .calling то .ended(reason: .cancel)
            for i in 0..<callList.count {
                if from == callList[i].outgoingUser || from == callList[i].incomingUser {
            
                    if callList[i].status == .talk {
                        let newCall = Call(id: callList[i].id, incomingUser: callList[i].incomingUser, outgoingUser: callList[i].outgoingUser, status: .ended(reason: .end))
                        callList[i] = newCall
                        return newCall.id
                    }
                    
                    if callList[i].status == .calling {
                        let newCall = Call(id: callList[i].id, incomingUser: callList[i].incomingUser, outgoingUser: callList[i].outgoingUser, status: .ended(reason: .cancel))
                        callList[i] = newCall
                        return newCall.id
                    }
                }
            }
            return nil
        }

    }
    
    func calls() -> [Call] {
        // просто возвращают список звонков
        callList
    }
    
    func calls(user: User) -> [Call] {
        // создаю промежуточный список входящих/исходящих звонков для пользователя
        var userCallList: [Call] = []
        for call in callList {
            if call.outgoingUser == user {
                userCallList.append(call)
            }
            if call.incomingUser == user {
                userCallList.append(call)
            }
        }
        return userCallList
    }
    
    func call(id: CallID) -> Call? {
        // возвращаю звонок по id из списка
        for call in callList {
            if call.id == id {
                return call
            }
        }
        return nil
    }
    
    func currentCall(user: User) -> Call? {
        
        // проверка по массиву звонков на совпадение пользователей при незаконченном разговоре
        for call in callList {
            if ((call.incomingUser == user || call.outgoingUser == user) && call.status == .calling) {
                return call
            }
            
            else if ((call.incomingUser == user || call.outgoingUser == user) && call.status == .talk) {
                return call
            }
            
            // проверка по массиву звонков на совпадение пользователей при законченном разговоре
            else if ((call.incomingUser == user || call.outgoingUser == user) && call.status == .ended(reason: .end)) {
                return nil
            }
            else if ((call.incomingUser == user || call.outgoingUser == user) && call.status == .ended(reason: .cancel)) {
                return nil
            }
        }
        

        
        
        
        return nil // исправить позже!
    }
}

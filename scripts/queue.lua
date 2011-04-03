Queue = {}
function Queue.new()
    function enqueue(q, val)
        q.last = q.last + 1
        q[q.last] = val
    end
    function dequeue(q)
        if q.first < q.last then
            error("Queue is empty!")
        end
        local val = q[q.first]
        q[q.first] = nil
        q.first = q.first + 1
        return val
    end
    function isEmpty(q)
        return q.first < q.last
    end

    return {first = 0, last = -1, enqueue = enqueue,
            dequeue = dequeue, isEmpty = isEmpty }
end


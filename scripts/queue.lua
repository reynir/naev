Queue = {}
function Queue.new()
    return {first = 0, last = -1}
end

function Queue.enqueue(q, val)
    q.last = q.last + 1
    q[q.last] = val
end

function Queue.dequeue(q)
    if q.first < q.last then
        error("Queue is empty!")
    end
    local val = q[q.first]
    q[q.first] = nil
    q.first = q.first + 1
    return val
end

function Queue.isEmpty(q)
    return q.first < q.last
end

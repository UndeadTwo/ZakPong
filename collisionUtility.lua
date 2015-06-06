function pointCollisionCheck(x, y, xa, ya, wa, ha)
  return x >= xa and x <= xa + wa and y >= ya and y <= ya + ha
end

function collisionCheck(x, y, w, h, xa, ya, wa, ha)
  return pointCollisionCheck(x, y, xa, ya, wa, ha) or
         pointCollisionCheck(x + w, y + h, xa, ya, wa, ha) or
         pointCollisionCheck(xa, ya, x, y, w, h) or
         pointCollisionCheck(xa + wa, ya + ha, x, y, w, h)
end

function doCollisions(entityA, entityB)
  local a = entityA
  local b = entityB

  if(collisionCheck(a.x - a.w / 2, a.y - a.h / 2, a.w, a.h, b.x - b.w / 2, b.y - b.h / 2, b.w, b.h))then
    a:collision(b)
    b:collision(a)
  end
end

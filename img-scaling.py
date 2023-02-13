import io
import base64
from PIL import Image

base64_str = ""
pref = ""
with open('image.txt', 'r') as readf:
    text = readf.read().split(',')
    pref = text[0]
    base64_str = text[1]
print(pref)

buffer = io.BytesIO()
imgdata = base64.b64decode(base64_str)
img = Image.open(io.BytesIO(imgdata))
print(img.format)
width, height = img.size
scale_factor = 2
while width > 610:
    print(scale_factor)
    width = int(width/scale_factor)
    height = int(height/scale_factor)
    scale_factor += 1
new_img = img.resize((width, height))  # x, y
new_img.save(buffer, format='JPEG')
img_b64 = base64.b64encode(buffer.getvalue())

with open('out.txt', 'w') as out:
    out.write((str(img_b64)[2:-1]))

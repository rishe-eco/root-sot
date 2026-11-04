"""Finish the Hamrah showcase: captions, speed, title cards, crossfades, a synthesized pad.

usage: python3 build.py take3        -> out/hamrah-showcase.mp4
"""
import json, subprocess, sys, wave
from pathlib import Path
import numpy as np

HERE = Path(__file__).parent
TAKE = HERE / (sys.argv[1] if len(sys.argv) > 1 else 'take3')
OUT = HERE / 'out'; OUT.mkdir(exist_ok=True)
marks = {m['name']: m['t'] for m in json.loads((TAKE / 'marks.json').read_text())}

SPEED = 1.15          # app footage plays a touch faster than it was driven
FADE = 0.6            # every crossfade
FPS = 30

# --- the app footage, in take time ---
A = (marks['start'] + 0.03, marks['cut'])
B = (marks['cut'] + 0.05, marks['end'])
dA, dB = (A[1] - A[0]) / SPEED, (B[1] - B[0]) / SPEED

# captions over the app, in take time (start, end)
g = marks['guard']
CAPS = [
    ('c1', marks['preview-fills'] + 0.6, marks['preview-fills'] + 5.0),
    ('c2', marks['designer'] + 0.8, marks['designer'] + 5.8),
    ('c3', g + 6.2, g + 15.4),
    ('c4', marks['build'] + 0.8, marks['paid'] - 0.2),
    ('c5', marks['admin-published'] - 1.8, marks['end'] + 1),
]

# --- the sequence ---
SEQ = [('tagline', 3.8), ('hamrah', 3.4), ('A', dA), ('later', 2.4), ('B', dB), ('close', 4.6), ('end', 5.6)]
# card-to-card cuts dip through the chalk ground instead of overlapping two texts
CARDS = {'tagline', 'hamrah', 'close', 'end'}
XF = [0.1 if SEQ[i][0] in CARDS and SEQ[i + 1][0] in CARDS else FADE for i in range(len(SEQ) - 1)]
DIP, CHALK = 0.5, '0xEDEFF0'
starts, t = [], 0.0
for i, (_, d) in enumerate(SEQ):
    starts.append(t); t += d - (XF[i] if i < len(SEQ) - 1 else 0)
TOTAL = t
start = dict(zip([s for s, _ in SEQ], starts))
def final_time(take_t):
    if take_t <= A[1]: return start['A'] + (take_t - A[0]) / SPEED
    return start['B'] + (take_t - B[0]) / SPEED
print(f'total {TOTAL:.2f}s · A {dA:.2f}s · B {dB:.2f}s')
for k, v in start.items(): print(f'  {k:8s} {v:6.2f}')

# --- music: a calm pad, D – Bm – G – A, landing on D at the closing line ---
SR = 48000
def hz(n): return 440 * 2 ** ((n - 69) / 12)
CHORDS = {  # MIDI notes
    'D':  [50, 57, 62, 66, 76],
    'Bm': [47, 54, 59, 62, 69],
    'G':  [43, 50, 55, 59, 66],
    'A':  [45, 52, 57, 62, 64],
}
CYCLE = ['D', 'Bm', 'G', 'A']
LEN = 8.0
t_close = start['close']
events = [('D', t_close, TOTAL - t_close + 2)]
k, tt = 3, t_close
while tt > -LEN:
    tt -= LEN; events.insert(0, (CYCLE[k % 4], tt, LEN)); k -= 1

n = int((TOTAL + 3) * SR)
L = np.zeros(n); R = np.zeros(n)
time = np.arange(n) / SR
for name, t0, dur in events:
    a, rel = 2.8, 3.2
    s0 = max(0, int(t0 * SR)); s1 = min(n, int((t0 + dur + rel) * SR))
    if s1 <= s0: continue
    tt_ = time[s0:s1] - t0
    env = np.clip(tt_ / a, 0, 1) * np.clip((t0 + dur + rel - time[s0:s1]) / rel, 0, 1)
    env = env ** 1.6
    for j, note in enumerate(CHORDS[name]):
        f = hz(note); amp = (0.16 if j == 0 else 0.10) * (0.7 if note > 70 else 1)
        lfo = 1 + 0.12 * np.sin(2 * np.pi * (0.07 + 0.03 * j) * time[s0:s1] + j)
        for side, det in ((L, 0.9985), (R, 1.0015)):
            ph = 2 * np.pi * f * det * time[s0:s1]
            tone = np.sin(ph) + 0.25 * np.sin(2 * ph) + 0.08 * np.sin(3 * ph)
            side[s0:s1] += amp * env * lfo * tone

def bell(at, notes=(81, 86), gain=0.07):
    s0 = int(at * SR); m = int(3.5 * SR); tt_ = np.arange(m) / SR
    for i, note in enumerate(notes):
        f = hz(note); s = s0 + int(i * 0.18 * SR); e = min(n, s + m)
        if s >= n: continue
        v = gain * np.exp(-tt_ / 1.1) * (np.sin(2 * np.pi * f * tt_) + 0.3 * np.sin(2 * np.pi * f * 2.76 * tt_) * np.exp(-tt_ / 0.3))
        L[s:e] += v[: e - s] * 0.9; R[s:e] += v[: e - s]
bell(final_time(marks['preview-fills']) + 0.3)
bell(final_time(marks['launched']), notes=(74, 78, 81))
bell(final_time(marks['admin-published']), notes=(78, 81, 86))

# a soft room: convolve with a decaying-noise impulse response
rng = np.random.default_rng(7)
ir_t = np.arange(int(2.4 * SR)) / SR
def room(x, seed):
    ir = np.random.default_rng(seed).standard_normal(len(ir_t)) * np.exp(-ir_t / 0.55)
    ir[0] = 0; ir /= np.abs(ir).sum() / 6
    N = 1 << int(np.ceil(np.log2(len(x) + len(ir))))
    wet = np.fft.irfft(np.fft.rfft(x, N) * np.fft.rfft(ir, N), N)[: len(x)]
    return 0.65 * x + 0.35 * wet
L, R = room(L, 1), room(R, 2)
# gentle fade in/out
fade = np.ones(n); fi, fo = int(2.0 * SR), int(3.5 * SR); end_s = int(TOTAL * SR)
fade[:fi] = np.linspace(0, 1, fi); fade[end_s - fo:end_s] = np.linspace(1, 0, fo); fade[end_s:] = 0
st = np.stack([L * fade, R * fade], 1)
st = st / np.abs(st).max() * 0.6
with wave.open(str(OUT / 'pad.wav'), 'wb') as w:
    w.setnchannels(2); w.setsampwidth(2); w.setframerate(SR)
    w.writeframes((st * 32767).astype('<i2').tobytes())

# --- ffmpeg graph ---
inputs = ['-i', str(TAKE / 'app.mp4')]
for c, _, _ in CAPS: inputs += ['-loop', '1', '-framerate', str(FPS), '-t', '100', '-i', str(HERE / 'cards' / f'{c}.png')]
card_idx, inputs_cards = {}, []
idx = 1 + len(CAPS)
for name, d in SEQ:
    if name in ('A', 'B'): continue
    inputs_cards += ['-loop', '1', '-framerate', str(FPS), '-t', f'{d:.3f}', '-i', str(HERE / 'cards' / f'{name}.png')]
    card_idx[name] = idx; idx += 1
audio_idx = idx
inputs += inputs_cards + ['-i', str(OUT / 'pad.wav')]

f = []
prev = '0:v'
for i, (c, a, b) in enumerate(CAPS, start=1):
    f.append(f'[{i}:v]format=rgba,fade=t=in:st={a:.3f}:d=0.35:alpha=1,fade=t=out:st={b - 0.35:.3f}:d=0.35:alpha=1[k{i}]')
    f.append(f'[{prev}][k{i}]overlay=0:0:eof_action=pass[o{i}]'); prev = f'o{i}'
f.append(f'[{prev}]split[pa][pb]')
for tag, (s, e) in (('A', A), ('B', B)):
    src = 'pa' if tag == 'A' else 'pb'
    f.append(f'[{src}]trim=start={s:.3f}:end={e:.3f},setpts=(PTS-STARTPTS)/{SPEED},fps={FPS},format=yuv420p,setsar=1,settb=AVTB[{tag}]')
names = [s for s, _ in SEQ]
for name, i in card_idx.items():
    k, d = names.index(name), SEQ[names.index(name)][1]
    fx = ''
    if k == 0 or (k > 0 and XF[k - 1] < FADE): fx += f',fade=t=in:st=0:d={DIP}:color={CHALK}'
    if k == len(SEQ) - 1 or XF[k] < FADE: fx += f',fade=t=out:st={d - DIP:.3f}:d={DIP}:color={CHALK}'
    f.append(f'[{i}:v]fps={FPS},format=yuv420p,setsar=1,settb=AVTB{fx}[{name}]')
cur, acc = SEQ[0][0], SEQ[0][1]
for j, (name, d) in enumerate(SEQ[1:], start=1):
    off = acc - XF[j - 1]
    out = f'x{j}'
    f.append(f'[{cur}][{name}]xfade=transition=fade:duration={XF[j - 1]}:offset={off:.3f}[{out}]')
    cur, acc = out, off + d
f.append(f'[{audio_idx}:a]atrim=0:{TOTAL:.3f},loudnorm=I=-18:TP=-2:LRA=9[aud]')

cmd = ['ffmpeg', '-y', '-v', 'error', '-stats', *inputs, '-filter_complex', ';'.join(f),
       '-map', f'[{cur}]', '-map', '[aud]', '-t', f'{TOTAL:.3f}',
       '-c:v', 'libx264', '-preset', 'slow', '-crf', '17', '-pix_fmt', 'yuv420p', '-profile:v', 'high', '-r', str(FPS),
       '-c:a', 'aac', '-b:a', '192k', '-ar', '48000', '-movflags', '+faststart',
       '-metadata', 'title=همراه · Hamrah — showcase (vision)', str(OUT / 'hamrah-showcase.mp4')]
(OUT / 'ffmpeg-cmd.txt').write_text(' '.join(cmd))
subprocess.run(cmd, check=True)
print('wrote', OUT / 'hamrah-showcase.mp4')

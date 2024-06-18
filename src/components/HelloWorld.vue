<script setup lang="ts">
import { reactive } from 'vue'
import { Button } from '@/components/ui/button'

defineProps<{ msg: string }>()

const videoList = reactive([
  {
    desc: '骨架屏对自动弹起白屏时间的影响',
    isPlaying: false,
    videos: [
      {
        url: 'https://lf3-infras.bytetos.com/obj/static-assets/a92bb93f3b5e55c701b9de779b16bb83.mp4',
        alt: '对照组-自动拉起',
        begin: 5.066,
        end: 0,
      },
      {
        url: 'https://lf3-infras.bytetos.com/obj/static-assets/3223151d85da4e65506d158e42a2d1b0.mp4',
        alt: '实验组-骨架屏-自动弹起',
        begin: 6.099,
        end: 0,
      }
    ]
  },
  {
    desc: 'html缓存对二开白屏时间的影响',
    videos: [
      {
        url: 'https://lf6-infras.bytetos.com/obj/static-assets/f2b6f4985f1d3772b73e23532a0a4aab.mp4',
        alt: '对照组-二开',
        begin: 0.799,
        end: 0,
      },
      {
        url: 'https://lf6-infras.bytetos.com/obj/static-assets/644f29d39f6d31d63fdacf5670f1d33b.mp4',
        alt: '实验组-html缓存-二开',
        begin: 0.666,
        end: 0,
      }
    ]
  },
])

const handleReplay = (item: any) => {
  item.isPlaying = true
  item.videos.forEach((video: any) => {
    const videoEl = document.querySelector(`video[alt="${video.alt}"]`) as HTMLVideoElement
    // why cut 0.3s? 有个明显的起点标识
    videoEl.currentTime = video.begin - 0.3
    videoEl.play()
  })
}

const togglePlay = (item: any) => {
  item.isPlaying = !item.isPlaying
  item.videos.forEach((video: any) => {
    const videoEl = document.querySelector(`video[alt="${video.alt}"]`) as HTMLVideoElement
    if (item.isPlaying) {
      videoEl.play()
    } else {
      videoEl.pause()
    }
  })
}

</script>

<template>
  <div>
    <div class="block" v-for="item in videoList" :key="item.desc">
      <h2>{{ item.desc }}</h2>
      <p>
        <Button @click="handleReplay(item)">Replay</Button>
        <Button variant="destructive" @click="togglePlay(item)">{{ item.isPlaying ? 'Pause' : 'Play' }}</Button>
      </p>
      <section v-for="video in item.videos" :key="video.url">
        <div>{{ video.alt }}</div>
        <video
          controls
          width="300"
          height="200"
          :src="video.url"
          :alt="video.alt"
        ></video>
      </section>
    </div>
  </div>
</template>

<style lang="less" scoped>
.block {
  display: inline-block;
  margin: 50px;
  h2 {
    margin: 20px 0;
  }
  section {
    display: inline-block;
    color: #aaa;
  }
  video {
    display: inline-block;
  }
}

p {
  margin: 10px 0;
}
button {
  margin-right: 10px;
}
</style>

<script setup lang="ts">
import * as THREE from 'three'
import { computed, onMounted, ref, watch } from 'vue'
import { useWindowSize } from '@vueuse/core'
import { OrbitControls } from 'three/examples/jsm/Addons.js'

const canvas = ref<HTMLCanvasElement | null>(null)

let renderer: THREE.WebGLRenderer
let controls: OrbitControls

const { width, height } = useWindowSize()
const aspectRatio = computed(() => width.value / height.value)

const scene = new THREE.Scene()
const camera = new THREE.PerspectiveCamera(75, aspectRatio.value, 0.1, 1000)
camera.position.y = 5
camera.position.z = 10
scene.add(camera)

const textureLoader = new THREE.TextureLoader()
const texture = textureLoader.load('texture.jpg')

// const sphere = new THREE.Mesh(
//   new THREE.SphereGeometry(5, 32, 32),
//   new THREE.MeshBasicMaterial({ map: texture })
// );
// scene.add(sphere);
const cube = new THREE.Mesh(
  new THREE.BoxGeometry(5, 5, 5, 32, 32),
  new THREE.MeshBasicMaterial({ map: texture }),
)
scene.add(cube)

onMounted(() => {
  if (!canvas.value) {
    console.error('Canvas not found')
    return
  }

  renderer = new THREE.WebGLRenderer({
    canvas: canvas.value,
    antialias: true,
  })

  controls = new OrbitControls(camera, renderer.domElement)
  controls.enableDamping = true

  updateCamera()
  updateRenderer()

  update()
})

const updateCamera = () => {
  camera.aspect = aspectRatio.value
  camera.updateProjectionMatrix()
}

const updateRenderer = () => {
  renderer.setSize(width.value, height.value)
  renderer.setPixelRatio(window.devicePixelRatio)
}

watch(aspectRatio, updateCamera)
watch(aspectRatio, updateRenderer)

const update = () => {
  renderer.render(scene, camera)

  cube.rotation.y += 0.01
  requestAnimationFrame(update)
}
</script>

<template>
  <canvas ref="canvas"></canvas>
</template>

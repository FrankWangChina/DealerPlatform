import Vue from 'vue'
import VueRouter from 'vue-router'
//import Home from '../views/Home.vue'
import Layout from '../views/Layout.vue'
import Main from '../views/MainPage.vue'
import ProductList from '../views/ProductListPage.vue'
import ShoppingCart from '../views/ShoppingCart.vue'

Vue.use(VueRouter)

const routes = [
  // {
  //   path: '/',
  //   name: 'Home',
  //   component: Home
  // },
  // {
  //   path: '/about',
  //   name: 'About',
  //   // route level code-splitting
  //   // this generates a separate chunk (about.[hash].js) for this route
  //   // which is lazy-loaded when the route is visited.
  //   component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  // },

  {
    path: '/',
    name: 'login',
    component: () => import('../views/Login.vue')
  },
  {
    path:'/layout',
    name:'layout',
    component:Layout,
    children:[
      {
        path:'/productlist',
        name:'productlist',
        component:ProductList
      },
      {
        path:'/main',
        name:'main',
        component:Main
      },
      {
        path:'/shoppingcart',
        name:'shoppingcart',
        component:ShoppingCart
      },
    ]
  },
]

const router = new VueRouter({
  routes
})

export default router

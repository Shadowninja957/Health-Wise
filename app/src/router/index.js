import Vue from 'vue'
import VueRouter from 'vue-router'
import LandingPage from '../components/LandingPage'
import LogIn from '../components/LogIn'
import SignUp from '../components/SignUp'
import HomePage from '../components/HomePage'
import DoctorPage from '../components/DoctorPage'
import AppointmentPage from '../components/AppointmentPage'
import FeedbackForm from '../components/FeedbackForm'
import FeedbackView from '../components/FeedbackView'
import DiagnosisPage from '../components/DiagnosisPage';
import store from '../store'

Vue.use(VueRouter);

const routes = [
    {
        path: '/',
        name: 'LandingPage',
        component: LandingPage,
        meta: {
            requiresVisitor: true,
        }
    },
    {
        path: '/login',
        name: 'LogIn',
        component: LogIn,
        meta: {
            requiresVisitor: true,
        }
    },
    {
        path: '/signup',
        name: 'SignUp',
        component: SignUp,
        meta: {
            requiresVisitor: true,
        }
    },
    {
      path: '/home',
      name: 'Home',
      component: HomePage,
      meta: {
        requiresAuth: true,
      }
    },
    {
      path: '/doctors',
      name: 'Doctors',
      component: DoctorPage,
      meta: {
        requiresAuth: true,
      }
    },
    {
      path: '/appointments',
      name: 'Appointments',
      component: AppointmentPage,
      meta: {
        requiresAuth: true,
      }
    },
    {
      path: '/feedback-form',
      name: 'FeedbackForm',
      component: FeedbackForm,
      meta: {
        requiresAuth: true,
      }
    },
    {
      path: '/feedback-view',
      name: 'FeedbackView',
      component: FeedbackView,
      meta: {
        requiresAuth: true,
      }
    },
    {
      path: '/diagnosis',
      name: 'Diagnosis',
      component: DiagnosisPage,
      meta: {
        requiresAuth: true,
      }
    },
]

const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
  })
  
  router.beforeEach((to, from, next) => {
    if (to.matched.some(record => record.meta.requiresAuth)) {
      // this route requires auth, check if logged in
      // if not, redirect to login page.
      console.log("Authenticated: ", store.getters['auth/getAuthenticated']);
      if (!store.getters['auth/getAuthenticated']) {
        next({
          path: '/login',
          
        })
      } else {
        next()
      }
    } else if (to.matched.some(record => record.meta.requiresVisitor)) {
      // this route requires auth, check if logged in
      // if not, redirect to login page.
      //console.log("Authenticated: ", store.getters['auth/authenticated']);
      if (store.getters['auth/getAuthenticated']) {
        console.log(`Authenticated: ${store.getters['auth/getAuthenticated']}`)
        next({
          path: '/login',
          
        })
      } else {
        next()
      }
    }else {
      next() // make sure to always call next()!
    }
  })
  
  export default router
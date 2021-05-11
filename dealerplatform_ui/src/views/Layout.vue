<template>
<div>
    <!--展示子页面内容-->
    <router-view />
    <!--展示底部三个菜单-->
    <div class="foot-menu-pad">
        <div class="foot-menu">
            <router-link to="/productlist" class="foot-item">
                <b v-bind:class="['i-search',{'menu-sel':bottomMenuIndex==1}]" v-on:cilck="bottomMenuClick"></b>
            </router-link>
            <router-link to="/shoppingcart" class="foot-item">
                <b v-bind:class="['i-car',{'menu-sel':bottomMenuIndex==2}]" v-on:cilck="bottomMenuClick">
                    <i>10</i>
                </b>
            </router-link>
            <router-link to="/main" class="foot-item">
                <b v-bind:class="['i-user',{'menu-sel':bottomMenuIndex==3}]" v-on:cilck="bottomMenuClick">
                    
                </b>
            </router-link>            
        </div>
    </div>
</div>
</template>

<script>
export default {
    data(){
        return{
            bottomMenuIndex:0
        }
    },
    mounted(){
        this.bottomMenuIndex =3;
    },
    methods:{
        bottomMenuClick(){

        }
    }
}
</script>

<style lang="scss" scoped>
.foot-menu-pad{
    height: 40px;
    .foot-menu{
        height: 40px;
        width: 100%;
        position:fixed;
        left: 0;
        bottom: 0;
        background-color: #fff;
        display: flex;// **************弹性盒子*********
        .foot-item{
            flex: 1;//****************单 行内容会等分***********
            height: 40px;
            line-height: 40px;
            text-align: center;
            background-color: #f0f0f0;
            b{
                background-color: #acacac;
                width: 26px;
                height: 26px;
                border-radius: 13px;
                display: inline-block;//可以一行多元素
                margin-top: 6px;
                background-position: center;
                background-repeat: no-repeat;
                //margin-left: 40%;
                i{
                    position: relative;
                    font-size: 8px;
                    font-weight: normal;
                    font-style: normal;
                    padding: 1px 3px;
                    width: 22px;
                    height: 12px;
                    border-radius: 8px;
                    background-color: red;
                    color: #fff;
                    left: 16px;
                    top: -19px;
                }
                
            }
            .i-search{
                background-image: url("/img/icons-png/search-white.png");
            }
            .i-car{
                background-image: url("/img/icons-png/shoppingCar-white.png");
            }
            .i-user{
                background-image: url("/img/icons-png/user-white.png");
            }
            .menu-sel {
                background-color: rgb(201, 39, 39);
            }
        }
    }
}

</style>

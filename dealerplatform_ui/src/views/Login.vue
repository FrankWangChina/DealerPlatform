<template>
    <div id="loginPage">
        <div class="login-pad">
            <h2>
                <img src="/img/icons/Logo2.png" alt="">
                经销商平台
            </h2>
            <p>
                <input type="text" name="" id="txtLogAcc" placeholder="用户名" v-model="acc">
            </p>
            <p>
                <input type="password" name="" id="txtLogPwd" placeholder="密码" v-model="pwd">
            </p>
            <button v-on:click="loginSubmit">➡</button>
        </div>
        <div class="login-bottom">
            &copy;Product By Frank
        </div>
    </div>
</template>

<script>
//var dom = document.getElementById("#id");
// dom.firstChild;//获取对象的第一个元素
// dom.childNodes;//获取所有子节点元素
// dom.removeChild()//移除所有子元素
// dom.appendChild(document.createElement('input'))//新增子元素
document.body.style.backgroundColor="#f2f3f3"; 
    export default {
        data() {
            return {
                acc:"",
                pwd:""
            }
        },
        mounted() {
            this.$router.push("/main");//开发测试用
        },
        methods: {
            loginSubmit(){
                if(this.acc.length<1 || this.pwd.length<1){
                    this.$msg("用户名或密码不能为空！");
                    return;
                }
                this.$http.post("Login",{CustomerName:this.acc,Pwd:this.pwd}).then(res=>{
                    localStorage["customerId"] = res.data;
                    console.log(res.data);

                    //$router  页面跳转
                    //$route   页面信息
                    this.$router.push("/main");
                });
            }
        },
    }
</script>

<style lang="scss" scoped>
.login-pad{
    width: 60%;
    margin: auto;
    margin-top: 25%;
    text-align: center;
    h2{
        font-weight: normal;
        margin-bottom: 30px;
        img{
            width: 36px;
            height: 36px;
            background-color: transparent;//透明
            display: inline-block;//共处一行
            //vertical-align: middle;//行中内容居中对齐
            vertical-align:-10px;
        }
    }
    p{
        width: 100%;
        margin-top: 20px;
        input{
            width: 100%;
            height: 36px;
            border: 1px #ccc solid;
            border-radius: 10px;
            background-color: transparent;
            text-align: center;
        }
    }
    button{
        margin-top: 30px;
        width: 60px;
        height: 60px;
        border: 0 none;
        border-radius: 30px;//当 radius 值为宽高一半时  为圆形
        color: #fff;
        font-size: 30px;
        font-weight: bold;
        outline: none; // outline设置元素边框
        background-color: royalblue;
        
    }
}
.login-bottom{
    position:absolute;
    bottom: 15px;
    text-align: center;
    margin: auto;
    width: 100%;//宽为100%时 text-align 
}
</style>
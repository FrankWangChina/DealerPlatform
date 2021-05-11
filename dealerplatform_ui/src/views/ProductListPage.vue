<template>
    <div>
        <div class="product-search-pad">
            <input type="text">
            <button>筛选</button>
        </div>
        <div class="product-type-pad">
            <div v-bind:class="['type-item',{'type-sel':sysBelongType=='Desktop'}]" v-on:click="selectedType('Desktop')">
                <span>台式机</span>
            </div>
            <div v-bind:class="['type-item',{'type-sel':sysBelongType=='NoteBook'}]" v-on:click="selectedType('NoteBook')">
                <span>笔记本</span>
            </div>
            <div v-bind:class="['type-item',{'type-sel':sysBelongType=='Integrated'}]" v-on:click="selectedType('Integrated')">
                <span>一体机</span>
            </div>
            
        </div>
        <div class="product-list-pad">
            <ul v-for="product in products" v-bind:key="product.id">
                <li>
                    <img v-bind:src="product.productPhoto.productPhotoUrl">
                    <div>
                        <p class="p-name">{{product.productName}}</p>
                        <p class="p-type"><i>类别：</i> {{product.typeName}}</p>
                        <p class="p-price">&yen;{{product.productSale.salePrice}}</p>
                        <span class="add-cart">          
                        </span>
                    </div>
                    
                </li>
            </ul>

            <div v-bind:class="['left-menu',{'left-menu-show':leftMenuShow}]">
                <div class="left-switch" v-on:click="lmShow">
                    <img src="/img/dealerImgs/up.png" alt="">
                </div>
                <ul>
                    <li class="left-menu-select"  v-for="type in belongTypes" v-bind:key="type">{{type}}</li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data(){
            return{
                isTypeSelected:true,
                sysBelongType:"NoteBook",
                pageIndex:1,
                pageSize:10,
                typeName:"",//笔记本
                searchText:"",
                productTypes:"",
                products:[],
                belongTypes:[],
                leftMenuShow:false
            }
        },
        mounted(){
            this.$parent.bottomMenuIndex =1;
            this.getAllProducts();
        },
        methods:{ 
            getAllProducts(){
                var bType=this.sysBelongType;
                var pageIndex=this.pageIndex;
                var pageSize=this.pageSize;
                var typeName=this.typeName;
                var searchText=this.searchText;
                var productTypes=this.productTypes;
                this.getTypeNames(bType);//获取typeNames
                //获取商品信息
                this.$http.get("Product",{params:{
                    bType,
                    typeName,
                    productTypes,
                    searchText, 
                    pageIndex,
                    pageSize                             
                }}).then((res) => {
                    if(res!=null&&res.data.length>0){
                        this.products = [];
                        res.data.forEach((m) => {
                            this.products.push(m);
                        });
                    }
                    console.log(this.products);
                });
            },  
            selectedType(type){
                if(type!=this.sysBelongType){//若两次选中的不同 才刷新
                    this.sysBelongType = type;
                    this.getAllProducts();
                }
            },
            getTypeNames(type){
                this.$http.get("Product/bType",
                {params:{bType:this.sysBelongType}}).then(res=>{
                    this.belongTypes=[];
                    if(res.data.length>0){
                        res.data.forEach((x)=>{
                            this.belongTypes.push(x);
                        });
                    }
                    console.log(this.belongTypes);
                });
            },
            lmShow(){
                this.leftMenuShow = !this.leftMenuShow;                
            }       
        }
    }
</script>

<style lang="scss" scoped>
.product-search-pad{
    padding: 6px 20px;
    background: #f0f0f0;
    display: flex;//弹性盒子
    position:fixed;
    width: 100%;
    z-index: 5;
    input{
        height: 28px;
        border: 1px solid #ddd;
        border-radius: 5px;
        flex: 1;//让所有弹性盒模型对象的子元素都有相同的长度，且忽略它们内部的内容
        padding: 0 6px;
        outline: none;
    }
    button{
        border: none;
        margin: 0 10px;
        background-color: transparent;
        font: 14px bold;
    }
}

.product-type-pad{
    background-color: #fff;
    display: flex;//弹性盒子
    width: 100%;
    position: fixed;
    margin-top: 40px;

    .type-item{
        flex: 1;
        text-align: center;
        background-color: #f0f0f0;
        border-bottom: 1px solid #ddd;
        border-left: 1px solid transparent;
        border-right: 1px solid transparent;

        span{
            border:none;
            height: 26px;
            background-color: #e4e3e3;
            margin: 5px;
            font-size: 14px;
            display: block; //块状浮动
            line-height: 26px;
            margin-top: 10px;
            border-radius: 6px;
        }
    }
    .type-sel{
        background-color: #e4e3e3;
        border-bottom: 1px solid transparent;
        border-left: 1px solid #ddd;
        border-right: 1px solid #ddd;
        span{
            background-color:red;
            color: #fff;
        }
    }
}

.product-list-pad{
    padding-top: 82px;
    ul{
        li{
            list-style: none;
            height: 80px;
            position: relative;
            padding-left: 110px;
            padding-right: 5px;
            img{
                position: absolute;
                width: 66px;
                height: 66px;
                left: 28px;
                background-color: #ddd;
                top: 7px;
            }
            div{         
                width: 100%;       
                height: 78px;
                //border-top: 1px solid #ddd;
                border-bottom: 1px solid #ddd;                
                padding: 10px 0;
                text-align: left;
                position:relative;//父级参考位置
                .p-name{
                    font-size: 12px;                    
                }
                .p-type{
                    font-size: 10px;
                    padding-top: 6px;
                    i{
                        font-style: normal;
                    }
                }
                .p-price{
                    font-size: 12px;
                    color: red;
                    padding-top: 6px;
                }

                .add-cart{
                    width: 35px;
                    height: 20px;
                    background-color: red;
                    display: inline-block;                  
                    position: absolute;//参考父级的
                    right: 10px;
                    bottom: 8px;
                    border-radius: 15px;
                    background-image: url("/img/dealerImgs/shopping212white.png");
                    background-repeat: no-repeat;
                    background-position: center;
                    background-size: contain;
                }
            }
        }
    }
    
    .left-menu{
        position: fixed;
        left: -105px;//
        height: 100%;
        width: 125px;
        background-color: #fff;
        top: 84px;
        border: 1px solid #ddd;
        border-radius: 0 18px 18px 0;
        transition: 0.5s;
        .left-switch{
            width: 20px;
            position: absolute;
            right: 0;
            height: 100%;
            border-left: 1px solid #f0f0f0;
            img{
                width: 20px;
                position: absolute;
                top: 40%;
                transform: rotate(90deg);
                right: 0;
                transition: 0.5s;
            }
        }

        display: flex;
        flex-direction: column;//主轴为垂直方向，起点在上沿。
        ul{
            position: absolute;
            width: 105px;
            height: 100%;
            background-color: #fff;            
            overflow: auto;//如果内容被修剪，则浏览器会显示滚动条，以便查看其余内容。 
            li{
                width: 105px;
                height: 40px;
                line-height: 40px;
                //background-color: #f0f0f0;
                border-bottom: 1px solid #ccc;
                opacity:0.5;
                font-size: 12px;
                text-align: center;
                padding: 0;
            }
        }
    }
    .left-menu-show{
        left:0;
        .left-switch{
            img{
            transform: rotate(-90deg);
            }
        }            
    }
}
</style>
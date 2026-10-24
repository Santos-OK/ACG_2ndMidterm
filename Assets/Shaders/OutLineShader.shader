Shader "ACG/OutLineShader" {
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _outline_color ("Outline Color", Color) = (1,1,1,1)
        _outline ("Outline Width", Range(0, 1)) = 0.5
    }
    
    SubShader
    {
        
        Tags{"Queue"="Transparent"}
        Zwrite Off
        
        CGPROGRAM
            #pragma surface surf Lambert vertex:vert
            
            float4 _outline_color;
            float _outline;

            struct Input{
                float2 uv_MainTex;
            };

            struct appdata{
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            void vert(inout appdata v){
                v.vertex.xyz += v.normal * _outline;
            }

            void surf(Input IN, inout SurfaceOutput o){
                o.Albedo = _outline_color.rgb;
            }
        ENDCG

        Zwrite On
        
        CGPROGRAM
            #pragma surface surf Lambert

            struct Input{
                float2 uv_MainTex;
            };

            sampler2D _MainTex;

            void surf(Input IN, inout SurfaceOutput o){
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            }



        ENDCG

    }
    FallBack "Diffuse"
}


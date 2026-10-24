Shader "ACG/BorderLandsShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _outline_color ("Outline Color", Color) = (1,1,1,1)
        _outline ("Outline Width", Range(0.002, 1)) = 0.005
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _MainTex;

            struct Input{
                float2 uv_MainTex;
            };

            void surf(Input IN, inout SurfaceOutput o){
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            }

        ENDCG

        Pass {

            Cull Front
            
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                float4 _outline_color;
                float _outline;

                struct appdata
                {
                    float4 vertex : POSITION;
                    float2 uv : TEXCOORD0;
                    float3 normal : NORMAL;
                };

                struct v2f
                {
                    float4 pos : SV_POSITION;
                    float4 color : COLOR;
                };


                v2f vert(appdata v) {
                    v2f o;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    float3 normal = normalize(mul((float3x3)UNITY_MATRIX_IT_MV,  v.normal));

                    float2 offset = TransformViewToProjection(normal.xy);

                    o.pos.xy += offset * _outline;
                    o.color = _outline_color;

                    return o;

                }

                

                float4 frag (v2f i) : SV_Target
                {
                    return i.color;
                }

            ENDCG



        }

    }
    FallBack "Diffuse"
}

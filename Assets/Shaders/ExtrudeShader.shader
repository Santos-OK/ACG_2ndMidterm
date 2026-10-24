Shader "ACG/ExtrudeShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _extrude ("Extrude", Range(-1,1)) = 0.05
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert vertex:vert

            sampler2D _MainTex;
            float _extrude;

            struct Input
            {
                float2 uv_MainTex;
            };

            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            void vert(inout appdata v){
                v.vertex.xyz += v.normal * _extrude;
            }


            void surf(Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            }
        ENDCG
    }
    FallBack "Diffuse"
}

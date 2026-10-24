Shader "ACG/WavesShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _speed ("Speed", Range(0, 100)) = 50
        _amplitude ("Amplitude", Range(0,1)) = 0.5
        _freq ("Freqcuency", Range(0,5)) = 0.5
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert vertex:vert

            struct Input
            {
                float2 uv_MainTex;
            };

            sampler2D _MainTex;
            float _speed;
            float _amplitude;
            float _freq;


            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
                float4 texcoord2 : TEXCOORD2;
            };

            void vert(inout appdata v){
                float time = _Time * _speed;
                float waveHeight = sin(time + v.vertex.x * _freq) * _amplitude + 
                                   sin(time + v.vertex.z * _freq) * _amplitude;
                v.vertex.y += waveHeight;
                v.texcoord.x += (time * _speed)/1000;
                v.texcoord.z += (time * _speed)/1000;
                  
                v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));

            }


            void surf(Input IN, inout SurfaceOutput o){
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            }
        ENDCG
    }
    FallBack "Diffuse"
}

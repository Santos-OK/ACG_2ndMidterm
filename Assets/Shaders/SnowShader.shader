Shader "ACG/SnowShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _snow("Snow level", Range(1, -1)) = 0.5
        _snow_direction("Snow direction", Vector) = (0,1,0,0)
        _snow_bump("Snow bump", Range(0,0.1)) = 0.03
        _snow_color ("Snow color", Color) = (1,1,1,1)
        
    }
    SubShader
    {

        CGPROGRAM
            #pragma surface surf Standard vertex:vert

            sampler2D _MainTex;
            float _snow;
            float _snow_bump;
            float4 _snow_direction;
            float4 _snow_color;

            struct Input
            {
                float2 uv_MainTex;
                float3 worldNormal;
                INTERNAL_DATA

            };


            void vert(inout appdata_full v){
                float3 snow_dir = normalize(_snow_direction.xyz);
                float dot_prod = dot(snow_dir, v.normal);
                
                if(dot_prod >= _snow){
                    v.vertex.xyz += v.normal * _snow_bump;
                }
            }

            void surf (Input IN, inout SurfaceOutputStandard o) {
                float4 c = tex2D(_MainTex, IN.uv_MainTex);
                float3 normal = normalize(WorldNormalVector(IN, o.Normal));
                float3 snow_dir = normalize(_snow_direction.xyz);
                
                float dot_prod = dot(snow_dir, normal);
                
                if(dot_prod >= _snow){
                    o.Albedo = _snow_color;
                }else {
                    o.Albedo.rgb = c;
                }
            }

        ENDCG
    }
    FallBack "Diffuse"
}

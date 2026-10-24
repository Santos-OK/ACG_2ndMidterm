Shader "ACG/ToonShader"
{
    properties{
        _Color("Color", Color) = (1,1,1,1)
        _RampTex("toonRamp", 2D) = "white"{}
        _MainTex("Texture", 2D) = "white"{}
    }
    subshader{
        CGPROGRAM
            #pragma surface surf Toon

            float4 _Color;
            sampler2D _RampTex;
            sampler2D _MainTex;

             float4 LightingToon(SurfaceOutput s, half3 lightDir, half atten){
                float diff = dot(s.Normal, lightDir); //valor entre -1 y 1
                float h = (diff * 0.5) + 0.5; //para que siempre este entre 0 y 1
                
                //ejemplo diff = -0.8
                // h = (-0.8 * 0.5) + 0.5 = -0.4 + 0.5 = 0.1 ---> 0.1 > 0 y < 1

                float2 wh = h; //se asigna el valor de h a las dos coordenadas

                float3 ramp = tex2D(_RampTex, wh).rgb; //se le asigna el valor de RampTex en las coordendas wh

                float4 finalColor;
                finalColor.rgb = s.Albedo *_LightColor0.rgb * ramp;
                finalColor.a = s.Alpha;

                return finalColor;
            }

            struct Input{
                float2 uv_MainTex;
            };

            void surf(Input IN, inout SurfaceOutput o){
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            }
        ENDCG

    }
    Fallback "Diffuse"
}
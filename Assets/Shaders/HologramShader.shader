Shader "ACG/HologramShader"{
    Properties{
        _RimColor("Rim Color", Color) = (1,1,1,1)
        _RimPower("Rim Power", Range(0.01, 10)) = 3.0
    }

    SubShader{
        Tags{
            "Queue"="Transparent"
        }

        Pass {

            ZWrite On
            ColorMask 0

        }

        CGPROGRAM
            #pragma surface surf Lambert alpha:fade

            float4 _RimColor;
            float _RimPower;

            struct Input{
                float3 viewDir;
            };

            void surf(Input IN, inout SurfaceOutput o){
                half rim = 1.0 - saturate(dot(IN.viewDir, o.Normal));
                o.Emission = _RimColor * pow(rim, _RimPower);
                o.Alpha = pow(rim, _RimPower);
            }
        ENDCG
    }
    Fallback "Diffuse"
}
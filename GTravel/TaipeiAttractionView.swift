//
//  TaipeiAttractionView.swift
//  GTravel
//
//  Created by Lono on 2024/7/20.
//

import SwiftUI

struct TaipeiAttractionView: View {
    @Binding var appState: AppState
    @Binding var navigationPath: NavigationPath
    @State private var selectedAttractions: Set<String> = []
    @State private var isSimulationComplete = false
    @State private var isPlanTripPressed = false

    let attractions: [Attraction] = [
        Attraction(name: "Taipei 101", location: "Taipei City                             ", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFvI-i933DsIrsDkya5u84vDJ7pINYMc8EWqh14-ljvhyvisVwfVwA7968WvGh3ZMo6d3KlYPSN388BMihG_nNzJZusTDBrg0s=s4800-w1200-h1600"),
        Attraction(name: "National Palace Museum", location: "Taipei City                             ", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFK-zCHOSPSmu7CYKUyLg7pcK-YSYuwvPpMWmKXUBnX_MFU3sg3ln8GKzuA6T5K5LxGyDDEmmQEOvani5cFKw8gI4gXMkrgrog=s4800-w1600-h1600"),
        Attraction(name: "Shilin Night Market", location: "Taipei City                             ", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFNtIcGAcQ10qRMlKwIFuOrf_avPAnD_zgLaPXrJWo6ckbIhq7xwJ1-9B6PovnvcQqrsKVNXU4SoJYH8WI-jPhka2jt5PtJXoE=s4800-w1600-h1600"),
        Attraction(name: "Yangmingshan National Park", location: "Taipei City                              ", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGxZqeYyqU4EUyHzuxePR8rS0N0TevKGlfi-y4T0BVSz0XcRZqCuRR3BU9978k3VpH3y4APTRkBEnbW1IBES3HkR43QiBTaFIg=s4800-w1600-h1600"),
        Attraction(name: "Jiufen Old Street", location: "New Taipei City                            ", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGK4vEGB_KcVSRlwuz53RfrQv26d7VQa1c6goq7HwbgS250NrP-FzzgvsSygNMcg2gRVhzf6a-0wOn2Iucw8kNfSr3iPYq145w=s4800-w1600-h1600"),
        Attraction(name: "Tamsui Old Street", location: "New Taipei City                            ", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGXH35xrxlbaUBU7i0YJFwvCBrfh_R9kmOKe0QYrl3BqvCcAsDjiBe3Z0t5ySiAqsf5eCxiqbEh2wOYcbTO6S8Pyc9wSNpqA-k=s4800-w1600-h1600"),
        Attraction(name: "Tamsui Fisherman's Wharf", location: "New Taipei City                            ", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFPgaSLRvwHv8czFF1MjOnAoL4ZssFmYgs0rY-wULra2pQ5FxQpL8QA4xSC2Thhr-6EE5xwE4yIlrz4Vai0IWVT9bPC384hdrE=s4800-w1600-h1600"),
        Attraction(name: "Yeliou", location: "New Taipei City                            ", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGvftp-741bZRI-z8TRZrOi5lCW3YlorId3NFUcF8pImZYh8_1z2E17oq906VuJbPS2SshiIgdnUIyTHDiJZtdsyJ4bDdYmqvo=s4800-w1600-h1600"),

        Attraction(name: "Beitou Hot Spring Museum", location: "Taipei City", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFFrx57n7X91n8G-TprBeE6gmZAOqwFEHDqByRfZwYgIHpE5lwtIKdHFE_A4t_mKSSRsL4BsWcfXPiWficgr0yWmmoQeuQ7cj0=s4800-w1600-h1600"),
        Attraction(name: "Jinguashih(Gold Ecological Park)", location: "New Taipei City", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFK7AddB9FenrhLHzV72FvIaWdo5y6CBhSjIGFn93JIeETg90eqDS-jm8eHiZaTBNnDenqk0PZV-NBY1Dk6XXUODjJQNr4jJxM=s4800-w1600-h1600"),
        Attraction(name: "Chiang Kai-shek Memorial Hall", location: "Taipei City", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqE4xc0o0S-It54SkEzsovtGMwCllWHmu0Q2xGFAvu0Hr6uycnXe5gQfoxoAszFbv_y_oTdAL40AoTjZZE-28wtJR_fOAsfR97M=s4800-w1600-h1600"),
        Attraction(name: "Songshan Cultural and Creative Park", location: "Taipei City", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGNjAZCio72yToQDfVBSa4RjjjGCzZyiumTRDcnT3dQUBU_cxSwtdNRMKu-StpmXUiE96pZ-MSuf1UGnHaS1abWoy-zam_3Z_A=s4800-w1600-h1600"),
        Attraction(name: "Huashan 1914 Creative Park", location: "No. 1, Section 1, Bade Rd, Zhongzheng District, Taipei City, Taiwan 100", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEufaaTd2Xx4mIDubL_X2IuvHl7W5jlvqeKz8GCqGuVzzFwMYjpWSYp1v5mV32KPW994HGKnpC7T8aekOLtU9_2fgx-FEDSgTM=s4800-w1600-h1600"),
        Attraction(name: "Lungshan Temple", location: "No. 211, Guangzhou St, Wanhua District, Taipei City, Taiwan 10853", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGXwfIurp8wxQ8PceDnAwFqRyDWWOHU_oUnudAvJfdXq0rnSGkAdHwtkXVhvuxzKe802PCwzQMtJ3Lx7WetW_aevaIJgkQmDds=s4800-w1600-h1600"),
        Attraction(name: "Bitan", location: "New Taipei City, Taiwan 231", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEJ4QcrTVLhWg-rrjDb4SxQUtIfLLHjJw7Dw8HX5-o_c00NBYmkOW7n3Nk8d2OXSsZ5XlF_Yht4o8yK0MgV8D1I-EEbOkMqcU4=s4800-w1600-h1600"),
        Attraction(name: "Hushan Hiking Trail", location: "Taipei City, Taiwan 110", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEcHt02fN_G5Bnav6R1GGLEjuEmEUu5rqgGqpsvVkSVTVJaGKff-5NBeDlBbtu0_kmIHk8fpnPqHqxlgqL5L8RrJrXCACjFhgk=s4800-w1600-h1600"),
        Attraction(name: "Bihu Park", location: "Taipei City, Taiwan 114", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEIL2e64vOCrmzbzUMTmX2D62Q1ygLwk894jUru_OCJFtTK7ZNF8cEYi3vvPQF__ylR5F5t5ujM_IP90nvsK-FifKbBJakVmG4=s4800-w1600-h1600"),
        Attraction(name: "Keelung MiaoKou Night Market", location: "Keelung City", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqE1J4IKdS2iZBu53A2PlNvhmdxiFY009luRBqNpI7ZKdNyqkLw8tLxfY3e2b_qgQ23QAeidUhEMWPgOHR25QZCZDvxiKSAam60=s4800-w1600-h1600"),
        Attraction(name: "Zoo - Maokong", location: "Zoo - Maokong", urlStr: ""),
        Attraction(name: "Sun Moon Lake", location: "Sun Moon Lake, Yuchi Township, Nantou County, Taiwan 555", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHoRQ0K-T7QwRPs_SlW0q1-xNxIUb3Iky--UL2-VCvgSNt3UFdhVMDsDsc8cpC0gcq4cikC_UZoY2iOxtXgCBllq62aVlUltUg=s4800-w1600-h1600"),
        Attraction(name: "Qingjing Farm", location: "5號, No. 186-1, Renhe Rd, Ren'ai Township, Nantou County, Taiwan 546", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFhaevMUutrWcnjf0v1nSPbRQw17S2kMRMcpPHqKIZr97DjqMxn5wLt6nTyGUzjCppyP_3Ypn5BDbHRUoVlYRsW1A7q1z7mtd4=s4800-w1600-h1600"),
        Attraction(name: "谷關溫泉", location: "谷關溫泉, Heping District, Taichung City, Taiwan 424", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFrqDJJJEM5z_s0RWxMJ-tGYUgxYJkvpV_S3t6RZu7ZeH3qSwe1YimCE-uaIoa5Hq9WZ6XCovJmwUWrI8Xc5rM4hMG35VH2cVo=s4800-w1600-h1600"),
        Attraction(name: "Rainbow Village", location: "Taichung City", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqE49F77KjdnG5fbICaGUOzArPMmHQl7TfYWKleUHy32gCVjEqXitr4J9r-npY8aTcOeWGdlbiKzdiyrwQmULsadBUtBORM1sAI=s4800-w1600-h1600"),
        Attraction(name: "National Taichung Theater", location: "Taichung City, Taiwan 407025", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFPUN3pT-YiSwZNmazexrzZtoTHVLoOUtxssaRgcSmysHYnQHeYJp-OAUPtGjrbVINKc9xMtNHLuq8t-MmkMZ_byhtSw9SuZsg=s4800-w1600-h1600"),
        Attraction(name: "Fengchia Night Market", location: "Taichung City, Taiwan 407", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFLwlkIFBQoSSvXQVvoBrnVFiryeEnFNWcFGTl82lwGaE7vAHxmVofe9-FmO34SytRe0AjbuSYKQnFSvMjoQ_gJBSvO46b8xWg=s4800-w1600-h1600"),
        Attraction(name: "Zhongshe flower market taichung", location: "Taichung City, Taiwan 421", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGWQKXc1_IyeFz7aHPjDMyxFT7zTwxX-5FFxkX-wGkSmYEPhcxynPeIesljYsnLO0NUcV_ruzEJO0gy9sansqn3Li8aYny97jU=s4800-w1600-h1600"),

        Attraction(name: "Xinfeng Fruit Farm", location: "Taichung City, Taiwan 426", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGAy6eQxWAcHKOqOAUAl9QGeMMuVwsNP_ejUZ1VxoVjATz34-2xbsqjj-E-K--bYZPMPICyWPwNRaP8vo3Wfv6mFuIoySBS5Ts=s4800-w1600-h1600"),
        Attraction(name: "National Museum of Natural Science", location: "NTaichung City, Taiwan 404", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEgkQH3rBy4Ab519TBMpJWqM5neOm2kS2DcQy5WBNV-bzxDhWuRXc1p62KFMw1h_y_rxmtatAK5MD9EBl2BS9WdAEvt3mSAy9U=s4800-w1600-h1600"),
        Attraction(name: "Lihpao Resort - DISCOVERY WORLD", location: "NTaichung City, Taiwan 421", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqF6u0JFI94TkWMLtfdqlvCDQq5AacDHPfZ9w32V4CD0coPmfU2apykDNEewKwNKn_Ao4WIflgTW7iaoBPuZavpDxTehNBwlQQM=s4800-w1600-h1600"),
        Attraction(name: "Taichung Park", location: "Taichung City, Taiwan 404", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGUB3IGMnHdwGowe8vv7i1tDuw3xhDlctmv6j-xgAX-H6eikyWDwcSq8grwGCM3F5_T4u-ZD82HhtUDGfxyDyXuqcv12av-nkc=s4800-w1600-h1600"),
        Attraction(name: "Gaomei Wetlands", location: "Gaomei Wetlands, Taiwan", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFMNHKE_bsE4ZANikF8Ow5BQi_A762zPU7iV_HEv4C1o6SzqeIXkQhv-JjyauftksT9vbREcxPKTRKBlgVzUnEshK0gIFf-XjQ=s4800-w1600-h1600"),

        Attraction(name: "Wuling Farm", location: "Taichung City, Taiwan 42495", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqH72yoy_1Q33K8YvNzDxyoaq6G0669EKhEznXcgRK0XggLLH_jfyvuB3rSSVfON8n3LuZ9rUHOItdsEok-moHt1Xno-Pzw7zVY=s4800-w1600-h1600"),
        Attraction(name: "Dajia Jenn Lann Temple", location: "No. 158號, Shuntian Rd, Dajia District, Taichung City, Taiwan 437", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHgDGZPFYDXCL1Um4aBRIWKP9CJFvB5Yp0l_h-BEN28isWXoEzVt7LJ8N9aJsrWW8KOs9Xuq3ztDsPQa7WvxDbIyi3IoCU8O9w=s4800-w1600-h1536"),
        Attraction(name: "Dongshi Forest Garden", location: "No. 6-1號, Shilin St, Dongshi District, Taichung City, Taiwan 423", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqElTbrozhwBYm-45DDLTphKgPLhSQo2hlKEi0W5zDzyJ0gBDT7dCTB-IBPVmIP8WCBwNn5F6l0zetpox0SmaUjSliNurryi214=s4800-w1600-h1600"),
        Attraction(name: "Jiji Green Tunnel", location: "552, Taiwan, Nantou County, Jiji Township, 集集火車站", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGvAplNMkqYpgjJ-BAUw7_vnPRLw5yFi3jouE5AhMXqv6XsV1hFkGMbRycsGxDh3AV6CcoTJAdVNhBW6_3uFg_vf1b6cfIhKg8=s4800-w1600-h1600"),
        Attraction(name: "Eight Trigram Mountains Buddha Landscape", location: "No. 31號, Wenquan Rd, Changhua City, Changhua County, Taiwan 500", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEeJkYQjqgyx7W2VGHBlugmNH3dHPdi6s0b12O3aet0aKK58x5jr-3iNdG6LWnrI5DJrcBwZdHew7bDmOM2y-dKeGu26FWo-U0=s4800-w1600-h1600"),
        Attraction(name: "Shin Kong Mitsukoshi Taichung Zhonggang Store", location: "No. 301號, Taiwan Ave, Xitun District, Taichung City, Taiwan 407", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHimUnCtU3llYC5mVFAFYYUqAQRwQ4LPjjgbUstpvUSj2KBsYBe2JgthiQ85EQn77oftCCmzN_qz-V9vKOkWi8Mx5ExhfbHnWg=s4800-w1600-h1600"),
        Attraction(name: "Kenting National Park", location: "Pingtung County, Taiwan", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqE1EuUN6rfkNJqxY_UJ0XyJfydrUZvmQZVzrHzSVgCQGvttr10iIll-DeYcB57_POVtR47Y5CDDYSZRliG4pW3r-2fjy5wRlTM=s4800-w736-h488"),
        Attraction(name: "Alishan Township", location: "Alishan Township, Chiayi County, Taiwan 605", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHXfVNqJEACEr6qWmNMpq0mtaTyd9_6uwzuJd298_b8ev36Tskv-QWkJMKWIwzyUTt2I5uKrb5EC3zua6GLUGc8JPuWB9HDzjw=s4800-w1600-h1600"),
        Attraction(name: "Qijin District", location: "Qijin District", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEC8oKTPmXR13FYzY-LBFCNZnfwGKpxXYesLk8PxR28ia07ngbd0HPblgNizSJ4nJ3jG6IvuYP5qmdfasVPexmILjaSUf-_dTE=s4800-w1600-h1080"),
        Attraction(name: "85 Sky Tower", location: "No. 5號, Ziqiang 3rd Rd, Lingya District, Kaohsiung City, Taiwan 802", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEKJe_lyL4W2YSUinYUVzwZsTPU9DVNO758z-e9b7oyBb6g0gwM2PttphpPAoAZ1fIJ-4t1bzMbYiqEvU1fzbVlejJ3lZ6m_ac=s4800-w1600-h1600"),
        Attraction(name: "Chikan Tower", location: "No. 212, Section 2, Minzu Rd, West Central District, Tainan City, Taiwan 700", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqG86zHH3zVdP9d-m5eSaiBkWFBaPiiExjFfsQpmOz6NYDEUfinTFqBScDurVJQGokHj2DzguaPzKEMpm4q27zohUHIK-ZCEZHc=s4800-w1024-h682"),
        Attraction(name: "Meinong Folk Village", location: "No. 80號, Lane 421, Section 2, Zhongshan Rd, Meinong District, Kaohsiung City, Taiwan 843", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHwJeX7_JeZt-p9KwRA95AuZNrW0Gea61EEEtGa1xmAeU5af7YRYmCZa4WjUBiy89bs7iXVtDDpPQF0c8fovPIoKH3X34B9y00=s4800-w1600-h1600"),
        Attraction(name: "Lotus Pond", location: "28747 Hoover Rd, Warren, MI 48093, USA", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFSezmtcZnaaokC60rCV2CoarXBn_sDxIQVH7p49YayDeoioW4kjuKnK4yau3MrL9sRXg0sOWBmI6teG5r_oOPPFkEv5LFYwkk=s4800-w1600-h1600"),
        Attraction(name: "Liouhe Tourist Night Market", location: "Liuhe 2nd Rd, Sinsing District, Kaohsiung City, Taiwan 800", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHohCPdfWGzaCEYvCswCD5j9EsyAYXh5GpN2bw20RFJm2YWZDFA8uJad9hIczTcTBQRV5t46fLyS_kqS-3F_yEJ1i_QLhdop4Q=s4800-w1600-h1600"),
        Attraction(name: "Fo Guang Shan Temple of Toronto", location: "6525 Millcreek Dr, Mississauga, ON L5N 7K6, Canada", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEj7mpmvfuXSZXJqo35Ha3ziVGuOrQC5ytRWbm2gAp7I3UYLZp7delbJ4bLX3TN9bSuRxZ3d2w38HgwhwxtVpvk5TyjDdWXwgw=s4800-w700-h300"),
        Attraction(name: "Lambai Island", location: "Lambai Island, Liuqiu Township, Pingtung County, Taiwan 929", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGWFna9Z2HA6EYTQS6yMMd2-j90ZUMd-EQu_xv4PtO9plMy6pw8shlc68N-MuzhM8ENQEXTIkmw-nv1uShbNnTLmNSOOYj_hPQ=s4800-w1478-h1108"),
        Attraction(name: "Tainan Confucius Temple", location: "No. 2號, Nanmen Rd, West Central District, Tainan City, Taiwan 700", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHNmY8hZ5HuVkxQZM6b6WoI_36WYhjB9DYn_nYslbEUksSobsswJzJ8WMZyFPKd001z_ukdfRX_7anpPX0SNciX8oSQxigtrB0=s4800-w1024-h682"),
        Attraction(name: "Chimei Museum", location: "No. 66號, Section 2, Wenhua Rd, Rende District, Tainan City, Taiwan 717015", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFv2rsqcOagHjyRpDTPJt2Q82apb2whsllk2oGvmCNWKhgc8rQdnq8mSoszFlh-x5S3FG9qi93STAHW-0rR36XILrV_0KY5Q-E=s4800-w1600-h1600"),
        Attraction(name: "Qigu Salt Mountain", location: "724, Taiwan, Tainan City, Qigu District, 鹽埕里66號", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFGQlC19YD7K5nvPiWQmWPSZjpv9OGct7hgGxlf3BcnpjP6Znj9RDzG2MIqBgvZwYy7T-xradoPnRD3q1xFcZ39nNuGbobZ99c=s4800-w1600-h1600"),
        Attraction(name: "Anping Old Fort", location: "No. 82, Guosheng Rd, Anping District, Tainan City, Taiwan 708", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGggAO2os3mmdvN-njYyjiUjP2GTpheyV7LKh8-Q4ufbZc1T35sYpyxh5U4A8IaRbIQ6dEH3dxn8CmDgXk13HoIo4bkfVYckWI=s4800-w1600-h1365"),
        Attraction(name: "Love River", location: "Love River, Kaohsiung City, Taiwan", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFuUSqtqjSJz1Me9xL9Iv6vzKqwgWqQ3gQwqjYGG5HoOATP6-C2U_NuNzzJsuxIWfpbKNTnChjGD3vI-rwUs20EdwqipU7zGh0=s4800-w1600-h1600"),
        Attraction(name: "Shoushan Zoo", location: "No. 350號, Wanshou Rd, Gushan District, Kaohsiung City, Taiwan 80444", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGadvi3FPyihMwUi3LHuKPT4c1u5VMZJKDfzlHkBFCFUETMNOHR5GFbeTxTCkd-ZHsTihkVtO2O_1_h8xt5vnXlLYBzXVuR9OM=s4800-w800-h533"),
        Attraction(name: "Maolin Scenic Spot Entrance", location: "Maolin District, Kaohsiung City, Taiwan 851", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHijw-z3FD9Pqg8ArFNorRuXcPfYk5SnC9-oB5VkRqBRKxUnry55KhqluGgerNCACBArYh6gQGDkrxV4bDX33juHiFDY8E2V9Q=s4800-w1200-h900"),
        Attraction(name: "Guanziling Hot Spring", location: "Baihe District, Tainan City, Taiwan 732", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEIIudvL19nTSBZ3I9e_51uxtuq6HB8hQ7F1PXjTTC49aCnpXi5QhsMbN9gZPPjjfoYO2ICkCGtf1WchP9cEhognyYr9zelPK0=s4800-w1600-h1600"),
        Attraction(name: "Sizihwan", location: "Sizihwan, Gushan District, Kaohsiung City, Taiwan 804", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqF0lTxHASIoQcZZ-lyJ7HHINogxEvFo8HX7jdRmLeYjXNKfOpGNCjxbzsPFn3fcUziJOZqN90OaMdRk_ALBaxP5spzE5ED-7_Y=s4800-w1600-h1536"),
        Attraction(name: "Taroko National Park", location: "972, Taiwan, Hualien County, Xiulin Township, 富世291號", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqE0_w1jYAbPnS2wl8KoYZLdSMh3dopOOE-nySDKqlawlUbPF-nVhWrFjjE00_Wx2eJTDibesl3GvDf8g0zERgDSYLLiXVpMCk4=s4800-w1600-h1600"),
        Attraction(name: "Qixingtan Beach", location: "Qixingtan Beach, Hualien County, Taiwan", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEERsePIwjy548Dn4vEb9jhRDEb-wIcud9sVm1uzFeD8kILUNz0-1BDEr5IcPhaV2RFqjXJW0s1mlYP3PwYStF-VAFoYhZfBkM=s4800-w1600-h960"),
        Attraction(name: "Sanxiantai", location: "No. 74號, Jihui Rd, Chenggong Township, Taitung County, Taiwan 961", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqE9NXQoeqKYFpmU1RUJoSHtFlLwCH-3z8p71PzNhiLRGQluKo9rrOxvaxveG7jvxTO83n2vO1nYXI0HG9Xx4BTLH6U8Y8CxINs=s4800-w1600-h1600"),
        Attraction(name: "Green Island", location: "Green Island, QLD, Australia", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHJNrgbnWGbUb-korQkRuqYJJjFgdMjk-LWIuKqNOSJFtd8M5AuiS18r1qe-NdjMF_DRgvkCr5y7oXHwOYnbcyIHQhgkYehKE0=s4800-w1600-h1600"),
        Attraction(name: "Orchid Island", location: "Orchid Island, Lanyu Township, Taitung County, Taiwan 952", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHctQ6QlbXSDvcw4cuGaX5YVOwbiankl2PlqfSFt3A0yQRYmmZ8CSkR9DEsHmazaLibshp0qJEkx2ocPqZI0wKHO919gL1xayM=s4800-w1600-h1600"),
        Attraction(name: "Brown Boulevard", location: "958, Taiwan, Taitung County, Chishang Township, 錦新三號道路", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEtJLuU4JNHuDVqppIJyzzlu7A6CJaMMA9MI3lxIQZWTu_T1bfAczV_gBBa31NLdMoWeeKAzEn15e9JTwnDsRd2xkp8ackohCU=s4800-w1600-h1600"),
        Attraction(name: "Ruisui Ranch", location: "978, Taiwan, Hualien County, Ruisui Township, 6鄰157號", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqF1ol5sRvJC_miX9NLyH_lLpkyxrj3eQdv1TjrMCxWzHJR-svIVy3aPT3A3q4-egk75nWoeEOJEM50DqUcpbXGA9EAHd0CDckg=s4800-w1600-h1600"),
        Attraction(name: "Liyu Lake", location: "Liyu Lake, Shoufeng Township, Hualien County, Taiwan 974", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqE4Mq5qRto7pK9673uYiDvTKgoJPYM6gMb__OPeynvudO7Zprmxa7MFxisA426TJPCMvbQRdC6vvDc_ty4jSM5tDkA05LbR6v4=s4800-w1600-h1600"),
        Attraction(name: "Luye Highlands", location: "No. 46號, Gaotai Rd, Luye Township, Taitung County, Taiwan 955", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFxV5M5N__KM2GuOT4X6CbbAJdRKAswoNZkI41me-h6WhC2pdjOEHC9ZOmn7OZQtELB9JfghhL2FXyQS0vuDheE6mWwjK6bljY=s4800-w1600-h1600"),
        Attraction(name: "Liyu Lake", location: "Liyu Lake, Shoufeng Township, Hualien County, Taiwan 974", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqE4Mq5qRto7pK9673uYiDvTKgoJPYM6gMb__OPeynvudO7Zprmxa7MFxisA426TJPCMvbQRdC6vvDc_ty4jSM5tDkA05LbR6v4=s4800-w1600-h1600"),
        Attraction(name: "Zhiben Hot Spring", location: "Beinan Township, Taitung County, Taiwan 954", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqEingvkGffheVG6BNwKnlOyEh80fXTDbxe-IOHROqEBVqBZGpUIf8lpfpJxjmq8hiSTWv-CVw6ZsJVg29Fu2b7udMQEV1JSQ7E=s4800-w1600-h1600"),
        Attraction(name: "East Coast National Scenic Area", location: "No. 25, Xincun Rd, Chenggong Township, Taitung County, Taiwan 96144", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHcqgSpfHQogufwUZyBKQsrfYp1HLb9IcYgk_wFbVGAO0AHwrguvlFNVW_lfI_W81zXC_aIgL8Qo4EzDu0scQ7w43Pj73T4K6Y=s4800-w1600-h1600"),
        Attraction(name: "Shitiping", location: "977, Taiwan, Hualien County, Fengbin Township, 台11線", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGo-9R4KdMY4XzCz_Eye0gqyAgSj4bgaD2ZNcjkPnEuCkA0rut2qs6838xcWgGN6C_ePuJu8PkbYAD4rAwAGPyNfmFsN7HEqq0=s4800-w1600-h1600"),
        Attraction(name: "Farglory Ocean Park", location: "974, Taiwan, Hualien County, Shoufeng Township, 福德189號", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFFaOGPcDOW3n5ruDP6peU5Mi6UZF98tp7MgiI9fmQgmUsFrDjNw6lNZHT0VnDYudo9tfPjEjFND6ifURE11pZvY6YIzCyUg0M=s4800-w1600-h1600"),
        Attraction(name: "Hualien Gangtian Temple", location: "No. 15號, Lane 500, Section 1, Zhongshan Rd, Hualien City, Hualien County, Taiwan 970", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqFoFfTM6m4l5wisvRWgu0OaaUOJc0Vm3TM_mwcdHUFd7wXhjqKnB-vHNGJ1rXYbmSu3MqFjcrCsxVwn0lFh_EtPAsW3405jHVo=s4800-w1600-h1600"),
        Attraction(name: "Donghe Bun Shop", location: "959, Taiwan, Taitung County, Donghe Township, 南東河15鄰420號", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqH8swxjuxWcCFEVCA5WElS5m803l-jORQcVf2hDOpsBr8IjKSIDCKDrOypJxRB6lhsVCfSXtxnZt1vNm2xcfuR_30grRpojodk=s4800-w1600-h1600"),
        Attraction(name: "Kinchen Mountain", location: "Kinchen Mountain, Jinfeng Township, Taitung County, Taiwan 964", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqGlYEsDwRkvjwLjjZQkeyZbMm7Zu8RRs5ioiORhVAnkzdw6h7npVJricHhUhPSOOoiPpVwlt73cNIH52KYvCtrD8m3TKdz-nXY=s4800-w1600-h1600"),
        Attraction(name: "Taitung Forest Park", location: "No. 300號, Huatai Rd, Taitung City, Taitung County, Taiwan 950", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHbnwzRBN08KGY0Azy5ZuAkAdp8h_LZXYCGiB6qXQ3x1BIY2xVK2KssxHpszmjwNv8TRt6QJ1URJG-JpfzwvJBhYYZlkYTmuXk=s4800-w1600-h1600"),
        Attraction(name: "木瓜溪", location: "Taiwan, 花蓮縣木瓜溪", urlStr: "https://lh3.googleusercontent.com/places/ANXAkqHXT9otKdUpwANGJtnrlnu_x_r9kMJMD2l5Tmupgn8-WmtmJ7fE_6jObqJF5AOjxsQ-n_TEG3CFeQtabVfpB-Y5w5xpWemBWtg=s4800-w1600-h1600"),
    ]
    let minumum: CGFloat = 0
    var body: some View {
        VStack {
            Text("Recommended Taiwan Tourist Sites")
                .font(.title)
                .foregroundColor(Color.white)
                .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(minimum: minumum)), GridItem(.flexible(minimum: minumum)), GridItem(.flexible(minimum: minumum)), GridItem(.flexible(minimum: minumum))], spacing: 10) {
                    ForEach(attractions, id: \.name) { attraction in
                        AttractionCard(attraction: attraction, isSelected: selectedAttractions.contains(attraction.name))
                            .onTapGesture {
                                toggleSelection(for: attraction)
                            }
                    }
                }
                .padding()
            }

            Button(action: {
                simulatePlanTripClick()
            }) {
                HStack {
                    Text("Plan My Trip")
                }
                .padding()
                .background(isPlanTripPressed ? Color.blue.opacity(0.7) : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .scaleEffect(isPlanTripPressed ? 0.95 : 1.0)
            }
            .padding()
            .disabled(selectedAttractions.isEmpty)
            .animation(.easeInOut(duration: 0.1), value: isPlanTripPressed)
        }
        .background(Color.black)
        .onAppear {
            simulateSelection()
        }
    }

    private func simulateSelection() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            selectedAttractions.insert("Taipei 101")

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                selectedAttractions.insert("Shilin Night Market")

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    selectedAttractions.insert("Yangmingshan National Park")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        simulatePlanTripClick()
                    }
                }
            }
        }
    }

    private func simulatePlanTripClick() {
        isPlanTripPressed = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isPlanTripPressed = false

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                planTrip()
            }
        }
    }

    private func planTrip() {
        appState.selectedSites = Array(selectedAttractions)
        isSimulationComplete = true
        navigationPath.append(ViewType.gTravel)
    }

    private func toggleSelection(for attraction: Attraction) {
        if !isSimulationComplete {
            if selectedAttractions.contains(attraction.name) {
                selectedAttractions.remove(attraction.name)
            } else {
                selectedAttractions.insert(attraction.name)
            }
        }
    }
}

struct AttractionCard: View {
    let attraction: Attraction
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: attraction.urlStr)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
                    )
                    .overlay(
                        ZStack {
                            if isSelected {
                                Color.black.opacity(0.3)
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40))
                            }
                        }
                    )
            } placeholder: {
                Color.gray
                    .frame(width: 140, height: 140)
            }

            Text(attraction.name)
                .font(.subheadline)
                .lineLimit(1)
                .foregroundColor(.white)

            Text(attraction.location)
                .font(.body)
                .lineLimit(1)
                .foregroundColor(.gray)
        }
    }
}

struct Attraction: Identifiable {
    let id = UUID()

    let name: String
    let location: String
    let urlStr: String
}

#Preview {
    TaipeiAttractionView(appState: .constant(AppState()), navigationPath: .constant(NavigationPath()))
}

/*
 */

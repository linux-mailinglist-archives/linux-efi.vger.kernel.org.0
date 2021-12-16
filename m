Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD6147681B
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 03:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhLPCcj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 21:32:39 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:61344 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbhLPCca (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 21:32:30 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211216023228epoutp045e46549bb4b78d2797d7a1ad7a779d87~BG3mumhCN0476604766epoutp04I
        for <linux-efi@vger.kernel.org>; Thu, 16 Dec 2021 02:32:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211216023228epoutp045e46549bb4b78d2797d7a1ad7a779d87~BG3mumhCN0476604766epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639621948;
        bh=xu5NdfDMEXF3znzl++/5As5UWccl5/DV/1rVCJK+/Dk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tYIcLyXZTRyKmuwwwQ/NSCGKGqeA8vEiVRlZ8kjOtpRJrtikzBqFS3liG9k0PcWAF
         P7HRAJen2QgLltDtHlj2KAA9w093R7t9DQKDTgC1+nk+N7hJ77HVvOYGFNBnBDl9f1
         3QuiSxwa7jGR9bxsbfgXPK8Ja5pgixYKP6EbQROE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211216023227epcas1p37d6db1cb22b8de18a509ca77556bcc22~BG3l51JWK1412214122epcas1p3-;
        Thu, 16 Dec 2021 02:32:27 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.231]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JDx376Bztz4x9Q3; Thu, 16 Dec
        2021 02:32:19 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.A9.21932.DE4AAB16; Thu, 16 Dec 2021 11:31:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211216023219epcas1p4a3e4ac07ae62491a5c0871c7afd0c531~BG3d3pF3m1698516985epcas1p4P;
        Thu, 16 Dec 2021 02:32:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211216023219epsmtrp10a3d72a3ddc714b2a955009532261790~BG3d0Wtob0258602586epsmtrp1m;
        Thu, 16 Dec 2021 02:32:19 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-df-61baa4edfdd9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.32.08738.235AAB16; Thu, 16 Dec 2021 11:32:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211216023218epsmtip107d0161f5f971769c7caa041d3f31de8~BG3djIiI60275402754epsmtip1b;
        Thu, 16 Dec 2021 02:32:18 +0000 (GMT)
Subject: Re: [PATCH v4 20/20] extcon: intel-cht-wc: Report RID_A for ACA
 adapters
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <827d2fe4-e50c-ce4c-9e6c-e10555bbabef@samsung.com>
Date:   Thu, 16 Dec 2021 11:55:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211206093318.45214-21-hdegoede@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxze6S23Bce4KyjHzjm4yiK4IoUCBwF1QV2NLsOYkWmysSvctR2l
        bXpbYFvMytTKU57y6AqaieBwmbzGoxgEhmPViaDBjZcIFhG2yhyaMWfYWi5u/Pf7fb/vO9/5
        zoOPCaZwIV+h0tFaFaUkcTdu8/f+IpG9ykIFPazxRYVl/2Dor8dzAP3WW8pBXd+ec0FDT3tc
        0PiTKwC1TdhxVNORB5BxYhigWxYzjuZzewDqPFWCoeKWHh4aST+PowuXHmDop2s3XdC1dh36
        +kcTtkMgbTON8aSN5wOkDbWZuHT09iVcWmndL53rGMSlTYMnuNKTTbVAar1q40rnG9bHuh1K
        ipLTVCKt9aFVCepEhUoWTe49EB8THxoWJBaJI1A46aOikulocue+WNFuhdKRifRJoZR6BxRL
        MQy5ZVuUVq3X0T5yNaOLJmlNolITqglkqGRGr5IFqmjdVnFQUHCog/hhknw2+5mL5iY/rbxw
        imsAz/As4MqHhAQWTRhBFnDjC4hWAFvu9gPnQED8AeB0XyI7mAdw1FzHe66wptfh7MAC4NGq
        +zxWMQfgou2ws/YkDsD6zuNLy3oRWRgcKl3kORuMMHBgRfHRJQVOBMDLD35Z2ogH4QsHF+4t
        ebsT22DGNz87OHw+l/CDBQPRTng1EQetzceWKS9Da7mN66S4ElvhaKWfE8YIbzhsO81h69dg
        i92MOW0hke0K+3K/4rIJdkLjnarl2hPO9jYtJxPCmTwjjxVUA/i0KJPDNhcBnDFlYiwrBF4+
        V8RxOmOEP7xo2cLCvrDt7wrAOr8EHz7JcXFSIOEOM4wClrIB3ro7xmHrtfDsiUw8H5CmFXFM
        KzKYVmQw/W92BnBrwRpawyTLaEaskfx32wnq5Aaw9N4DUCuosP8e2A04fNANIB8jvdxt71ko
        gXsi9cmntFYdr9UraaYbhDrOtwATrk5QOz6MShcvlkQEScKCQyRIHCYmvd2n3ymlBISM0tFJ
        NK2htc91HL6r0MAxNNkzunLGrsb4D/8aNp7hms9bk7w2ztIeI8zf3PcYv55mOPm+sjn2SGVF
        eYp5dKhE/idzWE4kzQim8k9vl714pzC3TqiwTdervGIu5HmAkRxl6m4R98i9iEnbwLsLHZ74
        GdPGFz64EYKqlQNDP3SdPdizaqIkZ1/6nvx5xXBn3PXjXp6rZiPNYTbvHF515NyMoPXQuv4S
        zfD9AuGp0sgr7ceK96ZOftc78aZHWs0C+ig1t976SBaxTl06O7jrYErw/uyKj7eH2qsasytb
        9AbJq2WbHo0sjm8qeX2Otz5qo+iLsvA33vrMPKn3+9zjtsLY2hjxZfvbRmxh865XwmfoG/3E
        DpLLyClxAKZlqH8BjOjEbXgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCSnK7R0l2JBtPuqVtMmvGf2eLnl/eM
        Fm+OT2eyOLhuKavFzV9HWC3ufz3KaLHz4Vs2i+X7+hkt2h7eYrS4vGsOm8Xn3iOMFgemTmO2
        mLL9CLvF7cYVbBar97xgtjhz+hKrxendJRYrT8xidhDy2DnrLrvH5hVaHptWdbJ53Lm2h81j
        3slAj/f7rrJ5bLnazuLRt2UVo8fJU09YPD5vkgvgiuKySUnNySxLLdK3S+DKeNX9h7XgEkfF
        zElPWRoY/7B1MXJySAiYSJxs3ABkc3EICexglJhxq4MZIiEpMe3iUSCbA8gWljh8uBii5i2j
        xJ9Jk9hBaoQFgiU2HmhlBLFFBHqYJf5N5AcpYhZoYJK4MGESM0THHkaJPWt3g1WxCWhJ7H9x
        A2w1v4CixNUfj8HivAJ2Eh1rrrODbGMRUJWYeNEWJCwqECaxc8ljJogSQYmTM5+wgJRwClhJ
        3JmnChJmFlCX+DPvEjOELS5x68l8JghbXmL72znMExiFZyHpnoWkZRaSlllIWhYwsqxilEwt
        KM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOcy2tHYx7Vn3QO8TIxMF4iFGCg1lJhPdJxK5E
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGphOrJrXvNyL
        yf2yz6H5nenGy5KtW60/SJtffsl4g8NK5v8HhnD90zc2fPP9c19bNlLsfarqd54wtfOcvsd5
        HdxffTU4zt1zuX7Xx6ZlzZr31ulwXT2kpZ0qap1dmRP3Q53/9v114jO0XpUnr0ise3SuJ/bB
        UkevT31bLPJKDjzmqResz/y3Lnvl6U6ZEykK038+uvvkU997zQye+L8SrPU1rQtE1l0vOvv7
        9efqTr69EbGJShp56kHG3wSVecI3Hr7Px3eg2FUo7FBsrU7eqlj56vrQzSarc2Z38Cf/fxpa
        3NV6pr57zq4JNx/MOGIUpabclOps+d/CJqt5Y7jY7E0/Ve4xZkzXeHSKZU37ZSWW4oxEQy3m
        ouJEAPrUT51iAwAA
X-CMS-MailID: 20211216023219epcas1p4a3e4ac07ae62491a5c0871c7afd0c531
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211206093542epcas1p177d404c7a4889bcd80705fe4f6f30b62
References: <20211206093318.45214-1-hdegoede@redhat.com>
        <CGME20211206093542epcas1p177d404c7a4889bcd80705fe4f6f30b62@epcas1p1.samsung.com>
        <20211206093318.45214-21-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/6/21 6:33 PM, Hans de Goede wrote:
> Make cht_wc_extcon_get_id() report RID_A for ACA adapters, instead of
> reporting ID_FLOAT.
> 
> According to the spec. we should read the USB-ID pin ADC value
> to determine the resistance of the used pull-down resister and
> then return RID_A / RID_B / RID_C based on this. But all "Accessory
> Charger Adapter"s (ACAs) which users can actually buy always use
> a combination of a charging port with one or more USB-A ports, so
> they should always use a resistor indicating RID_A. But the spec
> is hard to read / badly-worded so some of them actually indicate
> they are a RID_B ACA even though they clearly are a RID_A ACA.
> 
> To workaround this simply always return INTEL_USB_RID_A, which
> matches all the ACAs which users can actually buy.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-intel-cht-wc.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
[snip]

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

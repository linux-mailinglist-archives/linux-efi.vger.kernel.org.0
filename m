Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D21476815
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 03:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhLPCcW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 21:32:22 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:37415 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbhLPCcL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 21:32:11 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211216023210epoutp0119bf641362d7e5ceaef3caa70941e9bf~BG3VsVtzm2359123591epoutp01z
        for <linux-efi@vger.kernel.org>; Thu, 16 Dec 2021 02:32:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211216023210epoutp0119bf641362d7e5ceaef3caa70941e9bf~BG3VsVtzm2359123591epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639621930;
        bh=ty1qC/1gH2FsNRhocdd5b0QFkFPJAC9CaivB0gHrGrQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HoSvoJE1O+cOQ8S6+CZKAaCIUqtpZDAwoLfbBB3u3r6etnPncKTnJsDFToZLv24h7
         cuOZhLFe9OaNbRcGfmBiWPHJdwYpPUye4wuaJqdIgtDUr0I8/ks2sZJLDVUH/oopVZ
         maVeJfkftDncbBkfk71TPumeGBnentaMqfzwA+UM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211216023209epcas1p1d9cb4fe69bca356b35b8e2993429def2~BG3VH-CA80218602186epcas1p1C;
        Thu, 16 Dec 2021 02:32:09 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.236]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JDx2r3Xk9z4x9Pr; Thu, 16 Dec
        2021 02:32:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.7F.08277.425AAB16; Thu, 16 Dec 2021 11:32:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211216023204epcas1p4df770b46a4ed4ab7864a9fe2b1c5fec4~BG3PxJcVm1380413804epcas1p4-;
        Thu, 16 Dec 2021 02:32:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211216023204epsmtrp15c6c028ef5deecad4359f4ee147307b9~BG3PufVU-0258602586epsmtrp1V;
        Thu, 16 Dec 2021 02:32:04 +0000 (GMT)
X-AuditID: b6c32a36-a16caa8000002055-83-61baa5244d14
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.81.29871.325AAB16; Thu, 16 Dec 2021 11:32:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211216023203epsmtip1e482182351d5156e47890d19fd4befa5~BG3PbXSRl0229802298epsmtip1j;
        Thu, 16 Dec 2021 02:32:03 +0000 (GMT)
Subject: Re: [PATCH v4 19/20] extcon: intel-cht-wc: Add support for
 registering a power_supply class-device
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
Message-ID: <243764c8-e3ba-afab-b430-a0c81514e471@samsung.com>
Date:   Thu, 16 Dec 2021 11:55:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211206093318.45214-20-hdegoede@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxj23Nve3rIxLkX00B+uXh2LEKDFAqcKDSrBm8xkLBKzDyfcwR0g
        pe16i1/ZDIjUQaYFFIoNOHCiDOeYSIDy5QbdGBOThY8hOIY4MLAMOhQNA5yjXOf497zP+7zn
        Oc/5IHHZBCEn0/RmzqRndTThIWro3KIM2lzVzCpduWJUVPoMR3/PuQD6s8uGoe++rhKjoQWn
        GI0+/h4gx9g0ga60WwGyjA0D1NdcRqBHp50AfVtcgqNzjU4JuptdTaCrrZM46rnVK0a3Wszo
        yx/teLSMcdhHJMyN6gCmriaPYH79pZVgLnS/xbjaBwimfuCUiDlTXwOY7p/GRcyjug1xHu+m
        R6ZybDJnUnD6JENymj4lin5jb8KuhLBwpSpIpUERtELPZnBRdMyeuKDYNN1yJlpxiNVlLlNx
        LM/TIdpIkyHTzClSDbw5iuaMyTpjmDGYZzP4TH1KsJ4zb1MplaFhy8LE9NSRH/yMg8SR+Qqr
        KAs0iPOBlISUGk49WMTygQcpo5oAtEx0Ee6GjHoIYKeFEhpPALxru/JiovxBtlhotAHY1mAF
        QuECsPLafTwfkKQPlQGdszFufi2Vj8Mh2z8Sd4FTWRgsP5cjcS9FUAHw5uSdFT8vaiMcmP8d
        uLEnpYVFdZPAvZCIeg0+WVihfal9sLvh5HOJN+w+Py5yYym1DV78pmkF49R6ODz+OSbgV2Hj
        dBnu9oWUVQrnrxYBIUIMfLq09Bz7wD+66iUClsMpq0UiDFwGcOFsHiYUtQBO2fNwQbUV3qw6
        i7l3h1NbYG1ziEBvhI7FciA4vwJnHn8mdksg5Qk/tcgEySbYd28EE7Af/OJUHlEAaPuqPPZV
        GeyrMtj/N6sAohqwjjPyGSkcrzKGvrjtJENGHVh57wHhTaBo+q/gDoCRoANAEqfXeo6/3czK
        PJPZo8c4kyHBlKnj+A4QtnzAhbjcN8mw/GH05gSVWqNUh4duVSNVuIpe7zn5po2VUSmsmUvn
        OCNn+m8OI6XyLEyzg14Tcd7w8fHmG6mBm7RDn8TkJ/ddl/ae2Fvtv7unxH/N9bniRWVr4lMC
        iw4/8NAaUviRja2VDpwpXVflJYkMzOm8Q+7MGd2unZg9nP3sZYchOKdypnTztcDXy9L9C7x9
        W+IvuPziHT6+/RcT3x+cdbkKe9/bcDTy8uBtefUl5z4Df2nHzt+O9LZVBGaFlXhPRvTZtCGV
        w7rMkNb2joR3InL7opzyxqj4loIlRFg+5Pdou2bHDmpuuw54KKMdmtr++9v91UUfREdK9s+E
        BjKG/adlL83llHmNKg4Odrf0Dx427VKIZ0d5MrFMY7tXc5w4qYtdygUn1D9/dSw49lBPMS3i
        U1lVAG7i2X8BeeO4ZXgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCSnK7y0l2JBjsmSVlMmvGf2eLnl/eM
        Fm+OT2eyOLhuKavFzV9HWC3ufz3KaLHz4Vs2i+X7+hkt2h7eYrS4vGsOm8Xn3iOMFgemTmO2
        mLL9CLvF7cYVbBar97xgtjhz+hKrxendJRYrT8xidhDy2DnrLrvH5hVaHptWdbJ53Lm2h81j
        3slAj/f7rrJ5bLnazuLRt2UVo8fJU09YPD5vkgvgiuKySUnNySxLLdK3S+DKuHtMsuA6W8WP
        Bf0sDYzbWLsYOTkkBEwk5j5rBLK5OIQEdjNK3Px0lwUiISkx7eJR5i5GDiBbWOLw4WKImreM
        ErvfrmQDiQsL5Eoc+egCUi4i0MMs8W8iP0gNs0ADk8SFCZOYIRr2MEpsWfoebCibgJbE/hc3
        2EBsfgFFias/HjOC2LwCdhKTNr1gBBnKIqAq8e0XWFhUIExi55LHTBAlghInZz4BG8MpYCWx
        aMMOMJtZQF3iz7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWg
        ODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzjKtTR3MG5f9UHvECMTB+MhRgkOZiUR3icRuxKF
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYCqPWHbK3XlC
        Lo8Dl/mmH/9K8vIzUxcfsJp4Znv5GeOHBl+c4y5Xn3D2D2n/VPDwb8gd8TyZJckFGV+3nV6/
        Unl56lL921s1whIvVNWuq4hdfeXO/M5FF01id27Tm/H2ttYWpn8rl0xR+u39oaztzoJcEfbb
        U3dbRs1MljTkm+f+atuq5rLAlJOyfe+P/5mdFC03R+ub66Wt3wSDney0pa8WXEuaGH94qkuL
        QJfRlCXdlWk2/3NZl3bt9Fp1QyOyr+638+qbTLJFD7mPSx88pyTOstB16n6fjY7PrCR41vWm
        7j6vcLF7r5At+2QXrsj4iTMO5f772WK0oelcv9oBsYt7Vjx+NunCwbrTee6Zt+SUWIozEg21
        mIuKEwFMVuMYYQMAAA==
X-CMS-MailID: 20211216023204epcas1p4df770b46a4ed4ab7864a9fe2b1c5fec4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211206093538epcas1p1984cf8254f30fb6e2acb34d949f6b24d
References: <20211206093318.45214-1-hdegoede@redhat.com>
        <CGME20211206093538epcas1p1984cf8254f30fb6e2acb34d949f6b24d@epcas1p1.samsung.com>
        <20211206093318.45214-20-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/6/21 6:33 PM, Hans de Goede wrote:
> The bq25890 used on the Yogabook YB1-X90 / -X91 models relies on
> the extcon-driver's BC-1.2 charger detection, and the bq25890 driver
> expect this info to be  available through a parent power_supply
> class-device which models the detected charger (idem to how the Type-C
> TCPM code registers a power_supply classdev for the connected charger).
> 
> Add support for registering the power_supply class-device expected
> by this setup.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Some minor tweaks based on Andy's review
> ---
>  drivers/extcon/extcon-intel-cht-wc.c | 81 ++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)

[snip]

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

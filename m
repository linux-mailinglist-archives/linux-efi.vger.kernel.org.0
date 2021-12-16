Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2834767F5
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 03:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhLPCbh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 21:31:37 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:30816 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbhLPCbg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 21:31:36 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211216023135epoutp039d4e27764a4644083bd10188d54409cf~BG20-ZR-q0173501735epoutp03j
        for <linux-efi@vger.kernel.org>; Thu, 16 Dec 2021 02:31:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211216023135epoutp039d4e27764a4644083bd10188d54409cf~BG20-ZR-q0173501735epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639621895;
        bh=YCk8PBK4gxiSCDGnADGiFelQE+j9CDtYg4RWWhaBXH8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CjUotYpLg1m6N130m9meMnVZDK6D3kru6RMhVI0nBnTO3Sg8PvkoCuRbJ1em14w1o
         RGwhRN0WshfDj22r3bwV/Uu0surDfuK5uHniziJrP84x93RTqiY/wA7nE6BDGgLqY4
         KH0oklAXbCDf+y1fGr2kArqzVoUoMDdbRuB2kb+I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211216023134epcas1p403f4ac1502fd731fceaf47020b173851~BG20WcnnB3251332513epcas1p4Z;
        Thu, 16 Dec 2021 02:31:34 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.235]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JDx282N1pz4x9QD; Thu, 16 Dec
        2021 02:31:28 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.4F.08277.DF4AAB16; Thu, 16 Dec 2021 11:31:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211216023125epcas1p3878d322911155792f5724447a83470cb~BG2sB0tuc2540225402epcas1p3p;
        Thu, 16 Dec 2021 02:31:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211216023125epsmtrp2157c9e1d2c0fe16c75f8229ddba4a865~BG2r_0oEe3003730037epsmtrp2P;
        Thu, 16 Dec 2021 02:31:25 +0000 (GMT)
X-AuditID: b6c32a36-203ff70000002055-94-61baa4fd15ca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.12.08738.DF4AAB16; Thu, 16 Dec 2021 11:31:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211216023125epsmtip25575af7cbca89a2603192fbb6d16df81~BG2roxOcm1119311193epsmtip20;
        Thu, 16 Dec 2021 02:31:25 +0000 (GMT)
Subject: Re: [PATCH v4 17/20] extcon: intel-cht-wc: Support devs with
 Micro-B / USB-2 only Type-C connectors
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
Message-ID: <49f6f8b2-3fdc-7d4e-93b6-73e58bcf9599@samsung.com>
Date:   Thu, 16 Dec 2021 11:54:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211206093318.45214-18-hdegoede@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1AUVRzv7d7tHdTlciA80RCWzMDgbo8frQQOMzJ1VhNnDY1WM8fGbcBw
        3F23d0kMQzgSAikRINQJZoNw/CgpuORHKIGgHZJGgvJDRhwvQwhRTkaQAbpjsfjv8/28z2c/
        7/PeWyEq/hvzFiZrDIxeQ6sJzJV35nyAJGjpVBstXTbLqKKvV1Bq4eEMoP65WIZQnaer+NTw
        424+dXOuB1Ctt6YxynzuS0Dl3BoB1NW2coyyH+0G1K/HSlGqpLlbQI0erMGo+vYJlOq79Cef
        uvSLgar9zYRGi+WtpjGBvKkmUN5Yl4fJb1xrx+QnrHvlM+cGMbll8DBPXmCpA3Jrr40ntzf6
        KFzfS4lMYmgVo/dlNAlaVbImMYp44x3lbmVYuJQMIndSLxO+GjqViSJi3lQEvZqsdnQifD+h
        1UYHpaBZlpDsitRrjQbGN0nLGqIIRqdS68J0wSydyho1icEaxhBBSqWyMIcwPiWp5U4L0J0V
        ps20PxRkARuWD1yEEA+FOdNDIB+4CsV4C4BzvXd43DAL4MCFEowb7ABaBhZ4Tyyf1/cKuIU2
        ABv/sqxZZgDMLrrrsAiF7rgGdtZrnbwHno/C4bLlVQeKZyGwouSQwPkpDA+EHRNDqzvZgPvB
        wfnbwIlF+C54uaeA78Q8fBusHe1HnHgj/i60nsle07hB6zc2njPMBY+A9f1xThrFveCI7VuE
        w1th83Q56syFeLELLKr9QsBViIETM018DrvDyYuWNd4b2u+dxThDNYCPi/MQbmgA8K4pD+VU
        IbCjqhhxJqN4AGxok3C0H2xdrABc8rPw3twRvlMCcRHMzRFzEn94dXwM4fAmWHk4DysEhGld
        HdO6DqZ1HUz/h50EvDrgyejY1ESGJXWy/+47QZvaCFZffGB4Cyiavh/cBRAh6AJQiBIeItu+
        NlosUtGfpjN6rVJvVDNsFwhzHPBXqPfGBK3jl9EYlGToTmlouCwklCLDScJLNBFbRovxRNrA
        pDCMjtE/8SFCF+8s5Bnlhx99l399Mv7twq600T0bBFOKoPKncufBWIgqI0Cc2T+b+VqvbeH1
        WFl+pP7jutofVfxTklca+2xV37+447LtUOdo/BXP60vRndYT2/f9XOqlthm2PT0g289OuPfG
        9fQfn2I3h9kkizdfSFX0ufkZJpsaxioLh3/wD5gyeC97tl4Yet9teXxgZa+00q5RRVqMHrFJ
        s6Rud2IUT/ycMqb0JV1cg6pwZP/RG9UZAeYPmhX2Her7iw1b2v3N2gfEsd83FdSYNj/qTjtd
        +hNNYz6fRW+5EpE+n/HWgWsjD+LMf+i9TmanP8q8PXsEKXGVHEh4nt5Kk+TBjuqV3KXx8z7b
        K9wIHptEk4GonqX/BbyrJ5B6BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTURyAOTt3d9eVdZumZwY9lhmN0loFp6gsrLj9E1b2sJfd6jZX27zs
        up5EhpS0ar3McklpFJmLRhpO59TyUa3ndFpq7xxmD1llpYZlzRH438f5fR+/HxwKytxEBKXR
        p3IGPatVkFKiuFoxatLvSw52cvodAp882wdxz3cfwJ/vnhHh29cvi3Hzrxoxfv2jFuDStx0k
        vlJxDOCDb1sA9jhySNx5tAbgW6ezIM6010jw8/35JLY62yF++KBejB+UpeKr9yxwrowptbyU
        MEX5Sqaw4BDJvHjqJJnzriWMr6KRZG42ZhCM+WYBYFz3vQTTWTgyXrpaOmszp9Vs5wwxczZI
        k0vaSgBfTu30Ob9L0oCXNIEgCtHT0AHrfYkJSCkZXQLQp/R2SWAgR1l1tdAEqH8cgqqrhYDT
        AVDv6Urod0JoPbKa3f0cSh+B6M+JoX4J0mki5D5+EgYKJ0BfL34V+y2SVqLK9qb+1UPpMaix
        uxX4OZiegx7Xmvsdgh6Hrj6vE/l5OL0ClV5qFQWcYciV7SX8FwXRM5G1brn/GdLjUe/5ehjg
        cNTivSAK8Chk78iBx0GIZUBtGZBYBiSWAUkuIAqAnOMFnVonTOFVem5HtMDqBKNeHb0pRVcI
        +j9dqSwBzoIv0VVARIEqgCioCA32rnKwsuDN7K7dnCElyWDUckIVGEERivBgt8mVJKPVbCq3
        jeN4zvB/KqKCItJEKafOjU0e1HPlQtg3ladYo6nMi+pTadcxUUXKaMfCybkVDWul5j2JfdPt
        d9185Be9KnF0alPZtdYPTesUkbOlQ9bMMzZ0bdxv159o86jiFOr0uKVZnm2nZnwLcWjlD+fH
        ut9T87aKX+zZuiiHr/EV7ZIfHXbx0ZbKvNwGNGhnQlFikqtvQfWTRL5LFxffpbhVW25L6/ZM
        sEmpjFVWWJ+9mDcvDttXEdUWM63jKczoGa6dGhEffkPta9lbFhobSz5bf6busO1NvGbwu/zM
        H0nbvWHNO2aZBE7em/Dx11Kjvjv7lbFQOSa9mbSXddti2ifyCZpOWzlbvNoStSz75c+VCkJI
        ZqcooUFg/wIwmfZjYwMAAA==
X-CMS-MailID: 20211216023125epcas1p3878d322911155792f5724447a83470cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211206093607epcas1p342d85b95bd4d0819017a0c756993faec
References: <20211206093318.45214-1-hdegoede@redhat.com>
        <CGME20211206093607epcas1p342d85b95bd4d0819017a0c756993faec@epcas1p3.samsung.com>
        <20211206093318.45214-18-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/6/21 6:33 PM, Hans de Goede wrote:
> So far the extcon-intel-cht-wc code has only been tested on devices with
> a Type-C connector with USB-PD, USB3 (superspeed) and DP-altmode support
> through a FUSB302 Type-C controller.
> 
> Some devices with the intel-cht-wc PMIC however come with an USB-micro-B
> connector, or an USB-2 only Type-C connector without USB-PD.
> 
> Which device-model we are running on can be identified with the new
> cht_wc_model intel_soc_pmic field. On models without a Type-C controller
> the extcon code must control the Vbus 5V boost converter and the USB role
> switch depending on the detected cable-type.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Some minor tweaks / spelling fixes based on Andy's review
> ---
>  drivers/extcon/Kconfig               |  2 +
>  drivers/extcon/extcon-intel-cht-wc.c | 91 ++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)

[snip]

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

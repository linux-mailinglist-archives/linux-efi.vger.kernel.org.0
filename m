Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99CE4767EE
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 03:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhLPCbW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 21:31:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:26408 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhLPCbV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 21:31:21 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20211216023119epoutp023150d4e1a819f711b2adfb1d0b3fc91c~BG2mTkG-z1279612796epoutp02E
        for <linux-efi@vger.kernel.org>; Thu, 16 Dec 2021 02:31:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20211216023119epoutp023150d4e1a819f711b2adfb1d0b3fc91c~BG2mTkG-z1279612796epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639621879;
        bh=TUzRwrZF1/3XnFMJyJuZxMcG8td0JNwTFL6lUwbVwFQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YleAxWLN51KoYX4SXre8xNfZ4jO0L0ulk4dYzMbHcPcC1oG7TOG0+7iWxaTefAUCa
         o7DlWM16sA26P8MWtalis3dd4pcu6w2nqXraXYonpOFXuSLswZ6FPqNjBcOLnTxscL
         iYipubdVgT3UFeSlKT8VUDIIHNrOZPhTb7PrgLRQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211216023118epcas1p3a098e745a5392a5baf2282c71fe8c519~BG2ltOvMi1324113241epcas1p3V;
        Thu, 16 Dec 2021 02:31:18 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.236]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JDx1q6hlrz4x9QM; Thu, 16 Dec
        2021 02:31:11 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.D5.09592.DB4AAB16; Thu, 16 Dec 2021 11:30:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211216023111epcas1p187706cd1cb120df262dacdf1749cbc19~BG2es5aKb1352413524epcas1p1d;
        Thu, 16 Dec 2021 02:31:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211216023111epsmtrp19a27b037340f2cbd82c9af5474fc8707~BG2erCN020227102271epsmtrp1J;
        Thu, 16 Dec 2021 02:31:11 +0000 (GMT)
X-AuditID: b6c32a37-28fff70000002578-aa-61baa4bd1682
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.61.29871.EE4AAB16; Thu, 16 Dec 2021 11:31:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211216023111epsmtip14a8c38dd0303813d5fa041eb230cc106~BG2eVnqDA0239902399epsmtip1W;
        Thu, 16 Dec 2021 02:31:11 +0000 (GMT)
Subject: Re: [PATCH v4 16/20] extcon: intel-cht-wc: Use new cht_wc_model
 intel_soc_pmic field
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
Message-ID: <9921247a-675b-c225-c933-8cb1e98ab6c2@samsung.com>
Date:   Thu, 16 Dec 2021 11:54:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211206093318.45214-17-hdegoede@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxj39La3tywd1yLjgBHh6jDWgZSX10YYCeiuuvEYmZskW72BKy19
        pg/jcGwMF14TmKMT1iCSMB5iBEXkJSKDYkUYCXMI4sxUkPAQUZji0Iy1vWzjv9/vO9/3/b7f
        d87BENEE6oUpNEZGr6FVBOrCbereGuB/9ac2OnC62438vmQZIf/6cw6Qj23FHPLnukoeeWfJ
        yiP/eN4DyNYHsyhZ3VEIyKwHo4C81VaKkgv5VkB2/nAKIc3NVj559+salDzXPomQ/X2/8si+
        K0by7A0LEimiWi33+NSlGjHVUJuLUr/fbkepst54aq5jCKUah7K5VEFjLaB6b45zqYUG7ziX
        ROUuOUMnM3ofRpOkTVZoUsKJ/QmyKFloWKDEX7KT3EH4aGg1E05Evx/nv0ehsnsifI7QKpM9
        FEcbDMT2iF16rcnI+Mi1BmM4weiSVbpQXYCBVhtMmpQADWOUSgIDg0LtiYeU8qLzmYiuQHC0
        99kEPwNc5OcBAQbxEPiwyQbygAsmwlsAbFka47JkHsD2qssIS14AOFxTYD/BnCWTlyk2fhXA
        5WflPEcrET4H4NnZNAd2w2Ww5Jc8Z6d1eB4C7xT/zXcQBM/gwNPm405xFBfDa5MjqAO74r5w
        6OUYcCgI8QhYe3ebI8zF34Y9fbPOFHf8AOxt+gY4sBBfC3t/HOc6sACXQvMls3MIBPeAo+Nn
        OCzeCJtnS50OIF4sgF1PziGs6Wg4N/NqBbvBaVvjyjK84FRhFp8tqAJwqSiXw5J6AKcsuSsV
        wfBaZRHHMSmCb4X1bdvZsC9sfXUasMpvwifPT/DYdQlhTpaITdkEb92/x2GxJ6zIzkW/A4Rl
        lR/LKg+WVR4s/4uVA24teIvRGdQpjEGiC/7vupO06gbgfPDiHS3g1OzTgC7AwUAXgBhCrBOO
        f9JGi4TJ9OdpjF4r05tUjKELhNo3fBLxck/S2n+MxiiThOwMDAkLCg4hJWESwkM4GVtMi/AU
        2sgoGUbH6P+t42ACrwxO/KHh/siqROnBd/q2nQG2OvF9976uR96x1bXHhw8uvrs4uCnlyHvy
        DZWdfp3WSFvQ+Ynh9vUfw46Yw/Ebo9zULd0m6aIlKzVqNG26fqR5MG6/YkP/b65u+Wtev5G/
        kI5Jd8fqW82p/R7LwmOyAXGmT+KFdJUnf/38FzfmvhowlZZWxCk/+HZKTQ2+9g1OkAVN+xOp
        jXndFe22YzMz0a0l6VzkyhZN03XFbm457Vc2PK/Ym3Py8PTjmLUfesKXWMSF29iArgN+9Fnm
        Zr+ncpFnQs6aukJrdmz0Tbn2otJ1wiyQeR/Y/OL6vqpP66vdJ7dM9Jj2LI6VfTly9FGp9KE6
        uT+G4BrktESM6A30Pz3lXaJ5BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCSnO67JbsSDd5M1LeYNOM/s8XPL+8Z
        Ld4cn85kcXDdUlaLm7+OsFrc/3qU0WLnw7dsFsv39TNatD28xWhxedccNovPvUcYLQ5MncZs
        MWX7EXaL240r2CxW73nBbHHm9CVWi9O7SyxWnpjF7CDksXPWXXaPzSu0PDat6mTzuHNtD5vH
        vJOBHu/3XWXz2HK1ncWjb8sqRo+Tp56weHzeJBfAFcVlk5Kak1mWWqRvl8CVMXltE3NBH2fF
        yY/P2BsYN7J3MXJwSAiYSLzY6tHFyMkhJLCbUaJpXgSILSEgKTHt4lFmiBJhicOHi7sYuYBK
        3jJKNN97xwhSIywQLzHjbBcLiC0i0MMs8W8iP0gRs0ADk8SFCZOYITr2MEp82/qRHaSKTUBL
        Yv+LG2wgNr+AosTVH48ZQTbwCthJrLqtDRJmEVCVOHr6LViJqECYxM4lj5lAbF4BQYmTM5+A
        LeMUsJKYsnkKK4jNLKAu8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKz0LSPgtJyywkLbOQtCxg
        ZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREc5VqaOxi3r/qgd4iRiYPxEKMEB7OS
        CO+TiF2JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTCJ
        zrP7+izr9fpI0cszjwV0fOSrjj1w4uN6ZtcX6yW8jdxO7td+5dHlaDnl+g3jlH7mfbcDmJxt
        yiZz7z795J5Gx60r7D568+9VS/0OrMis+GaQvzxALfw+0701ih9nrG+5NvXz+oz2lyufn18z
        69iERf8apyTa+z5ttp7nb6ot2xq8ejbr/Lpp08O2TgtqmXdAIzz/1Nk9ujM7M21rSiu2XpX4
        JpibrCGg/NbzFkemQF/kBxsr+xu5L47c4GfKulm0/aXa8UUaS7M+yv5dMPNRWFKp6JHZQSb7
        TmstUlUoaImTq5nF0Pjm7QIP+9W/HjQmJAf/i7W3MOksOdRlWc0Qbru9T36Ol3zG9xflTy8p
        sRRnJBpqMRcVJwIA5D/8iWEDAAA=
X-CMS-MailID: 20211216023111epcas1p187706cd1cb120df262dacdf1749cbc19
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211206093525epcas1p16aaa71953c9a230ed859cb617589d301
References: <20211206093318.45214-1-hdegoede@redhat.com>
        <CGME20211206093525epcas1p16aaa71953c9a230ed859cb617589d301@epcas1p1.samsung.com>
        <20211206093318.45214-17-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/6/21 6:33 PM, Hans de Goede wrote:
> The CHT_WC_VBUS_GPIO_CTLO GPIO actually driving an external 5V Vboost
> converter for Vbus depends on the board on which the Cherry Trail -
> Whiskey Cove PMIC is actually used.
> 
> Since the information about the exact PMIC setup is necessary in other
> places too, struct intel_soc_pmic now has a new cht_wc_model field
> indicating the board model.
> 
> Only poke the CHT_WC_VBUS_GPIO_CTLO GPIO if this new field is set to
> INTEL_CHT_WC_GPD_WIN_POCKET, which indicates the Type-C (with PD and
> DP-altmode) setup used on the GPD pocket and GPD win; and on which
> this GPIO actually controls an external 5V Vboost converter.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Use the new cht_wc_model intel_soc_pmic field which replaces the
>   intel_cht_wc_get_model() helper and adjust the commit msg to match
> ---
>  drivers/extcon/extcon-intel-cht-wc.c | 35 +++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 14 deletions(-)

[snip]

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEEE476811
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 03:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhLPCcG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 21:32:06 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:60688 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhLPCcD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 21:32:03 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211216023202epoutp04be8e5aa98725702dba6eb8f998e47aa1~BG3N9etcb0101101011epoutp04e
        for <linux-efi@vger.kernel.org>; Thu, 16 Dec 2021 02:32:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211216023202epoutp04be8e5aa98725702dba6eb8f998e47aa1~BG3N9etcb0101101011epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639621922;
        bh=OaOToBnDJYk2iAFaQgTEadOFmrioXRFbKwV6yJRjhw4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CRh+tixOTkizcWvjgaq3mfywnVOU+tYVSkef9xIoveVttsveYCAS2NUgwxEbuAW8e
         2dv0d3LXJJiXgXVZd1wKJIEP+nqLdYHSWYwMNO331nLpFMYVT018nhSYN2zM3Aj8UK
         evJ0xaRcdL9NXMRfxBhL2C/r/AnAomFiAQ4nUrTE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211216023201epcas1p1efe38b5e465b9820efeaff93d352ed97~BG3NQ71EW0218602186epcas1p1Y;
        Thu, 16 Dec 2021 02:32:01 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.235]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JDx2h1TP8z4x9Pp; Thu, 16 Dec
        2021 02:31:56 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.6F.08277.515AAB16; Thu, 16 Dec 2021 11:31:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211216023149epcas1p4c96460ba04caa6f898d1c8d95fee3379~BG3B5ZbI01108411084epcas1p4E;
        Thu, 16 Dec 2021 02:31:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211216023149epsmtrp11cffa20fb5887bbeff231c06fb175f68~BG3B3TKN90224102241epsmtrp1b;
        Thu, 16 Dec 2021 02:31:49 +0000 (GMT)
X-AuditID: b6c32a36-1edff70000002055-1d-61baa515a083
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.81.29871.415AAB16; Thu, 16 Dec 2021 11:31:48 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211216023148epsmtip2841ce14ef6239a094440ddf1c92b06d5~BG3BlD3QO0991809918epsmtip2C;
        Thu, 16 Dec 2021 02:31:48 +0000 (GMT)
Subject: Re: [PATCH v4 18/20] extcon: intel-cht-wc: Refactor
 cht_wc_extcon_get_charger()
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
Message-ID: <310fca69-3c49-808a-4f2e-f054840ecc05@samsung.com>
Date:   Thu, 16 Dec 2021 11:54:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211206093318.45214-19-hdegoede@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTdxT2d297KY2d1yryG0sEi1tCkxYKpV4JIInElLgpDgObW1KucEOR
        0pbeMocjC7CNV3hsPF1VICDKMDwsTKA8upUiK2hwAww4GBBYVmSsBGURyXB94MZ/3znn+845
        3+/BQrlWzIuVrNRSGiWp4GFsxr1BP6HAo9FABlSNcYiyq69QYvO5DRB/DlcjxI+tjUxi+qWZ
        ScxtDAGiZ2EVI24PlAIid+EJIMYN1zHiWbEZED9UVqFERZfZjfg1uwkj7vRZUeLB6C9MYrRX
        S3z3kw6N4Ep7dLNu0o4mvlTfXIBJZx73YdIayzmpbWASk3ZO5jGkJZ3NQGoZWWJIn+kPR7Mv
        pITKKTKR0vhQygRVYrIyKYx3OkZ2UhYsCRAJRMeJYzwfJZlKhfEi340WnEpW2D3xfD4hFen2
        VDRJ0zz/8FCNKl1L+chVtDaMR6kTFepgtZAmU+l0ZZJQSWlDRAEBgcF2YnyKXL9Wi6nbmZ9a
        c09ngXZGIXBnQVwMdTWNzELAZnHxbgDrf+8GrmAdQOPK3Z3K3wCuj7W5vZZ0fJWDugr9AI4/
        sjBcgQ3A+ZEhZ+MD+AXY0mV0yg/ihSicrt52cwQonoXAGxVfOHthOB8arVOYA+/Dj8DJF4vA
        gTl4OLyT8zPiwAz8bVhfXcJ0YA88FlrufbnD2Q8t3y45p7njIXCmbs6ZR3FP+GSpFnFhb9i1
        et25K8RL3WF1w8Md35FwYKCN6cIH4NPhzh1zXnC5NNfNJbgF4MvyAsQVtAG4rCtAXawgaGws
        txdY9hF+sM3g70ofgT1bN3a2eAP+tVHEdFAgzoH5uVwXxReOz88iLvwmbMgrwL4GPN0uP7pd
        HnS7POj+H1YHGM3gEKWmU5MoWqQO/O/CE1SpeuB88nxJNyhbXROaAMICJgBZKO8gZ+kDA8nl
        JJIZVyiNSqZJV1C0CQTbT/gb1MsjQWX/M0qtTCQ+HiCWBAaJCZFExPPkWM9Wk1w8idRSKRSl
        pjSvdQjL3SsLuRlSzvavifrYt4k9cbeufd/2Q2PlO5IX2rNaaiPow0tDgbHhNKGe1S2c2GLu
        fxR3vrUv8iPBe60F4r2jvcOdR5cl6rf4nlSeb5pEvBIzdmUqm/tgukdge4XomvLjjx4TJnqX
        nXsus2ScEaTl349YvNi/WXH7UpiyoS+bn1k44HfSdkiQabqVP0K1rJsvZmRs/RGnndmMWokQ
        XlaVITfl8qJri1dbfzMVMT7LqWxZEDbvmZ3DF+Jrg2KTSw5TJ0KwiEHDP+rQ920pFafm2Wbv
        x9fi9Ge+txVPdSieZkZN9De0mnoHLcF7PzcWT+xZO0+PNsYYLltD71eZt+vn+2RpmTwGLSdF
        fFRDk/8CGuX06HsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSvK7I0l2JBhtuKlpMmvGf2eLnl/eM
        Fm+OT2eyOLhuKavFzV9HWC3ufz3KaLHz4Vs2i+X7+hkt2h7eYrS4vGsOm8Xn3iOMFgemTmO2
        mLL9CLvF7cYVbBar97xgtjhz+hKrxendJRYrT8xidhDy2DnrLrvH5hVaHptWdbJ53Lm2h81j
        3slAj/f7rrJ5bLnazuLRt2UVo8fJU09YPD5vkgvgiuKySUnNySxLLdK3S+DK2PRhPlvBBtaK
        F23eDYwbWLoYOTkkBEwkNrc2MXcxcnEICexmlJixcis7REJSYtrFo0AJDiBbWOLw4WKImreM
        Eh8+bACrERaIkli7fT8riC0i0MMs8W8iP0gRs0ADk8SFCZOgpu5hlNj65y0TSBWbgJbE/hc3
        2EBsfgFFias/HjOC2LwCdhKrmy6C1bAIqEosmt4HNlVUIExi55LHTBA1ghInZz4BO5tTwEri
        zoL7YL3MAuoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPwLCTts5C0zELSMgtJywJGllWMkqkF
        xbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMGRrqW5g3H7qg96hxiZOBgPMUpwMCuJ8D6J2JUo
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9Ne8erf71ae
        ZTy3QSc848V+kQ17EvenFJw6eL2i+8qXGcoKFhsr9Y25pHI5eCatvWbiLjX53wVbRWWmZhGm
        mNz84AchVw77Bjkc3Wmoeigq96er0+6TjyddWr/t9qsMjvTNsfrFa3n7N89ytLt1zYbLUfzY
        Cy6Z+4FzLM5JlN60r6/xfyEvOuOD3XbTUJ3QcN177Gka5Yp9/kItUd6B+tme96zsuBbPffRo
        1YGPiR/lRG8t/epof2z6+QNPT9Q0PlxaL/O+pbJK8v+PKffPPN8dUVq9dJeUM2v2NMetWlcX
        3Tz+dRZD0Im6B+8ebOSNFFoYILIs6/lSjfUHHfbMScsOnDKFg/9XnMdOE70L9WlKLMUZiYZa
        zEXFiQC5M1VmYwMAAA==
X-CMS-MailID: 20211216023149epcas1p4c96460ba04caa6f898d1c8d95fee3379
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211206093536epcas1p18b0299ac3bf8c3b8f452039f6725644b
References: <20211206093318.45214-1-hdegoede@redhat.com>
        <CGME20211206093536epcas1p18b0299ac3bf8c3b8f452039f6725644b@epcas1p1.samsung.com>
        <20211206093318.45214-19-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/6/21 6:33 PM, Hans de Goede wrote:
> This is a preparation patch for adding support for registering
> a power_supply class device.
> 
> Setting usbsrc to "CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT"
> will make the following switch-case return EXTCON_CHG_USB_SDP
> just as before, so there is no functional change.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Reword the commit message
> ---
>  drivers/extcon/extcon-intel-cht-wc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

[snip]

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

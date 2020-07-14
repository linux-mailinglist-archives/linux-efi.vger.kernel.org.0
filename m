Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7221EA77
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jul 2020 09:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgGNHn7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jul 2020 03:43:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43323 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgGNHn6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jul 2020 03:43:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200714074357euoutp01c60d2de4e933e851eee89c87b26d1364~hjrHJUY_d0058900589euoutp01o
        for <linux-efi@vger.kernel.org>; Tue, 14 Jul 2020 07:43:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200714074357euoutp01c60d2de4e933e851eee89c87b26d1364~hjrHJUY_d0058900589euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594712637;
        bh=9FFWm4rsrO3DZUrBCqVdTmUf2OLNkpr0y/XL43tw84k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CcUqPNyhsViA/Idl1LClhP81wfgRxwG48w1XXx/i47+bGNdzUWbfeDfo7ZoTwUYIf
         5Q8tW7viwh8NYjZoyUfuao0h1zEsD5fd/sIAIZx7p/stGQ2rQmmriHRIpWz/todPm4
         zwxCClxnEVrsXRlcT6SCyyvERNLG5UamSunGorK8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200714074357eucas1p25141581b6dd71d92ae3ad81afa90e594~hjrG4ByGa2165521655eucas1p2J;
        Tue, 14 Jul 2020 07:43:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B2.23.06318.C326D0F5; Tue, 14
        Jul 2020 08:43:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200714074356eucas1p15a1f57757ad1c40e9f7531a1fecd1f6d~hjrGdqDfm0685606856eucas1p1E;
        Tue, 14 Jul 2020 07:43:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200714074356eusmtrp26e887373ffa755e3bc2d1486c78c216f~hjrGc44M72697626976eusmtrp23;
        Tue, 14 Jul 2020 07:43:56 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-25-5f0d623ca237
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6B.2F.06017.C326D0F5; Tue, 14
        Jul 2020 08:43:56 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200714074356eusmtip2b68aaccf1ec7da02052cb9604d6b0f60~hjrGDQU2G1674116741eusmtip2u;
        Tue, 14 Jul 2020 07:43:56 +0000 (GMT)
Subject: Re: [PATCH v2] efi: avoid error message when booting under Xen
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <0a5494ff-431d-5667-680f-77987cff2984@samsung.com>
Date:   Tue, 14 Jul 2020 09:43:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200710142253.28070-1-jgross@suse.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7o2SbzxBu/eW1r8/PKe0eLK1/ds
        FnNuGlm0PbzFaHGi7wOrxeVdc9gsuhbeYLf4vmUykwOHx6ZVnWwe97uPM3kc/nCFxeP9vqts
        Huu3XGXx+LxJLoAtissmJTUnsyy1SN8ugSuj6eEN1oKlXBXfb8xga2A8ytHFyMkhIWAicenp
        EZYuRi4OIYEVjBLXzxxnhXC+MEq0//oBlfnMKLFwziVWmJbTE+4zQSSWM0rsPjAPquUto0T3
        yUeMIFXCAu4SRyf+ZAaxRQSUJT629rKDFDELPGKU6Fj+gQUkwSZgJTGxfRVYA6+AnUT7syVs
        IDaLgKrEgT9/wGxRgQiJTw8Os0LUCEqcnPkErJdTwFSiu+0LWC+zgLjErSfzmSBseYntb+cw
        gyyTEDjELnHg2Daou10kvh85xA5hC0u8Or4FypaR+L9zPhNEwzpGib8dL6C6tzNKLJ/8jw2i
        ylrizrlfQDYH0ApNifW79EFMCQFHiRk/IiFMPokbbwUhbuCTmLRtOjNEmFeio00IYoaaxIZl
        G9hgtnbtXMk8gVFpFpLPZiH5ZhaSb2YhrF3AyLKKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/
        dxMjMDGd/nf86w7GfX+SDjEKcDAq8fBK+PPEC7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1
        KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkGRqaG5mk9j6fL6LG38q+O
        vbE04TpvxveAlJPPOfZv7ZDv2sPW61ihuiT9+58dBcvD5Yo+N7ff5RY03bmnM+FZeAbfX6kP
        whMLWGrYjfYyF3/d1b7Q314+dafm9YKkfSemPfr2/Msx84Roi7mzStrep9naZoVN0lfavDhZ
        K4P3fsR07a784lXeSizFGYmGWsxFxYkAAxqkn0gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7o2SbzxBm0TFCx+fnnPaHHl63s2
        izk3jSzaHt5itDjR94HV4vKuOWwWXQtvsFt83zKZyYHDY9OqTjaP+93HmTwOf7jC4vF+31U2
        j/VbrrJ4fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqT
        WZZapG+XoJfR9PAGa8FSrorvN2awNTAe5ehi5OSQEDCROD3hPlMXIxeHkMBSRonXTW2MXYwc
        QAkZiePryyBqhCX+XOtig6h5zSixaFkPG0hCWMBd4ujEn8wgtoiAssTH1l52kCJmgUeMEn2H
        pzFDdHQwSnyc/YARpIpNwEpiYvsqMJtXwE6i/dkSsEksAqoSB/78AbNFBSIkDu+YBVUjKHFy
        5hMWEJtTwFSiu+0LWJxZQF3iz7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSahaR9FpKWWUhaZiFp
        WcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwErcd+7llB2PXu+BDjAIcjEo8vBL+PPFC
        rIllxZW5hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YJLIK4k3NDU0
        t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAWHBgtvj7FWmpe4U+L5JaY154
        6MRePc8JV19PjpHanrx8d4FFl0tZ27fP3tP/mvP++3rmRDf729a9j1SCwy727wrxNTA90LNU
        2W7Lpaa4+XtLToiGfp5nVmtwWfiv9l0BBqfv3O0rGsp/NVb+Fzc6bZDmHOcUdbL6yokZ9+xN
        9x5q4OSZu+BqjRJLcUaioRZzUXEiAKwTzYPaAgAA
X-CMS-MailID: 20200714074356eucas1p15a1f57757ad1c40e9f7531a1fecd1f6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200710142443eucas1p120b3d15e1f7be8bb95ffb9d83875fa70
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200710142443eucas1p120b3d15e1f7be8bb95ffb9d83875fa70
References: <CGME20200710142443eucas1p120b3d15e1f7be8bb95ffb9d83875fa70@eucas1p1.samsung.com>
        <20200710142253.28070-1-jgross@suse.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/10/20 4:22 PM, Juergen Gross wrote:
> efifb_probe() will issue an error message in case the kernel is booted
> as Xen dom0 from UEFI as EFI_MEMMAP won't be set in this case. Avoid
> that message by calling efi_mem_desc_lookup() only if EFI_MEMMAP is set.
> 
> Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/efifb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 65491ae74808..e57c00824965 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -453,7 +453,7 @@ static int efifb_probe(struct platform_device *dev)
>  	info->apertures->ranges[0].base = efifb_fix.smem_start;
>  	info->apertures->ranges[0].size = size_remap;
>  
> -	if (efi_enabled(EFI_BOOT) &&
> +	if (efi_enabled(EFI_MEMMAP) &&
>  	    !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
>  		if ((efifb_fix.smem_start + efifb_fix.smem_len) >
>  		    (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
> 


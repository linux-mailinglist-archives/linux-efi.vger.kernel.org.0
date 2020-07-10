Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A2C21B30F
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jul 2020 12:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGJKRE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jul 2020 06:17:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55836 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgGJKRD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jul 2020 06:17:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200710101701euoutp0119be8d55290c0809a83a885eb3cdc15d~gXLnQ003n2215822158euoutp01K
        for <linux-efi@vger.kernel.org>; Fri, 10 Jul 2020 10:17:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200710101701euoutp0119be8d55290c0809a83a885eb3cdc15d~gXLnQ003n2215822158euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594376221;
        bh=zuImCTUG8KB0maKe8qkWKgOT1mxGOgJZkICKt5oGbeI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=plnuMrsuGMEkycrAG8jAYl+NYTqyivgLb9gVuse4XXicaMM9PDEyMfw5nB5QoSfJm
         P1aQT6TW0KjabHQlpjLuvOfJMNx0eAQjIwyi7eBAgZXTdBaZyXsq6PVX9p622yLKya
         6tgQ+p2keFGMAmWTZwwfp05CEFWjmdO4ZfAR6TnY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710101701eucas1p2b25fdf4c5eb5debe392ff1ff0530324e~gXLnD4l0R0954409544eucas1p2H;
        Fri, 10 Jul 2020 10:17:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B5.6D.06318.C10480F5; Fri, 10
        Jul 2020 11:17:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200710101700eucas1p27a9b4f0c67d6b5af361ad3085c830d39~gXLmrr0ra0940409404eucas1p23;
        Fri, 10 Jul 2020 10:17:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200710101700eusmtrp20bdf7cf974e4798332791a5c06de0237~gXLmq972P2032920329eusmtrp2m;
        Fri, 10 Jul 2020 10:17:00 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-fc-5f08401c4f46
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F2.C0.06314.C10480F5; Fri, 10
        Jul 2020 11:17:00 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200710101700eusmtip20235ca730843f772b9729ddb9037521d~gXLmM2BMQ2026820268eusmtip2O;
        Fri, 10 Jul 2020 10:17:00 +0000 (GMT)
Subject: Re: [PATCH] efi: avoid error message when booting under Xen
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <170e01b1-220d-5cb7-03b2-c70ed3ae58e4@samsung.com>
Date:   Fri, 10 Jul 2020 12:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ec21b883-dc5c-f3fe-e989-7fa13875a4c4@suse.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUYRjG+XZmx3Fx5XM1fHGlYjEhI80UGUzESmrznyL6I+3QNSePPHe8
        KzDMI8uwJMxVWNsgS0HNPNI8QMuzNPNITUjzlszFEyMtZ0fJ/57vfd4f3/PASxOyCrEVHRwe
        zarDVaEKSkJWtax3Hbb2oH2PNPa4MuvLC4jpW1mgmPyho0zq2DBi2h7qxUxvbT7FZDwbNGLW
        KrJFHrSyvOgepfx+v1WkbNb3kcqFhn5KWVrRTyqXyveeo3wkbgFsaHAsq3Zw95METXWsiiPL
        TOP1uTlUEnpgkoGMacDOMPttgMxAElqGXyJY0BSTvCHDywjG33sLxhKC1cWP1A7RkdlBCEYh
        glJtOxIe8whKJuoNuDn2hNXiJBGvLbALzC1lGvFLBP6BoLhx3LBEYVd4lFa0RdO0FLtDn/YC
        PybxAShImSN4vQdfhMXRZjGvpdgM2nMnDKgxdoPxJ3WI1wS2hOEJrUjQ+yC5Ms+QDnCLETTO
        lm3H9oSprDEjQZvDXGvFtraGvzU8zAMlCDbSZ7bpagSF2Zvb9DEY6fpN8UkJfBBKax2E8XH4
        UJ1sKADYFAbnzYQQpvC4KocQxlJIT5UJ27ZQ9mInjjVk1LwispBCs6uaZlcdza46mv//FiCy
        CFmyMVxYIMs5hbNx9pwqjIsJD7S/FhFWjrZuqXOzdeUtavjj34QwjRQmUr8NylcmVsVyCWFN
        CGhCYSE98anzqkwaoEpIZNURvuqYUJZrQnKaVFhKnXSzV2Q4UBXN3mDZSFa944poY6sk9LUu
        1Gf1zc8v85cHCup69mfapMTrrp91jopZ0TGFcSaH9FG3ck9falv08u093xCy0p3f6lhf7yS/
        wznOhLSfqdv4dXugyNiuPOBUopP3kLQwOE3u9U5fEhdyT+v//GSSfHptWj5qox3pUz59nSUp
        q/zsZ4vEkzqXie6beXfdHNcnFSQXpHK0I9Sc6h+lhHiIRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7oyDhzxBru/yFr8/PKe0eLK1/ds
        FnNuGlm0PbzFaHGi7wOrxeVdc9gsuhbeYLf4vmUykwOHx6ZVnWwe97uPM3kc/nCFxeP9vqts
        Huu3XGXx+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUn
        syy1SN8uQS/j2alvrAUb+Co+zJzO1sDYw9PFyMkhIWAicar3FHMXIxeHkMBSRokZK5sYuxg5
        gBIyEsfXl0HUCEv8udbFBlHzmlHi3KpLjCAJYQEXiW+rG5hAbBEBM4lXn3vZQYqYBR4xSnT9
        XcYE0fEGaGrbYRaQKjYBK4mJ7avANvAK2ElcmR8CEmYRUJVY0PqKGcQWFYiQOLxjFtgCXgFB
        iZMzn4C1cgrYSDyeugcsziygLvFn3iVmCFtc4taT+UwQtrxE89bZzBMYhWYhaZ+FpGUWkpZZ
        SFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzDbcd+bt7BeGlj8CFGAQ5GJR7eHf/Z
        4oVYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAFJFXEm9o
        amhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHRb92WuV5/fNYZH7OQEeEs
        1LlrHL9SQy3SLE5/7zqVJ3U7H7R+CBFw2V8k+vr8M7WoDfpMocp+seJ/ulZHKGX1RXi+6mxK
        zPFR5rM/eOm+c0dOIEc8s5DCc4N9Vx5tjO+d5SjyKl4j/cnF36cMtp2Kazo3hV89ec6JO1/9
        r2/4L9h6P5nBuU+JpTgj0VCLuag4EQDuYox+2QIAAA==
X-CMS-MailID: 20200710101700eucas1p27a9b4f0c67d6b5af361ad3085c830d39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200709091750eucas1p18003b0c8127600369485c62c1e587c22
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200709091750eucas1p18003b0c8127600369485c62c1e587c22
References: <20200610141052.13258-1-jgross@suse.com>
        <094be567-2c82-7d5b-e432-288286c6c3fb@suse.com>
        <CGME20200709091750eucas1p18003b0c8127600369485c62c1e587c22@eucas1p1.samsung.com>
        <ec21b883-dc5c-f3fe-e989-7fa13875a4c4@suse.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


[ added EFI Maintainer & ML to Cc: ]

Hi,

On 7/9/20 11:17 AM, Jürgen Groß wrote:
> On 28.06.20 10:50, Jürgen Groß wrote:
>> Ping?
>>
>> On 10.06.20 16:10, Juergen Gross wrote:
>>> efifb_probe() will issue an error message in case the kernel is booted
>>> as Xen dom0 from UEFI as EFI_MEMMAP won't be set in this case. Avoid
>>> that message by calling efi_mem_desc_lookup() only if EFI_PARAVIRT
>>> isn't set.
>>>
>>> Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> ---
>>>   drivers/video/fbdev/efifb.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
>>> index 65491ae74808..f5eccd1373e9 100644
>>> --- a/drivers/video/fbdev/efifb.c
>>> +++ b/drivers/video/fbdev/efifb.c
>>> @@ -453,7 +453,7 @@ static int efifb_probe(struct platform_device *dev)
>>>       info->apertures->ranges[0].base = efifb_fix.smem_start;
>>>       info->apertures->ranges[0].size = size_remap;
>>> -    if (efi_enabled(EFI_BOOT) &&
>>> +    if (efi_enabled(EFI_BOOT) && !efi_enabled(EFI_PARAVIRT) &&
>>>           !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
>>>           if ((efifb_fix.smem_start + efifb_fix.smem_len) >
>>>               (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
>>>
>>
> 
> In case I see no reaction from the maintainer for another week I'll take
> this patch through the Xen tree.

From fbdev POV this change looks fine to me and I'm OK with merging it
through Xen or EFI tree:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

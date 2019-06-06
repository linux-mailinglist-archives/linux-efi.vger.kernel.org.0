Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB04237DD0
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2019 22:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfFFUGG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jun 2019 16:06:06 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34086 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFFUGF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jun 2019 16:06:05 -0400
Received: by mail-it1-f194.google.com with SMTP id u124so2905833itc.1
        for <linux-efi@vger.kernel.org>; Thu, 06 Jun 2019 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPCEkqd4vSVAcTEf/gSOGXbf+HD+7Jly1LWGKc+zuG4=;
        b=zVaOpaxv8dOkHtzV5MIqmrTLIsnhFdAGp8AEct0DgejVwNvne4+/21gT6nJ2aRCRxd
         nt5YvXI3ksT7V3dwuiCIyJf46vzP4LFmKTyevhKl0CMA4veHSRJDAwEFD/KEE4vXuS7N
         z0KeXRwwBYxR98kNUQDgaOUslHB0oRkTGXBHtItiHaGFncV18VJJffAhoUpI02VFfV+R
         oaUVmbLVubV8GxflnmSFGoBHJezd7ZdBN6+LN+5yMMdOHHK3PIevjJoQe18siqaVqNTw
         5W8Mbck9gUUVUkLm+igPSWOQlQA9CqZpP6yw7pktxOmD8b6OcptqwBTu2FoY1Bmr2B+y
         MtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPCEkqd4vSVAcTEf/gSOGXbf+HD+7Jly1LWGKc+zuG4=;
        b=EeTy2FeTUPoMDFJojzBovyiivvXnyLM+OyZ9TPthYffqR17HdZO6bl3GHKno9FlCBN
         TQXmteYYFNSRzJZBcaGbpVOoSJ+TJ+HDGrW0zVf1o4VBybgMaF5YH/RGTb/JCq+McL7Y
         rlteX+cOqJ5NHDwWVUhuOGbk6kMbKlk8OI544ZPRTZ7WQGbabsHdnO8h2KclJTh5+zWE
         cr1enYKptNSNK+JUlsQCDAN73OnJqneuB8Yck0NhkyWIxHjouzX1lYNTZTKecm1oJrtj
         oc876KxR/70b/T/BD0ZHZVr1TcwgVp4AB12CUulHdzPDG8dNl++JT8v4zopT849Mjy6p
         8WgQ==
X-Gm-Message-State: APjAAAUodkWQ8sqe+5xZ5ZnnRaZzVQOb+Yufz+Rs1vgQhJRfH7T96tYu
        Yuru2RYshag3jS7eEzPT4TRtDTU9NWg78XWGfEBN7U4kAis=
X-Google-Smtp-Source: APXvYqywJR/Sz7wupFO45RC8t06LnmAAovtDZvtU5cGfbf5Am13Uwsft5RsqBET86h1d5koIDEhuxbDYF+RV9RcdBNU=
X-Received: by 2002:a05:660c:44a:: with SMTP id d10mr1382745itl.153.1559851564940;
 Thu, 06 Jun 2019 13:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <d812f073-67b2-ca7a-616c-7c440716885c@broadcom.com> <02582092-ea73-6947-7aa8-098c10437c92@arm.com>
In-Reply-To: <02582092-ea73-6947-7aa8-098c10437c92@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Jun 2019 22:05:48 +0200
Message-ID: <CAKv+Gu_ZsWAvFV2M0Yo+yawJkD=r_mPmxmoW+aR-CrJzAMvz4A@mail.gmail.com>
Subject: Re: gicv3-its driver crashes in crash dump kernel
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Jonathan Richardson <jonathan.richardson@broadcom.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ray Jui <ray.jui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 6 Jun 2019 at 16:32, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> Hi Jonathan,
>
> On 05/06/2019 23:14, Jonathan Richardson wrote:
> > Hi,
> >
> > As of the 5.0 kernel we're seeing the crash dump kernel crash when the gicv3-its driver calls gic_reserve_range():
>
> [...]
>
> > On crash dump boot, gic calls the same function, efi_mem_reserve_persistent, finds the entry that was on initial boot (0xc3836000), converts it to a va, and then crashes when it's used on this line:
> > atomic_fetch_add_unless(&rsv->count
> >
> > In the previous revision of this file, kmalloc was called and this worked fine.
> >
> > [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> > [    0.000000] GICv3: Distributor has no Range Selector support
> > [    0.000000] GICv3: no VLPI support, no direct LPI support
> > [    0.000000] GICv3: CPU0: found redistributor 1 region 0:0x0000000063e20000
> > [    0.000000] ITS [mem 0x63c20000-0x63c2ffff]
> > [    0.000000] ITS@0x0000000063c20000: allocated 32768 Devices @fd480000 (flat, esz 8, psz 64K, shr 0)
> > [    0.000000] ITS: using cache flushing for cmd queue
> > [    0.000000] iter: prsv = 0xc3836000
> > [    0.000000] rsv = 0x43836000
> > [    0.000000] Unable to handle kernel paging request at virtual address ffff80a343836004
> > [    0.000000] Mem abort info:
> > [    0.000000]   ESR = 0x96000004
> > [    0.000000]   Exception class = DABT (current EL), IL = 32 bits
> >
> > int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
> > {
> > <clip>
> >     for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
> >         printk("iter: prsv = 0x%x\n", prsv);
> >         rsv = __va(prsv);
> >         printk("rsv = 0x%x\n", rsv);
> >         index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
> >         if (index < rsv->size) {
> >             rsv->entry[index].base = addr;
> >             rsv->entry[index].size = size;
> > <clip>
> >
> > It looks like the change has broken crash dump kernel, but I'm not
> > sure what it should be doing instead. Has anyone used gicv3-its with
> > crash dump kernel after this change?
>
> I've definitely used kexec/kdump since, both in VMs and bare-metal.
> Other than __va() going horribly wrong, I have no idea.
>
> Ard, do you have any suggestion?
>

Not sure. It would be helpful to have the entire log, though.
including the normal kernel boot. I can take a look tomorrow.

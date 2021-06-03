Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231B139A99B
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jun 2021 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFCR7a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Jun 2021 13:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFCR73 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Jun 2021 13:59:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F1AC06174A;
        Thu,  3 Jun 2021 10:57:45 -0700 (PDT)
Received: from zn.tnic (p200300ec2f13850035eef6c5c121f5ff.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:35ee:f6c5:c121:f5ff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D78D61EC03D2;
        Thu,  3 Jun 2021 19:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622743062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=skVr9zMvIufazzChvk3drDWrXdpHfZx6gfNB+k0l89Q=;
        b=r8jqC+hgf3ijlHDfI2JOAPpy5D4fDHz1DUW1javoAm/NG1nkQr3dG932YUuEztnxhfFjUV
        rNHiADzamRL3amcP8n1xMpppr5QY2DuHu66FO2Fmm9cYR0X6WY6nS8JaiYzhqkOHgLBtlI
        3VAQ67hbOn4WatmRC+SkaEiaRgF6B1s=
Date:   Thu, 3 Jun 2021 19:57:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/setup: always reserve the first 1M of RAM
Message-ID: <YLkYEDauZfHrcCrm@zn.tnic>
References: <20210601075354.5149-1-rppt@kernel.org>
 <20210601075354.5149-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210601075354.5149-2-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 01, 2021 at 10:53:52AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There are BIOSes that are known to corrupt the memory under 1M, or more
> precisely under 640K because the memory above 640K is anyway reserved for
> the EGA/VGA frame buffer and BIOS.
> 
> To prevent usage of the memory that will be potentially clobbered by the
> kernel, the beginning of the memory is always reserved. The exact size of
> the reserved area is determined by CONFIG_X86_RESERVE_LOW build time and
> reservelow command line option. The reserved range may be from 4K to 640K
> with the default of 64K. There are also configurations that reserve the
> entire 1M range, like machines with SandyBridge graphic devices or systems
> that enable crash kernel.
> 
> In addition to the potentially clobbered memory, EBDA of unknown size may
> be as low as 128K and the memory above that EBDA start is also reserved
> early.
> 
> It would have been possible to reserve the entire range under 1M unless for
> the real mode trampoline that must reside in that area.
> 
> To accommodate placement of the real mode trampoline and keep the memory
> safe from being clobbered by BIOS reserve the first 64K of RAM before
> memory allocations are possible and then, after the real mode trampoline is
> allocated, reserve the entire range from 0 to 1M.
> 
> Update trim_snb_memory() and reserve_real_mode() to avoid redundant
> reservations of the same memory range.
> 
> Also make sure the memory under 1M is not getting freed by
> efi_free_boot_services().
> 
> Fixes: a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/kernel/setup.c        | 35 ++++++++++++++++++++--------------
>  arch/x86/platform/efi/quirks.c | 12 ++++++++++++
>  arch/x86/realmode/init.c       | 14 ++++++++------
>  3 files changed, 41 insertions(+), 20 deletions(-)

Ok, let's try it. Booting on a couple of boxes looks ok here, the
difference is visible:

-  DMA zone: 30 pages reserved
+  DMA zone: 159 pages reserved

On the other box, it was already reserving so many pages even before

  DMA zone: 159 pages reserved

i.e., the first 640K.

But it's not like I had problems before with early reservations so my
testing doesn't mean a whole lot. Hugh's testing sounds good, lemme add
his tag too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

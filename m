Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBA3E905E
	for <lists+linux-efi@lfdr.de>; Wed, 11 Aug 2021 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhHKMTl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Aug 2021 08:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbhHKMTe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Aug 2021 08:19:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E4AC06179C
        for <linux-efi@vger.kernel.org>; Wed, 11 Aug 2021 05:19:07 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t9so5263651lfc.6
        for <linux-efi@vger.kernel.org>; Wed, 11 Aug 2021 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QRfjFOudnOiwA+M7/UAaVDTJpihSFBYjea6mHo6NSYA=;
        b=FrdABWFOYFHYVQYvsn9eIFG1XXIqUnaFBCPEPrWXTbkImjcaYqnfbbDKJbjXTj8n2z
         XKpeeMl+HDYMaw1njH7BCzSmXb2GWH1pBn4+E1w1Zkax9zqjTCMN0ceFLpN0oNSL7p4h
         tTOYo06jVnb3EuSp9CAkw3RajLjCGRh5DcWWOVaUC3oCLa3fiXHjMHrKiPKxkbd9MHf4
         XWiG9YDES/j+Q6K8AbBgatHhy3Ey7EF4Mw9l8egNLjOvPiIJBkLqlDJHfGJd1OD2IwY9
         /Dj5oeYRUTA55X3eykWwXtvq+RdRhaXu8H17iGSYXfRtDXdJr3ACYPa147h4M5kexh1Q
         1YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QRfjFOudnOiwA+M7/UAaVDTJpihSFBYjea6mHo6NSYA=;
        b=oFG/TgiqPEKjar6bLGLjYkuG6CNqOTsxlPcR/t0MVPqBRv6UqPZIrv9DTy5zcMP9ZZ
         GIDuZsNOdbi6ZAfETVdXRjOL50kuVVKdOblphslpb2pD+uPcHCZ7XQ0cJwPgT+FGK9sh
         xzouaAFPIpDlkuYzb6Zn2ENCVT/MxtDYMfdgh+r6M/juMl24GjoVhBG6ZskID1uX7JQv
         PrD8aGIVcJemHcoGQL7B9g53JJDsSedHBaGJ0yi8CrZN2HDFL93K2374VV1d+elxQhPp
         9k7GPJzDJt128RLEFtFznbizc9z0AijdER5+bW8sGDPtUnPBez92+T7MIsIHAbLB+eCT
         AZsg==
X-Gm-Message-State: AOAM532irh6D+LZsMRWpOo/TlIKyz3TxuAnlK0vFmpp67LiGyrRc37xC
        k6vdGxxS66na0gHE+iycGGRwXA==
X-Google-Smtp-Source: ABdhPJwYqCmmrayYkwT8dKOh/tHUuUvcGTl6bQD02skpgV77PxIfPFHOo1k2HSgXk2Z2qwWhaj6ksA==
X-Received: by 2002:ac2:50d8:: with SMTP id h24mr4762329lfm.631.1628684346244;
        Wed, 11 Aug 2021 05:19:06 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w7sm2337599lft.285.2021.08.11.05.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:19:05 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A68EB102A2E; Wed, 11 Aug 2021 15:19:17 +0300 (+03)
Date:   Wed, 11 Aug 2021 15:19:17 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
Message-ID: <20210811121917.ghxi7g4mctuybhbk@box.shutemov.name>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 10, 2021 at 02:48:54PM -0500, Tom Lendacky wrote:
> On 8/10/21 1:45 PM, Kuppuswamy, Sathyanarayanan wrote:
> > 
> > 
> > On 7/27/21 3:26 PM, Tom Lendacky wrote:
> >> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> >> index de01903c3735..cafed6456d45 100644
> >> --- a/arch/x86/kernel/head64.c
> >> +++ b/arch/x86/kernel/head64.c
> >> @@ -19,7 +19,7 @@
> >>   #include <linux/start_kernel.h>
> >>   #include <linux/io.h>
> >>   #include <linux/memblock.h>
> >> -#include <linux/mem_encrypt.h>
> >> +#include <linux/protected_guest.h>
> >>   #include <linux/pgtable.h>
> >>     #include <asm/processor.h>
> >> @@ -285,7 +285,7 @@ unsigned long __head __startup_64(unsigned long
> >> physaddr,
> >>        * there is no need to zero it after changing the memory encryption
> >>        * attribute.
> >>        */
> >> -    if (mem_encrypt_active()) {
> >> +    if (prot_guest_has(PATTR_MEM_ENCRYPT)) {
> >>           vaddr = (unsigned long)__start_bss_decrypted;
> >>           vaddr_end = (unsigned long)__end_bss_decrypted;
> > 
> > 
> > Since this change is specific to AMD, can you replace PATTR_MEM_ENCRYPT with
> > prot_guest_has(PATTR_SME) || prot_guest_has(PATTR_SEV). It is not used in
> > TDX.
> 
> This is a direct replacement for now.

With current implementation of prot_guest_has() for TDX it breaks boot for
me.

Looking at code agains, now I *think* the reason is accessing a global
variable from __startup_64() inside TDX version of prot_guest_has().

__startup_64() is special. If you access any global variable you need to
use fixup_pointer(). See comment before __startup_64().

I'm not sure how you get away with accessing sme_me_mask directly from
there. Any clues? Maybe just a luck and complier generates code just right
for your case, I donno.

A separate point is that TDX version of prot_guest_has() relies on
cpu_feature_enabled() which is not ready at this point.

I think __bss_decrypted fixup has to be done if sme_me_mask is non-zero.
Or just do it uncoditionally because it's NOP for sme_me_mask == 0.

> I think the change you're requesting
> should be done as part of the TDX support patches so it's clear why it is
> being changed.
> 
> But, wouldn't TDX still need to do something with this shared/unencrypted
> area, though? Or since it is shared, there's actually nothing you need to
> do (the bss decrpyted section exists even if CONFIG_AMD_MEM_ENCRYPT is not
> configured)?

AFAICS, only kvmclock uses __bss_decrypted. We don't enable kvmclock in
TDX at the moment. It may change in the future.

-- 
 Kirill A. Shutemov

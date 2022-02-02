Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C204A6BC0
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 07:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbiBBGwp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 01:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244791AbiBBGwj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 01:52:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1F8C061757;
        Tue,  1 Feb 2022 22:09:37 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11E321EC0464;
        Wed,  2 Feb 2022 07:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643782171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sZqgeaY2T05GRVx++Y85byZFFFlp+ohQpqesnax8x/o=;
        b=KjtKrheXOmUc492KuKPtthqotPhBLPoisxL+wxk9XP9303vFRnbL9SZn3SUmPtGpeFNpYU
        vi/W1tV6fApf2lZ0sK2bO1HWyJahbnRou6YbfB41YDwNdH//rUwztJa5AX4dCFPOGREpkM
        w3nRBvX4FyEgNZYkh1vtwdiIRcJ4M3A=
Date:   Wed, 2 Feb 2022 07:09:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 05/43] x86/compressed/64: Detect/setup SEV/SME
 features earlier in boot
Message-ID: <YfogFFOoHvCV+/2Y@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-6-brijesh.singh@amd.com>
 <Yfl3FaTGPxE7qMCq@zn.tnic>
 <20220201203507.goibbaln6dxyoogv@amd.com>
 <YfmmBykN2s0HsiAJ@zn.tnic>
 <20220202005212.a3fnn6i76ko6u6t5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220202005212.a3fnn6i76ko6u6t5@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 01, 2022 at 06:52:12PM -0600, Michael Roth wrote:
> Since the kernel proper rdmsr()/wrmsr() definitions are getting pulled in via
> misc.h, I have to use a different name to avoid compiler errors. For now I've
> gone with rd_msr()/wr_msr(), but no problem changing those if needed.

Does that fix it too?

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 16ed360b6692..346c46d072c8 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -21,7 +21,6 @@
 
 #include <linux/linkage.h>
 #include <linux/screen_info.h>
-#include <linux/elf.h>
 #include <linux/io.h>
 #include <asm/page.h>
 #include <asm/boot.h>
---

This is exactly what I mean with a multi-year effort of untangling what
has been mindlessly mixed in over the years...

> Since the rd_msr/wr_msr are oneliners, it seemed like it might be a
> little cleaner to just define them in boot/msr.h as static inline and
> include them directly as part of the header.

Ok, that's fine too.

> Here's what it looks like on top of this tree, and roughly how I plan to
> split the patches for v10:
> 
> - define the rd_msr/wr_msr helpers
>   https://github.com/mdroth/linux/commit/982c6c5741478c8f634db8ac0ba36575b5eff946
> 
> - use the helpers in boot/compressed/sev.c and boot/cpucheck.c
>   https://github.com/mdroth/linux/commit/a16e11f727c01fc478d3b741e1bdd2fd44975d7c
> 
> For v10 though I'll likely just drop rd_sev_status_msr() completely and use
> rd_msr() directly.
> 
> Let me know if I should make any changes and I'll make sure to get those in for
> the next spin.

Yap, looks good.

Thanks for doing that!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

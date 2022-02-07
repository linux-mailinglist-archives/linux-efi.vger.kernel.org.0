Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FFD4AC369
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiBGPaH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 10:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbiBGPWj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 10:22:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ADEC0401C8;
        Mon,  7 Feb 2022 07:22:35 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C41E81EC0295;
        Mon,  7 Feb 2022 16:22:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644247349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9kw2JUuU4tOJy7Y1YqOoL272nzWKEY2AY+xtiIohMEI=;
        b=Z1hjKr7ZsdoSLPXWGCo9U0lVd0+sc+AZB3agyDxd+AJOlxIF2dL7NSX6pyRpok68cKRHwO
        B2rQcdhqtLso+qJmn0PKiL3rW65d++y+9w83Aq7drNfxUiS92t/BWB1y0F1Qxjh30SkmUz
        UE52d9BAbutNd15WBJMFn32ugNvJzVw=
Date:   Mon, 7 Feb 2022 16:22:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 41/43] virt: Add SEV-SNP guest driver
Message-ID: <YgE5MOJ+yi5ouGcb@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-42-brijesh.singh@amd.com>
 <YgBOKQKXEH5VqTO7@zn.tnic>
 <cb4aa4c4-11e9-163c-5101-8b0dea336fc1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb4aa4c4-11e9-163c-5101-8b0dea336fc1@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 07, 2022 at 08:41:47AM -0600, Brijesh Singh wrote:
> Randy asked me similar question on v7, and here is my response to it.
> 
> https://lore.kernel.org/linux-mm/e6b412e4-f38e-d212-f52a-e7bdc9a26eff@infradead.org/
> 
> Let me know if you still think that we should make it 'n'. I am not dead
> against it but I have feeling that once distro's starts building SNP aware
> guest kernel, then we may get asked to enable it by default so that
> attestation report can be obtained by the initial ramdisk.

Well, let's see:

$ make oldconfig
...

#
# No change to .config
#
$

So it didn't even ask me. Because

# CONFIG_VIRT_DRIVERS is not set

so what's the point of this "default y"?

If the distros are your worry, then you probably will have to ask
them to do so explicitly anyway because at least we edit our configs
ourselves and decide what to enable or what not.

> After this condition is met, a guest will no longer get the attestation
> report. It's up to the userspace to reboot the guest or continue without
> attestation.
> 
> The only thing that will reset the counter is re-launching the guest to go
> through the entire PSP initialization sequence once again.

Well, but you need to explain that somewhere to the guest owners.
I guess either here in that error message or in some higher-level
glue which will do the attestation. Just saying that some counter has
overflown is not very user-friendly, I'd say.

> Yep, it need to protect more stuff.
> 
> We allocate a shared buffers (request, response, cert-chain) that gets
> populated before issuing the command, and then we copy the result from
> reponse shared to callers buffer after the command completes. So, we also
> want to ensure that the shared buffer is not touched before the previous
> ioctl is finished.

So you need to rename that mutex and slap a comment above it what it
protects.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7C84A8776
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 16:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351739AbiBCPQk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 10:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiBCPQk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Feb 2022 10:16:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CA9C061714;
        Thu,  3 Feb 2022 07:16:39 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E9311EC052A;
        Thu,  3 Feb 2022 16:16:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643901394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yg+soGFEUKSbxLOHDIvcVK6A2p0O5VjkYxKG83vqchE=;
        b=C539Dr+f4cCq60tPa3aZj/xVx2yPOJH7EBjcb6UDpKQ5/7YFd/MWP4EhkVDwmv3F4ZxZOn
        VY+0Ja1hfKp9LnGIsarzSoAOGiwMI70e2EVVxG1NbCo6FiJDYVFxTN2PsLbCFC92Uqyvcw
        dcJdG8k4LlUmuEl1K7vl11Ism3AMLq8=
Date:   Thu, 3 Feb 2022 16:16:33 +0100
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
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: Re: [PATCH v9 23/43] KVM: x86: Move lookup of indexed CPUID leafs to
 helper
Message-ID: <Yfvx0Rq8Tydyr/RO@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-24-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-24-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:44AM -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Determining which CPUID leafs have significant ECX/index values is
> also needed by guest kernel code when doing SEV-SNP-validated CPUID
> lookups. Move this to common code to keep future updates in sync.
> 
> Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/cpuid.h | 38 ++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/cpuid.c         | 19 ++----------------
>  2 files changed, 40 insertions(+), 17 deletions(-)
>  create mode 100644 arch/x86/include/asm/cpuid.h
> 
> diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
> new file mode 100644
> index 000000000000..00408aded67c
> --- /dev/null
> +++ b/arch/x86/include/asm/cpuid.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Kernel-based Virtual Machine driver for Linux cpuid support routines
> + *
> + * derived from arch/x86/kvm/x86.c
> + * derived from arch/x86/kvm/cpuid.c
> + *
> + * Copyright 2011 Red Hat, Inc. and/or its affiliates.
> + * Copyright IBM Corporation, 2008
> + */

I have no clue what you're trying to achieve by copying the copyright of
the file this comes from. As dhansen properly points out, those lines
in that function come from other folks/companies too so why even bother
with this?

git history holds the correct and full copyright anyway...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

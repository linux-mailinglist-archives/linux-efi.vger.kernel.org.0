Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D059B42C206
	for <lists+linux-efi@lfdr.de>; Wed, 13 Oct 2021 16:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhJMOEk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Oct 2021 10:04:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36956 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhJMOEj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 13 Oct 2021 10:04:39 -0400
Received: from zn.tnic (p200300ec2f1208001796bb6dc2170571.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:800:1796:bb6d:c217:571])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF28E1EC051F;
        Wed, 13 Oct 2021 16:02:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634133755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NurK9sx2E3ZorSLuDzTSVMGD0abr259MgqmkGxhYunc=;
        b=BfN4IUFU3/eKIX37iXR25VuZJZfq0gwCcmJIo74REhBJxLHgr2IUVEc/tOe6+OWsIjhtwF
        pqmUlzUvmYxmZqM3q5gdwSGDl6BRWnqJfG0Qw1p1V2i06CSWDsBqNUW0EudVX23OlHE2Jy
        FVCoeKqYWNp5vr875rp1nUyJ4f0r800=
Date:   Wed, 13 Oct 2021 16:02:33 +0200
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
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 07/42] x86/sev: Add support for hypervisor feature
 VMGEXIT
Message-ID: <YWbm+SOMv7AXduWR@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-8-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008180453.462291-8-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 08, 2021 at 01:04:18PM -0500, Brijesh Singh wrote:
> Version 2 of GHCB specification introduced advertisement of a features
> that are supported by the hypervisor. Add support to query the HV
> features on boot.
> 
> Version 2 of GHCB specification adds several new NAEs, most of them are
> optional except the hypervisor feature. Now that hypervisor feature NAE
> is implemented, so bump the GHCB maximum support protocol version.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev-common.h |  3 +++
>  arch/x86/include/asm/sev.h        |  2 +-
>  arch/x86/include/uapi/asm/svm.h   |  2 ++
>  arch/x86/kernel/sev-shared.c      | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 36 insertions(+), 1 deletion(-)

For the next version, when you add those variables, do this too pls:

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 8ee27d07c1cd..7a2176e0d0ad 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -21,10 +21,10 @@
  *
  * GHCB protocol version negotiated with the hypervisor.
  */
-static u16 __ro_after_init ghcb_version;
+static u16 ghcb_version __ro_after_init;
 
 /* Bitmap of SEV features supported by the hypervisor */
-static u64 __ro_after_init sev_hv_features;
+static u64 sev_hv_features __ro_after_init;
 
 static bool __init sev_es_check_cpu_features(void)
 {

I didn't realize this earlier but we put that annotation at the end.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801E7767280
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 18:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjG1Q4i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 12:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjG1Q4U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 12:56:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BCBE47;
        Fri, 28 Jul 2023 09:55:57 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96B621EC0F5F;
        Fri, 28 Jul 2023 18:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690563355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RSQT6kz7q95HmcLEvve4qa6I/xcjQSECnE4yw3Z+BmU=;
        b=ElxUExeiD9kGERJ+C54vf0jddcWtGvI5ZT3Mn555PFNTBBE7MKO2eostStL4ekhXWvqayv
        /RbxMcrajN3tUT+GI3UdAdoDqljFLmSmgc8/c+S6Z0XMX67m1enswyiqfJES+T/mCaQhmk
        IGPpzQg15MRrynSuB7RURODe3GY704k=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rzgwixfY34gw; Fri, 28 Jul 2023 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690563352; bh=RSQT6kz7q95HmcLEvve4qa6I/xcjQSECnE4yw3Z+BmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ix3uBvolQLGla1R3bo/TEjxXMwOJL8/Q7O4av2ki3Yq7BEv97Jix8mr1kzLolSqTr
         5DqLxWDwtN3SoMvvLCQ9AVOT7osB5ESpRY7Xei97nqS7lKN05xJCRUqVxE1SQzXKwN
         TRzemVX4S/G98igilaQAvaSNdf4F3z4zf3+xx0Ut1PrHUybZVCn6eMOrLa2QngOecQ
         c0OX0nb1ukkw1gyiOPzm8FDUKbW7xyvShChOV5etXZ4ZKji46fl+x01pRSyYoi1qyJ
         MCahbaVtT+WIk0+TDZusdAjeu//Ma8ic27dWerp/ev8Ch+eOzVPgMwMy0zeyjPnPSY
         I0G5kEL1fHDbcNt0vLT+ZvO6xYPCIXQ74viHSwwdrVE29TbBCt/XXr62qPUWZFS0pb
         C5YFxIL4KCLgn0bCujD40bFs0hD7+rXb6AzCFFmIC4/jXbme14LWl3/8Tv+5Npitkn
         OC2uzSgH0BFrqczdKwI2G7szphKaEDuff8i0GRXutZyGdRoB3tnBEjRBlPplSPrkIh
         Vh1wCnc4BKb8sWIAykeW2IH+JpPEivnsO9dpenjTFymT+BHUUV1i2fphWSuDZQaHLD
         5lpJTmpn1ZksxD3H0Zhd95mZ6MIHNpTKPQxOG7HW6OfF86FohclpLRsrbAkT8/FMzn
         +KMO7sjbO8ULrvhhqcvVlneU=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEA0740E0184;
        Fri, 28 Jul 2023 16:55:39 +0000 (UTC)
Date:   Fri, 28 Jul 2023 18:55:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tao Liu <ltao@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
 <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 27, 2023 at 07:03:26PM +0800, Tao Liu wrote:
> Hi Borislav,
> 
> Sorry for the late response. I spent some time retesting your patch
> against 6.5.0-rc1 and 6.5.0-rc3, and it is OK. So
> 
> Reported-and-tested-by: Tao Liu <ltao@redhat.com>
> 
> And will we use this patch as a workaround or will we wait for a
> better solution as proposed by Michael?

First of all, please do not top-post.

And yes, here's a better one. I'd appreciate it you testing it.

Thx.

---
 arch/x86/boot/compressed/idt_64.c |  5 ++++-
 arch/x86/boot/compressed/sev.c    | 37 +++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 6debb816e83d..0f03ac12e2a6 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -63,7 +63,10 @@ void load_stage2_idt(void)
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
+	if (sev_status & BIT(1))
+		set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
+	else
+		set_idt_entry(X86_TRAP_VC, NULL);
 #endif
 
 	load_boot_idt(&boot_idt_desc);
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 09dc8c187b3c..c3e343bd4760 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -404,13 +404,46 @@ void sev_enable(struct boot_params *bp)
 	if (bp)
 		bp->cc_blob_address = 0;
 
+	/*
+	 * Do an initial SEV capability check before snp_init() which
+	 * loads the CPUID page and the same checks afterwards are done
+	 * without the hypervisor and are trustworthy.
+	 *
+	 * If the HV fakes SEV support, the guest will crash'n'burn
+	 * which is good enough.
+	 */
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return;
+
+	/*
+	 * Check for the SME/SEV feature:
+	 *   CPUID Fn8000_001F[EAX]
+	 *   - Bit 0 - Secure Memory Encryption support
+	 *   - Bit 1 - Secure Encrypted Virtualization support
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	/* Check whether SEV is supported */
+	if (!(eax & BIT(1)))
+		return;
+
 	/*
 	 * Setup/preliminary detection of SNP. This will be sanity-checked
 	 * against CPUID/MSR values later.
 	 */
 	snp = snp_init(bp);
 
-	/* Check for the SME/SEV support leaf */
+	/* Now repeat the checks with the SNP CPUID table. */
+
+	/* Recheck the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
@@ -418,7 +451,7 @@ void sev_enable(struct boot_params *bp)
 		return;
 
 	/*
-	 * Check for the SME/SEV feature:
+	 * Recheck for the SME/SEV feature:
 	 *   CPUID Fn8000_001F[EAX]
 	 *   - Bit 0 - Secure Memory Encryption support
 	 *   - Bit 1 - Secure Encrypted Virtualization support
-- 
2.41.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

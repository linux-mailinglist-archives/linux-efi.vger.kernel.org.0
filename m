Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B347730F141
	for <lists+linux-efi@lfdr.de>; Thu,  4 Feb 2021 11:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhBDKwq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Feb 2021 05:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbhBDKwp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Feb 2021 05:52:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33233C061573;
        Thu,  4 Feb 2021 02:52:05 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c7e00dc348a22cc2c06fb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7e00:dc34:8a22:cc2c:6fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A80071EC00F8;
        Thu,  4 Feb 2021 11:52:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612435921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x+q7M5BysVCq0z73BCA5GL6K1zhxLeh9Ep6YuQ1rvpw=;
        b=NkbeH0s9FBLOV+Wse/Y6c3Vc6CDqAD5AEy6ZGsLflQepqjqCjWV3lxVgMi6lbhBpftYVew
        9QtP+ljkKRefd9fZoY1dFln9/Q9e2nFNnzMC/0s/gZU154j1HyoOWlWHrCTQqsJfebf8Q9
        FrVVybE3qHTptJdYnKQsjd6ae3frQgg=
Date:   Thu, 4 Feb 2021 11:51:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <20210204105155.GA32255@zn.tnic>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan>
 <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic>
 <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
 <20210203185148.GA1711888@localhost>
 <CAMj1kXFPOvkcw573wzKzMQOgT-nddFcAZo9M4Lk+idn_1UBbnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFPOvkcw573wzKzMQOgT-nddFcAZo9M4Lk+idn_1UBbnA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 03, 2021 at 09:29:18PM +0100, Ard Biesheuvel wrote:
> I think we have agreement on the approach but it is unclear who is
> going to write the patch.

How's that below?

And frankly, I'd even vote for removing those assertions altogether. If
somehow the EFI pgd lands somewhere else, the kernel will crash'n'burn
spectacularly and quickly so it's not like we won't catch it...

---
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 91ac10654570..b6be19c09841 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -156,8 +156,8 @@ extern unsigned int ptrs_per_p4d;
 #define CPU_ENTRY_AREA_PGD	_AC(-4, UL)
 #define CPU_ENTRY_AREA_BASE	(CPU_ENTRY_AREA_PGD << P4D_SHIFT)
 
-#define EFI_VA_START		( -4 * (_AC(1, UL) << 30))
-#define EFI_VA_END		(-68 * (_AC(1, UL) << 30))
+#define EFI_VA_START		( -4UL * (_AC(1, UL) << 30))
+#define EFI_VA_END		(-68UL * (_AC(1, UL) << 30))
 
 #define EARLY_DYNAMIC_PAGE_TABLES	64
 
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e1e8d4e3a213..56fdc0bbb554 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -123,9 +123,7 @@ void efi_sync_low_kernel_mappings(void)
 	 * only span a single PGD entry and that the entry also maps
 	 * other important kernel regions.
 	 */
-	MAYBE_BUILD_BUG_ON(pgd_index(EFI_VA_END) != pgd_index(MODULES_END));
-	MAYBE_BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) !=
-			(EFI_VA_END & PGDIR_MASK));
+	MAYBE_BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) != PGDIR_MASK);
 
 	pgd_efi = efi_pgd + pgd_index(PAGE_OFFSET);
 	pgd_k = pgd_offset_k(PAGE_OFFSET);
@@ -137,8 +135,7 @@ void efi_sync_low_kernel_mappings(void)
 	 * As with PGDs, we share all P4D entries apart from the one entry
 	 * that covers the EFI runtime mapping space.
 	 */
-	BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
-	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
+	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != P4D_MASK);
 
 	pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
 	pgd_k = pgd_offset_k(EFI_VA_END);


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E15521315
	for <lists+linux-efi@lfdr.de>; Tue, 10 May 2022 13:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbiEJLID (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 May 2022 07:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbiEJLHz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 May 2022 07:07:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEF127EB9F;
        Tue, 10 May 2022 04:03:58 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86E9A1EC06BA;
        Tue, 10 May 2022 13:03:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652180632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=syfkLxHRdwVeg4TDYaeS8+/osqvt2Cc1E/livBnG7OM=;
        b=SLJxJVy2h1wrhVo+uXYwj0AmoBMCri/tlQceGXhLQMKhuayhE5HkchGtFPZvgpwWJGJj+z
        XzYKxgfTfHowtHzEj/se8njAdX/JRwhUrxQxY/HBLjWZMbzf+8ZtYy9+9nJrnifV6eiZih
        8geRjbWUkJUl3nkh4lqkJQWs4Chq+NM=
Date:   Tue, 10 May 2022 13:03:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Message-ID: <YnpGnMoviGoK4Ucq@zn.tnic>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
 <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 06, 2022 at 06:30:13PM +0300, Kirill A. Shutemov wrote:
> I find it harder to follow.

If in doubt, always consider using a helper function:

---

diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
index 7db2f41b54cd..cf475243b6d5 100644
--- a/arch/x86/boot/compressed/efi.h
+++ b/arch/x86/boot/compressed/efi.h
@@ -32,6 +32,7 @@ typedef	struct {
 } efi_table_hdr_t;
 
 #define EFI_CONVENTIONAL_MEMORY		 7
+#define EFI_UNACCEPTED_MEMORY		15
 
 #define EFI_MEMORY_MORE_RELIABLE \
 				((u64)0x0000000000010000ULL)	/* higher reliability */
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 28b91df9d31e..39bb4c319dfc 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -671,6 +671,23 @@ static bool process_mem_region(struct mem_vector *region,
 }
 
 #ifdef CONFIG_EFI
+
+/*
+ * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if supported) are guaranteed
+ * to be free.
+ */
+static inline bool memory_type_is_free(efi_memory_desc_t *md)
+{
+	if (md->type == EFI_CONVENTIONAL_MEMORY)
+		return true;
+
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+		if (md->type == EFI_UNACCEPTED_MEMORY)
+			return true;
+
+	return false;
+}
+
 /*
  * Returns true if we processed the EFI memmap, which we prefer over the E820
  * table if it is available.
@@ -723,21 +740,9 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 		 * free memory and thus available to place the kernel image into,
 		 * but in practice there's firmware where using that memory leads
 		 * to crashes.
-		 *
-		 * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if
-		 * supported) are guaranteed to be free.
 		 */
-
-		switch (md->type) {
-		case EFI_CONVENTIONAL_MEMORY:
-			break;
-		case EFI_UNACCEPTED_MEMORY:
-			if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
-				break;
+		if (!memory_type_is_free(md))
 			continue;
-		default:
-			continue;
-		}
 
 		if (efi_soft_reserve_enabled() &&
 		    (md->attribute & EFI_MEMORY_SP))
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

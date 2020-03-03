Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE25D17845F
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 21:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbgCCUys (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 15:54:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35049 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730949AbgCCUys (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 15:54:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id v15so1171258qto.2;
        Tue, 03 Mar 2020 12:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxnoNODxTRgUma85r+YaM42HDwfM3r/uZczD0dRTEq0=;
        b=SXTmef6bob839lACsbHpa2qoAszBbau66MLxqShVRNIgb5KxAiJSAsxfyFQBH3Bb5L
         g+4YeL0WIXBbiUjOtFq32DWk/QYHBw/ZbLxjec+T1FweVQiw4T5pDBaozy7NAoK0xQxt
         5uOPHr2lWIPh6EiiqB9NxtSq57jvnB5H/nVBU94S7ZxeCT9AIDYblZRRDHKtzV9dOROQ
         8YQjCwnBWtf/MfkZNKWQt2ve6Ff8VrbMpANbb2jldnhyaFA8/q1v7tuF+hV+bYqgf6/E
         2zs05Iw8WMIAKTRT163xVW497ZfnwAV3NXFypbLf06F3bbv/sKqtBEgqsSeGZJCbpjCx
         nCdw==
X-Gm-Message-State: ANhLgQ3OQOkGKA0lKGbLaEP2XKHZDRJBJVEEWHvlr4F/u9qci70Ag3Zl
        Wl4MGt4dr2y7VBZ5LOTPA1Y=
X-Google-Smtp-Source: ADFU+vveX0cofs0UCUhXRRe8jbjv4EzVDdkAvTupJ+2hAgpljEtp+BkSBDjF1fBd3OlTmeWmd8A4Tg==
X-Received: by 2002:ac8:73c8:: with SMTP id v8mr5986511qtp.270.1583268887098;
        Tue, 03 Mar 2020 12:54:47 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v12sm11473041qti.84.2020.03.03.12.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:54:46 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] x86/mm/pat: Handle no-GBPAGES case correctly in populate_pud
Date:   Tue,  3 Mar 2020 15:54:42 -0500
Message-Id: <20200303205445.3965393-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303205445.3965393-1-nivedita@alum.mit.edu>
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit d367cef0a7f0 ("x86/mm/pat: Fix boot crash when 1GB pages are not
supported by the CPU") added checking for CPU support for 1G pages
before using them.

However, when support is not present, nothing is done to map the
intermediate 1G regions and we go directly to the code that normally
maps the remainder after 1G mappings have been done. This code can only
handle mappings that fit inside a single PUD entry, but there is no
check, and it instead silently produces a corrupted mapping to the end
of the PUD entry, and no mapping beyond it, but still returns success.

This bug is encountered on EFI machines in mixed mode (32-bit firmware
with 64-bit kernel), with RAM beyond 2G. The EFI support code
direct-maps all the RAM, so a memory range from below 1G to above 2G
triggers the bug and results in no mapping above 2G, and an incorrect
mapping in the 1G-2G range. If the kernel resides in the 1G-2G range, a
firmware call does not return correctly, and if it resides above 2G, we
end up passing addresses that are not mapped in the EFI pagetable.

Fix this by mapping the 1G regions using 2M pages when 1G page support
is not available.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/mm/pat/set_memory.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c4aedd00c1ba..d0b7b06253a5 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1370,12 +1370,22 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
 	/*
 	 * Map everything starting from the Gb boundary, possibly with 1G pages
 	 */
-	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
-		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
-				   canon_pgprot(pud_pgprot))));
+	while (end - start >= PUD_SIZE) {
+		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {
+			set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
+					   canon_pgprot(pud_pgprot))));
+			cpa->pfn += PUD_SIZE >> PAGE_SHIFT;
+		} else {
+			if (pud_none(*pud))
+				if (alloc_pmd_page(pud))
+					return -1;
+			if (populate_pmd(cpa, start, start + PUD_SIZE,
+					 PUD_SIZE >> PAGE_SHIFT,
+					 pud, pgprot) < 0)
+				return cur_pages;
+		}
 
 		start	  += PUD_SIZE;
-		cpa->pfn  += PUD_SIZE >> PAGE_SHIFT;
 		cur_pages += PUD_SIZE >> PAGE_SHIFT;
 		pud++;
 	}
-- 
2.24.1


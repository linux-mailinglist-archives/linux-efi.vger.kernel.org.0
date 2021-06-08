Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B7739F4B3
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 13:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhFHLOb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 07:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFHLOa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Jun 2021 07:14:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23111C061574;
        Tue,  8 Jun 2021 04:12:37 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bc9005757c3be7e9afbb5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:c900:5757:c3be:7e9a:fbb5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E0BA1EC036C;
        Tue,  8 Jun 2021 13:12:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623150755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3sPDCvRlwwIpxA2b3PcLxBUFevSmv4P/XZ/ZVXKpHEY=;
        b=pm3yWyMyq0vfbN/1lB1/7YSiZn9GqmppzRw5hFrYhvwk6G8zDGbVnobmgbVtvU5ugIyGc2
        AvNowWwi3/OJYL2ri6TSgeqQ6tZbxnkJW1XzcRYwrpPRsJY9eY4tLQhjhK0PfmioT/M5D8
        XquQKU68mAu73X2MJSJsE7Wl84JJeyg=
Date:   Tue, 8 Jun 2021 13:12:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 08/22] x86/compressed: Add helper for
 validating pages in the decompression stage
Message-ID: <YL9Qo/8ycWKZGRwt@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-9-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-9-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:02AM -0500, Brijesh Singh wrote:
> +static void __page_state_change(unsigned long paddr, int op)
> +{
> +	u64 val;
> +
> +	if (!sev_snp_enabled())
> +		return;
> +
> +	/*
> +	 * If private -> shared then invalidate the page before requesting the
> +	 * state change in the RMP table.
> +	 */
> +	if ((op == SNP_PAGE_STATE_SHARED) && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
> +		goto e_pvalidate;
> +
> +	/* Issue VMGEXIT to change the page state in RMP table. */
> +	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
> +	VMGEXIT();
> +
> +	/* Read the response of the VMGEXIT. */
> +	val = sev_es_rd_ghcb_msr();
> +	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
> +		sev_es_terminate(1, GHCB_TERM_PSC);
> +
> +	/*
> +	 * Now that page is added in the RMP table, validate it so that it is
> +	 * consistent with the RMP entry.
> +	 */
> +	if ((op == SNP_PAGE_STATE_PRIVATE) && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
> +		goto e_pvalidate;
> +
> +	return;
> +
> +e_pvalidate:
> +	sev_es_terminate(1, GHCB_TERM_PVALIDATE);
> +}

You don't even need that label, diff ontop:

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 808fe1f6b170..dd0f22386fd2 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -146,7 +146,7 @@ static void __page_state_change(unsigned long paddr, int op)
 	 * state change in the RMP table.
 	 */
 	if ((op == SNP_PAGE_STATE_SHARED) && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
-		goto e_pvalidate;
+		sev_es_terminate(1, GHCB_TERM_PVALIDATE);
 
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
@@ -162,12 +162,7 @@ static void __page_state_change(unsigned long paddr, int op)
 	 * consistent with the RMP entry.
 	 */
 	if ((op == SNP_PAGE_STATE_PRIVATE) && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
-		goto e_pvalidate;
-
-	return;
-
-e_pvalidate:
-	sev_es_terminate(1, GHCB_TERM_PVALIDATE);
+		sev_es_terminate(1, GHCB_TERM_PVALIDATE);
 }
 
 void snp_set_page_private(unsigned long paddr)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

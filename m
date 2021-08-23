Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8814F3F4C2E
	for <lists+linux-efi@lfdr.de>; Mon, 23 Aug 2021 16:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhHWORK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 10:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhHWORF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Aug 2021 10:17:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5323C061757;
        Mon, 23 Aug 2021 07:16:21 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07d900e826476efa1e0ef3.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d900:e826:476e:fa1e:ef3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E7C151EC01DF;
        Mon, 23 Aug 2021 16:16:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629728176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKD+/8Qbv6yv6nIGV7iJbsxCYPsTuanF1BGer6VcD3Q=;
        b=fl2Qa5G0kimY8dlcx57nwjuUVsOyw/YTDGgTJJIaA2N0r2c9wtb47MYkDSQbAUPKdcccji
        exXZ8QJN7O52aXOlT0T1CVQQE8Da6aBbgEZZ2YOE263xSzLuAcAFM7fQ+bCZmZl9FGXEjh
        HzbE1JM09KsuZt4AnEG95Z4di2Vt2ws=
Date:   Mon, 23 Aug 2021 16:16:51 +0200
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
        Wanpeng Li <wanpengli@tencent.com>,
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
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 11/38] x86/compressed: Add helper for validating
 pages in the decompression stage
Message-ID: <YSOt01Qk9KOsTVj/@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-12-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210820151933.22401-12-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:06AM -0500, Brijesh Singh wrote:
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index d426c30ae7b4..1cd8ce838af8 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -57,6 +57,26 @@
>  #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
>  #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
>  
> +/* SNP Page State Change */

Let's make it very clear here that those cmd numbers below are actually
part of the protocol and not randomly chosen:

/*
 * ...
 *
 * 0x014 – SNP Page State Change Request
 *
 * GHCBData[55:52] – Page operation:
 *   0x0001 – Page assignment, Private
 *   0x0002 – Page assignment, Shared
 */

> +enum psc_op {
> +	SNP_PAGE_STATE_PRIVATE = 1,
> +	SNP_PAGE_STATE_SHARED,
> +};
> +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

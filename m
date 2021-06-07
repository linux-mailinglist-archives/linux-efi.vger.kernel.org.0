Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE0F39E09F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jun 2021 17:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhFGPhR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Jun 2021 11:37:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47616 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhFGPhQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Jun 2021 11:37:16 -0400
Received: from zn.tnic (p200300ec2f0b4f0010db370b6947fb68.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4f00:10db:370b:6947:fb68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8578E1EC04CD;
        Mon,  7 Jun 2021 17:35:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623080123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qFFCUAag8UGkqculjLWLlTiPg+uQkNT3QZ7+KscRBoA=;
        b=BKOlmEeKnyk5qxENdyy79PSCLvCjmvXOE3iQHPkpjK6gxXcWlNFo/wsR2nw6WKnGPIKhy6
        Xp7JRpoEaS1wiqjd6hKFwKKCHs38CLT81t6M/lommh1TMic1r+Q4KOhijQhUK6/yA0qzCE
        CojhJDDtfzCf0hsxub2W1TXpqykEBFM=
Date:   Mon, 7 Jun 2021 17:35:18 +0200
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
Subject: Re: [PATCH Part1 RFC v3 07/22] x86/sev: Add a helper for the
 PVALIDATE instruction
Message-ID: <YL48ttHne8d6xl9n@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-8-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-8-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:01AM -0500, Brijesh Singh wrote:
> +static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
> +{
> +	bool no_rmpupdate;
> +	int rc;

From a previous review:

Please put over the opcode bytes line:

        /* "pvalidate" mnemonic support in binutils 2.36 and newer */

> +	asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFF\n\t"
> +		     CC_SET(c)
> +		     : CC_OUT(c) (no_rmpupdate), "=a"(rc)
> +		     : "a"(vaddr), "c"(rmp_psize), "d"(validate)
> +		     : "memory", "cc");
> +
> +	if (no_rmpupdate)
> +		return PVALIDATE_FAIL_NOUPDATE;
> +
> +	return rc;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

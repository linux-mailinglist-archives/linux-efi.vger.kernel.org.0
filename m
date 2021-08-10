Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E833E5923
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 13:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhHJLdU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 07:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhHJLdU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Aug 2021 07:33:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB0C0613D3;
        Tue, 10 Aug 2021 04:32:58 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d650032ff4b0dbb793dda.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6500:32ff:4b0d:bb79:3dda])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 124861EC0345;
        Tue, 10 Aug 2021 13:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628595170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=R0Bn+dXKzaBou1+W8ZeOwhmfqcSDNHnGnKGMW8DU+1o=;
        b=Flm+45n8y3Gtv+plIrS/FRcndJKdE24N1BwdLlt+khb4sM4nPfiJaI8pTzCJCrQgE26phx
        D+cVO7QxwpUFbuhBxXejG6qZ3AkJlIiTSvMrYvQRzKtD5dDIiK8EbnSKyeoCVsbX6EW2c8
        c81rM3/neP7P3s/3IznKD+Dekv/zL8o=
Date:   Tue, 10 Aug 2021 13:33:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 05/36] x86/sev: Define the Linux specific
 guest termination reasons
Message-ID: <YRJkDhcbUi9xQemM@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-6-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-6-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:35PM -0500, Brijesh Singh wrote:
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 23929a3010df..e75e29c05f59 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -63,9 +63,17 @@
>  	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
>  	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
>  
> +/* Error code from reason set 0 */

... Error codes...

> +#define SEV_TERM_SET_GEN		0
>  #define GHCB_SEV_ES_GEN_REQ		0
>  #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
>  
>  #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
>  
> +/* Linux specific reason codes (used with reason set 1) */

... Linux-specific ...

> +#define SEV_TERM_SET_LINUX		1

GHCB doc says:

"This document defines and owns reason code set 0x0"

Should it also say, reason code set 1 is allocated for Linux guest use?
I don't see why not...

Tom?

> +#define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
> +#define GHCB_TERM_PSC			1	/* Page State Change failure */
> +#define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
> +
>  #endif

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

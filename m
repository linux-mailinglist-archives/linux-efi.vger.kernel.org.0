Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7039C78F
	for <lists+linux-efi@lfdr.de>; Sat,  5 Jun 2021 12:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFEKy7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Jun 2021 06:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhFEKy7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Jun 2021 06:54:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69BC061766;
        Sat,  5 Jun 2021 03:53:11 -0700 (PDT)
Received: from zn.tnic (p4fed32f0.dip0.t-ipconnect.de [79.237.50.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2FC41EC01A2;
        Sat,  5 Jun 2021 12:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622890389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m4WFNDMn/F2hBFMtOb5KcbkKEA5fPujaJDdSpXTf3yI=;
        b=b9euwxNWNDPFTyr/DO+tkH5SKsRbrIAcUy0+u+Jvmj/u6fbpiZz9u3lFXvXcgwIemAcufI
        NyCxlLalL3M1NPfNHFgQhUWN/nBA/Vh8556EE5bzxFiKvpEO+aa9S/C6oi3V7LKg6VQ6eu
        Z/KRkDNbfBU2ttfxGH9aWiVrTQ//cn8=
Date:   Sat, 5 Jun 2021 12:50:53 +0200
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
Subject: Re: [PATCH Part1 RFC v3 04/22] x86/mm: Add sev_feature_enabled()
 helper
Message-ID: <YLtXDQHWnAvCl99M@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-5-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-5-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:03:58AM -0500, Brijesh Singh wrote:
> @@ -78,6 +85,7 @@ static inline void sev_es_init_vc_handling(void) { }
>  static inline bool sme_active(void) { return false; }
>  static inline bool sev_active(void) { return false; }
>  static inline bool sev_es_active(void) { return false; }
> +static inline bool sev_snp_active(void) { return false; }

Leftover from the previous version, can go.

> +bool sev_feature_enabled(unsigned int type)
> +{
> +	switch (type) {
> +	case SEV: return sev_status & MSR_AMD64_SEV_ENABLED;
> +	case SEV_ES: return sev_status & MSR_AMD64_SEV_ES_ENABLED;
> +	case SEV_SNP: return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
> +	default: return false;
> +	}
> +}

Yeah, btw, we might even do a generic one, see:

https://lkml.kernel.org/r/YLkcIuL2qvo0hviU@zn.tnic

and the following mail.

But that doesn't matter as sev_feature_enabled()'s body can go into
sev_protected_guest_has() or whatever we end up calling it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DCA39DFB8
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jun 2021 16:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhFGO4i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Jun 2021 10:56:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41070 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231503AbhFGO41 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Jun 2021 10:56:27 -0400
Received: from zn.tnic (p200300ec2f0b4f0010db370b6947fb68.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4f00:10db:370b:6947:fb68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 54EC81EC04CC;
        Mon,  7 Jun 2021 16:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623077674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DkskgYhv3CpcRt1UBQdVga8YOE910b/AK0zkqCeMk5Q=;
        b=B2WSbbvqp4seSrpi84QxtYgx7pE62m2aoNK9Z7GTfQ7mrnKEVj/yNCeFXxev9C2iGtC/O9
        hPxvkFgHhKZVdFwdXW1vGsA7BRlvbo32+Yj4opf1oUGwt9PiLczI17X425rx4GrGI5RqqL
        W1IWDPcZ1ymoTrJQao4ERgbBhxDRfYg=
Date:   Mon, 7 Jun 2021 16:54:29 +0200
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
Subject: Re: [PATCH Part1 RFC v3 06/22] x86/sev: check SEV-SNP features
 support
Message-ID: <YL4zJT1v6OuH+tvI@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-7-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-7-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:00AM -0500, Brijesh Singh wrote:
>  static bool early_setup_sev_es(void)

This function is doing SNP init now too, so it should be called
something generic like

	do_early_sev_setup()

or so.

>  #define GHCB_SEV_ES_GEN_REQ		0
>  #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
> +#define GHCB_SEV_ES_SNP_UNSUPPORTED	2

GHCB_SNP_UNSUPPORTED

> +static bool __init sev_snp_check_hypervisor_features(void)

check_hv_features()

is nice and short.

> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 77a754365ba9..9b70b7332614 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -609,6 +609,10 @@ static bool __init sev_es_setup_ghcb(void)

Ditto for this one: setup_ghcb()

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

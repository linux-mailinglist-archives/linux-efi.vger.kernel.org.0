Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39F3AC2EB
	for <lists+linux-efi@lfdr.de>; Fri, 18 Jun 2021 07:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhFRFtA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Jun 2021 01:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhFRFs7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Jun 2021 01:48:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF98C061574;
        Thu, 17 Jun 2021 22:46:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0dd800c1c0f109d0ca36f4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d800:c1c0:f109:d0ca:36f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 739671EC054F;
        Fri, 18 Jun 2021 07:46:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623995209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Z2NcsQEXbnE2U0G6jQczPtJMf0zCLQ336536FRXg81M=;
        b=gf8n4odDGWXwGJEBtSR/Ph2wRe/dCxc/qC6TznTV/wZrAPIanM6DBG6ZnaRQcHTW2w7jNL
        7X76OBMJf6LrsqYa+IVNSsAA0wJdWACrEla2WhdlZQLbax/a9Joo5Vv5xqQ+MarhLrZCi2
        E5aBSMueO9iMceLUivF9j6PX26bQGqo=
Date:   Fri, 18 Jun 2021 07:46:38 +0200
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
Message-ID: <YMwzPjV9s/6qW75m@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-7-brijesh.singh@amd.com>
 <YL4zJT1v6OuH+tvI@zn.tnic>
 <e617a0a1-bb8d-9d75-56a4-2ac1138ebf8b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e617a0a1-bb8d-9d75-56a4-2ac1138ebf8b@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 17, 2021 at 01:46:08PM -0500, Brijesh Singh wrote:
> Based on your feedback on AP creation patch to not use the accessors, I am inclined to
> remove this helper and have the caller directly check the feature bit, is that okay ?
> 
> something like:
> 
> if (sev_snp_enabled() && !(hv_features & GHCB_HV_FT_SNP))
> 	sev_es_terminate(GHCB_SNP_UNSUPPORTED);
> 
> Let me know if you think I should still keep the accessors.

Yeah, looks about right. Let's keep hv_features in a sev-specific
header so that there are no name clashes. Or maybe we should call it
sev_hv_features since it is going to be read-only anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

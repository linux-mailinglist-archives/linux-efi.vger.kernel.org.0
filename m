Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEAF3A99DA
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 14:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhFPMFa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 08:05:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232164AbhFPMFY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Jun 2021 08:05:24 -0400
Received: from zn.tnic (p200300ec2f0c2b00ec25a986a17212ee.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2b00:ec25:a986:a172:12ee])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3BAEE1EC03E4;
        Wed, 16 Jun 2021 14:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623844996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qK3Y1DHOt57Qig7xfqZFQT3ydoFk9JaEiyImUpf/4h4=;
        b=mPkX1WjdJx43H98yJ0xojjxpLkY44F46gfmAvHgRhvQxPBJMGtuYOk9hA3L8aJwckyEYjZ
        5rQCCG8gEnwy45fVBV3wv3aILo7Xjvo6F5qham5jpiWltLR6fF3pok4WGqWjxdq/L0DgZ2
        ArwOn584uWA7wywbnefvHhDirxUBCUM=
Date:   Wed, 16 Jun 2021 14:03:05 +0200
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
Subject: Re: [PATCH Part1 RFC v3 11/22] x86/sev: Add helper for validating
 pages in early enc attribute changes
Message-ID: <YMnoeRcuMfAqX5Vf@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-12-brijesh.singh@amd.com>
 <YMI02+k2zk9eazjQ@zn.tnic>
 <d0759889-94df-73b0-4285-fa064eb187cd@amd.com>
 <YMen5wVqR31D/Q4z@zn.tnic>
 <70db789d-b1aa-c355-2d16-51ace4666b3f@amd.com>
 <YMnNYNBvEEAr5kqd@zn.tnic>
 <f7e70782-701c-13dd-43d2-67c92f8cf36f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7e70782-701c-13dd-43d2-67c92f8cf36f@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 16, 2021 at 06:00:09AM -0500, Brijesh Singh wrote:
> I am trying to be consistent with previous VMGEXIT implementations. If
> the command itself failed then use the command specific error code to
> tell hypervisor why we terminated but if the hypervisor violated the
> GHCB specification then use the "general request termination".

I feel like we're running in circles here: I ask about debuggability
and telling the user what exactly failed and you're giving me some
explanation about what the error codes mean. I can see what they mean.

So let me try again:

Imagine you're a guest owner and you haven't written the SNP code and
you don't know how it works.

You start a guest in the public cloud and it fails because the
hypervisor violates the GHCB protocol and all that guest prints before
it dies is

"general request termination"

How are you - the guest owner - going to find out what exactly happened?

Call support?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

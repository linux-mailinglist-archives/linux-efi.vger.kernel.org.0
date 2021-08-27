Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C803F9E95
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 20:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhH0SNg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 14:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhH0SNf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Aug 2021 14:13:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BB6C061757;
        Fri, 27 Aug 2021 11:12:46 -0700 (PDT)
Received: from zn.tnic (p200300ec2f111700cf40790d4c46ba75.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:cf40:790d:4c46:ba75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 027621EC0464;
        Fri, 27 Aug 2021 20:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630087961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Hlz/5VHRXOfPhVFm7WimoCOj8La+rdAhYJDH4ZFMWbQ=;
        b=NZddcriKO1PUvMjPs2tFF605PavVOcGKBCU1BA3MnkZVTgbB73hIPgsXYXdschIR7S1+Lp
        kdQm5Rj6pCwGGqj0B7lkK3xZ8+th3EqnXfpKqYdxuO+fi1SoVcKXs4VB9adfV8G52RawXN
        N51VO5jyxZpg3mFRIWfHvwPWB/6fKwY=
Date:   Fri, 27 Aug 2021 20:13:17 +0200
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
Subject: Re: [PATCH Part1 v5 33/38] x86/sev: Provide support for SNP guest
 request NAEs
Message-ID: <YSkrPXLqg38txCqp@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-34-brijesh.singh@amd.com>
 <YSkkaaXrg6+cnb9+@zn.tnic>
 <4acd17bc-bdb0-c4cc-97af-8842f8836c8e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4acd17bc-bdb0-c4cc-97af-8842f8836c8e@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 01:07:59PM -0500, Brijesh Singh wrote:
> Okay, works for me. The main reason why I choose the enum was to not
> expose the GHCB exit code to the driver

Why does that matter?

> but I guess that attestation driver need to know which VMGEXIT need to
> be called, so, its okay to have it pass the VMGEXIT number instead of
> enum.

Well, they're in an uapi header - can't be more public than that. :-)

> So far most of the changes were in x86 specific files. However, the
> attestation service is available through a driver to the userspace. The
> driver needs to use the VMGEXIT routines provides by the x86 core. I
> created the said header file so that driver does not need to include
> <asm/sev.h/sev-common.h> etc and will compile for !x86.

Lemme ask my question again:

Is SNP available on something which is !x86, all of a sudden?

Why would you want to compile that driver on anything but x86?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

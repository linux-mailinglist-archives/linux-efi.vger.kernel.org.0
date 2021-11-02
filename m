Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32374435E7
	for <lists+linux-efi@lfdr.de>; Tue,  2 Nov 2021 19:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhKBSrB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Nov 2021 14:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhKBSrB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Nov 2021 14:47:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2186EC061714;
        Tue,  2 Nov 2021 11:44:26 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1dc300e1073f755e7fce47.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:c300:e107:3f75:5e7f:ce47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4195F1EC0295;
        Tue,  2 Nov 2021 19:44:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635878664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AxuOw0DQ4Frl9MECG8Kper8H3T3XmCRerq6iet0JTvg=;
        b=fnDosBtZdhTQHutSgr1/+RABVQIrAbm94J935ajx4Z9Kisycu7UocDnt8PckwIj3n3lTJx
        BI19SipB4tqJQJUImPbytZWTapJ9GIoEiP27NptNIzkc92S11oTGUZeyuZe08xinQ4Gf7N
        AyTH+RF5Fl4D+tugIqEWI0IxA6rfSSU=
Date:   Tue, 2 Nov 2021 19:44:18 +0100
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 14/42] x86/sev: Register GHCB memory when SEV-SNP is
 active
Message-ID: <YYGGv6EtWrw7cnLA@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-15-brijesh.singh@amd.com>
 <YYFs+5UUMfyDgh/a@zn.tnic>
 <aea0e0c8-7f03-b9db-3084-f487a233c50b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aea0e0c8-7f03-b9db-3084-f487a233c50b@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 02, 2021 at 01:24:01PM -0500, Brijesh Singh wrote:
> To answer your question, GHCB is registered at the time of first #VC
> handling by the second exception handler.

And this is what I don't like - register at use. Instead of init
everything *before* use.

> Mike can correct me, the CPUID page check is going to happen on first
> #VC handling inside the early exception handler (i.e case 1).

What is the "CPUID page check"?

And no, you don't want to do any detection when an exception happens -
you want to detect *everything* *first* and then do exceptions.

> See if my above explanation make sense. Based on it, I don't think it
> makes sense to register the GHCB during the CPUID page detection. The
> CPUID page detection will occur in early VC handling.

See above. If this needs more discussion, we can talk on IRC.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

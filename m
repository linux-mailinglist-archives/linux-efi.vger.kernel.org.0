Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F386443413
	for <lists+linux-efi@lfdr.de>; Tue,  2 Nov 2021 17:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhKBQ5M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Nov 2021 12:57:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52284 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234954AbhKBQ5F (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 2 Nov 2021 12:57:05 -0400
Received: from zn.tnic (p200300ec2f0f6200599060f0a067c463.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6200:5990:60f0:a067:c463])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46E391EC0532;
        Tue,  2 Nov 2021 17:54:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635872069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XRnIinnL4tOnsAL/GsMC8vW8ZfXO/hpxLuI1GtroUw0=;
        b=MkIi5voWdAAqnJnlNQK6bNu9R7cztziHTaU/XPDf0ZKy0BqKKb1BQ3RuzDIFFXHy9EJP83
        lb8sQGtpdAFvET5XpRXx283CSabxdd1se7RVnQ+RMaimeIJVnDCNa3vkNqD8JkEkKV3iVn
        j67HJZb2nQ1KtMFypPkKcJjVwQmjdIA=
Date:   Tue, 2 Nov 2021 17:54:29 +0100
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
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v6 15/42] x86/sev: Remove do_early_exception() forward
 declarations
Message-ID: <YYFtRfdSEtjRI15D@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-16-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008180453.462291-16-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 08, 2021 at 01:04:26PM -0500, Brijesh Singh wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> There's a perfectly fine prototype in the asm/setup.h header. Use it.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Right, for the next and all future submissions, it is a lot easier if
you put all fixes and cleanups and code reorganizations at the beginning
of the patchset. Because then they can simply get applied earlier -
they're useful cleanups and fixes, after all - and this way you'll
unload some of the patches quicker and have to deal with a smaller set.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

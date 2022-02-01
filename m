Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159094A5CBD
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbiBANCs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:02:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42684 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238302AbiBANCr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 1 Feb 2022 08:02:47 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E351A1EC0441;
        Tue,  1 Feb 2022 14:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643720562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V45qKhsa32BToHgvxiyQ7/0biiBqQBIo5RIp2z/c1p0=;
        b=hKosanF82+uCnGcQ+cjuuUazkNmbqTKV0RwM8q/n3i2L7GrV3rzW6Jvlc7koykyvxaGdoe
        4DhBNSdnJ0OFIZf1gE3H92X2xe+ExK5J9QAtuzmFjWGoF47/GtFsrsfO5Y6vfU073i/9xa
        2SjcG/IcbeXeV6ocK0yqwXwA2QqceUs=
Date:   Tue, 1 Feb 2022 14:02:42 +0100
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
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: Re: [PATCH v9 02/43] KVM: SVM: Create a separate mapping for the
 SEV-ES save area
Message-ID: <YfkvchuxmkHgnPWT@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-3-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-3-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:23AM -0600, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> The save area for SEV-ES/SEV-SNP guests, as used by the hardware, is
> different from the save area of a non SEV-ES/SEV-SNP guest.
> 
> This is the first step in defining the multiple save areas to keep them
> separate and ensuring proper operation amongst the different types of
> guests. Create an SEV-ES/SEV-SNP save area and adjust usage to the new
> save area definition where needed.
> 
> Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/svm.h | 87 +++++++++++++++++++++++++++++---------
>  arch/x86/kvm/svm/sev.c     | 24 +++++------
>  arch/x86/kvm/svm/svm.h     |  2 +-
>  3 files changed, 80 insertions(+), 33 deletions(-)

https://lore.kernel.org/r/Yc2jzOunYej4vwSc@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

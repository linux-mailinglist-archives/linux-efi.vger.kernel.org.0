Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2C428D9F
	for <lists+linux-efi@lfdr.de>; Mon, 11 Oct 2021 15:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhJKNRZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Oct 2021 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbhJKNRY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Oct 2021 09:17:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96466C061570;
        Mon, 11 Oct 2021 06:15:24 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08bb00608dded251e09f1b.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:bb00:608d:ded2:51e0:9f1b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 161DB1EC01B7;
        Mon, 11 Oct 2021 15:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633958123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jCMoAF/G6nShUACG0ht2kXTNSZwdTajCxjyuJX54Kmg=;
        b=YYMwvqngYlD0Vfggl3CGG7j1wno7aGftVm86pVdEvkTAF2WXsZE2p2el+RlGwnWjVc0fby
        GquYSnZklcwTHOg48URxTs3OP3g5iMplqm4VaBPmavEfPooaN4YjC5+G+/LTjCr6nO4Gqc
        kGH+HsmjZ5ZCvNsQqE25noSASoHWfvA=
Date:   Mon, 11 Oct 2021 15:15:23 +0200
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
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: Re: [PATCH v6 02/42] x86/sev: Shorten GHCB terminate macro names
Message-ID: <YWQ4694RuZUY3TaU@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-3-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008180453.462291-3-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 08, 2021 at 01:04:13PM -0500, Brijesh Singh wrote:

Yeah, let's add a trivial commit message here anyway:

<-- "Shorten macro names for improved readability."

> Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c    | 6 +++---
>  arch/x86/include/asm/sev-common.h | 4 ++--
>  arch/x86/kernel/sev-shared.c      | 2 +-
>  arch/x86/kernel/sev.c             | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

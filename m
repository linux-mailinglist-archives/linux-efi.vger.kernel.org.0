Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8172C44D9B7
	for <lists+linux-efi@lfdr.de>; Thu, 11 Nov 2021 17:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhKKQEK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Nov 2021 11:04:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51942 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233892AbhKKQEJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 11 Nov 2021 11:04:09 -0500
Received: from zn.tnic (p200300ec2f0fc200d3d8f5bf79794a84.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:c200:d3d8:f5bf:7979:4a84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 800E11EC053B;
        Thu, 11 Nov 2021 17:01:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636646477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FihBinBXkmNsh/IjwJSIBgx3D9wIrdak+y0L6vgJ/u4=;
        b=fs5b6zP+d1kZmnUut+527UHIxCkQRdFynFL9NnNX5IlId8yKaHDDR2MuaWoqInPJyK5MFG
        F4mYQRQg+H1m4kYKEYTJbq00Rv9lXzrAxRo9fKZRaAotC6UWYzyI86ktY6JGJR7XvjjL6v
        3YXE5wOwzMWeuQY+rQP060MkjmrrdCU=
Date:   Thu, 11 Nov 2021 17:01:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
Subject: Re: [PATCH v6 19/42] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <YY0+RfjPDCzC2udP@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-20-brijesh.singh@amd.com>
 <YYrNL7U07SxeUQ3E@zn.tnic>
 <4ea63467-3869-b6f5-e154-d70d1033135b@amd.com>
 <YYwS74PbHfNuAGQ7@zn.tnic>
 <50283b5a-3876-db91-da99-b95a4e8e0fb5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50283b5a-3876-db91-da99-b95a4e8e0fb5@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 11, 2021 at 08:49:49AM -0600, Tom Lendacky wrote:
> 2032 => sizeof(ghcb->shared_buffer) ?

Or that.

> The idea is that a full snp_psc_desc structure is meant to fit completely in
> the shared_buffer area. So if there are no compile time checks, then the
> code on the HV side will need to ensure that the input doesn't cause the HV
> to access the structure outside of the shared_buffer area - which, IIRC, it
> does (think protect against a malicious guest), so the min_t() on the memcpy
> should be safe on the guest side.
> 
> But given the snp_psc_desc is sized/meant to fit completely in the
> shared_buffer, a compile time check would be a good idea, too, right?

If the desc thing is meant to fit, then a compile-time check is also a
good way to express that intention. So yeah.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

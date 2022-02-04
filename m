Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA864A9CD9
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 17:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiBDQWB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 11:22:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54150 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbiBDQWB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Feb 2022 11:22:01 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 918581EC064D;
        Fri,  4 Feb 2022 17:21:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643991715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=C3Aiz07fgWzpDuMjml0gbG/sKOww28AvWjFoDlVxnJA=;
        b=bzscTGd8iNT4OCAu004DCeFYPE77BetHF+Z3Y3dygBfQ17HjWzjsDA+abRsi/Cq94sM42w
        DaBD7U/xgfvsktQzKLAEHnMUsbJ4QEjn4EcQKkGeyiknG9PKQ7Ue/c7D/3e/V1xDmoTRyE
        zamWAsnXmQ6R085hO5Os2nfNz0H65C0=
Date:   Fri, 4 Feb 2022 17:21:51 +0100
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
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 29/43] x86/boot: Add Confidential Computing type to
 setup_data
Message-ID: <Yf1Sn4AdPgIzpih9@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-30-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-30-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:50AM -0600, Brijesh Singh wrote:
> +/*
> + * AMD SEV Confidential computing blob structure. The structure is
> + * defined in OVMF UEFI firmware header:
> + * https://github.com/tianocore/edk2/blob/master/OvmfPkg/Include/Guid/ConfidentialComputingSevSnpBlob.h

So looking at that typedef struct CONFIDENTIAL_COMPUTING_SNP_BLOB_LOCATION there:

typedef struct {
  UINT32    Header;
  UINT16    Version;
  UINT16    Reserved1;
  UINT64    SecretsPhysicalAddress;
  UINT32    SecretsSize;
  UINT64    CpuidPhysicalAddress;
  UINT32    CpuidLSize;
} CONFIDENTIAL_COMPUTING_SNP_BLOB_LOCATION;

> + */
> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
> +struct cc_blob_sev_info {
> +	u32 magic;

That's called "Header" there.

> +	u16 version;
> +	u16 reserved;
> +	u64 secrets_phys;
> +	u32 secrets_len;
> +	u32 rsvd1;

You've added that member for padding but the fw blob one doesn't have
it.

But if we get a blob from the firmware and the structure layout differs,
how is this supposed to even work?

> +	u64 cpuid_phys;
> +	u32 cpuid_len;
> +	u32 rsvd2;

That one too.

Or are you going to change the blob layout in ovmf too, to match?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

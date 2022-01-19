Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58555493AB0
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jan 2022 13:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244288AbiASMz5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jan 2022 07:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiASMz4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Jan 2022 07:55:56 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E5C061574;
        Wed, 19 Jan 2022 04:55:55 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D72F91EC0373;
        Wed, 19 Jan 2022 13:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642596950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9NkeC38NDHwqMNmxnwshSdaG9bUxrwB91bS9TAMfKIo=;
        b=mvKNWpbjdzVyfWHExAFnc1xVkLATCq/T1K8CYTEeU6EwlfTl9kSRmHZYPFhwrMLQttQYgY
        6rwufaIxMOl+zcMlA5jrKc8lXE6+rzNAwnTFN8xA2JqegyVg3ba9ZHrP6RrFQxQTGUxiDg
        kgxZ7yzL+s2twDYiUNBTluU/8XLV2mA=
Date:   Wed, 19 Jan 2022 13:55:43 +0100
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
Subject: Re: [PATCH v8 31/40] x86/compressed: add SEV-SNP feature
 detection/setup
Message-ID: <YegKTxXHDSSh5xHl@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-32-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-32-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:23AM -0600, Brijesh Singh wrote:
> +/*
> + * TODO: These are exported only temporarily while boot/compressed/sev.c is
> + * the only user. This is to avoid unused function warnings for kernel/sev.c
> + * during the build of kernel proper.
> + *
> + * Once the code is added to consume these in kernel proper these functions
> + * can be moved back to being statically-scoped to units that pull in
> + * sev-shared.c via #include and these declarations can be dropped.
> + */
> +struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp);

You don't need any of that - just add the function with the patch which
uses it.

> +/*
> + * Search for a Confidential Computing blob passed in as a setup_data entry
> + * via the Linux Boot Protocol.
> + */
> +struct cc_blob_sev_info *
> +snp_find_cc_blob_setup_data(struct boot_params *bp)

Please break lines like that only if absolutely necessary. Which doesn't
look like it here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

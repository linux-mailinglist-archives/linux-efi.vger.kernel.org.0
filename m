Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4859F4A2EA8
	for <lists+linux-efi@lfdr.de>; Sat, 29 Jan 2022 13:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiA2MC1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Jan 2022 07:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiA2MC1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Jan 2022 07:02:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1DCC061714;
        Sat, 29 Jan 2022 04:02:26 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2BF4B1EC01B7;
        Sat, 29 Jan 2022 13:02:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643457741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1SqI9kGrSv75+nJPwZYKxkcTL83Vduz6X2Q74CD9Idc=;
        b=cpPOiblw8z2FwDfVV+8Cx0gJBEZNMWEIsqxMvsZI45g70BBWrD1cdgvk7WcuViGnXEW3Zt
        w2dBeSBqEsUj1PwAVsBYj3Ix9UfYnGw4OVtjeo9/YFKg83b4EBpejQM5Gk0DJD94L1MujC
        KQyEa3QGcWGmbyjQjsI3rua5JaZbDeo=
Date:   Sat, 29 Jan 2022 13:02:18 +0100
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
Subject: Re: [PATCH v8 36/40] x86/sev: Provide support for SNP guest request
 NAEs
Message-ID: <YfUsygRVgPCrUvFX@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-37-brijesh.singh@amd.com>
 <YfLGcp8q5f+OW72p@zn.tnic>
 <87d4999a-14cc-5070-4f03-001dd5f1d2b1@amd.com>
 <YfUWgeonL4tfGf8P@zn.tnic>
 <fb90b0a5-a8cf-0c94-ebbe-a0d5343fe3b9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb90b0a5-a8cf-0c94-ebbe-a0d5343fe3b9@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jan 29, 2022 at 05:49:06AM -0600, Brijesh Singh wrote:
> The hypervisor must validate that the guest has supplied enough pages to
> hold the certificates that will be returned before performing the SNP
> guest request. If there are not enough guest pages to hold the
> certificate table and certificate data, the hypervisor will return the
> required number of pages needed to hold the certificate table and
> certificate data in the RBX register and set the SW_EXITINFO2 field to
> 0x0000000100000000.

Then you could call that one:

#define SNP_GUEST_REQ_ERR_NUM_PAGES       BIT_ULL(32)

or so, to mean what exactly that error is. Because when you read the
code, it is more "self-descriptive" this way:

	...
	ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_ERR_NUM_PAGES)
		input->data_npages = ghcb_get_rbx(ghcb);

> It does not spell it as invalid length. However, for *similar* failure,
> the SEV-SNP spec spells out it as INVALID_LENGTH, so, I choose macro
> name as INVALID_LENGTH.

You can simply define a separate one here called ...INVALID_LENGTH.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

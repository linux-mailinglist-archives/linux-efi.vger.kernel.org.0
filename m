Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0084C8880
	for <lists+linux-efi@lfdr.de>; Tue,  1 Mar 2022 10:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiCAJtA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Mar 2022 04:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiCAJs7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Mar 2022 04:48:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9760342A17;
        Tue,  1 Mar 2022 01:48:18 -0800 (PST)
Received: from nazgul.tnic (dynamic-002-247-255-128.2.247.pool.telefonica.de [2.247.255.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D0F961EC053F;
        Tue,  1 Mar 2022 10:48:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646128093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+RtOrO/V2Xe6RcjueTstlwPFpZ/tJZ3H1GqzoLfZj+A=;
        b=OPbNuA9icMYBNiferdOC7ortcT5oZV9YAZskyMI7sFPTGqS8LEmY5QpfDR9THz/YxPWsFF
        inqKgkiWexXbOIrklEPVbvjnazRVt0Nos7EYErANwlPbl7Wqq2Jmwfp1Z4k+GL1YVv6wmn
        wPXeKMLtkxReL6gHIl8+ZGMbAzjzEcE=
Date:   Tue, 1 Mar 2022 10:48:16 +0100
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 29/45] x86/boot: Add Confidential Computing type to
 setup_data
Message-ID: <Yh3r1PSx/fjqoBB3@nazgul.tnic>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-30-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224165625.2175020-30-brijesh.singh@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 24, 2022 at 10:56:09AM -0600, Brijesh Singh wrote:
> +/*
> + * AMD SEV Confidential computing blob structure. The structure is
> + * defined in OVMF UEFI firmware header:
> + * https://github.com/tianocore/edk2/blob/master/OvmfPkg/Include/Guid/ConfidentialComputingSevSnpBlob.h
> + */
> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
> +struct cc_blob_sev_info {
> +	u32 magic;
	^^^^^^^^^^^^

You said you wanted to rename this:

https://lore.kernel.org/all/12b945a0-b18c-7f2a-52c7-5e22a944d7f5@amd.com/

and further code is checking magic so I'm guessing you wanna rename the
OVMF definition to "Magic" too?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

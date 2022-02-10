Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC24B136C
	for <lists+linux-efi@lfdr.de>; Thu, 10 Feb 2022 17:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244799AbiBJQtE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Feb 2022 11:49:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244818AbiBJQtB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Feb 2022 11:49:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F95E87;
        Thu, 10 Feb 2022 08:48:59 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FBA21EC05DD;
        Thu, 10 Feb 2022 17:48:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644511733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nkwdvv/kN4X+IUhmjyxPM+gWIWhdYINS6ChexlWbNOI=;
        b=arLbkOX2S7ry/YFU6kZeY6npGAVqVq1czzxbl6Wg3TeXcm/yLbTXBtO0kpBPLau3TR8IRL
        C1bHBb8f4K4p/UXHzOWeMiXb31DiA221T/eEqZ1tyzLSmbyajDlsAJaCg/NFezPoi0TNfR
        lSxt6sAQAeC+Yx4YlN0cZnq7X7/nx2o=
Date:   Thu, 10 Feb 2022 17:48:55 +0100
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
Subject: Re: [PATCH v10 21/45] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <YgVB94suNJLjzalt@zn.tnic>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
 <20220209181039.1262882-22-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209181039.1262882-22-brijesh.singh@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 09, 2022 at 12:10:15PM -0600, Brijesh Singh wrote:
> The set_memory_{encrypted,decrypted}() are used for changing the pages
> from decrypted (shared) to encrypted (private) and vice versa.
> When SEV-SNP is active, the page state transition needs to go through
> additional steps done by the guest.
> 
> If the page is transitioned from shared to private, then perform the
> following after the encryption attribute is set in the page table:
> 
> 1. Issue the page state change VMGEXIT to add the memory region in
>    the RMP table.
> 2. Validate the memory region after the RMP entry is added.
> 
> To maintain the security guarantees, if the page is transitioned from
> private to shared, then perform the following before encryption attribute
> is removed from the page table:
> 
> 1. Invalidate the page.
> 2. Issue the page state change VMGEXIT to remove the page from RMP table.
> 
> To change the page state in the RMP table, use the Page State Change
> VMGEXIT defined in the GHCB specification.
> 
> The GHCB specification provides the flexibility to use either 4K or 2MB
> page size in during the page state change (PSC) request. For now use the
> 4K page size for all the PSC until RMP page size tracking is supported
> in the kernel.

This commit message sounds familiar because I've read it before - patch
18 - and it looks copied. So I've turned into a simple one which says it
all:

    x86/mm: Validate memory when changing the C-bit

    Add the needed functionality to change pages state from shared
    to private and vice-versa using the Page State Change VMGEXIT as
    documented in the GHCB spec.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

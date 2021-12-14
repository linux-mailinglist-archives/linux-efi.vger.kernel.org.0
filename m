Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C078474DD9
	for <lists+linux-efi@lfdr.de>; Tue, 14 Dec 2021 23:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhLNWWO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Dec 2021 17:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhLNWWN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Dec 2021 17:22:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AAAC061574;
        Tue, 14 Dec 2021 14:22:13 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91C911EC01DF;
        Tue, 14 Dec 2021 23:22:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639520526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4lAn1SgoaQ1GQMFyEB3G1ncclFpElzPMf3D4eKuDSGY=;
        b=pCtYT2MDftEdrpgfR/bI7xUtD+qQqvVvfVLlmTmyVaSvlV9cfrWdIwuhHRTlWGS6D1nZw5
        K6vPAo1KUakfb8YJc8xUNim5rLZM7SjqEBv0YqBFEquAwAC/L4fe/dxGUKjlcm5qcpuPHC
        d+yBE0ofNvjd+CCmkMCrVza1mZ31R2U=
Date:   Tue, 14 Dec 2021 23:22:08 +0100
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
Subject: Re: [PATCH v8 04/40] x86/sev: Define the Linux specific guest
 termination reasons
Message-ID: <YbkZEJ/R3rLcLkJ2@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-5-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-5-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:42:56AM -0600, Brijesh Singh wrote:
> GHCB specification defines the reason code for reason set 0. The reason
> codes defined in the set 0 do not cover all possible causes for a guest
> to request termination.
> 
> The reason set 1 to 255 is reserved for the vendor-specific codes.
> Reseve the reason set 1 for the Linux guest. Define an error codes for

Yah, your spellchecker is still broken:

Reseve the reason set 1 for the Linux guest. Define an error codes for
Unknown word [Reseve] in commit message, suggestions:
        ['Reeves', 'Reeve', 'Reserve', 'Res eve', 'Res-eve', 'Severe', 'Reverse', 'Sevres', 'Revers']

> reason set 1.

"... and use them in the Linux guest so that one can have meaningful
termination reasons and thus better guest failure diagnosis."

The *why* is very important.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

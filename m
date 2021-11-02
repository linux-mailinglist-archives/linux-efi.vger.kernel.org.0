Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620684432E3
	for <lists+linux-efi@lfdr.de>; Tue,  2 Nov 2021 17:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhKBQjC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Nov 2021 12:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhKBQir (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Nov 2021 12:38:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E668C0432EE;
        Tue,  2 Nov 2021 09:33:55 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f6200599060f0a067c463.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6200:5990:60f0:a067:c463])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D3CBB1EC054E;
        Tue,  2 Nov 2021 17:33:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635870833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LgqrmB8sgbt0GGy55Ij0lvUle6j2/wn+2sw2xrp27AY=;
        b=j3LUENcqI26r8HYNZ8BSLpWqVpyY8aYCrXHrPKvlogaZlwvSZm2zRXcKwf082+ljUp5vPc
        Ii8rUxK3c19CcxhFAROclfd+fe0dxmegzWMDzMMuXAbAXoE4wFPchiOd9EwxwJ3FJiy0Nu
        2gFxYxzea53lDkOWUG92mFHUqAT+Glg=
Date:   Tue, 2 Nov 2021 17:33:52 +0100
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
Subject: Re: [PATCH v6 13/42] x86/compressed: Register GHCB memory when
 SEV-SNP is active
Message-ID: <YYFocEczs9F+evkx@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-14-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008180453.462291-14-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 08, 2021 at 01:04:24PM -0500, Brijesh Singh wrote:
> The SEV-SNP guest is required to perform GHCB GPA registration. This is

Let's write that out and make this more readable for outsiders too:

"... is required by the GHCB spec to register the GHCB's Guest Physical
Address (GPA)."

> because the hypervisor may prefer that a guest use a consistent and/or
> specific GPA for the GHCB associated with a vCPU. For more information,
> see the GHCB specification.

Giving a section in that spec would be helpful.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

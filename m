Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA648D776
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jan 2022 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiAMMXQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jan 2022 07:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbiAMMXP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jan 2022 07:23:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8CDC06173F;
        Thu, 13 Jan 2022 04:23:14 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30C3B1EC0354;
        Thu, 13 Jan 2022 13:23:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642076589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSIneQvlEfcmrMcVzDlxcrsF8+nqvT9Jh6DkVwdCzrA=;
        b=cq+9aHgIPMYctMdnzPQ+/D2NhDsGzNGfpwrvUlPdeu0XuQFdWUtnYjQcJM5BkOxvzqnq+G
        Dvh4pQSdC8f4/AdMu1LZ94SZ+NK7+UrkduRbnrOH9SKY2ljaCt9YkKaaHKpNdoDctFH7P5
        9mYhNMEiLS0lYNIBc7ChQXHALpLbfOc=
Date:   Thu, 13 Jan 2022 13:23:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 20/40] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
Message-ID: <YeAZtLFuRijGg6xP@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-21-brijesh.singh@amd.com>
 <Yc8jerEP5CrxfFi4@zn.tnic>
 <75c0605f-7ed0-abcc-4855-dae5d87d0861@amd.com>
 <346da2f7-220f-83bd-2dbf-29e681fc089b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <346da2f7-220f-83bd-2dbf-29e681fc089b@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 12, 2022 at 11:10:04AM -0600, Tom Lendacky wrote:
> On 1/12/22 10:33 AM, Brijesh Singh wrote:
> > On 12/31/21 9:36 AM, Borislav Petkov wrote:
> > > On Fri, Dec 10, 2021 at 09:43:12AM -0600, Brijesh Singh wrote:
> 
> > > > +     * an attempt was done to use the current VMSA with a running vCPU, a
> > > > +     * #VMEXIT of that vCPU would wipe out all of the settings being done
> > > > +     * here.
> > > 
> > > I don't understand - this is waking up a CPU, how can it ever be a
> > > running vCPU which is using the current VMSA?!
> 
> Yes, in general. My thought was that nothing is stopping a malicious
> hypervisor from performing a VMRUN on that vCPU and then the VMSA would be
> in use.

Ah, that's what you mean.

Ok, please extend that comment with it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

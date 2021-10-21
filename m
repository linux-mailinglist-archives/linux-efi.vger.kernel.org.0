Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20AB4366E7
	for <lists+linux-efi@lfdr.de>; Thu, 21 Oct 2021 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhJUP6d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Oct 2021 11:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJUP6b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 21 Oct 2021 11:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634831775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZmeI+xNFSQkhhEf0UgyyM+rZSNNUl4FvcDPA0Dfsy8Y=;
        b=i8Bza+4jxQHJonD0Mkxl+4SOPyXfH4zf5pUYv4K95dr22JR54Q2Tur8ePXKM4sF+nNNLx6
        kMC4XZglQZMLDTk301rXSTbuCa8VYeUh+Pdj+gT8OcsV61zUyhYlDkcUrf7jITwfCBCRqC
        XeBCO1B6GWWK46uzZgqOjqxhFGNQ+g8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-e91IjkGCNL6jc0HBjFXQlg-1; Thu, 21 Oct 2021 11:56:14 -0400
X-MC-Unique: e91IjkGCNL6jc0HBjFXQlg-1
Received: by mail-wm1-f69.google.com with SMTP id l187-20020a1c25c4000000b0030da46b76daso47598wml.9
        for <linux-efi@vger.kernel.org>; Thu, 21 Oct 2021 08:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZmeI+xNFSQkhhEf0UgyyM+rZSNNUl4FvcDPA0Dfsy8Y=;
        b=xPTbQowznSL4XIz6zUXGSnEPgnQs+ba1PocRK1s6G4PmLDQWAbmWCIiBh4Y0BRTJ7D
         icCM5xevlvT+3SORPveripl0sN230WdrK4cgBfcryjPlS2GnD4dFFsicdiuJkxJ6uN30
         6/zIAhq7N1CMGAWdk7HuWxZ1apdcvOy7LOxEg073FY7hW5hss7HE5cAnw+1qUaE7ORJq
         rPWGdixvaojA767FXnDM2R+eVlBu9bmHoYNZvt7iEUlvq2DXDHJbW/YoC89gmDjl0XDU
         7wu5KwJyq4kWTouIYtxd/9uJ5TLHUtP9kaPvgXzDb7TBmBScHo47G3eldqFVutnKj8LH
         pcZA==
X-Gm-Message-State: AOAM533w7WtiAAJvM5zfosivUc0bXL8ddlSsEjGmUCisaSbVh+uHoiSb
        AtbWAsj/5rVxbrEjp40bv1PCs+8kMdh5oEMiG2nQW2Nt0fdT+p3fWLtgoAC5Bl456dDq/3vu5P+
        PCBRhzFMWjWXCNSsb1vOV
X-Received: by 2002:adf:a38d:: with SMTP id l13mr8196981wrb.103.1634831773014;
        Thu, 21 Oct 2021 08:56:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/BOxtIRR/HebL6q5wYCsAEIdtnhPXy/FgcPBKoCIKwTHe4AeOvR2zv4dj1RexyLHkS2L7QA==
X-Received: by 2002:adf:a38d:: with SMTP id l13mr8196931wrb.103.1634831772775;
        Thu, 21 Oct 2021 08:56:12 -0700 (PDT)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id x8sm295768wrw.6.2021.10.21.08.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:56:12 -0700 (PDT)
Date:   Thu, 21 Oct 2021 16:56:09 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 08/42] x86/sev-es: initialize sev_status/features
 within #VC handler
Message-ID: <YXGNmeR/C33HvaBi@work-vm>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXF9sCbPDsLwlm42@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXF9sCbPDsLwlm42@zn.tnic>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Borislav Petkov (bp@alien8.de) wrote:
> On Wed, Oct 20, 2021 at 11:10:23AM -0500, Michael Roth wrote:
> > At which point we then switch to using the CPUID table? But at that
> > point all the previous CPUID checks, both SEV-related/non-SEV-related,
> > are now possibly not consistent with what's in the CPUID table. Do we
> > then revalidate?
> 
> Well, that's a tough question. That's basically the same question as,
> does Linux support heterogeneous cores and can it handle hardware
> features which get enabled after boot. The perfect example is, late
> microcode loading which changes CPUID bits and adds new functionality.
> 
> And the answer to that is, well, hard. You need to decide this on a
> case-by-case basis.

I can imagine a malicious hypervisor trying to return different cpuid
answers to different threads or even the same thread at different times.

> But isn't it that the SNP CPUID page will be parsed early enough anyway
> so that kernel proper will see only SNP CPUID info and init properly
> using that?
> 
> > Even a non-malicious hypervisor might provide inconsistent values
> > between the two sources due to bugs, or SNP validation suppressing
> > certain feature bits that hypervisor otherwise exposes, etc.
> 
> There's also migration, lemme point to a very recent example:
> 
> https://lore.kernel.org/r/20211021104744.24126-1-jane.malalane@citrix.com

Ewww.

> which is exactly what you say - a non-malicious HV taking care of its
> migration pool. So how do you handle that?

Well, the spec (AMD 56860 SEV spec) says:

  'If firmware encounters a CPUID function that is in the standard or extended ranges, then the
firmware performs a check to ensure that the provided output would not lead to an insecure guest
state'

so I take that 'firmware' to be the PSP; that wording doesn't say that
it checks that the CPUID is identical, just that it 'would not lead to
an insecure guest' - so a hypervisor could hide any 'no longer affected
by' flag for all the CPUs in it's migration pool and the firmware
shouldn't complain; so it should be OK to pessimise.

Dave

> > Now all the code after sme_enable() can potentially take unexpected
> > execution paths, where post-sme_enable() code makes assumptions about
> > pre-sme_enable() checks that may no longer hold true.
> 
> So as I said above, if you parse SNP CPUID page early enough, you don't
> have to worry about feature rediscovery. Early enough means, before
> identify_boot_cpu().
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86CB3B95D8
	for <lists+linux-efi@lfdr.de>; Thu,  1 Jul 2021 20:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGASGd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Jul 2021 14:06:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44848 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhGASGc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 1 Jul 2021 14:06:32 -0400
Received: from zn.tnic (p200300ec2f129e0080cb4010141c3d3f.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:9e00:80cb:4010:141c:3d3f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7547E1EC054E;
        Thu,  1 Jul 2021 20:04:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625162640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pA5qidpGRMz4iB462uPn953XJs14KjqFbjDwTnvDnKg=;
        b=OHT4NlQL9fVtGHXge2xZSd0T4EtBcQOmHUNmaE2UC612fKA/8lwfY5w8HH19skwww6/STE
        w59gY7ILIMMe0ZyN6jwbgjjR4zWs30kvUfgtbeBw73IN/ywKqCl1h2D8vx+XtIEcdzKNGg
        kS/Fvml/488FUBEJyM1T7mfITHlUCSg=
Date:   Thu, 1 Jul 2021 20:03:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Dov Murik <dovmurik@linux.ibm.com>
Subject: Re: [PATCH Part1 RFC v3 22/22] virt: Add SEV-SNP guest driver
Message-ID: <YN4DixahyShxyyCv@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-23-brijesh.singh@amd.com>
 <YNxzJ2I3ZumTELLb@zn.tnic>
 <46499161-0106-3ae9-9688-0afd9076b28b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46499161-0106-3ae9-9688-0afd9076b28b@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 30, 2021 at 11:26:46AM -0500, Brijesh Singh wrote:
> As you have noticed that Dov is submitting the SEV specific driver.

Well, reportedly that driver is generic-ish as it only handles the
EFI-provided sekrits and is not SEV-specific - the SEV use is only
exemplary.

> I was thinking that it will be nice if we have one driver that covers
> both the SEV and SEV-SNP. That driver can be called "sevguest". The
> kernel will install the appropriate platform device. The sevguest
> driver can probe for both the "sev-guest" and "snp-guest" and delegate
> the ioctl handling accordingly.
>
> In the kernel the directory structure may look like this:
>
> virt/coco/sevguest
>   sevguest.c       // common code
>   snp.c            // SNP specific ioctl implementation
>   sev.c            // SEV specific ioctl or sysfs implementation
> 
> Thoughts ?

Sure, but I'd call it sevguest.c and will have it deal with both SEV and
SNP ioctls depending on what has been detected in the hardware. Or is
there some special reason for having snp.c and sev.c separate?

> I followed the naming convension you recommended during the initial SEV driver
> developement. IIRC, the main reason for us having to add "user" in it because
> we wanted to distinguious that this structure is not exactly same as the what
> is defined in the SEV-SNP firmware spec.

I most definitely have forgotten about this. Can you point me to the
details of that discussion and why there's a need to distinguish?

> Good question, I am not able to find a generic place to document it. Should we
> create a documentation "Documentation/virt/coco/sevguest-api.rst" for it ? I am
> open to other suggestions.

Well, grepping the tree for "ioctl" I see:

Documentation/driver-api/ioctl.rst
Documentation/process/botching-up-ioctls.rst
Documentation/userspace-api/ioctl/cdrom.rst
Documentation/userspace-api/ioctl/hdio.rst
Documentation/userspace-api/ioctl/index.rst
Documentation/userspace-api/ioctl/ioctl-decoding.rst
Documentation/userspace-api/ioctl/ioctl-number.rst
Documentation/userspace-api/media/cec/cec-func-ioctl.rst
Documentation/userspace-api/media/mediactl/media-func-ioctl.rst
Documentation/userspace-api/media/mediactl/request-func-ioctl.rst
Documentation/userspace-api/media/v4l/func-ioctl.rst

and there's some good info as to what to do.

In any case, Documentation/virt/coco/sevguest-api.rst doesn't sound too
bad either, actually, as it collects everything under virt/

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

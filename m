Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945B43B1803
	for <lists+linux-efi@lfdr.de>; Wed, 23 Jun 2021 12:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFWKYv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Jun 2021 06:24:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45846 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFWKYv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Jun 2021 06:24:51 -0400
Received: from zn.tnic (p200300ec2f114b00a4a414805e84bac1.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4b00:a4a4:1480:5e84:bac1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F7B01EC0501;
        Wed, 23 Jun 2021 12:22:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624443752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=p5+c5VpLnVkRT8GmtkDspNcjMFF7W/ui62AD9LCqlPk=;
        b=e2LuFJNezzgau+25vW0IJH4CjrNtDoAaSBLURhPLxyMyrRAds/jOnXt78I5xC77knVEKvq
        baJZP/TmTVV21d+sc0U45cY5tY1aI6z5eCV+axHmCLAaoAhEo9UqtSrSgRlXHKCYtdphid
        1muhFRjcmYp9jP5yPnJw3C7F3KP/mR8=
Date:   Wed, 23 Jun 2021 12:22:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 20/22] x86/boot: Add Confidential Computing
 address to setup_header
Message-ID: <YNMLX6fbB3PQwSpv@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-21-brijesh.singh@amd.com>
 <YMw4UZn6AujpPSZO@zn.tnic>
 <15568c80-c9a9-5602-d940-264af87bed98@amd.com>
 <YMy2OGwsRzrR5bwD@zn.tnic>
 <162442264313.98837.16983159316116149849@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162442264313.98837.16983159316116149849@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 22, 2021 at 11:30:43PM -0500, Michael Roth wrote:
> Quoting Borislav Petkov (2021-06-18 10:05:28)
> > On Fri, Jun 18, 2021 at 08:57:12AM -0500, Brijesh Singh wrote:
> > > Don't have any strong reason to keep it separate, I can define a new
> > > type and use the setup_data to pass this information.
> > 
> > setup_data is exactly for use cases like that - pass a bunch of data
> > to the kernel. So there's no need for a separate thing. Also see that
> > kernel_info thing which got added recently for read_only data.
> 
> Hi Boris,
> 
> There's one side-effect to this change WRT the CPUID page (which I think
> we're hoping to include in RFC v4).
> 
> With CPUID page we need to access it very early in boot, for both
> boot/compressed kernel, and the uncompressed kernel. At first this was
> implemented by moving the early EFI table parsing code from
> arch/x86/kernel/boot/compressed/acpi.c into a little library to handle early
> EFI table parsing to fetch the Confidential Computing blob to get the CPUID
> page address.
> 
> This was a bit messy since we needed to share that library between
> boot/compressed and uncompressed, and at that early stage things like
> fixup_pointer() are needed in some places, else even basic things like
> accessing EFI64_LOADER_SIGNATURE and various EFI helper functions could crash
> in uncompressed otherwise, so the library code needed to be fixed up
> accordingly.
> 
> To simplify things we ended up simply keeping the early EFI table parsing in
> boot/compressed, and then having boot/compressed initialize
> setup_data.cc_blob_address so that the uncompressed kernel could access it
> from there (acpi does something similar with rdsp address).

Yes, except the rsdp address is not vendor-specific but an x86 ACPI
thing, so pretty much omnipresent.

Also, acpi_rsdp_addr is part of boot_params and that struct is full
of padding holes and obsolete members so reusing a u32 there is a lot
"easier" than changing the setup_header. So can you put that address in
boot_params instead?

> Now that we're moving it to setup_data, this becomes a bit more awkward,
> since we need to reserve memory in boot/compressed to store the setup_data
> entry, then add it to the linked list to pass along to uncompressed kernel.
> In turn that also means we need to add an identity mapping for this in
> ident_map_64.c, so I'm not sure that's the best approach.
> 
> So just trying to pin what the best approach is:
> 
> a) move cc_blob to setup_data, and do the above-described to pass
>    cc_blob_address from boot/compressed to uncompressed to avoid early
>    EFI parsing in uncompressed
> b) move cc_blob to setup_data, and do the EFI table parsing in both
>    boot/compressed. leave setup_data allocation/init for BIOS/bootloader
> c) keep storing cc_blob_address in setup_header.cc_blob_address
> d) something else?

Leaving in the whole text for newly CCed TDX folks in case they're going
to need something like that.

And if so, then both vendors should even share the field definition.

Dave, Sathya, you can find the whole subthread here:

https://lkml.kernel.org/r/20210602140416.23573-21-brijesh.singh@amd.com

in case you need background info on the topic at hand.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

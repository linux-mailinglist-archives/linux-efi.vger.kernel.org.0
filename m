Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F401C3B5F44
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jun 2021 15:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhF1NqI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Jun 2021 09:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhF1NqH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Jun 2021 09:46:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7851C061574;
        Mon, 28 Jun 2021 06:43:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ad700491bef6a2c18e575.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d700:491b:ef6a:2c18:e575])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2FA21EC0473;
        Mon, 28 Jun 2021 15:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624887819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oaTWoMIR/8kJ1vrSQ/YRM/leTg1aNhhSfH9Oxbdei28=;
        b=CcGIVm4bSbzMzC10uwvsiurej2wJd+CPm1Arml3UbITXCUfouCbJT706JeVxr6NOxOmjwo
        Bv7E2wkMLBJ3qDqFg3z4uKMvcXyXgLKEw3LFgtzRCZDU2rPJBwZVy9us4eNCpqb3a3lL7u
        oZVemIo605NkzDqx5AiWPvSFPd0d4X8=
Date:   Mon, 28 Jun 2021 15:43:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
Message-ID: <YNnSBl5asXjXIvfy@zn.tnic>
References: <YNMLX6fbB3PQwSpv@zn.tnic>
 <20210624031911.eznpkbgjt4e445xj@amd.com>
 <YNQz7ZxEaSWjcjO2@zn.tnic>
 <20210624123447.zbfkohbtdusey66w@amd.com>
 <YNSAlJnXMjigpqu1@zn.tnic>
 <20210624141111.pzvb6gk5lzfelx26@amd.com>
 <YNXs1XRu31dFiR2Z@zn.tnic>
 <8faad91a-f229-dee3-0e1f-0b613596db17@amd.com>
 <YNYMAkoSoMnfhBnJ@zn.tnic>
 <20210625181417.kaylo56pz4rlwwqr@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210625181417.kaylo56pz4rlwwqr@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 25, 2021 at 01:14:17PM -0500, Michael Roth wrote:
> So non-EFI case would rely purely on the setup_data entry for both (though
> we could still use boot_params->cc_blob_address to avoid the need to scan
> setup_data list in proper kernel as well, but scanning it early on doesn't
> have the same issues as with EFI config table so it's not really
> necessary there).

Yeah, sure, we can simply always use boot_params->cc_blob_address just
like acpi_rsdp_addr and always put the CC blob address there.

> I opted to give setup_data precedence over EFI, since if a bootloader goes
> the extra mile of packaging up a setup_data argument instead of just leaving
> it to firmware/EFI config table, it might be out of some extra need.  For
> example, if we do have a shared definition for both SEV and TDX, maybe the
> bootloader needs to synthesize multiple EFI table entries, and a unified
> setup_data will be easier for the kernel to consume than replicating that same
> work, and maybe over time the fallback can be deprecated. And containers will
> more than likely prefer setup_data approach, which might drive future changes
> that aren't in lockstep with EFI definitions as well.

Yah, that makes perfect sense. And you/Brijesh should put the gist of
that in a comment over the code so that people are aware. The less we
rely on firmware, the better.

> Brijesh can correct me if I'm wrong, but I believe that's the intent, and the
> setup_data approach definitely seems workable for that aspect.

Oki doki, I think we're all on the same page then. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

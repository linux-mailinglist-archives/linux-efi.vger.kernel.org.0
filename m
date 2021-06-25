Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767343B4617
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jun 2021 16:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhFYOvU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Jun 2021 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFYOvU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Jun 2021 10:51:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4BBC061574;
        Fri, 25 Jun 2021 07:48:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0dae0049fb297996de39ad.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:49fb:2979:96de:39ad])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C72C91EC0595;
        Fri, 25 Jun 2021 16:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624632537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ENHDjrvHsrLVlBAdGgAmMkR2KuwDaPAvXCPilbbBf7A=;
        b=LSXOwsdhUEbhG7vaRlM3tlHXlIL2v/KBN+RiZWsEAiLf8BjJ9w+dKv3EgevZlFNctBQ91L
        kihWVCGWyB74ZmIbVG0UFqLQZu5TOOgdIAz2KLjcURGT5bgtWTYQC9esnD34CSJRSM4rZm
        Ez3S06oseaAAUrkfLls9v8mOe0j+Sqk=
Date:   Fri, 25 Jun 2021 16:48:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
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
Message-ID: <YNXs1XRu31dFiR2Z@zn.tnic>
References: <YMw4UZn6AujpPSZO@zn.tnic>
 <15568c80-c9a9-5602-d940-264af87bed98@amd.com>
 <YMy2OGwsRzrR5bwD@zn.tnic>
 <162442264313.98837.16983159316116149849@amd.com>
 <YNMLX6fbB3PQwSpv@zn.tnic>
 <20210624031911.eznpkbgjt4e445xj@amd.com>
 <YNQz7ZxEaSWjcjO2@zn.tnic>
 <20210624123447.zbfkohbtdusey66w@amd.com>
 <YNSAlJnXMjigpqu1@zn.tnic>
 <20210624141111.pzvb6gk5lzfelx26@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624141111.pzvb6gk5lzfelx26@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 24, 2021 at 09:11:11AM -0500, Michael Roth wrote:
>   We don't need anything in setup_data/setup_header. We can access the
>   CC blob table via EFI config table. However, parsing EFI config table
>   early in uncompressed/proper kernel has the complications I mentioned in my
>   initial response.

So since you want to parse the EFI table in the boot stage, that tells
me that you need the blob in the early, boot kernel too, correct?

> This is where using a new boot_params field comes into
>   play (similar to acpi_rsdp_addr), so boot/compressed can pass
>   uncompressed/proper kernel a pointer to the pre-parsed CC blob so it doesn't
>   need to re-parse EFI config table during early boot.

Ack.

> For non-EFI case:
> 
>   We need a "proper" mechanism that bootloaders can use. My
>   understanding is this would generally be via setup_data or
>   setup_header, and that a direct boot_params field would be frowned
>   upon.

So, you need to pass only an address, right?

How workable would it be if you had a cmdline option:

	cc_blob_address=0xb1a

with which you tell the kernel where that thing is?

Because then you can use this in both cases - EFI and !EFI.

Or is this blob platform-dependent and the EFI table contains it and
something needs to get it out of there, even if it were a user to
type in the cmdline cc_blob_address or some script when it comes to
containers...?

In any case, setup_data is kinda the generic way to pass arbitrary data
to the kernel so in this case, you can prioritize the EFI table in the
EFI case and fall back to setup_data if there's no EFI table...

> So your understanding of the situation seems correct.
> 
> By bringing up the non-EFI case I only meant to point out that by using a
> field in setup_header, we could re-use that field for the EFI case as well,
> and wouldn't need a seperate boot_params field to handle the
> boot/compressed->uncompressed passing of the pre-parsed CC blob address
> in the EFI case. But I don't think it makes a big difference as far as
> my stuff goes at least. Maybe for TDX though this needs more thought.

Yah, let's see what requirements they'd come back with.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

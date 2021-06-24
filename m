Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6503B2896
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jun 2021 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFXHaJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Jun 2021 03:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhFXHaI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Jun 2021 03:30:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3558C061574;
        Thu, 24 Jun 2021 00:27:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c1e0051d60f689d4f0453.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1e00:51d6:f68:9d4f:453])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CEBD1EC0253;
        Thu, 24 Jun 2021 09:27:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624519667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Tk8bS/1GVIXPT0HJ7nIwptwsGI5hts/jHchSoFxDYwk=;
        b=LI0h9MmccHlICbtRqQhCC3gRJh4OKEODp3Chzd+32gPVF3K9RZOvUCpqfOF7Ds7k0dTR42
        Pu2uxB3uG0wcizcYUsLG3RGmRR66qZaNYd+x9mNYFTvgAEy+OiP+lpgWjJjEGUkO7KQz33
        qu3nAYVYpp+HzJ3neF4aZ/ZyH67DiO8=
Date:   Thu, 24 Jun 2021 09:27:41 +0200
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
Message-ID: <YNQz7ZxEaSWjcjO2@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-21-brijesh.singh@amd.com>
 <YMw4UZn6AujpPSZO@zn.tnic>
 <15568c80-c9a9-5602-d940-264af87bed98@amd.com>
 <YMy2OGwsRzrR5bwD@zn.tnic>
 <162442264313.98837.16983159316116149849@amd.com>
 <YNMLX6fbB3PQwSpv@zn.tnic>
 <20210624031911.eznpkbgjt4e445xj@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624031911.eznpkbgjt4e445xj@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 23, 2021 at 10:19:11PM -0500, Michael Roth wrote:
> One downside to this is we still need something in the boot protocol,
> either via setup_data, or setup_header directly.

Huh, now I'm confused. You gave the acpi_rsdp_addr example and I thought
that should be enough, that's why I suggested boot_params.

Maybe you should point me to the code which does what you need so that I
can get a better idea...

> Having it in setup_header avoids the need to also have to add a field
> to boot_params for the boot/compressed->uncompressed passing, but
> maybe that's not a good enough justification. Perhaps if the TDX folks
> have similar needs though.

Yes, reportedly they do so I guess the solution should be
vendor-agnostic. Let's see what they need first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

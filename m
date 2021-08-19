Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09A23F1EC1
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhHSRJq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 13:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhHSRJp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 13:09:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E1DC061575;
        Thu, 19 Aug 2021 10:09:09 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f6a00894cffc8901d9ad3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:894c:ffc8:901d:9ad3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F092D1EC04F3;
        Thu, 19 Aug 2021 19:09:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629392943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5h/pBCa48TpXaDC5k6IrIdMKol2hS7fNRvaR9js1Y0w=;
        b=Y+o2JyP4Tg1O4OSMYH/GIP8+RzcS0qjXj/JucPGugTCf3iMvd2TXwRWBSklMZvSnsBBjzn
        fr3Y7u61lMY10cqPUfxz1UkhK57dEAyb8NrVtZid6qA8GMlZphUUqzbVVrsR6nRZEgXn0p
        Zwnk5rkTl3zqeU7wg2G67ypkiAml6Zw=
Date:   Thu, 19 Aug 2021 19:09:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 24/36] x86/compressed/acpi: move EFI config
 table access to common code
Message-ID: <YR6QVh3qZUxqsyI+@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-25-brijesh.singh@amd.com>
 <YR42323cUxsbQo5h@zn.tnic>
 <20210819145831.42uszc4lcsffebzu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210819145831.42uszc4lcsffebzu@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 09:58:31AM -0500, Michael Roth wrote:
> Not sure what you mean here. All the interfaces introduced here are used
> by acpi.c. There is another helper added later (efi_bp_find_vendor_table())
> in "enable SEV-SNP-validated CPUID in #VC handler", since it's not used
> here by acpi.c.

Maybe I got confused by the amount of changes in a single patch. I'll
try harder with your v5. :)

> There is the aforementioned efi_bp_find_vendor_table() that does the
> simple iteration, but I wasn't sure how to build the "find one of these,
> but this one is preferred" logic into it in a reasonable way.

Instead of efi_foreach_conf_entry() you simply do a bog-down simple
loop and each time you stop at a table, you examine it and overwrite
pointers, if you've found something better.

With "overwrite pointers" I mean you cache the pointers to those conf
tables you iterate over and dig out so that you don't have to do it a
second time. That is, *if* you need them a second time. I believe you
call at least efi_bp_get_conf_table() twice... you get the idea.

> I could just call it once for each of these GUIDs though. I was
> hesitant to do so since it's less efficient than existing code, but if
> it's worth it for the simplification then I'm all for it.

Yeah, this is executed once during boot so I don't think you can make it
more efficient than a single iteration over the config table blobs.

I hope that makes more sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D38F56384C
	for <lists+linux-efi@lfdr.de>; Fri,  1 Jul 2022 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiGAQvZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Jul 2022 12:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGAQvY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Jul 2022 12:51:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A5D44A0A;
        Fri,  1 Jul 2022 09:51:23 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff648329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f648:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 43EFA1EC064A;
        Fri,  1 Jul 2022 18:51:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656694277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LsRagpxJ0d6m6LED7HHfWRzzrUzw8aGp7k8R8oF5VaQ=;
        b=kVgbaLHTIsuv3Te5Rsh4ZkmUq+hTiJvlWYa0pGnkSJ1yBJNazGmA2MlsU8d0LXoBgXZDOs
        BK/Mwzu4AfZefSG/tFTr/kXyg/+2uZlvmUlaGKGG9Ycsc+noYabQkfcWzq5iRgMug9P5/h
        w9QwkfALpCmGSrcjBNsjLmOwQ/3hJ1w=
Date:   Fri, 1 Jul 2022 18:51:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Roth <michael.roth@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 19/46] x86/kernel: Make the .bss..decrypted section
 shared in RMP table
Message-ID: <Yr8mARnQT+VZK0iy@zn.tnic>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-20-brijesh.singh@amd.com>
 <YqfabnTRxFSM+LoX@google.com>
 <YqistMvngNKEJu2o@google.com>
 <daaf7a84-4204-48ca-e40c-7ba296b4789c@amd.com>
 <YqizrTCk460kov/X@google.com>
 <6db51d45-e17a-38dd-131d-e43132c55dfb@amd.com>
 <Yqjm/b3deMlxxePh@google.com>
 <9abe9a71-242d-91d5-444a-b56c8b9b6d90@amd.com>
 <YqtdIf7OSivLxFL0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqtdIf7OSivLxFL0@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 16, 2022 at 04:41:05PM +0000, Sean Christopherson wrote:
> > I worry that another use of cc_platform_has() could creep in at some point
> > and cause the same issue. Not sure how bad it would be, performance-wise, to
> > remove the jump table optimization for arch/x86/coco/core.c.

Is there a gcc switch for that?

> One thought would be to initialize "vendor" to a bogus value, disallow calls to
> cc_set_vendor() until after the kernel as gotten to a safe point, and then WARN
> (or panic?) if cc_platform_has() is called before "vendor" is explicitly set.
> New calls can still get in, but they'll be much easier to detect and less likely
> to escape initial testing.

The invalid vendor thing makes sense but I don't think it'll help in
this case.

We set vendor in sme_enable() which comes before the

__startup_64 -> sme_postprocess_startup

path you're hitting.

We could do only the aspect of checking whether it hasn't been set yet
and warn then, in order to make the usage more robust...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4277248C6
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 18:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbjFFQRI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 12:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbjFFQRE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 12:17:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537CF198D;
        Tue,  6 Jun 2023 09:16:47 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C7CFA1EC064A;
        Tue,  6 Jun 2023 18:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686068170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EzBNPsFl2Dhg5+mFLreu4S8+80Y4hLppeh74KxkxTV0=;
        b=kL9MUkQiC0UGBSPHskdsYSS8Sun5ZP40wjnMuRf4XqVC/ucpHdpbaETCgZabPrrU+59aBo
        IL6BwpRYVz4LW5nsrG15WxB3B4g9sY3o2A1RUIHqcQTmMN3NpnTO7tP8nJE8PLdeezhCcd
        Mj5M018TevNsx4gJequl4dGcYnpPqys=
Date:   Tue, 6 Jun 2023 18:16:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv14 0/9] mm, x86/cc, efi: Implement support for unaccepted
 memory
Message-ID: <20230606161606.GDZH9bxhrGnFkaLl2A@fat_crate.local>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 06, 2023 at 05:26:28PM +0300, Kirill A. Shutemov wrote:
> v14:
>  - Fix error handling in arch_accept_memory() (Tom);
>  - Address Borislav's feedback:
>    + code restructure;
>    + added/adjusted comments;

In file included from arch/x86/coco/tdx/tdx-shared.c:1:
./arch/x86/include/asm/tdx.h: In function ‘tdx_kvm_hypercall’:
./arch/x86/include/asm/tdx.h:70:17: error: ‘ENODEV’ undeclared (first use in this function)
   70 |         return -ENODEV;
      |                 ^~~~~~
./arch/x86/include/asm/tdx.h:70:17: note: each undeclared identifier is reported only once for each function it appears in
make[4]: *** [scripts/Makefile.build:252: arch/x86/coco/tdx/tdx-shared.o] Error 1
make[3]: *** [scripts/Makefile.build:494: arch/x86/coco/tdx] Error 2
make[2]: *** [scripts/Makefile.build:494: arch/x86/coco] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [scripts/Makefile.build:494: arch/x86] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:2026: .] Error 2

Not enough build tests ran?

$ grep INTEL_TDX_GUEST .config
CONFIG_INTEL_TDX_GUEST=y
$ grep KVM_GUEST .config
$

Why does that tdx_kvm_hypercall() thing even depend on CONFIG_KVM_GUEST?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

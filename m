Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED76D724B01
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjFFSP1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbjFFSO5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 14:14:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF421981;
        Tue,  6 Jun 2023 11:14:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A9015C013C;
        Tue,  6 Jun 2023 14:14:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Jun 2023 14:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1686075289; x=1686161689; bh=hPyHPz1cEzFaFzAfFQsbhREfE
        QLxVSzdwxLuf3WmlCE=; b=lh5DWpHxDd9X6FAW4ow+Ir/EA5g1xtObhqmHTg38L
        yz9KreysaW6DxZwF4EfoEdOiKAPXcFQ5/b2x3yZEamg7kCwU4cnG3LQ0GCKyPHX1
        jiMfSlRNpAP35bIqq6m4Fo7aLzUmnSUnZyxI/7AWx5AWiQXhId4UeMA2V/YyNW8X
        IeleujKYyBs0VmEgF3Fn2dUWDuXWxzoT1eunEci9BmkpRRiJ2b2dBUVDeP4jrFUU
        h1vy+k9nRoztCSa1c5Izwegt1R2tIUQh3BSLJkPzFx1EyjYr4p4viIeR8tmN6UKt
        J+eeYJB4c6rjQT2ATmOZXfnVUn1CrPGmc7Zi6PnZDFKSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686075289; x=1686161689; bh=hPyHPz1cEzFaFzAfFQsbhREfEQLxVSzdwxL
        uf3WmlCE=; b=e5D47AQ9v2sUHMq/yFuIXeXuG2fFGcxTLxASN5v9rpiikOQH2AX
        JeoeyHiLzG/qVelvp3Cs/vnDgKDjEiqbNOpCDxjGIvumZGJtsW7pZGqtjXS+JiEy
        NqFHKh294Xt+dpskYiarbDZYzYuIAucr6qDI8m3JyiC9gQCBp4nTMvbFDBQs1TlJ
        gc/ColaWEkNEsji6Lp7ueBRoLAKi1gn2JIx64hXz15yYTubzSns/r4ztjeni2D1D
        bNBF0/+K/xhi1rTtJKOP7HEv5KFeQ5DeTVZeWwMHePYXynUDal0q1wr9j6V839G2
        4UG/zoaBfznDtyww8+OuHSqh27j6XweBaqA==
X-ME-Sender: <xms:mHd_ZHnu3Fo1x5XmG3RU2b1R4YG_rlDYo-YqYfEiybWJo0HI7nDqyw>
    <xme:mHd_ZK1b1Dvh3pdnKPyS3S8scwsftZupJFET5nhtoCbe5eN3tF4ZGzNKqkW7vIZgA
    MPrODNV7tbyhh4AwTc>
X-ME-Received: <xmr:mHd_ZNrOpMSL6fpg0Js0c5AWxntaK10eHIV7xhaTaofGJXfyxWFsS4YEjEOIp1Wy8OzleA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthektddttddtjeenucfhrhhomhepfdfm
    ihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeelteeftdeggefgtddttedtgfehveeitdfg
    heeuieefveffkeeiueeuueegvdffveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhi
    lhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:mHd_ZPla381_ATPL6zAQK2BZDoAkSud4-bdz1M3ULW5KLCXaoHXeGQ>
    <xmx:mHd_ZF02pVuxXVjS6c-9ThGN6vaIjXHFN9pJ2Eac-OK8QLBMTAAbiw>
    <xmx:mHd_ZOtP0rh1J4g0Rpb7UdD_VUnnZppbqAFILj3mE5Dx3hMftJQxDA>
    <xmx:mXd_ZIBCQNju7qkcD7otPDbqXBqaliTvsxTMMDw9GSJ213DxgfcsDA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 14:14:48 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8A4F110CFD2; Tue,  6 Jun 2023 21:14:44 +0300 (+03)
Date:   Tue, 6 Jun 2023 21:14:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20230606181444.2rxorg6gaeasgugx@box.shutemov.name>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606161606.GDZH9bxhrGnFkaLl2A@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230606161606.GDZH9bxhrGnFkaLl2A@fat_crate.local>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 06, 2023 at 06:16:06PM +0200, Borislav Petkov wrote:
> On Tue, Jun 06, 2023 at 05:26:28PM +0300, Kirill A. Shutemov wrote:
> > v14:
> >  - Fix error handling in arch_accept_memory() (Tom);
> >  - Address Borislav's feedback:
> >    + code restructure;
> >    + added/adjusted comments;
> 
> In file included from arch/x86/coco/tdx/tdx-shared.c:1:
> ./arch/x86/include/asm/tdx.h: In function ‘tdx_kvm_hypercall’:
> ./arch/x86/include/asm/tdx.h:70:17: error: ‘ENODEV’ undeclared (first use in this function)
>    70 |         return -ENODEV;
>       |                 ^~~~~~
> ./arch/x86/include/asm/tdx.h:70:17: note: each undeclared identifier is reported only once for each function it appears in
> make[4]: *** [scripts/Makefile.build:252: arch/x86/coco/tdx/tdx-shared.o] Error 1
> make[3]: *** [scripts/Makefile.build:494: arch/x86/coco/tdx] Error 2
> make[2]: *** [scripts/Makefile.build:494: arch/x86/coco] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [scripts/Makefile.build:494: arch/x86] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:2026: .] Error 2
> 
> Not enough build tests ran?

Hm. I've got a lot of reports from 0day, but never this one.

Kai has posted patch that fixes it already:

https://lore.kernel.org/all/20230606034000.380270-1-kai.huang@intel.com/

> $ grep INTEL_TDX_GUEST .config
> CONFIG_INTEL_TDX_GUEST=y
> $ grep KVM_GUEST .config
> $
> 
> Why does that tdx_kvm_hypercall() thing even depend on CONFIG_KVM_GUEST?

Because nobody uses it otherwise. For instance, Hyper-V guest will no need
this KVM glue.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

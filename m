Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965BF705B3E
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 01:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjEPXWO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 19:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPXWN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 19:22:13 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813D54C13;
        Tue, 16 May 2023 16:22:12 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9F3A63200681;
        Tue, 16 May 2023 19:22:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 16 May 2023 19:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1684279329; x=1684365729; bh=q/LDWIGbdAy3VoznxUJjsf+bX
        tJKKbTqkkqMGU6+v/g=; b=m2m1bUIgub9QXAWlH0fXpM8Ue2oIvS5xbkrbTUXU7
        sQ1V+prRb7Sqq89T2vRTQG7AzJvJJU3vy+PH9gNrySqbh+ohj1rJhPcbYIJhki7X
        QVyzkyANCKJ9bgEXruB8x/a8wq6cbKvuaCuU48bzkZJKz5o1cL0olKQwLd6+PFLD
        nflEvm8iONTsphwgwU6KUtVfdMoEC+GQ03OX65HWiu9nTAvpCluubAYxmiGrsnsV
        nXZ0OrLah/e+n6y1xBuGdwQn6/X5ii7abSYavOCo0YHt6REih2PHmB61tqkRHCJt
        cMU1bGQIXpCI2MgSKHJYnR8oryhlQBhaJhzrafxmUJSZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684279329; x=1684365729; bh=q/LDWIGbdAy3VoznxUJjsf+bXtJKKbTqkkq
        MGU6+v/g=; b=vTcG5a/PZ7wgpgaWwyxWbKArzwxA/WRYZjM+oWJmPlIF00YhYs4
        9+uGBmCIn/K2ZzQASUUVgalTxEeTms4nHUKqMCBF47VXLmnAFTF6CcFjvWg4MCCh
        gtpBh0o8D5duCSDXD9W6GpWRbMeebzD0+KHTrgUiTwS5frhI8TRi7OSFgwzCnPmF
        +/Zr38ICtbF2gkAXWFLJIuqdVqlbvxDe+V9J+tGf6F8xFcerQocYm+B9N1j/g6Cn
        kzZpyDxqVb0HPVYUaQ1mTyAgi/c8k7SbQMstoyVrstXCNxgHvwCk/5P1Cww6lrt4
        feBBZ6QVHa8FztvL1j8NP4WobpOETEHV8+A==
X-ME-Sender: <xms:HxBkZOHWtYX8NJWSX4AacVPlM4izqm2AZW9VJnxBc8h6VhpOynyosg>
    <xme:HxBkZPW_3MqMXO6tQ4mjlSN1C5PdBuO-TveEhuKswxbJMNxa4fW6uBGMm_YKmpz-n
    Q0cgiiEVbczTv_6gsM>
X-ME-Received: <xmr:HxBkZIIxsBcLx8iaNnj3QGlLymMt5rpmsM5W6kQP_B-PBiJzKTc_9SmJSxFOdIuUFVqz1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeitddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkedttddttdejnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefggeevgffgtdejjedujeeltedutdfgtddu
    vdevfeeiueeikeduleeuffegueevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:IBBkZIFMOwdKBz3tQQuRr9yOt971u0wNetTNNWAIJ0jhM50UffZO4Q>
    <xmx:IBBkZEU9K_x3ehQ9-emwBqsTs_JN7R8-y9G5MQBLDdGwyYjZjGgf2g>
    <xmx:IBBkZLOw9wkgVvDVrGJIJ287W4sHtA9lj-7iSLxnhZs2svIT3bP6qA>
    <xmx:IRBkZOijMa1x0BxhZ6K4_AuFe1eENc3ccxN-5nwA4Z8oZvNSKIWAIg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 May 2023 19:22:07 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B222610C8C1; Wed, 17 May 2023 02:22:04 +0300 (+03)
Date:   Wed, 17 May 2023 02:22:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCHv11 0/9] mm, x86/cc, efi: Implement support for unaccepted
 memory
Message-ID: <20230516232204.3k53vh6pdnimdrhi@box.shutemov.name>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <aa35a445-f410-b11f-bf21-3e482647faae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa35a445-f410-b11f-bf21-3e482647faae@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 16, 2023 at 05:41:55PM -0500, Tom Lendacky wrote:
> On 5/13/23 17:04, Kirill A. Shutemov wrote:
> > UEFI Specification version 2.9 introduces the concept of memory
> > acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> > SEV-SNP, requiring memory to be accepted before it can be used by the
> > guest. Accepting happens via a protocol specific for the Virtual
> > Machine platform.
> > 
> > Accepting memory is costly and it makes VMM allocate memory for the
> > accepted guest physical address range. It's better to postpone memory
> > acceptance until memory is needed. It lowers boot time and reduces
> > memory overhead.
> > 
> > The kernel needs to know what memory has been accepted. Firmware
> > communicates this information via memory map: a new memory type --
> > EFI_UNACCEPTED_MEMORY -- indicates such memory.
> > 
> > Range-based tracking works fine for firmware, but it gets bulky for
> > the kernel: e820 has to be modified on every page acceptance. It leads
> > to table fragmentation, but there's a limited number of entries in the
> > e820 table
> > 
> > Another option is to mark such memory as usable in e820 and track if the
> > range has been accepted in a bitmap. One bit in the bitmap represents
> > 2MiB in the address space: one 4k page is enough to track 64GiB or
> > physical address space.
> > 
> > In the worst-case scenario -- a huge hole in the middle of the
> > address space -- It needs 256MiB to handle 4PiB of the address
> > space.
> > 
> > Any unaccepted memory that is not aligned to 2M gets accepted upfront.
> > 
> > The approach lowers boot time substantially. Boot to shell is ~2.5x
> > faster for 4G TDX VM and ~4x faster for 64G.
> > 
> > TDX-specific code isolated from the core of unaccepted memory support. It
> > supposed to help to plug-in different implementation of unaccepted memory
> > such as SEV-SNP.
> > 
> > -- Fragmentation study --
> > 
> > Vlastimil and Mel were concern about effect of unaccepted memory on
> > fragmentation prevention measures in page allocator. I tried to evaluate
> > it, but it is tricky. As suggested I tried to run multiple parallel kernel
> > builds and follow how often kmem:mm_page_alloc_extfrag gets hit.
> > 
> > See results in the v9 of the patchset[1][2]
> > 
> > [1] https://lore.kernel.org/all/20230330114956.20342-1-kirill.shutemov@linux.intel.com
> > [2] https://lore.kernel.org/all/20230416191940.ex7ao43pmrjhru2p@box.shutemov.name
> > 
> > --
> > 
> > The tree can be found here:
> > 
> > https://github.com/intel/tdx.git guest-unaccepted-memory
> 
> I get some failures when building without TDX support selected in my
> kernel config after adding unaccepted memory support for SNP:
> 
>   In file included from arch/x86/boot/compressed/../../coco/tdx/tdx-shared.c:1,
>                    from arch/x86/boot/compressed/tdx-shared.c:2:
>   ./arch/x86/include/asm/tdx.h: In function ‘tdx_kvm_hypercall’:
>   ./arch/x86/include/asm/tdx.h:72:17: error: ‘ENODEV’ undeclared (first use in this function)
>      72 |         return -ENODEV;
>         |                 ^~~~~~
>   ./arch/x86/include/asm/tdx.h:72:17: note: each undeclared identifier is reported only once for each function it appears in
> 
> Adding an include for linux/errno.h gets past that error, but then
> I get the following:
> 
>   ld: arch/x86/boot/compressed/tdx-shared.o: in function `tdx_enc_status_changed_phys':
>   tdx-shared.c:(.text+0x42): undefined reference to `__tdx_hypercall'
>   ld: tdx-shared.c:(.text+0x7f): undefined reference to `__tdx_module_call'
>   ld: tdx-shared.c:(.text+0xce): undefined reference to `__tdx_module_call'
>   ld: tdx-shared.c:(.text+0x13b): undefined reference to `__tdx_module_call'
>   ld: tdx-shared.c:(.text+0x153): undefined reference to `cc_mkdec'
>   ld: tdx-shared.c:(.text+0x15d): undefined reference to `cc_mkdec'
>   ld: tdx-shared.c:(.text+0x18e): undefined reference to `__tdx_hypercall'
>   ld: arch/x86/boot/compressed/vmlinux: hidden symbol `__tdx_hypercall' isn't defined
>   ld: final link failed: bad value
> 
> So it looks like arch/x86/boot/compressed/tdx-shared.c is being
> built, while arch/x86/boot/compressed/tdx.c isn't.

Right. I think this should help:

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 78f67e0a2666..b13a58021086 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -106,8 +106,8 @@ ifdef CONFIG_X86_64
 endif

 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
-vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
-vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o $(obj)/tdx-shared.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/tdx-shared.o
+vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o

 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o

> After setting TDX in the kernel config, I can build successfully, but
> I'm running into an error when trying to accept memory during
> decompression.
> 
> In drivers/firmware/efi/libstub/unaccepted_memory.c, I can see that the
> unaccepted_table is allocated, but when accept_memory() is invoked the
> table address is now zero. I thought maybe it had to do with bss, but even
> putting it in the .data section didn't help. I'll keep digging, but if you
> have any ideas, that would be great.

Not right away. But maybe seeing your side of enabling would help.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

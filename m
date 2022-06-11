Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3BC547371
	for <lists+linux-efi@lfdr.de>; Sat, 11 Jun 2022 11:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiFKJ42 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Jun 2022 05:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiFKJ41 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Jun 2022 05:56:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B6BEE15;
        Sat, 11 Jun 2022 02:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 965DA60BA3;
        Sat, 11 Jun 2022 09:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF641C3411E;
        Sat, 11 Jun 2022 09:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654941386;
        bh=G3SijAZJFwW8PPbomjAxbmJ1C1Qf1Qf77wWOoRRw+dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=je5xCyBasUps0lw+zm8BT+55x7BMo8QBuhxo7JbtlactdaXmHz6lygNzLVrkm8nAX
         HjEppJFc+QzCFrtWjpMbQ5TNT070wVV+inQya2B9+gtBdLCpCi5lhYrB8oioVSA00t
         hIu1Oa3GrD0WLeAPrt7UP5jlkYHkU2fo87dm0Y2tsE2pbKenH7urJXTDUAgrXYtoWI
         sACEfm3Hy0H/485yd2z03sytvQHGo5HqeAr0OHZgDGtUHNS7u3v0z9DoUqRmcgnTGS
         yJ2Edt+EBxtqLD6Zk4/TW4K+j7AB4xUoNv3rGt0AT9EmLHGsWZAuNEVqCOGQlFxuD6
         6hRDH3YDodvdQ==
Date:   Sat, 11 Jun 2022 12:56:12 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Wupeng Ma <mawupeng1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>, songmuchun@bytedance.com,
        Randy Dunlap <rdunlap@infradead.org>,
        damien.lemoal@opensource.wdc.com,
        Stephen Boyd <swboyd@chromium.org>,
        Wei Liu <wei.liu@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, gpiccoli@igalia.com,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        chenzhou10@huawei.com, vijayb@linux.microsoft.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/6] introduce mirrored memory support for arm64
Message-ID: <YqRmvJDiy2UQkEDu@kernel.org>
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <CAMj1kXH5r=CUoLCndBUsZ04_0UCJ2VqgJDdp2wbdNCtEx0Yxag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH5r=CUoLCndBUsZ04_0UCJ2VqgJDdp2wbdNCtEx0Yxag@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 10, 2022 at 01:23:34PM +0200, Ard Biesheuvel wrote:
> On Tue, 7 Jun 2022 at 11:16, Wupeng Ma <mawupeng1@huawei.com> wrote:
> >
> > From: Ma Wupeng <mawupeng1@huawei.com>
> >
> > Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
> > introduced mirrored memory support for x86. This support rely on UEFI to
> > report mirrored memory address ranges.  See UEFI 2.5 spec pages 157-158:
> >
> >   http://www.uefi.org/sites/default/files/resources/UEFI%202_5.pdf
> >
> > Memory mirroring is a technique used to separate memory into two separate
> > channels, usually on a memory device, like a server. In memory mirroring,
> > one channel is copied to another to create redundancy. This method makes
> > input/output (I/O) registers and memory appear with more than one address
> > range because the same physical byte is accessible at more than one
> > address. Using memory mirroring, higher memory reliability and a higher
> > level of memory consolidation are possible.
> >
> > These EFI memory regions have various attributes, and the "mirrored"
> > attribute is one of them. The physical memory region whose descriptors
> > in EFI memory map has EFI_MEMORY_MORE_RELIABLE attribute (bit: 16) are
> > mirrored. The address range mirroring feature of the kernel arranges such
> > mirrored regions into normal zones and other regions into movable zones.
> >
> > Arm64 can support this too. So mirrored memory support is added to support
> > arm64.
> >
> > The main purpose of this patch set is to introduce mirrored support for
> > arm64 and we have already fixed the problems we had which is shown in
> > patch #5 to patch #8 and try to bring total isolation in patch #9 which
> > will disable mirror feature if kernelcore is not specified.
> >
> > In order to test this support in arm64:
> > - patch this patch set
> > - add kernelcore=mirror in kernel parameter
> > - start you kernel
> >
> > Patch #1-#2 introduce mirrored memory support form arm64.
> > Patch #3-#5 fix some bugs for arm64 if memory reliable is enabled.
> > Patch #6 disable mirror feature if kernelcore is not specified.
> >
> > Thanks to Ard Biesheuvel's hard work [1], now kernel will perfer mirrored
> > memory if kaslr is enabled.
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/CAMj1kXEPVEzMgOM4+Yj6PxHA-jFuDOAUdDJSiSxy_XaP4P7LSw@mail.gmail.com/T/
> >
> > Changelog since v2:
> > - remove efi_fake_mem support
> > - remove Commit ("remove some redundant code in ia64 efi_init") since
> >   efi_print_memmap() is not public
> > - add mirror flag back on initrd memory
> >
> > Changelog since v1:
> > - update changelog in cover letter
> > - use PHYS_PFN in patch #7
> >
> > Ma Wupeng (6):
> >   efi: Make efi_find_mirror() public
> >   arm64/mirror: arm64 enabling - find mirrored memory ranges
> >   mm: Ratelimited mirrored memory related warning messages
> >   mm: Demote warning message in vmemmap_verify() to debug level
> >   mm: Add mirror flag back on initrd memory
> >   efi: Disable mirror feature if kernelcore is not specified
> >
> 
> I have tested these changes on QEMU/arm64 with the patch below, and
> things seem to work as expected. We have some minor issues to work out
> but the general shape of this code is good.
> 
> As for the mm/ changes: does anyone mind if I take those through the
> EFI tree as well?

No objections from me.

> I don't think the EFI and -mm changes depend on each other, so they
> can go into -mm separately as well.

--
Sincerely yours,
Mike.

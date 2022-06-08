Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69128542CF2
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jun 2022 12:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbiFHKQZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jun 2022 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiFHKP0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jun 2022 06:15:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1700925694C;
        Wed,  8 Jun 2022 03:03:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E21ECE2761;
        Wed,  8 Jun 2022 10:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3838CC3411C;
        Wed,  8 Jun 2022 10:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654682581;
        bh=IE2ioBq3LzKNaoMouoT+ks73JxPmJtR88S4lYSVl7wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAaCktvfr7A5t034XvRH9WIQQr/4Mw4S4pGwpHeH4fIQQ1OC3w+8pGZSBUX9y0GLQ
         mgtqq5MQh0C5UQQpqLNjTSzsmtJPE/Oo1imEyoWuCfIeYrcOmnTHfbOUvxxuxYbsOI
         XXKH0ppnWrlYoimgq23myaUGrrd9NdQaW16h4TGAmhBBX5NCp4i8cMQjk387d88JiQ
         uHPdkfVZdVxnaXX/xz4qB49xdyEassZxq7C5wW2GToi1PY1VMiyNP3XmyxUpSQhuD/
         w8hEhPJQlrPE5vkZm6aaML6rqgy/PNE0PefD+a42+p7LkMDHiSE2ZWn5MgafXB9SHF
         JV/9iIXozkOOA==
Date:   Wed, 8 Jun 2022 13:02:42 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     mawupeng <mawupeng1@huawei.com>
Cc:     ardb@kernel.org, david@redhat.com, corbet@lwn.net, will@kernel.org,
        catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, dvhart@infradead.org, andy@infradead.org,
        akpm@linux-foundation.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        swboyd@chromium.org, wei.liu@kernel.org, robin.murphy@arm.com,
        anshuman.khandual@arm.com, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, gpiccoli@igalia.com,
        chenhuacai@kernel.org, geert@linux-m68k.org, chenzhou10@huawei.com,
        vijayb@linux.microsoft.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 5/6] mm: Add mirror flag back on initrd memory
Message-ID: <YqBzwgTgWEAx8J/C@kernel.org>
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-6-mawupeng1@huawei.com>
 <99900b31-2605-2c85-a1b7-9ef2666b58da@redhat.com>
 <CAMj1kXGkzjq3koW_sgO4uzrdtwqSqzsJfT5ABYyvodf+ggXT2w@mail.gmail.com>
 <29900b05-ec44-76a2-645a-22a13399d7fd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29900b05-ec44-76a2-645a-22a13399d7fd@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 08, 2022 at 03:27:09PM +0800, mawupeng wrote:
> 
> 在 2022/6/7 22:49, Ard Biesheuvel 写道:
> > On Tue, 7 Jun 2022 at 14:22, David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > On 07.06.22 11:38, Wupeng Ma wrote:
> > > > From: Ma Wupeng <mawupeng1@huawei.com>
> > > > 
> > > > Initrd memory will be removed and then added in arm64_memblock_init() and this
> > > > will cause it to lose all of its memblock flags. The lost of MEMBLOCK_MIRROR
> > > > flag will lead to error log printed by find_zone_movable_pfns_for_nodes if
> > > > the lower 4G range has some non-mirrored memory.
> > > > 
> > > > In order to solve this problem, the lost MEMBLOCK_MIRROR flag will be
> > > > reinstalled if the origin memblock has this flag.
> > > > 
> > > > Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> > > > ---
> > > >   arch/arm64/mm/init.c     |  9 +++++++++
> > > >   include/linux/memblock.h |  1 +
> > > >   mm/memblock.c            | 20 ++++++++++++++++++++
> > > >   3 files changed, 30 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > > index 339ee84e5a61..11641f924d08 100644
> > > > --- a/arch/arm64/mm/init.c
> > > > +++ b/arch/arm64/mm/init.c
> > > > @@ -350,9 +350,18 @@ void __init arm64_memblock_init(void)
> > > >                        "initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
> > > >                        phys_initrd_size = 0;
> > > >                } else {
> > > > +                     int flags, ret;
> > > > +
> > > > +                     ret = memblock_get_flags(base, &flags);
> > > > +                     if (ret)
> > > > +                             flags = 0;
> > > > +
> > > >                        memblock_remove(base, size); /* clear MEMBLOCK_ flags */
> > > >                        memblock_add(base, size);
> > > >                        memblock_reserve(base, size);
> > > 
> > > Can you explain why we're removing+re-adding here exactly? Is it just to
> > > clear flags as the comment indicates?
> > > 
> > 
> > This should only happen if the placement of the initrd conflicts with
> > a mem= command line parameter or it is not covered by memblock for
> > some other reason.
> > 
> > IOW, this should never happen, and if re-memblock_add'ing this memory
> > unconditionally is causing problems, we should fix that instead of
> > working around it.
> 
> This will happen if we use initrdmem=3G,100M to reserve initrd memory below
> the 4G limit to test this scenario(just for testing, I have trouble to boot
> qemu with initrd enabled and memory below 4G are all mirror memory).
> 
> Re-memblock_add'ing this memory unconditionally seems fine but clear all
> flags(especially MEMBLOCK_MIRROR) may lead to some error log.
> 
> > 
> > > If it's really just about clearing flags, I wonder if we rather want to
> > > have an interface that does exactly that, and hides the way this is
> > > actually implemented (obtain flags, remove, re-add ...), internally.
> > > 
> > > But most probably there is more magic in the code and clearing flags
> > > isn't all it ends up doing.
> > > 
> > 
> > I don't remember exactly why we needed to clear the flags, but I think
> > it had to do with some corner case we hit when the initrd was
> > partially covered.
> If "mem=" is set in command line, memblock_mem_limit_remove_map() will
> remove all memory block without MEMBLOCK_NOMAP. Maybe this will bring the
> memory back if this initrd mem has the MEMBLOCK_NOMAP flag?
> 
> The rfc version [1] introduce and use memblock_clear_nomap() to clear the
> MEMBLOCK_NOMAP of this initrd memblock.
> So maybe the usage of memblock_remove() is just to avoid introducing new
> function(memblock_clear_nomap)?
> 
> Since commit 4c546b8a3469 ("memblock: add memblock_clear_nomap()") already
> introduced memblock_clear_nomap(). Can we use this to remove flag MEMBLOCK_NOMAP
> to solve this problem rather than bring flag MEMBLOCK_MIRROR back?

AFAICT, there are two corner cases that re-adding initrd memory covers:
* initrd memory is not a part of the memory reported to memblock, either
because of firmware weirdness or because it was cut out with mem=
* initrd memory overlaps a NOMAP region

So to make sure initrd memory is mapped properly and retains
MEMBLOCK_MIRROR I think the best we can do is

	memblock_add();
	memblock_clear_nomap();
	memblock_reserve();

 
> [1] https://lore.kernel.org/linux-arm-kernel/20160202180622.GP10166@arm.com/T/#t
> > .

-- 
Sincerely yours,
Mike.

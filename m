Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965775FF05E
	for <lists+linux-efi@lfdr.de>; Fri, 14 Oct 2022 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJNObz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Oct 2022 10:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJNOby (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Oct 2022 10:31:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCAD1974EE;
        Fri, 14 Oct 2022 07:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3330F61B8F;
        Fri, 14 Oct 2022 14:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A8AC4347C;
        Fri, 14 Oct 2022 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665757911;
        bh=mDcukcYJrmOVCxy575pvfds4Xv4av2d610QjGAZCSj0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SqMN0iJDAj7PIz8iruMtlpZ5+QU5LChyPkdDSDTuzxEHAjUJ5nwbe5fs7k03Sa45p
         qCLmHuZaT/MOXqCn+VMAiwApOMP6T08a5OcsKH/DI4svw1Y/xpyDyZkLu7Iu2cBWRj
         s8+TSEy9kVDSidGvy3OLQQuAtKup+iDZ+oJBgpvYwO5lnrBLNA75GpWn0TVzPZicnn
         hHz42HYJk0/X+s6ZMxzJpbpEtC+MxCK0/JZSxMP4WvMDcBpQNlLCpgQi+BP+9uvZ65
         mV1eO+sjdyQ7GPgahWJ9YIR61esUFHFqt0Ldqk6zc4T/+t+EWv2X75EqqL4B4X2wUF
         B50ueHEPp56qg==
Received: by mail-lf1-f43.google.com with SMTP id d6so7466657lfs.10;
        Fri, 14 Oct 2022 07:31:51 -0700 (PDT)
X-Gm-Message-State: ACrzQf0CymTt8OJ4b1f4GiJPvG4lr0WUR0hTCuLBavqWqbGxs5XoUN+J
        jPPJ2TgHvHkYoX8lcpBVeLoo/2gepTnAJa/bu4s=
X-Google-Smtp-Source: AMsMyM5LHwQZmnwLviheiBh5Mdklsidx+rUX9A8o2tes8uj4vB5PU4Dki2egGdEli825gIwBEahWXDs6pyMp3N4itg4=
X-Received: by 2002:ac2:4c47:0:b0:4a2:c07b:4b62 with SMTP id
 o7-20020ac24c47000000b004a2c07b4b62mr1724753lfk.426.1665757909466; Fri, 14
 Oct 2022 07:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221010023559.69655-1-justin.he@arm.com> <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic> <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic> <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0gUpoaUBKw/jjaD@zn.tnic> <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
 <DBBPR08MB453845A7A15596F6FE96DBC9F7249@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB453845A7A15596F6FE96DBC9F7249@DBBPR08MB4538.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Oct 2022 16:31:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHrP_P79ObKPFFgpN-X7gN+zaN1vKbsQZTJGvm=Uoav3g@mail.gmail.com>
Message-ID: <CAMj1kXHrP_P79ObKPFFgpN-X7gN+zaN1vKbsQZTJGvm=Uoav3g@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
To:     Justin He <Justin.He@arm.com>
Cc:     Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 14 Oct 2022 at 14:00, Justin He <Justin.He@arm.com> wrote:
>
> Hi Ard
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Thursday, October 13, 2022 11:41 PM
> > To: Borislav Petkov <bp@alien8.de>
> > Cc: Justin He <Justin.He@arm.com>; Len Brown <lenb@kernel.org>; James
> > Morse <James.Morse@arm.com>; Tony Luck <tony.luck@intel.com>; Mauro
> > Carvalho Chehab <mchehab@kernel.org>; Robert Richter <rric@kernel.org>;
> > Robert Moore <robert.moore@intel.com>; Qiuxu Zhuo
> > <qiuxu.zhuo@intel.com>; Yazen Ghannam <yazen.ghannam@amd.com>; Jan
> > Luebbe <jlu@pengutronix.de>; Khuong Dinh
> > <khuong@os.amperecomputing.com>; Kani Toshi <toshi.kani@hpe.com>;
> > linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-edac@vger.kernel.org; devel@acpica.org; Rafael J . Wysocki
> > <rafael@kernel.org>; Shuai Xue <xueshuai@linux.alibaba.com>; Jarkko
> > Sakkinen <jarkko@kernel.org>; linux-efi@vger.kernel.org; nd <nd@arm.com>;
> > kernel test robot <lkp@intel.com>
> > Subject: Re: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
> >
> > On Thu, 13 Oct 2022 at 15:37, Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Wed, Oct 12, 2022 at 12:04:57PM +0000, Justin He wrote:
> > > > I have a concern about what if cmpxchg failed? Do we have to still
> > > > guarantee the ordering since cmpxchg will not imply a smp_mb if it
> > > > failed.
> > >
> > > Of course it will imply that. At least on x86 it does. smp_wmb() is a
> > > compiler barrier there and cmpxchg() already has that barrier
> > > semantics by clobbering "memory". I'm pretty sure you should have the
> > > same thing on ARM.
> > >
> >
> > No it definitely does not imply that. A memory clobber is a codegen construct,
> > and the hardware could still complete the writes in a way that could result in
> > another observer seeing a mix of old and new values that is inconsistent with
> > the ordering of the stores as issued by the compiler.
> >
> > > says, "new_cache must be put into array after its contents are written".
> > >
> > > Are we writing anything into the cache if cmpxchg fails?
> > >
> >
> > The cache fields get updated but the pointer to the struct is never shared
> > globally if the cmpxchg() fails so not having the barrier on failure should not be
> > an issue here.
> >
> > > > Besides, I didn't find the paired smp_mb or smp_rmb for this smp_wmb.
> > >
> > > Why would there be pairs? I don't understand that statement here.
> > >
> >
> > Typically, the other observer pairs the write barrier with a read barrier.
> >
> > In this case, the other observer appears to be ghes_estatus_cached(), and the
> > reads of the cache struct fields must be ordered after the read of the cache
> > struct's address. However, there is an implicit ordering there through an address
> > dependency (you cannot dereference a struct without knowing its address) so
> > the ordering is implied (and
> > rcu_dereference() has a READ_ONCE() inside so we are guaranteed to always
> > dereference the same struct, even if the array slot gets updated concurrently.)
> >
> > If you want to get rid of the barrier, you could drop it and change the cmpxchg()
> > to cmpxchg_release().
> >
> > Justin: so why are the RCU_INITIALIZER()s needed here?
>
> In my this patch, I add the "__rcu" to the definition of ghes_estatus_caches. Hence
> Sparse will still have the warning on X86 with this RCU_INITIALIZER cast.
> drivers/acpi/apei/ghes.c:843:27: sparse: warning: incorrect type in initializer (different address spaces)
> drivers/acpi/apei/ghes.c:843:27: sparse:    expected struct ghes_estatus_cache [noderef] __rcu *__old
> drivers/acpi/apei/ghes.c:843:27: sparse:    got struct ghes_estatus_cache *[assigned] slot_cache
> drivers/acpi/apei/ghes.c:843:27: sparse: warning: incorrect type in initializer (different address spaces)
> drivers/acpi/apei/ghes.c:843:27: sparse:    expected struct ghes_estatus_cache [noderef] __rcu *__new
> drivers/acpi/apei/ghes.c:843:27: sparse:    got struct ghes_estatus_cache *[assigned] new_cache
>
> On Arm, IMO the macro cmpxchg doesn't care about it, that is, sparse will not report warnings with or
> without RCU_INITIALIZER cast.
>
> I tend to remain this cast, what do you think of it.
>

OK, fair enough, I had only tested the arm64 build myself.

But just putting unrcu_pointer() and RCU_INITIALIZER() arbitrarily to
shut up sparse is a bit sloppy, imho. Passing around pointers like
this code does makes that necessary, unfortunately, so it would be
nice if we could clean that up, by getting rid of the slot_cache
variable.

And now that I have spent some time looking at this code, I wonder
what the point of the cmpxchg() is in the first place.
ghes_estatus_cache_add() selects a slot, and either succeeds in
replacing its contents with a pointer to a new cached item, or it just
gives up and frees the new item again, without attempting to select
another slot even if one might be available.

Since we only insert new items, the race can only cause a failure if
the selected slot was updated with another new item concurrently,
which means that it is arbitrary which of those two items gets
dropped. This means we don't need the cmpxchg() and the special case,
and we can just drop the existing item unconditionally. Note that this
does not result in loss of error events, it simply means we might
cause a false cache miss, and report the same event one additional
time in quick succession even if the cache should have prevented that.


------------------------8<------------------------------
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 80ad530583c9..03acdfa35dab 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -138,7 +138,7 @@ struct ghes_vendor_record_entry {
 static struct gen_pool *ghes_estatus_pool;
 static unsigned long ghes_estatus_pool_size_request;

-static struct ghes_estatus_cache
*ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
+static struct ghes_estatus_cache __rcu
*ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;

 static int ghes_panic_timeout __read_mostly = 30;
@@ -773,31 +773,26 @@ static struct ghes_estatus_cache
*ghes_estatus_cache_alloc(
        return cache;
 }

-static void ghes_estatus_cache_free(struct ghes_estatus_cache *cache)
+static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
 {
+       struct ghes_estatus_cache *cache;
        u32 len;

+       cache = container_of(head, struct ghes_estatus_cache, rcu);
        len = cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
        len = GHES_ESTATUS_CACHE_LEN(len);
        gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
        atomic_dec(&ghes_estatus_cache_alloced);
 }

-static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
-{
-       struct ghes_estatus_cache *cache;
-
-       cache = container_of(head, struct ghes_estatus_cache, rcu);
-       ghes_estatus_cache_free(cache);
-}
-
 static void ghes_estatus_cache_add(
        struct acpi_hest_generic *generic,
        struct acpi_hest_generic_status *estatus)
 {
        int i, slot = -1, count;
        unsigned long long now, duration, period, max_period = 0;
-       struct ghes_estatus_cache *cache, *slot_cache = NULL, *new_cache;
+       struct ghes_estatus_cache *cache, *new_cache;
+       struct ghes_estatus_cache __rcu *victim;

        new_cache = ghes_estatus_cache_alloc(generic, estatus);
        if (new_cache == NULL)
@@ -808,13 +803,11 @@ static void ghes_estatus_cache_add(
                cache = rcu_dereference(ghes_estatus_caches[i]);
                if (cache == NULL) {
                        slot = i;
-                       slot_cache = NULL;
                        break;
                }
                duration = now - cache->time_in;
                if (duration >= GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
                        slot = i;
-                       slot_cache = cache;
                        break;
                }
                count = atomic_read(&cache->count);
@@ -823,17 +816,28 @@ static void ghes_estatus_cache_add(
                if (period > max_period) {
                        max_period = period;
                        slot = i;
-                       slot_cache = cache;
                }
        }
-       /* new_cache must be put into array after its contents are written */
-       smp_wmb();
-       if (slot != -1 && cmpxchg(ghes_estatus_caches + slot,
-                                 slot_cache, new_cache) == slot_cache) {
-               if (slot_cache)
-                       call_rcu(&slot_cache->rcu, ghes_estatus_cache_rcu_free);
-       } else
-               ghes_estatus_cache_free(new_cache);
+       if (slot != -1) {
+               /*
+                * Use release semantics to ensure that ghes_estatus_cached()
+                * running on another CPU will see the updated cache fields if
+                * it can see the new value of the pointer.
+                */
+               victim = xchg_release(ghes_estatus_caches + slot,
+                                     RCU_INITIALIZER(new_cache));
+
+               /*
+                * At this point, victim may point to a cached item different
+                * from the one based on which we selected the slot. Instead of
+                * going to the loop again to pick another slot, let's just
+                * drop the other item anyway: this may cause a false cache
+                * miss later on, but that won't cause any problems.
+                */
+               if (victim)
+                       call_rcu(&rcu_dereference(victim)->rcu,
+                                ghes_estatus_cache_rcu_free);
+       }
        rcu_read_unlock();
 }

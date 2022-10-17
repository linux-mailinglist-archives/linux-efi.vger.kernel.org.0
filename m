Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5497601148
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiJQOjo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiJQOjn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 10:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7644DF43;
        Mon, 17 Oct 2022 07:39:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F8316117D;
        Mon, 17 Oct 2022 14:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97457C43144;
        Mon, 17 Oct 2022 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666017576;
        bh=S3adBKWWRCbdw9aTgDVjLyyamcpV9tzhi9nN0qio5y8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bkZec/mpzcK73DGRsO+9WMq/Vf5m3ykC5aBPApPU4IlCMDH/aVBUT6I0Xcr+eR1vi
         latXBJJn9/vjqk+Cmg3zR8EZ18LjveNkJxgSQHO0b6oqQ6sJKJIbwom6zZh0xOBWSj
         oHmxLPQjjacMwWcJYTQwvXDUYaKLd7RgFWyrS/gaymZeeCaCBcw04K6kOKaMdH52hC
         8kuWJnaipTMtjkAqtwXBGuaU5bF3t1m6zpN3iz03ulc7N9sigKx9tZEeE2aeow9XLA
         V8xWJnLvFkTABpmBnID3kfXpocnADmMUA6jchPTPVMC3emP5huEQdY4kYMT0HLUvXE
         bV3P5Rn20U/ow==
Received: by mail-lf1-f49.google.com with SMTP id f37so17819625lfv.8;
        Mon, 17 Oct 2022 07:39:36 -0700 (PDT)
X-Gm-Message-State: ACrzQf2pjYg+1o41l68BmIxh8yBnAO5i7KDzKrgd/e+wnqkIykLzGOvU
        sXRLt4OS1YyVbb2ewwussiAIqtl+5bzRftrNXJ0=
X-Google-Smtp-Source: AMsMyM55z/nkRG2B+V8V1IwJyHIiMNsM2xHM1VyPrZy9VQr+/mQ4Twt2BgzGR8m3xY0sgjtNJw8gKq0UoiD0ohuDQKQ=
X-Received: by 2002:ac2:4c47:0:b0:4a2:c07b:4b62 with SMTP id
 o7-20020ac24c47000000b004a2c07b4b62mr3839451lfk.426.1666017574462; Mon, 17
 Oct 2022 07:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221017130140.420986-1-justin.he@arm.com> <20221017130140.420986-7-justin.he@arm.com>
In-Reply-To: <20221017130140.420986-7-justin.he@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Oct 2022 16:39:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEge+PtOHug2FhnbAetDLOTJ4jguC4uwA4oORbu-25YiA@mail.gmail.com>
Message-ID: <CAMj1kXEge+PtOHug2FhnbAetDLOTJ4jguC4uwA4oORbu-25YiA@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] apei/ghes: Use xchg_release() for updating new
 cache slot instead of cmpxchg()
To:     Jia He <justin.he@arm.com>
Cc:     Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 17 Oct 2022 at 15:02, Jia He <justin.he@arm.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> ghes_estatus_cache_add() selects a slot, and either succeeds in
> replacing its contents with a pointer to a new cached item, or it just
> gives up and frees the new item again, without attempting to select
> another slot even if one might be available.
>
> Since only inserting new items is needed, the race can only cause a failure
> if the selected slot was updated with another new item concurrently,
> which means that it is arbitrary which of those two items gets
> dropped. This means the cmpxchg() and the special case are not necessary,
> and hence just drop the existing item unconditionally. Note that this
> does not result in loss of error events, it simply means we might
> cause a false cache miss, and report the same event one additional
> time in quick succession even if the cache should have prevented that.
>
> Move the xchg_release() and call_rcu out of rcu_read_lock/unlock section
> since there is no actually dereferencing the pointer at all.
>
> Co-developed-by: Jia He <justin.he@arm.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/acpi/apei/ghes.c | 47 +++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 27c72b175e4b..5d7754053ca0 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -150,7 +150,7 @@ struct ghes_vendor_record_entry {
>  static struct gen_pool *ghes_estatus_pool;
>  static unsigned long ghes_estatus_pool_size_request;
>
> -static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
> +static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>  static atomic_t ghes_estatus_cache_alloced;
>
>  static int ghes_panic_timeout __read_mostly = 30;
> @@ -785,31 +785,26 @@ static struct ghes_estatus_cache *ghes_estatus_cache_alloc(
>         return cache;
>  }
>
> -static void ghes_estatus_cache_free(struct ghes_estatus_cache *cache)
> +static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
>  {
> +       struct ghes_estatus_cache *cache;
>         u32 len;
>
> +       cache = container_of(head, struct ghes_estatus_cache, rcu);
>         len = cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
>         len = GHES_ESTATUS_CACHE_LEN(len);
>         gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
>         atomic_dec(&ghes_estatus_cache_alloced);
>  }
>
> -static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
> -{
> -       struct ghes_estatus_cache *cache;
> -
> -       cache = container_of(head, struct ghes_estatus_cache, rcu);
> -       ghes_estatus_cache_free(cache);
> -}
> -
>  static void ghes_estatus_cache_add(
>         struct acpi_hest_generic *generic,
>         struct acpi_hest_generic_status *estatus)
>  {
>         int i, slot = -1, count;
>         unsigned long long now, duration, period, max_period = 0;
> -       struct ghes_estatus_cache *cache, *slot_cache = NULL, *new_cache;
> +       struct ghes_estatus_cache *cache, *new_cache;
> +       struct ghes_estatus_cache __rcu *victim;
>
>         new_cache = ghes_estatus_cache_alloc(generic, estatus);
>         if (new_cache == NULL)
> @@ -820,13 +815,11 @@ static void ghes_estatus_cache_add(
>                 cache = rcu_dereference(ghes_estatus_caches[i]);
>                 if (cache == NULL) {
>                         slot = i;
> -                       slot_cache = NULL;
>                         break;
>                 }
>                 duration = now - cache->time_in;
>                 if (duration >= GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
>                         slot = i;
> -                       slot_cache = cache;
>                         break;
>                 }
>                 count = atomic_read(&cache->count);
> @@ -835,18 +828,28 @@ static void ghes_estatus_cache_add(
>                 if (period > max_period) {
>                         max_period = period;
>                         slot = i;
> -                       slot_cache = cache;
>                 }
>         }
> -       /* new_cache must be put into array after its contents are written */
> -       smp_wmb();
> -       if (slot != -1 && cmpxchg(ghes_estatus_caches + slot,
> -                                 slot_cache, new_cache) == slot_cache) {
> -               if (slot_cache)
> -                       call_rcu(&slot_cache->rcu, ghes_estatus_cache_rcu_free);
> -       } else
> -               ghes_estatus_cache_free(new_cache);
>         rcu_read_unlock();
> +
> +       if (slot != -1) {
> +               /*
> +                * Use release semantics to ensure that ghes_estatus_cached()
> +                * running on another CPU will see the updated cache fields if
> +                * it can see the new value of the pointer.
> +                */
> +               victim = xchg_release(&ghes_estatus_caches[slot], new_cache);
> +

This still lacks the RCU_INITIALIZER()

> +               /*
> +                * At this point, victim may point to a cached item different
> +                * from the one based on which we selected the slot. Instead of
> +                * going to the loop again to pick another slot, let's just
> +                * drop the other item anyway: this may cause a false cache
> +                * miss later on, but that won't cause any problems.
> +                */
> +               if (victim)
> +                       call_rcu(unrcu_pointer(&victim->rcu), ghes_estatus_cache_rcu_free);

Please use &unrcu_pointer(victim)->rcu here.

> +       }
>  }
>
>  static void __ghes_panic(struct ghes *ghes,
> --
> 2.25.1
>

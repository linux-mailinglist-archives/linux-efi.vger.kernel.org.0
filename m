Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF76C60C6DD
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 10:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiJYItA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 04:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiJYIs7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 04:48:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60B6119BE8;
        Tue, 25 Oct 2022 01:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE7F61800;
        Tue, 25 Oct 2022 08:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3A2C43145;
        Tue, 25 Oct 2022 08:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666687737;
        bh=ALIxJODN8NmEqkhMN2hY8APBG9FTNhCT6kj466I4hUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CtSn2D0fFEh6IEUzioIUUeXuNYUMwvDIwFCgUVr+EUlH9OHceRmf9ksLvMt9hgh2y
         M4J17CAUi6Ny9CsgZzQN0U4DIlk3AGxL1YtZF5VpuNp2TV1DY3krHI77JU8ejMqp8A
         Z3BdLH4U5TbRpCqE8S/s4Wcfh8UX21XNtM3MZC/nQRO2ZSN1GplJFXHR0S7+gESe4I
         VivLkNzgZHOaIZLDWTCW/3OU0hoRem7ud+l6OHfF2L0wvykgCM3lkGraDvyYy8NBpd
         xcuh4ytAG9znVtIB0Yclv6dZ7JClwVevfP1bBuygxvUHQkdXLkuf8e8EtyAqnOXn7z
         J7Ja7v1mGnTvw==
Received: by mail-lj1-f178.google.com with SMTP id a15so11215931ljb.7;
        Tue, 25 Oct 2022 01:48:57 -0700 (PDT)
X-Gm-Message-State: ACrzQf36Rx6NzWtoykWvLAS/4Uag6mB0TZZXE/U7DwpgANgd+3I7sXoj
        BfFRE8HeBlpydpJC2rbgoqCXa6VNL9n8j3tVtCA=
X-Google-Smtp-Source: AMsMyM5ruveAK0IGw1O/2pni0OsgQxULbYs2QLIbQuz2DUemeGnjHpRMJjxOsbwBcn0lW/rgzmNDw73f7Aj9mi9iRzg=
X-Received: by 2002:a2e:9a81:0:b0:26c:5b63:7a83 with SMTP id
 p1-20020a2e9a81000000b0026c5b637a83mr14800333lji.291.1666687735537; Tue, 25
 Oct 2022 01:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221018082214.569504-1-justin.he@arm.com> <20221018082214.569504-7-justin.he@arm.com>
 <Y1OtRpLRwPPG/4Il@zn.tnic> <CAMj1kXFu36faTPoGSGPs9KhcKsoh_DE9X2rmwdenxaJwa3P_yw@mail.gmail.com>
 <Y1O/QN32d2AlzEiA@zn.tnic> <Y1ayrYZgLqjp7WOG@zn.tnic>
In-Reply-To: <Y1ayrYZgLqjp7WOG@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Oct 2022 10:48:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXV6XwLV9ydNrM1Ap_TjTXna=x8xdAM6D2_BwhM9KmZg@mail.gmail.com>
Message-ID: <CAMj1kXEXV6XwLV9ydNrM1Ap_TjTXna=x8xdAM6D2_BwhM9KmZg@mail.gmail.com>
Subject: Re: [PATCH] apei/ghes: Use xchg_release() for updating new cache slot
 instead of cmpxchg()
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
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
        devel@acpica.org, Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 24 Oct 2022 at 17:43, Borislav Petkov <bp@alien8.de> wrote:
>
> Ok,
>
> here's what I've done to it, holler if something's still missing.
>
> @rjw, if you wanna take this through your tree, it should work too - it
> is unrelated to the ghes_edac changes we're doing. Or I can carry it,
> whatever you prefer.
>

Thanks for summarizing that, I'm sure it will be helpful some day :-)



> ---
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Some documentation first, about how this machinery works:
>
> It seems, the intent of the GHES error records cache is to collect
> already reported errors - see the ghes_estatus_cached() checks. There's
> even a sentence trying to say what this does:
>
>   /*
>    * GHES error status reporting throttle, to report more kinds of
>    * errors, instead of just most frequently occurred errors.
>    */
>
> New elements are added to the cache this way:
>
>   if (!ghes_estatus_cached(estatus)) {
>           if (ghes_print_estatus(NULL, ghes->generic, estatus))
>                   ghes_estatus_cache_add(ghes->generic, estatus);
>
> The intent being, once this new error record is reported, it gets cached
> so that it doesn't get reported for a while due to too many, same-type
> error records getting reported in burst-like scenarios. I.e., new,
> unreported error types can have a higher chance of getting reported.
>
> Now, the loop in ghes_estatus_cache_add() is trying to pick out the
> oldest element in there. Meaning, something which got reported already
> but a long while ago, i.e., a LRU-type scheme.
>
> And the cmpxchg() is there presumably to make sure when that selected
> element slot_cache is removed, it really *is* that element that gets
> removed and not one which replaced it in the meantime.
>
> Now, ghes_estatus_cache_add() selects a slot, and either succeeds in
> replacing its contents with a pointer to a newly cached item, or it just
> gives up and frees the new item again, without attempting to select
> another slot even if one might be available.
>
> Since only inserting new items is being done here, the race can only
> cause a failure if the selected slot was updated with another new item
> concurrently, which means that it is arbitrary which of those two items
> gets dropped.
>
> And "dropped" here means, the item doesn't get added to the cache so
> the next time it is seen, it'll get reported again and an insertion
> attempt will be done again. Eventually, it'll get inserted and all those
> times when the insertion fails, the item will get reported although the
> cache is supposed to prevent that and "ratelimit" those repeated error
> records. Not a big deal in any case.
>
> This means the cmpxchg() and the special case are not necessary.
> Therefore, just drop the existing item unconditionally.
>
> Move the xchg_release() and call_rcu() out of rcu_read_lock/unlock
> section since there is no actually dereferencing the pointer at all.
>
>   [ bp:
>     - Flesh out and summarize what was discussed on the thread now
>       that that cache contraption is understood;
>     - Touch up code style. ]
>
> Co-developed-by: Jia He <justin.he@arm.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lore.kernel.org/r/20221010023559.69655-7-justin.he@arm.com
> ---
>  drivers/acpi/apei/ghes.c | 60 ++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 249cd01cb920..6164bf737ee6 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -154,7 +154,7 @@ struct ghes_vendor_record_entry {
>  static struct gen_pool *ghes_estatus_pool;
>  static unsigned long ghes_estatus_pool_size_request;
>
> -static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
> +static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>  static atomic_t ghes_estatus_cache_alloced;
>
>  static int ghes_panic_timeout __read_mostly = 30;
> @@ -789,48 +789,42 @@ static struct ghes_estatus_cache *ghes_estatus_cache_alloc(
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
> -static void ghes_estatus_cache_add(
> -       struct acpi_hest_generic *generic,
> -       struct acpi_hest_generic_status *estatus)
> +static void
> +ghes_estatus_cache_add(struct acpi_hest_generic *generic,
> +                      struct acpi_hest_generic_status *estatus)
>  {
> -       int i, slot = -1, count;
>         unsigned long long now, duration, period, max_period = 0;
> -       struct ghes_estatus_cache *cache, *slot_cache = NULL, *new_cache;
> +       struct ghes_estatus_cache *cache, *new_cache;
> +       struct ghes_estatus_cache __rcu *victim;
> +       int i, slot = -1, count;
>
>         new_cache = ghes_estatus_cache_alloc(generic, estatus);
> -       if (new_cache == NULL)
> +       if (!new_cache)
>                 return;
> +
>         rcu_read_lock();
>         now = sched_clock();
>         for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
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
> @@ -839,18 +833,30 @@ static void ghes_estatus_cache_add(
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
> +               victim = xchg_release(&ghes_estatus_caches[slot],
> +                                     RCU_INITIALIZER(new_cache));
> +
> +               /*
> +                * At this point, victim may point to a cached item different
> +                * from the one based on which we selected the slot. Instead of
> +                * going to the loop again to pick another slot, let's just
> +                * drop the other item anyway: this may cause a false cache
> +                * miss later on, but that won't cause any problems.
> +                */
> +               if (victim)
> +                       call_rcu(&unrcu_pointer(victim)->rcu,
> +                                ghes_estatus_cache_rcu_free);
> +       }
>  }
>
>  static void __ghes_panic(struct ghes *ghes,
> --
> 2.35.1
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

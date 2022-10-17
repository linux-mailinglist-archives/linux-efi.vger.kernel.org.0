Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05B3600AA8
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 11:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJQJ2E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 05:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiJQJ2C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 05:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E8B58DEF;
        Mon, 17 Oct 2022 02:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 060F060FE5;
        Mon, 17 Oct 2022 09:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613B4C433C1;
        Mon, 17 Oct 2022 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665998851;
        bh=tsjHF/ZW38t4aO0UmlYwxV09JTSHo1oGEGHw3AMx5xg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CTAAfVq6VZiLxSTJoLnt66JMAMq+4aPo/YJB0z5MRMy3olTWcxhRIIZ1PDi801UaP
         SVnDHPPjtlhT2EIEfKpi/viEzp66QCDLvi3rdqOj2P/ASJ2n+WUCBYBrtj0B8ZXNr3
         gTFQgblalrWo1eiq37b4t8wlXSyemakt8XInDPB0RNjGeS+lVg9Q2mWl+hsFpm1rGq
         eUj8R/2tHKBZMic3H+uw8AyeK9Iy7Pv4Z/IkaMrFeWFfVKEoc+WLeACygLZuCbRz3Y
         DeeXxvdJGwx3NXgTLrw+OLLLlcyX/VLLPvpiyx49rDpTSiqac+f6NpRTVA41N2076Q
         c20gDleluWr2Q==
Received: by mail-lf1-f46.google.com with SMTP id o12so8097346lfq.9;
        Mon, 17 Oct 2022 02:27:31 -0700 (PDT)
X-Gm-Message-State: ACrzQf1CiD4PFCAycz2Iao6fr2ZU9tVowE+MteRW/Gy2XDfrDIDUfp89
        w5kcFI4zHuyGi0YBkjwtC3FrGDxHaQ22kBiu97Q=
X-Google-Smtp-Source: AMsMyM4gNARDWEb4YnDBpRg3rWLb0SlDoLy9Utl2gMjjLg4VUnwoQUoNQZbywHEDs/RA8BzuZH1RLJeVwtzm/3lR+QE=
X-Received: by 2002:a05:6512:3119:b0:4a2:d749:ff82 with SMTP id
 n25-20020a056512311900b004a2d749ff82mr3858788lfb.637.1665998849373; Mon, 17
 Oct 2022 02:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221010023559.69655-1-justin.he@arm.com> <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic> <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic> <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0gUpoaUBKw/jjaD@zn.tnic> <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
 <DBBPR08MB453845A7A15596F6FE96DBC9F7249@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXHrP_P79ObKPFFgpN-X7gN+zaN1vKbsQZTJGvm=Uoav3g@mail.gmail.com>
 <Y0l8AeQCrMLYW6g3@hirez.programming.kicks-ass.net> <CAMj1kXENTJVZU27PYqwWGod4ESkTxgJ8+2vdqWjR5DVRSbNGDg@mail.gmail.com>
 <DBBPR08MB4538066E9C43FCF2983C8B60F7299@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB4538066E9C43FCF2983C8B60F7299@DBBPR08MB4538.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Oct 2022 11:27:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFNEtGYBefwcSLvs8XokyiZXDypC9mCgZhCkbVkS09Jog@mail.gmail.com>
Message-ID: <CAMj1kXFNEtGYBefwcSLvs8XokyiZXDypC9mCgZhCkbVkS09Jog@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
To:     Justin He <Justin.He@arm.com>
Cc:     Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Justin,

On Mon, 17 Oct 2022 at 10:47, Justin He <Justin.He@arm.com> wrote:
>
> Hi Ard
>
> > -----Original Message-----
> > Subject: Re: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
> >
> > On Fri, 14 Oct 2022 at 17:11, Peter Zijlstra <peterz@infradead.org> wro=
te:
> > >
> > > On Fri, Oct 14, 2022 at 04:31:37PM +0200, Ard Biesheuvel wrote:
> > > > +       if (slot !=3D -1) {
> > > > +               /*
> > > > +                * Use release semantics to ensure that
> > ghes_estatus_cached()
> > > > +                * running on another CPU will see the updated cach=
e
> > fields if
> > > > +                * it can see the new value of the pointer.
> > > > +                */
> > > > +               victim =3D xchg_release(ghes_estatus_caches + slot,
> > > > +
> > RCU_INITIALIZER(new_cache));
> > > > +
> > > > +               /*
> > > > +                * At this point, victim may point to a cached item
> > different
> > > > +                * from the one based on which we selected the slot=
.
> > Instead of
> > > > +                * going to the loop again to pick another slot, le=
t's
> > just
> > > > +                * drop the other item anyway: this may cause a fal=
se
> > cache
> > > > +                * miss later on, but that won't cause any problems=
.
> > > > +                */
> > > > +               if (victim) {
> > > > +                       call_rcu(&rcu_dereference(victim)->rcu,
> > > > +                                ghes_estatus_cache_rcu_free);
> > >                 }
> > >
> > > I think you can use unrcu_pointer() here instead, there should not be
> > > a data dependency since the ->rcu member itself should be otherwise
> > > unused (and if it were, we wouldn't care about its previous content a=
nyway).
> > >
> > > But only Alpha cares about that distinction anyway, so *shrug*.
> > >
> >
> > Ah yeah good point - and we are not actually dereferencing the pointer =
at all
> > here, just adding an offset to get at the address of the rcu member.
> >
> > So we can take this block out of the rcu_read_lock() section as well.
> >
> >
> > > While I much like the xchg() variant; I still don't really fancy the
> > > verbage the sparse nonsense makes us do.
> > >
> > >                 victim =3D xchg_release(&ghes_estatus_caches[slot],
> > new_cache);
> > >                 if (victim)
> > >                         call_rcu(&victim->rcu,
> > > ghes_estatus_cache_rcu_free);
> > >
> > > is much nicer code.
> > >
> > > Over all; I'd simply ignore sparse (I often do).
> > >
> >
> > No disagreement there.
>
> What do you think of the updated patch:
>
> apei/ghes: Use xchg() for updating new cache slot instead of
>  cmpxchg()
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> ghes_estatus_cache_add() selects a slot, and either succeeds in
> replacing its contents with a pointer to a new cached item, or it just
> gives up and frees the new item again, without attempting to select
> another slot even if one might be available.
>
> Since only inserting new items is needed, the race can only cause a failu=
re
> if the selected slot was updated with another new item concurrently,
> which means that it is arbitrary which of those two items gets
> dropped. This means the cmpxchg() and the special case are not necessary,
> and hence just drop the existing item unconditionally. Note that this
> does not result in loss of error events, it simply means we might
> cause a false cache miss, and report the same event one additional
> time in quick succession even if the cache should have prevented that.
>

Please add a line here

Co-developed-by: Jia He <justin.he@arm.com>

> Signed-off-by: Jia He <justin.he@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> [Justin]: I removed __rcu annotation of victim, removed the RCU_INITIALIZ=
ER
> cast and added the unptr for xchg.
>
> drivers/acpi/apei/ghes.c | 44 ++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 27c72b175e4b..5fc8a135450b 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -150,7 +150,7 @@ struct ghes_vendor_record_entry {
>  static struct gen_pool *ghes_estatus_pool;
>  static unsigned long ghes_estatus_pool_size_request;
>
> -static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHE=
S_SIZE];
> +static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS=
_CACHES_SIZE];
>  static atomic_t ghes_estatus_cache_alloced;
>
>  static int ghes_panic_timeout __read_mostly =3D 30;
> @@ -785,31 +785,26 @@ static struct ghes_estatus_cache *ghes_estatus_cach=
e_alloc(
>         return cache;
>  }
>
> -static void ghes_estatus_cache_free(struct ghes_estatus_cache *cache)
> +static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
>  {
> +       struct ghes_estatus_cache *cache;
>         u32 len;
>
> +       cache =3D container_of(head, struct ghes_estatus_cache, rcu);
>         len =3D cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
>         len =3D GHES_ESTATUS_CACHE_LEN(len);
>         gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
>         atomic_dec(&ghes_estatus_cache_alloced);
>  }
>
> -static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
> -{
> -       struct ghes_estatus_cache *cache;
> -
> -       cache =3D container_of(head, struct ghes_estatus_cache, rcu);
> -       ghes_estatus_cache_free(cache);
> -}
> -
>  static void ghes_estatus_cache_add(
>         struct acpi_hest_generic *generic,
>         struct acpi_hest_generic_status *estatus)
>  {
>         int i, slot =3D -1, count;
>         unsigned long long now, duration, period, max_period =3D 0;
> -       struct ghes_estatus_cache *cache, *slot_cache =3D NULL, *new_cach=
e;
> +       struct ghes_estatus_cache *cache, *new_cache;
> +       struct ghes_estatus_cache *victim;
>
>         new_cache =3D ghes_estatus_cache_alloc(generic, estatus);
>         if (new_cache =3D=3D NULL)
> @@ -820,13 +815,11 @@ static void ghes_estatus_cache_add(
>                 cache =3D rcu_dereference(ghes_estatus_caches[i]);
>                 if (cache =3D=3D NULL) {
>                         slot =3D i;
> -                       slot_cache =3D NULL;
>                         break;
>                 }
>                 duration =3D now - cache->time_in;
>                 if (duration >=3D GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
>                         slot =3D i;
> -                       slot_cache =3D cache;
>                         break;
>                 }
>                 count =3D atomic_read(&cache->count);
> @@ -835,17 +828,24 @@ static void ghes_estatus_cache_add(
>                 if (period > max_period) {
>                         max_period =3D period;
>                         slot =3D i;
> -                       slot_cache =3D cache;
>                 }
>         }
> -       /* new_cache must be put into array after its contents are writte=
n */
> -       smp_wmb();
> -       if (slot !=3D -1 && cmpxchg(ghes_estatus_caches + slot,
> -                                 slot_cache, new_cache) =3D=3D slot_cach=
e) {
> -               if (slot_cache)
> -                       call_rcu(&slot_cache->rcu, ghes_estatus_cache_rcu=
_free);
> -       } else
> -               ghes_estatus_cache_free(new_cache);
> +       if (slot !=3D -1) {
> +               /*
> +                * Use release semantics to ensure that ghes_estatus_cach=
ed()
> +                * running on another CPU will see the updated cache fiel=
ds if
> +                * it can see the new value of the pointer.

Please move the comment back where it was. 'At this point' is now
ambiguous because victim has not been assigned yet.

> +                * At this point, victim may point to a cached item diffe=
rent
> +                * from the one based on which we selected the slot. Inst=
ead of
> +                * going to the loop again to pick another slot, let's ju=
st
> +                * drop the other item anyway: this may cause a false cac=
he
> +                * miss later on, but that won't cause any problems.
> +                */
> +               victim =3D unrcu_pointer(xchg_release(&ghes_estatus_cache=
s[slot],
> +                                       new_cache));

Doesn't this still trigger the sparse warning on x86?

> +               if (victim)
> +                       call_rcu(&victim->rcu, ghes_estatus_cache_rcu_fre=
e);

I think it is better to add back the __rcu annotation to 'victim', and
change this line to

call_rcu(&unrcu_pointer(victim)->rcu, ghes_estatus_cache_rcu_free);

> +       }
>         rcu_read_unlock();

This can now be moved before the if()

>  }
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.

Please get rid of this footer.

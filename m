Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD335FF13C
	for <lists+linux-efi@lfdr.de>; Fri, 14 Oct 2022 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJNPY5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Oct 2022 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJNPYt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Oct 2022 11:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAA248C98;
        Fri, 14 Oct 2022 08:24:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCE2561B43;
        Fri, 14 Oct 2022 15:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269C0C433D6;
        Fri, 14 Oct 2022 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665761056;
        bh=JWZO03i3M3oGthfvXQsP2k8HaF/1/fJ9ZZkQJqs+CMs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aFlXQZWFqXCBzX1Z+mIQWsGCgoh4AXUaWWbhj1PPZqhC2rpjURtWCljWjhtPWt75M
         10Ntwbh/8GGg77a69PLfGiQe8ixZRjBQyTUNNJ7T6dBGCYW6Y/hUX6GuKGCeCWhqZn
         ZYSb05dVNLlKgH5Q0dBlfT8c+VF6bCyQWLLRzrq3qDdfeVtzr5O7prczdcAYLXkb22
         BRezsflYx7RQ8ScdIIr0NPTxmwJkPLydPSlVW55c65ayMoZ+s+vZJcsZa9O8H8wS3t
         I5Wc+3V0qljScR5pYNIce/2/7KR8NlMTzmMbI9oGoW9k9WCbW/BI+7KQw1vSxG5Wmj
         Dz3McjJZRot2g==
Received: by mail-lj1-f172.google.com with SMTP id x18so6431731ljm.1;
        Fri, 14 Oct 2022 08:24:16 -0700 (PDT)
X-Gm-Message-State: ACrzQf1yR4oUx2CwjJ4BluthPfqbEwf57jQ/J96l1QGnSdW4G2sKaC1G
        /+nDtfgtyberx+r5WLIE3jc/n1PRzDbqUt8mImY=
X-Google-Smtp-Source: AMsMyM55jht631wIbiZqbXKCkNypoq7fCNp7qbJwalyEsLUtJ39vRnH6gUAmY+wagKJB0ympBmbf2SY6fCNCxNpk/50=
X-Received: by 2002:a2e:2d0a:0:b0:26c:a1c:cdf with SMTP id t10-20020a2e2d0a000000b0026c0a1c0cdfmr2171083ljt.352.1665761054128;
 Fri, 14 Oct 2022 08:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221010023559.69655-1-justin.he@arm.com> <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic> <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic> <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0gUpoaUBKw/jjaD@zn.tnic> <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
 <DBBPR08MB453845A7A15596F6FE96DBC9F7249@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXHrP_P79ObKPFFgpN-X7gN+zaN1vKbsQZTJGvm=Uoav3g@mail.gmail.com> <Y0l8AeQCrMLYW6g3@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0l8AeQCrMLYW6g3@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Oct 2022 17:24:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXENTJVZU27PYqwWGod4ESkTxgJ8+2vdqWjR5DVRSbNGDg@mail.gmail.com>
Message-ID: <CAMj1kXENTJVZU27PYqwWGod4ESkTxgJ8+2vdqWjR5DVRSbNGDg@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Justin He <Justin.He@arm.com>, Borislav Petkov <bp@alien8.de>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
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
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 14 Oct 2022 at 17:11, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Oct 14, 2022 at 04:31:37PM +0200, Ard Biesheuvel wrote:
> > +       if (slot != -1) {
> > +               /*
> > +                * Use release semantics to ensure that ghes_estatus_cached()
> > +                * running on another CPU will see the updated cache fields if
> > +                * it can see the new value of the pointer.
> > +                */
> > +               victim = xchg_release(ghes_estatus_caches + slot,
> > +                                     RCU_INITIALIZER(new_cache));
> > +
> > +               /*
> > +                * At this point, victim may point to a cached item different
> > +                * from the one based on which we selected the slot. Instead of
> > +                * going to the loop again to pick another slot, let's just
> > +                * drop the other item anyway: this may cause a false cache
> > +                * miss later on, but that won't cause any problems.
> > +                */
> > +               if (victim) {
> > +                       call_rcu(&rcu_dereference(victim)->rcu,
> > +                                ghes_estatus_cache_rcu_free);
>                 }
>
> I think you can use unrcu_pointer() here instead, there should not be a
> data dependency since the ->rcu member itself should be otherwise unused
> (and if it were, we wouldn't care about its previous content anyway).
>
> But only Alpha cares about that distinction anyway, so *shrug*.
>

Ah yeah good point - and we are not actually dereferencing the pointer
at all here, just adding an offset to get at the address of the rcu
member.

So we can take this block out of the rcu_read_lock() section as well.


> While I much like the xchg() variant; I still don't really fancy the
> verbage the sparse nonsense makes us do.
>
>                 victim = xchg_release(&ghes_estatus_caches[slot], new_cache);
>                 if (victim)
>                         call_rcu(&victim->rcu, ghes_estatus_cache_rcu_free);
>
> is much nicer code.
>
> Over all; I'd simply ignore sparse (I often do).
>

No disagreement there.

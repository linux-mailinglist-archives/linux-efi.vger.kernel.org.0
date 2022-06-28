Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CE655E8BE
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 18:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344763AbiF1N6V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347176AbiF1N5w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 09:57:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBABF344E0
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 06:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79FA961973
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 13:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E135FC385A5
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656424670;
        bh=nYK6Mj3D6ExSA3OoOlOmN1zZe4kmWgcbbBbcWRgx+Z8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cTCDdXTMkXfsfLQVVJjxIzghRjcSgtdYpQhvIdudCuIknYR0U6rZ9byX4aLRbkTRq
         VxD7iLXJOxlaHzWoxNXJUEMczSdvGuuQyg+dV+8ppO5Ik1dj84YcfVHdnjcQgFwJKs
         v/VD55HHbTHixIdZ3V2ji6cmbx7kgCqGxuXCAoJq9Dwrdkq0BROiOvuV4Vashy1vOz
         vc8noL3nYL6b+a7i0gZOOuw4mekx2l5QyCa3962s/ZHegd94T7v65bmHMPVvnAM3J6
         BBqKsLkbQUG7geB66TJSl5JQUJS9KMPa8xgAg5AiOT+muvdiS2MkGBABOYWpLAOrML
         oLKKzuFtFf8dw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-101bb9275bcso17135929fac.8
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 06:57:50 -0700 (PDT)
X-Gm-Message-State: AJIora9ZlsqQgC8Nidammzia3Jc6B8sCmDYMAxvDFeXfvGOhRZRsIB9G
        Io1BeUbJ7NXtuG+n9xGj17wEZPN+pRWlFC7oc1s=
X-Google-Smtp-Source: AGRyM1u9bhqFeYFgRrM5jL39J1p4uluON0014IOPWa4h3gJ8PRe+F8T/HqO9Q6jZvVnWAi1exl4VPBeHvchp2JW0aX0=
X-Received: by 2002:a05:6870:e98b:b0:fe:219a:2449 with SMTP id
 r11-20020a056870e98b00b000fe219a2449mr12960353oao.228.1656424670063; Tue, 28
 Jun 2022 06:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220628125938.694256-1-sudeep.holla@arm.com> <CAMj1kXENKbduN65vs-qAeuiApA8e=_ee5jxVPzRf5kxn8bAzcQ@mail.gmail.com>
 <20220628134738.xqj6gu5ngbsuql2f@bogus>
In-Reply-To: <20220628134738.xqj6gu5ngbsuql2f@bogus>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 15:57:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG+CjXUa+ysfpoc64GZRPKvVwSVehgkUUU+on-gAUS+KA@mail.gmail.com>
Message-ID: <CAMj1kXG+CjXUa+ysfpoc64GZRPKvVwSVehgkUUU+on-gAUS+KA@mail.gmail.com>
Subject: Re: [PATCH] ARM: efi: Simplify arch_efi_call_virt() macro by using typeof()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Jun 2022 at 15:47, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Jun 28, 2022 at 03:16:26PM +0200, Ard Biesheuvel wrote:
> > On Tue, 28 Jun 2022 at 14:59, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > Currently, the arch_efi_call_virt() assumes all users of it will have
> > > defined a type 'efi_##f##_t' to make use of it. It is unnecessarily
> > > forcing the users to create a new typedef when __efi_rt_asm_wrapper()
> > > actually expects void pointer.
> > >
> > > Simplify the arch_efi_call_virt() macro by using typeof(p->f) which must
> > > be a pointer as required by __efi_rt_asm_wrapper() and eliminate the
> > > explicit need for efi_##f##_t type for every user of this macro.
> > >
> > > This change is done to align with implementations on other similar
> > > architectures.
> > >
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  arch/arm/include/asm/efi.h | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > Hi,
> > >
> > > Reference for this change [1] and in particular[2]
> > >
> > > Regards,
> > > Sudeep
> > >
> > > [1] https://lore.kernel.org/r/20220628125346.693304-1-sudeep.holla@arm.com
> > > [2] https://lore.kernel.org/r/20220628125346.693304-3-sudeep.holla@arm.com/
> > >
> > > diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
> > > index 27218eabbf9a..d4a405c9b4b6 100644
> > > --- a/arch/arm/include/asm/efi.h
> > > +++ b/arch/arm/include/asm/efi.h
> > > @@ -26,8 +26,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
> > >
> > >  #define arch_efi_call_virt(p, f, args...)                              \
> > >  ({                                                                     \
> > > -       efi_##f##_t *__f;                                               \
> > > -       __f = p->f;                                                     \
> > > +       typeof(p->f) __f = p->f;                                        \
> > >         __f(args);                                                      \
> > >  })
> > >
> >
> > I think this could simply be
> >
> > #define arch_efi_call_virt(p, f, args...) ((p)->f(args))
> >
> > no?
>
> Yes, I came to similar conclusion just after sending this out as I started to
> look if we can have one generic definition for arm/arm64/riscv/loongarch.
>

Not really - arm64 has the asm wrapper, and loongarch is only halfway
merged so I'm not sure yet if this is the final form.

> I am yet to figure out how asm/efi.h and linux/efi.h are included so that
> we can have generic definition in linux/efi.h and x86 can undefine that
> and redefine its own version.
>
> Does that make sense ?
>

I appreciate the effort, but for now, let's just fix the ones we need
to fix (and the ARM one too while we're at it). PRM can only be
enabled on x86 and arm64 anyway.

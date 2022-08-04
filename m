Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB3589C2C
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiHDNHs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 09:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDNHr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 09:07:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC91463C5
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 06:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EA6CB82492
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 13:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF15FC433B5
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 13:07:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jLH9m/iO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659618458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHpXpetfvhI+GjnukjzJ1jUP7ZppZWoiQjyERBvsIpk=;
        b=jLH9m/iOLfK7M4SeZFboVPJ7KnujIvuz6hNU8BLjuz51GhWsR378jGDNCM1abrdlRZcWyR
        AKlLKcrA/J4dywy5LngXkOQZj7LADb84m1BCd0NzjvebHC15mms8HQE7jZPJ8qS+xPoapt
        XdvL/mAyRufO221/TKx5M20su+X1JTE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2cb74099 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-efi@vger.kernel.org>;
        Thu, 4 Aug 2022 13:07:38 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-32868f43dd6so23504507b3.8
        for <linux-efi@vger.kernel.org>; Thu, 04 Aug 2022 06:07:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo0OBdZ9xnfd9+y56SDdZV2KdYTrp8GyKz8Wc0aCy8RJiGO0/S4J
        69KvuvtSfzGLWhANL1o0IejaN4Fg38HKZGnmyNs=
X-Google-Smtp-Source: AA6agR6n0CErDYOCo4pVtebQuVAsWeuo9kEQV1vFNfq9HNitnVeH04jMWbTZmh+Z1vA8B14eFAa7YJMCegzthfMCuro=
X-Received: by 2002:a0d:ca85:0:b0:328:3048:530f with SMTP id
 m127-20020a0dca85000000b003283048530fmr1612943ywd.414.1659618456702; Thu, 04
 Aug 2022 06:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <YusVVLNbLgsk49PK@zx2c4.com> <20220804004411.1343158-1-Jason@zx2c4.com>
 <YuvBaxwcWPGvW0gZ@redhat.com>
In-Reply-To: <YuvBaxwcWPGvW0gZ@redhat.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 4 Aug 2022 15:07:25 +0200
X-Gmail-Original-Message-ID: <CAHmME9p-3ssXmyX6D=Ji9mBHqFoB8yeQgfWx=U1qfm1si9q3aQ@mail.gmail.com>
Message-ID: <CAHmME9p-3ssXmyX6D=Ji9mBHqFoB8yeQgfWx=U1qfm1si9q3aQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
To:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc:     QEMU Developers <qemu-devel@nongnu.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Daniel,

On Thu, Aug 4, 2022 at 2:54 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Thu, Aug 04, 2022 at 02:44:11AM +0200, Jason A. Donenfeld wrote:
> > The boot parameter header refers to setup_data at an absolute address,
> > and each setup_data refers to the next setup_data at an absolute addres=
s
> > too. Currently QEMU simply puts the setup_datas right after the kernel
> > image, and since the kernel_image is loaded at prot_addr -- a fixed
> > address knowable to QEMU apriori -- the setup_data absolute address
> > winds up being just `prot_addr + a_fixed_offset_into_kernel_image`.
> >
> > This mostly works fine, so long as the kernel image really is loaded at
> > prot_addr. However, OVMF doesn't load the kernel at prot_addr, and
> > generally EFI doesn't give a good way of predicting where it's going to
> > load the kernel. So when it loads it at some address !=3D prot_addr, th=
e
> > absolute addresses in setup_data now point somewhere bogus, causing
> > crashes when EFI stub tries to follow the next link.
> >
> > Fix this by placing setup_data at some fixed place in memory, relative
> > to real_addr, not as part of the kernel image, and then pointing the
> > setup_data absolute address to that fixed place in memory. This way,
> > even if OVMF or other chains relocate the kernel image, the boot
> > parameter still points to the correct absolute address.
> >
> > Fixes: 3cbeb52467 ("hw/i386: add device tree support")
> > Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: linux-efi@vger.kernel.org
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  hw/i386/x86.c | 38 ++++++++++++++++++++------------------
> >  1 file changed, 20 insertions(+), 18 deletions(-)
> >
> > diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> > index 050eedc0c8..8b853abf38 100644
> > --- a/hw/i386/x86.c
> > +++ b/hw/i386/x86.c
>
>
> >      if (!legacy_no_rng_seed) {
> > -        setup_data_offset =3D QEMU_ALIGN_UP(kernel_size, 16);
> > -        kernel_size =3D setup_data_offset + sizeof(struct setup_data) =
+ RNG_SEED_LENGTH;
> > -        kernel =3D g_realloc(kernel, kernel_size);
> > -        setup_data =3D (struct setup_data *)(kernel + setup_data_offse=
t);
> > +        setup_data_item_len =3D sizeof(struct setup_data) + RNG_SEED_L=
ENGTH;
> > +        setup_datas =3D g_realloc(setup_datas, setup_data_total_len + =
setup_data_item_len);
> > +        setup_data =3D (struct setup_data *)(setup_datas + setup_data_=
total_len);
> >          setup_data->next =3D cpu_to_le64(first_setup_data);
> > -        first_setup_data =3D prot_addr + setup_data_offset;
> > +        first_setup_data =3D setup_data_base + setup_data_total_len;
> > +        setup_data_total_len +=3D setup_data_item_len;
> >          setup_data->type =3D cpu_to_le32(SETUP_RNG_SEED);
> >          setup_data->len =3D cpu_to_le32(RNG_SEED_LENGTH);
> >          qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH)=
;
> >      }
> >
> > -    /* Offset 0x250 is a pointer to the first setup_data link. */
> > -    stq_p(header + 0x250, first_setup_data);
> > +    if (first_setup_data) {
> > +            /* Offset 0x250 is a pointer to the first setup_data link.=
 */
> > +            stq_p(header + 0x250, first_setup_data);
> > +            rom_add_blob("setup_data", setup_datas, setup_data_total_l=
en, setup_data_total_len,
> > +                         setup_data_base, NULL, NULL, NULL, NULL, fals=
e);
> > +    }
>
> The boot measurements with AMD SEV now succeed, but I'm a little
> worried about the implications of adding this ROM, when a few lines
> later here we're discarding the 'header' changes for AMD SEV. Is
> this still going to operate correctly in the guest OS if we've
> discarded the header changes below ?

I'll add a !sev_enabled() condition to that block too, so it also
skips adding the ROM, for v3.

Jason

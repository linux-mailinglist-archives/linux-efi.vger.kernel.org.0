Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B278D97D
	for <lists+linux-efi@lfdr.de>; Wed, 30 Aug 2023 20:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjH3SdQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Aug 2023 14:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244624AbjH3NdG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Aug 2023 09:33:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0093E11F;
        Wed, 30 Aug 2023 06:33:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8E162390;
        Wed, 30 Aug 2023 13:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED459C433C8;
        Wed, 30 Aug 2023 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693402383;
        bh=nQgp86MKxOrSCn+y2q+FObwNi+k/hNmyb1P1RmPb5xk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EfasZJr5StYeQXgzod0sx6bGBqJoc1XYMTKm+8TBCxh3iZuPx8NxKpcz5HxfeK6mx
         jARbDkw3LXm+DqiGFNtSUUgFz9DNkGnA+avr45tTJfXFToVxhTfhg/bTJHgAgLHflg
         HNQMPrdLQ34bV2+4H9WpywPwUz+r7x5hVNB3wSsgfzfPXTEcuVnZr2r0YJ/05C5eJy
         BH41WRn+9Ikyn9wQHBrbIWk402ljWzi0Jv9NXHsAVEKCPRNZI3rd0I5KRWsLfw6sHn
         3Gwx7Tx7QU/iw1RWPAXAYvTWZ2ZkffuW4e4XQQOEJmnp9jgo2vnySmdSirjUI/F3Hg
         4OZFxlB6b1HNw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso85523371fa.3;
        Wed, 30 Aug 2023 06:33:02 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz2Pf0ivcqKq16tdgB5rZryG14txXjs2CDydzGI0pgNCovog+Qc
        dz9EtES8irTzu+NyXou1bnClr+eX3H6HGZnhOJQ=
X-Google-Smtp-Source: AGHT+IEczqc2q2dpCrAf6gstOmu97YU6GzRl+D7s3bMHOw1vVTZ7uWLeBA8Z45LYHxSOKw5riW45834TbnQ75sHW6IU=
X-Received: by 2002:a05:6512:234d:b0:4fb:52a3:e809 with SMTP id
 p13-20020a056512234d00b004fb52a3e809mr1831624lfu.28.1693402380916; Wed, 30
 Aug 2023 06:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230829-missingvardecl-efi-v1-1-13d055a55176@google.com>
 <CAMj1kXE_xs+wWno4G4U+6CFCOwO7JWcmNv4et5=W=ZRrQatWnQ@mail.gmail.com> <CAHp75VeEvWXQoMwfmMixw_DHWrXq3=eSPkxgzJaKTT0L3G_Fpg@mail.gmail.com>
In-Reply-To: <CAHp75VeEvWXQoMwfmMixw_DHWrXq3=eSPkxgzJaKTT0L3G_Fpg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Aug 2023 15:32:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHXR5UOxS2C1T267hFg+x15Gnf+OS8RYSUs8fPpR=6a1Q@mail.gmail.com>
Message-ID: <CAMj1kXHXR5UOxS2C1T267hFg+x15Gnf+OS8RYSUs8fPpR=6a1Q@mail.gmail.com>
Subject: Re: [PATCH] efi: fix -Wmissing-variable-declarations warning
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 30 Aug 2023 at 15:25, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
> On Wed, Aug 30, 2023 at 2:04=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> > On Wed, 30 Aug 2023 at 00:54, Justin Stitt <justinstitt@google.com> wro=
te:
>
> ...
>
> > > When building x86/defconfig with Clang-18 I encounter the following w=
arnings:
> > > | arch/x86/platform/efi/efi.c:934:23: warning: no previous extern dec=
laration for non-static variable 'efi_attr_fw_vendor' [-Wmissing-variable-d=
eclarations]
> > > |   934 | struct kobj_attribute efi_attr_fw_vendor =3D __ATTR_RO(fw_v=
endor);
> > > | arch/x86/platform/efi/efi.c:935:23: warning: no previous extern dec=
laration for non-static variable 'efi_attr_runtime' [-Wmissing-variable-dec=
larations]
> > > |   935 | struct kobj_attribute efi_attr_runtime =3D __ATTR_RO(runtim=
e);
> > > | arch/x86/platform/efi/efi.c:936:23: warning: no previous extern dec=
laration for non-static variable 'efi_attr_config_table' [-Wmissing-variabl=
e-declarations]
> > > |   936 | struct kobj_attribute efi_attr_config_table =3D __ATTR_RO(c=
onfig_table);
> > >
> > > These variables are not externally declared anywhere (AFAIK)
> >
> > They are:
> >
> > drivers/firmware/efi/efi.c:extern __weak struct kobj_attribute
> > efi_attr_fw_vendor;
> > drivers/firmware/efi/efi.c:extern __weak struct kobj_attribute efi_attr=
_runtime;
> > drivers/firmware/efi/efi.c:extern __weak struct kobj_attribute
> > efi_attr_config_table;
> >
> > > so let's add the static keyword and ensure we follow the ODR.
>
> > This won't work.
> >
> > Those variables are referenced via weak references in generic code.
> > The idea is that the weak references resolve to NULL pointers on
> > architectures other than x86, terminating the array early and hiding
> > the non-existent variables.
> >
> > Making them static in arch/x86/platform/efi/efi.c means that these
> > references will remain unsatisfied, and so the variables will no
> > longer be exposed on x86 either.
>
> So it means that we have no definitions in the header for these, right?
>

Indeed.

If there are better ways of fixing this that don't involve weak
references, I am also fine with that, but just moving the existing
extern declarations into linux/efi.h is probably the easiest approach
here.

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A997478D972
	for <lists+linux-efi@lfdr.de>; Wed, 30 Aug 2023 20:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjH3SdK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Aug 2023 14:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344007AbjH3R4p (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Aug 2023 13:56:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF7F198
        for <linux-efi@vger.kernel.org>; Wed, 30 Aug 2023 10:56:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a0856b4fdso7632947a12.1
        for <linux-efi@vger.kernel.org>; Wed, 30 Aug 2023 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693418201; x=1694023001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXI8G58qBJITCVjge68+nl9obJSgD1GdUL6oiLmDNDI=;
        b=5sFk99MmsfAzpAyxMfI1B1lwyHc2RQ+fQ5TueOA5QTnFnVDzYIR7p7kcyoxBhfczA2
         9G1s1BWEr+ce6McrIvEdqaOJupuJcWlziYoHqK/ILBk6WKRDxES038nJExl3HFJ/yK3F
         rimY8wIk1VksDC5Qv2hfgFqC9tIuqpgm0yHWEtNRd47z/MQYoisdFR3UaUWJFbPC8Vlj
         l9XEh0JMUyUAN+uvsktJL6T/uOEhCTu1S5zIR8r7LwjPLKwIfnm270HWogN15Ar3qE5s
         aFvlQXj6YcKf2D7uUS0n3kBPzJ+AD4FNPO6cHRH09z+wWNKrvT7KDY0O1PfSA3304ar3
         caKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693418201; x=1694023001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXI8G58qBJITCVjge68+nl9obJSgD1GdUL6oiLmDNDI=;
        b=Nn5fbyjkuHXD9cl3W2Nch/N80VpIoio/n4gzxXC+Dwa9gPMs8Okej5ggSmryj6YnhN
         fD5/uJ185nQheNmUBHKfSQwSBUoQXCxyqrnFayWGKKCiXyc/gDxJoZg7TY4IVc0MJW44
         jFowD6FJ7JNE6jYCjLBAWanDz78uXUwtSwGw/mna4BiMaCGyWcsejmsI0bvX3T2tRgRT
         s8bohrAeK+TG/esjTMS0FCvkLi+2mhkh6qZw10m6DCVQWQa7Kxr724Zzue/OUYnkZSDM
         SJOwcL5yXyOWZvM8WRUBHOe7czL4oszX0wlnqK/U5sRKhwy0kvLG+2N+weA4MZQaTEDS
         zhdg==
X-Gm-Message-State: AOJu0YwevbEjsv9OWjc0Fri14h0Fy1g/3L5yiagEPVRBncaHMOFaLS71
        D4OvKjs6kAtvKdDI2ljg7kyf8+jjKRqW0woh3QAiSg==
X-Google-Smtp-Source: AGHT+IFrwH9v8R15ct++h699j0jys5ZO41JUXqWbc8SydhI9De04gDz2U2m8CUBKU+nT/3exLWOKvVLmzC8kiqA2yCI=
X-Received: by 2002:aa7:d4d2:0:b0:525:469a:fc47 with SMTP id
 t18-20020aa7d4d2000000b00525469afc47mr2312236edr.22.1693418201087; Wed, 30
 Aug 2023 10:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-missingvardecl-efi-v2-1-818081a204d2@google.com> <CAMj1kXGbBx=gWsDJ7nXPwygOvX=Ek3tPQmZ_fQpBNmVg5_7u9A@mail.gmail.com>
In-Reply-To: <CAMj1kXGbBx=gWsDJ7nXPwygOvX=Ek3tPQmZ_fQpBNmVg5_7u9A@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 30 Aug 2023 10:56:28 -0700
Message-ID: <CAFhGd8rWih8CNQyWQmcfsBoraVZ1xb8nvuxRGCJDPKdC_O99mA@mail.gmail.com>
Subject: Re: [PATCH v2] efi: fix -Wmissing-variable-declarations warning
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 30, 2023 at 10:54=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Wed, 30 Aug 2023 at 19:51, Justin Stitt <justinstitt@google.com> wrote=
:
> >
> > When building x86/defconfig with Clang-18 I encounter the following war=
nings:
> > | arch/x86/platform/efi/efi.c:934:23: warning: no previous extern decla=
ration for non-static variable 'efi_attr_fw_vendor' [-Wmissing-variable-dec=
larations]
> > |   934 | struct kobj_attribute efi_attr_fw_vendor =3D __ATTR_RO(fw_ven=
dor);
> > | arch/x86/platform/efi/efi.c:935:23: warning: no previous extern decla=
ration for non-static variable 'efi_attr_runtime' [-Wmissing-variable-decla=
rations]
> > |   935 | struct kobj_attribute efi_attr_runtime =3D __ATTR_RO(runtime)=
;
> > | arch/x86/platform/efi/efi.c:936:23: warning: no previous extern decla=
ration for non-static variable 'efi_attr_config_table' [-Wmissing-variable-=
declarations]
> > |   936 | struct kobj_attribute efi_attr_config_table =3D __ATTR_RO(con=
fig_table);
> >
> > These symbols are declared extern in drivers/firmware/efi/efi.c. Move
> > the declarations to linux/efi.h to resolve these warnings.
> >
> > Also, trim a trailing space from efi_set_variable_t typedef.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1920
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Thanks, I'll take this as a fix.
>
> > ---
> > Changes in v2:
> > - Don't use static. Instead move symbols to header file (thanks Ard)
> > - Remove duplicated warnings output from b4 (thanks Ard)
> > - Link to v1: https://lore.kernel.org/r/20230829-missingvardecl-efi-v1-=
1-13d055a55176@google.com
> > ---
> > Note: build-tested.
> >
> > Also, a question: Why does the compiler warn at all? The extern
> > declarations _do_ exist as Ard points out [1].
> >
> > [1]: https://lore.kernel.org/all/CAMj1kXE_xs+wWno4G4U+6CFCOwO7JWcmNv4et=
5=3DW=3DZRrQatWnQ@mail.gmail.com/
>
> Those declarations are not observed by the compiler when building .c
> files other than drivers/firmware/efi/efi.c, so they essentially don't
> exist when compiling arch/x86/platform/efi/efi.c.

I see, the linker is resolving these later then?

>
>
> > ---
> >  drivers/firmware/efi/efi.c | 3 ---
> >  include/linux/efi.h        | 6 +++++-
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 1599f1176842..7b4e59ccf09e 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -161,9 +161,6 @@ static ssize_t fw_platform_size_show(struct kobject=
 *kobj,
> >         return sprintf(buf, "%d\n", efi_enabled(EFI_64BIT) ? 64 : 32);
> >  }
> >
> > -extern __weak struct kobj_attribute efi_attr_fw_vendor;
> > -extern __weak struct kobj_attribute efi_attr_runtime;
> > -extern __weak struct kobj_attribute efi_attr_config_table;
> >  static struct kobj_attribute efi_attr_fw_platform_size =3D
> >         __ATTR_RO(fw_platform_size);
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index ab088c662e88..32f7ca60b0e9 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -287,7 +287,7 @@ typedef efi_status_t efi_get_variable_t (efi_char16=
_t *name, efi_guid_t *vendor,
> >                                          unsigned long *data_size, void=
 *data);
> >  typedef efi_status_t efi_get_next_variable_t (unsigned long *name_size=
, efi_char16_t *name,
> >                                               efi_guid_t *vendor);
> > -typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_=
t *vendor,
> > +typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_=
t *vendor,
> >                                          u32 attr, unsigned long data_s=
ize,
> >                                          void *data);
> >  typedef efi_status_t efi_get_next_high_mono_count_t (u32 *count);
> > @@ -632,6 +632,10 @@ typedef struct {
> >
> >  extern unsigned long __ro_after_init efi_rng_seed;             /* RNG =
Seed table */
> >
> > +extern __weak struct kobj_attribute efi_attr_fw_vendor;
> > +extern __weak struct kobj_attribute efi_attr_runtime;
> > +extern __weak struct kobj_attribute efi_attr_config_table;
> > +
> >  /*
> >   * All runtime access to EFI goes through this structure:
> >   */
> >
> > ---
> > base-commit: 706a741595047797872e669b3101429ab8d378ef
> > change-id: 20230829-missingvardecl-efi-59306aacfed4
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >

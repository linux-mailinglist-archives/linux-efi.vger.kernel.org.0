Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5EC78D97C
	for <lists+linux-efi@lfdr.de>; Wed, 30 Aug 2023 20:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjH3SdP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Aug 2023 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244596AbjH3NZP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Aug 2023 09:25:15 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0150B137;
        Wed, 30 Aug 2023 06:25:12 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-573ac2fa37aso1042977eaf.3;
        Wed, 30 Aug 2023 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693401911; x=1694006711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmogliSTtL2RB5d6BjlDVGsgCldCZrhobb3z+lU+kTo=;
        b=swRqPUmcO44iiWQ5MgqCQfbQmcu++UPi9CJ/44UZ+e+sJymaH81+5H128BdbFciiss
         LeiWuvIfpoV8G1NW+nyTYaTvNoIjWjitHyaq8t+VIeg1Fd1aH6tHc1w5kRJVYQABZ+bV
         Dp+wCaelk/sz+bfPjYW3dYXhyCz2Dge1NY15QHTkUCa9mmCaQfbOoZcS8p4OXarCMhhd
         jZgIK8VS5H3059Xr84PWkhYB8HU6JtYvyu40IjQgjXtSD2inRmX63mA6in1Ct0gC/cBv
         Qs8PnhIRwytKLsI+kZytfA8j8usPz9qEiXO6ICgdd4Faqhm+mPlqySD+UaTRu/Pki9za
         BZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401911; x=1694006711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmogliSTtL2RB5d6BjlDVGsgCldCZrhobb3z+lU+kTo=;
        b=SvtjBNS0Vju462r0nd4+BsvAVvbhxX3r3GcRzAg4jmfa/dWdavOwN8pRzaqn/GMNsR
         mzZ/JbXgrsHwFCUADWLcWMZOBol3LMFBvQCQ2jLD405ODwrtif8lUX9ddGt0SQBNiyx6
         peDhYGNu30fuDRJi9jzm0WWLlcwktKPGC32sbGYG0qPFF1hHVHsBdE6BtGYPnE26YXaJ
         +xc5QXoURrl0SRV159HRRz5Vo9DKYo6zyF8Nd2lkpci1gI74r8vRT5qsRWte3sF6H7PL
         Z/U6L80+FzB8DcMo2AnwbOHm3vD8lnQtXIVCzGw3HPzvcZcF1t+OlITNq8FVYqsOPZLJ
         2Psg==
X-Gm-Message-State: AOJu0YxGqmimBDsUDRgqWx9RVB/bYEw4o1SG3qNmt/Pcx9HrIivg7EaW
        ibAGKT7+3ElQBl9tmIeMbpS1Bbfs+TNBL5+Juos=
X-Google-Smtp-Source: AGHT+IGcm+fuYV6DElZl0ERELQLCKFcV4jDm/YiJBfQen9r6vTRbRZD6JbCmADX4a3ozRdhakxdldUDiTEXW6Kpe6p0=
X-Received: by 2002:a4a:2a1c:0:b0:573:55f4:516a with SMTP id
 k28-20020a4a2a1c000000b0057355f4516amr1923557oof.3.1693401911143; Wed, 30 Aug
 2023 06:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230829-missingvardecl-efi-v1-1-13d055a55176@google.com> <CAMj1kXE_xs+wWno4G4U+6CFCOwO7JWcmNv4et5=W=ZRrQatWnQ@mail.gmail.com>
In-Reply-To: <CAMj1kXE_xs+wWno4G4U+6CFCOwO7JWcmNv4et5=W=ZRrQatWnQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Aug 2023 16:24:34 +0300
Message-ID: <CAHp75VeEvWXQoMwfmMixw_DHWrXq3=eSPkxgzJaKTT0L3G_Fpg@mail.gmail.com>
Subject: Re: [PATCH] efi: fix -Wmissing-variable-declarations warning
To:     Ard Biesheuvel <ardb@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 30, 2023 at 2:04=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
> On Wed, 30 Aug 2023 at 00:54, Justin Stitt <justinstitt@google.com> wrote=
:

...

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
> > These variables are not externally declared anywhere (AFAIK)
>
> They are:
>
> drivers/firmware/efi/efi.c:extern __weak struct kobj_attribute
> efi_attr_fw_vendor;
> drivers/firmware/efi/efi.c:extern __weak struct kobj_attribute efi_attr_r=
untime;
> drivers/firmware/efi/efi.c:extern __weak struct kobj_attribute
> efi_attr_config_table;
>
> > so let's add the static keyword and ensure we follow the ODR.

> This won't work.
>
> Those variables are referenced via weak references in generic code.
> The idea is that the weak references resolve to NULL pointers on
> architectures other than x86, terminating the array early and hiding
> the non-existent variables.
>
> Making them static in arch/x86/platform/efi/efi.c means that these
> references will remain unsatisfied, and so the variables will no
> longer be exposed on x86 either.

So it means that we have no definitions in the header for these, right?

--=20
With Best Regards,
Andy Shevchenko

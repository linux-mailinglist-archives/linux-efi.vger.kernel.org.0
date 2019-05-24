Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0393296FB
	for <lists+linux-efi@lfdr.de>; Fri, 24 May 2019 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390699AbfEXLUV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 May 2019 07:20:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37712 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390535AbfEXLUV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 May 2019 07:20:21 -0400
Received: by mail-io1-f67.google.com with SMTP id u2so7472175ioc.4
        for <linux-efi@vger.kernel.org>; Fri, 24 May 2019 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7d/6XpSVKWFgXsU9iU4Jq8RO9qBp/1WookkZU13gAgg=;
        b=HPX/LcMhHWorbLqmdkvcm8HPM1jjweECCT3YX0QcDxz7xBncD0fSfCTyA1loezCyWK
         IynfPJP2ornHMTYiUkQ7JFALXGn2+E6mnS83J/EumCz6SlvxcaxcJgNGMh1f6XU2JbxI
         s8qHL/WjHuFeggxJSTOt2HI2t4aTXU71wyVsp2xZQO4AAht7W2J2UfU48s1bn8KbccFO
         A6pHPSYRpsSpUbzeZumbBTiCV1AnVsJfrxo4SFA3YCKvCoEudtW65JoWyegiQ6lMd/2j
         xfor4jroNylurEM4M5pk6ag2GgG2sPomFZtsF47oiL1bJ4+0ARW88B8RQG6BKarmgdBi
         Ldeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7d/6XpSVKWFgXsU9iU4Jq8RO9qBp/1WookkZU13gAgg=;
        b=NlQo5U8yHGQZx4TJpjH5LEdtqfN920cMFc7bhQFZtmXE07uUSfQMgA5zeWR4OCzEoI
         hrTxCvhX0KKjWCITqBxCr7DH17FVB3d8fMPKEf7B3AyTZTrWeYqmOf7r1GeIRYhOJA/i
         czI3d87lGP8gBipzTgesvi7I4jk8inNyDbOGEisEb+DFwjaIlmr6EXPTKk0OKw+07L72
         d5IGUxs69LKRbcBebD760eG6LwVPubg+qKqbaAu2/6LXEvW6oexeJmUh1Dxw94nivGKC
         eUVDGJfaQ9wbxQo2gBrEjp+r+dGhvvXX6voz8BoIRYNh2FgvpJJ5OP8tq+yv+k/hpXRj
         pIIw==
X-Gm-Message-State: APjAAAWuLcolacqITO+FwfrVmGIxzxoQ++1ITUeA0CKtChzpRD5JxxX4
        OGcES4TClGsmNBGVZceBD/6ci2qV9AqKZwgYqSC5mg==
X-Google-Smtp-Source: APXvYqxvhW8VM5u/6+RviLu+yBT120LWlh8ISMsEasdQChJq2TetZHVWNIiGcdOhGJNhNPSo3ci5TbTUtAqJW+h2E6I=
X-Received: by 2002:a5d:968e:: with SMTP id m14mr25526546ion.49.1558696820456;
 Fri, 24 May 2019 04:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190416095958.26163-1-robert.bradford@intel.com> <145f1fac860402629bc8a9c67cc23be39f201e80.camel@intel.com>
In-Reply-To: <145f1fac860402629bc8a9c67cc23be39f201e80.camel@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 24 May 2019 13:20:08 +0200
Message-ID: <CAKv+Gu9v8he2Kq9AXFQuWe2i3+C5nQPVij4CU8S0Lu+Q4ZKgow@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Check the number of EFI configuration tables entries
To:     "Bradford, Robert" <robert.bradford@intel.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 21 May 2019 at 14:20, Bradford, Robert
<robert.bradford@intel.com> wrote:
>
> On Tue, 2019-04-16 at 10:59 +0100, Rob Bradford wrote:
> > Only try and access the EFI configuration tables if there there are
> > any
> > reported. This allows EFI to be continued to used on systems where
> > there
> > are no configuration table entries.
> >
> > v2: Move return on nr_tables==0 earlier
> >
> > Signed-off-by: Rob Bradford <robert.bradford@intel.com>
> > ---
> >  arch/x86/platform/efi/quirks.c | 3 +++
> >  drivers/firmware/efi/efi.c     | 3 +++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/arch/x86/platform/efi/quirks.c
> > b/arch/x86/platform/efi/quirks.c
> > index 95e77a667ba5..6b9a4792242b 100644
> > --- a/arch/x86/platform/efi/quirks.c
> > +++ b/arch/x86/platform/efi/quirks.c
> > @@ -471,6 +471,9 @@ int __init efi_reuse_config(u64 tables, int
> > nr_tables)
> >       void *p, *tablep;
> >       struct efi_setup_data *data;
> >
> > +     if (nr_tables == 0)
> > +             return 0;
> > +
> >       if (!efi_setup)
> >               return 0;
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 415849bab233..185424a8b879 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -628,6 +628,9 @@ int __init
> > efi_config_init(efi_config_table_type_t *arch_tables)
> >       void *config_tables;
> >       int sz, ret;
> >
> > +     if (efi.systab->nr_tables == 0)
> > +             return 0;
> > +
> >       if (efi_enabled(EFI_64BIT))
> >               sz = sizeof(efi_config_table_64_t);
> >       else
>
> Any chance of getting this into the tree? Without this we can't boot
> the kernel in EFI mode on our KVM based hypervisor[1] & firmware[2] as
> it does not provide any tables, nor does it need to.
>

Apologies for the delay. I will pick it up today.

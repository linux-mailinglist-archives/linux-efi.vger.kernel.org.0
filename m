Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FFA2C6C6E
	for <lists+linux-efi@lfdr.de>; Fri, 27 Nov 2020 21:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgK0UJ1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Nov 2020 15:09:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731779AbgK0UHw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Nov 2020 15:07:52 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D2EC24124;
        Fri, 27 Nov 2020 19:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606505378;
        bh=8QymvV5Hnh6tFqtBLh0j3rJoBCVR1S8omUbfnSVDUeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oLLIUYhA6GpbhNj2qR7MD4psdVtsmBPseexX/GY2TFosrpuEPbpwsT2G0SCF4846R
         Fptt4olt4YE28inoYnnVg6/DEtn4trVGGQNAp603+RsVNAoJ4QhA39uLlqt7dI8bM/
         rS1NkODIQ8Hn+pojhY6qo7/a4/UnN0VzVz4jzdRI=
Received: by mail-ot1-f49.google.com with SMTP id h39so5566433otb.5;
        Fri, 27 Nov 2020 11:29:38 -0800 (PST)
X-Gm-Message-State: AOAM532J6wv/fAkAQt3OlFPnQ7oVWzTxSPjY/bWmQoOGhKNrK+uiXj+S
        bGskCWazF8d9afIPY/udXMs1WWcV3MDwp3yBXgU=
X-Google-Smtp-Source: ABdhPJxcQfyG8b5MTqOyTrK4rfOhSVdRZ+KuSazB0xNflwCE1YFEDJEnpF1r+2Dxy4l8nzC63Zt0IswN/eMtn4GNX2M=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr7274707otd.90.1606505377691;
 Fri, 27 Nov 2020 11:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20201127192051.1430-1-xypron.glpk@gmx.de> <98faddb2-5acc-c228-d002-71341d1c558e@canonical.com>
In-Reply-To: <98faddb2-5acc-c228-d002-71341d1c558e@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 27 Nov 2020 20:29:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFNtCJEvbhZpO9p96UNGuo-r2dXQPm0TRjmQuF4TLBUcg@mail.gmail.com>
Message-ID: <CAMj1kXFNtCJEvbhZpO9p96UNGuo-r2dXQPm0TRjmQuF4TLBUcg@mail.gmail.com>
Subject: Re: ACK: [PATCH 1/1] efi/efi_test: read RuntimeServicesSupported
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ivan Hu <ivan.hu@canonical.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fwts-devel@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 27 Nov 2020 at 20:28, Colin Ian King <colin.king@canonical.com> wrote:
>
> On 27/11/2020 19:20, Heinrich Schuchardt wrote:
> > Since the UEFI 2.8A specification the UEFI enabled firmware provides a
> > configuration table EFI_RT_PROPERTIES_TABLE which indicates which runtime
> > services are enabled. The EFI stub reads this table and saves the value of
> > the field RuntimeServicesSupported internally.
> >
> > The Firmware Test Suite requires the value to determine if UEFI runtime
> > services are correctly implemented.
> >
> > With this patch an IOCTL call is provided to read the value of the field
> > RuntimeServicesSupported, e.g.
> >
> >     #define EFI_RUNTIME_GET_SUPPORTED_MASK \
> >             _IOR('p', 0x0C, unsigned int)
> >     unsigned int mask;
> >     fd = open("/dev/efi_test", O_RDWR);
> >     ret = ioctl(fd, EFI_RUNTIME_GET_SUPPORTED_MASK, &mask);
> >
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >  drivers/firmware/efi/test/efi_test.c | 16 ++++++++++++++++
> >  drivers/firmware/efi/test/efi_test.h |  3 +++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
> > index ddf9eae396fe..47d67bb0a516 100644
> > --- a/drivers/firmware/efi/test/efi_test.c
> > +++ b/drivers/firmware/efi/test/efi_test.c
> > @@ -663,6 +663,19 @@ static long efi_runtime_query_capsulecaps(unsigned long arg)
> >       return rv;
> >  }
> >
> > +static long efi_runtime_get_supported_mask(unsigned long arg)
> > +{
> > +     unsigned int __user *supported_mask;
> > +     int rv = 0;
> > +
> > +     supported_mask = (unsigned int *)arg;
> > +
> > +     if (put_user(efi.runtime_supported_mask, supported_mask))
> > +             rv = -EFAULT;
> > +
> > +     return rv;
> > +}
> > +
> >  static long efi_test_ioctl(struct file *file, unsigned int cmd,
> >                                                       unsigned long arg)
> >  {
> > @@ -699,6 +712,9 @@ static long efi_test_ioctl(struct file *file, unsigned int cmd,
> >
> >       case EFI_RUNTIME_RESET_SYSTEM:
> >               return efi_runtime_reset_system(arg);
> > +
> > +     case EFI_RUNTIME_GET_SUPPORTED_MASK:
> > +             return efi_runtime_get_supported_mask(arg);
> >       }
> >
> >       return -ENOTTY;
> > diff --git a/drivers/firmware/efi/test/efi_test.h b/drivers/firmware/efi/test/efi_test.h
> > index f2446aa1c2e3..117349e57993 100644
> > --- a/drivers/firmware/efi/test/efi_test.h
> > +++ b/drivers/firmware/efi/test/efi_test.h
> > @@ -118,4 +118,7 @@ struct efi_resetsystem {
> >  #define EFI_RUNTIME_RESET_SYSTEM \
> >       _IOW('p', 0x0B, struct efi_resetsystem)
> >
> > +#define EFI_RUNTIME_GET_SUPPORTED_MASK \
> > +     _IOR('p', 0x0C, unsigned int)
> > +
> >  #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
> > --
> > 2.29.2
> >
>
> Looks good to me. Thanks Heinrich.
>
> The EFI driver needs to be also updated in the linux kernel - has that
> fix been submitted or do you require the fwts team to do that?
>

This /is/ the EFI driver.

I'll take this as an acked-by but I'd like Ivan to chime in as well.

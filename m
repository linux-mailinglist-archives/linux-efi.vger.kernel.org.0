Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04B511F3F0
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 21:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfLNU1z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 15:27:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37346 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLNU1z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 15:27:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so2550351wru.4
        for <linux-efi@vger.kernel.org>; Sat, 14 Dec 2019 12:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+75J0Dw1r5yEvpgIkQ19P8zMx2J5+W73CXbyBfhqvU=;
        b=Lttw4tXBxHMWfjfV2ecxDid1JNEW7y88V4OuBJIB1oHbaIFLW8CVDG+hQVgEXksi7a
         0lZVr++aGzqnvpPX2vUrdk/JpFCMKHRiXBq3eAO0oz4L4aVcnc5QKb5dtBovHuar/VN9
         7bro2BQPiDC2ZIM35L/s5FNY5uuyxJhJoAIplXGbdr7vGMJKAyCbzENvSKFOYRATIOM4
         P//QFb47iX6wj2RozdDo1c3zCV1c5Qdn+JDou3RrBRNEWSNy5mb/FAJNHbnygKJKuh6d
         y3hqBWxFLRt/OcESH0t9wTCw9LbrYE/KC3pwb7FLPze0JrVMaBPcgmFSQ/yvl53EoHxP
         gaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+75J0Dw1r5yEvpgIkQ19P8zMx2J5+W73CXbyBfhqvU=;
        b=UQd3ZJAqXUdAZAludgyRC+gRP313KmMiwtclihaBiHQq4eraJOOV6bKm6AHUwdnat8
         SMHy0JDVnRViry9UgDGSPo/UKGZHruI1WCpblbhzC60T39xQfTFZvztr8Qq2iC12pO2j
         rfjb9ElqSUU0GHzmPWkZXVqHozn4SKnNgy/8u4kmvEJ+Xh5BOHDge7EW2aXV6kJ4x4I0
         nXXhFyKzkmKa4IkUr2vKd1aGF4D5Cs2DUPf7Slhged885x6bHdxgfY4rfP/f9kFDUPqJ
         LyM+d/KkAUB99lNGFycvU1b68tzEtf5h60GD+3iPHAjaSsKnmxz1rxOJcnCb3rcg/8f5
         u4Mg==
X-Gm-Message-State: APjAAAWZQM4tYeSYyqivhIleKGwvlzj043SpgStBg6dHo4X4uWtngB3g
        J4CczcdehLsZlSA6j69LTkmCiiLjKbEMGvacmYjB4Q==
X-Google-Smtp-Source: APXvYqyHSgL0areroJWp6qSyg36babTJ6gPRWX7Y+JLL+Yt8m5mgMkZ/GphYT9DivXL/EB83hCQ9p8p1Ta/qTD+Ty3E=
X-Received: by 2002:a5d:5345:: with SMTP id t5mr21457773wrv.0.1576355272607;
 Sat, 14 Dec 2019 12:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20191214175735.22518-1-ardb@kernel.org> <20191214175735.22518-6-ardb@kernel.org>
 <20191214194626.GA140998@rani.riverdale.lan> <20191214194936.GB140998@rani.riverdale.lan>
 <CAKv+Gu_JQz=xd_UmqiuZ8TvA+ksT_rY4iXP_j7OdW4F5sfZt9g@mail.gmail.com> <20191214201334.GC140998@rani.riverdale.lan>
In-Reply-To: <20191214201334.GC140998@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 14 Dec 2019 20:27:50 +0000
Message-ID: <CAKv+Gu-A4bE0DM96-dNjtsYG=a3g-X4f-y=NcJ5ZCvZHaDJZmw@mail.gmail.com>
Subject: Re: [PATCH 05/10] efi/libstub: distinguish between native/mixed not
 32/64 bit
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 14 Dec 2019 at 21:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, Dec 14, 2019 at 07:54:25PM +0000, Ard Biesheuvel wrote:
> > On Sat, 14 Dec 2019 at 20:49, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Sat, Dec 14, 2019 at 02:46:27PM -0500, Arvind Sankar wrote:
> > > > On Sat, Dec 14, 2019 at 06:57:30PM +0100, Ard Biesheuvel wrote:
> > > > > +
> > > > > +#define efi_table_attr(table, attr, instance) ({                   \
> > > > > +   __typeof__(((table##_t *)0)->attr) __ret;                       \
> > > > > +   if (efi_is_native()) {                                          \
> > > > > +           __ret = ((table##_t *)instance)->attr;                  \
> > > > > +   } else {                                                        \
> > > > > +           __typeof__(((table##_32_t *)0)->attr) at;               \
> > > > > +           at = (((table##_32_t *)(unsigned long)instance)->attr); \
> > > > > +           __ret = (__typeof__(__ret))(unsigned long)at;           \
> > > > > +   }                                                               \
> > > > > +   __ret;                                                          \
> > > > > +})
> > > >
> > > > The casting of `at' is appropriate if the attr is a pointer type which
> > > > needs to be zero-extended to 64-bit, but for other fields it is
> > > > unnecessary at best and possibly dangerous.  There are probably no
> > > > instances currently where it is called for a non-pointer field, but is
> > > > it possible to detect if the type is pointer and avoid the cast if not?
> > >
> > > To clarify, I mean the casting via `unsigned long' -- casting to type of
> > > __ret should be ok. We could also use uintptr_t for cleanliness when the
> > > cast is required?
> >
> > Could you give an example of how it could break?
>
> eg, if the field is actually a structure. Nobody seems to do this
> currently, but say for
>         efi_table_attr(efi_boot_services, hdr, instance)
> you shouldn't cast hdr to unsigned long.
>

Yes. the efi_guid_t in efi_config_table_t is another example - I had
to work around that in get_efi_config_table().

> There's also the case of nested 32/64-bit structures that breaks, but
> that might be too hard to try to handle:
>         efi_table_attr(efi_pci_io_protocol, io, instance)
> where io is a structure of two pointers which would need to be
> individually casted. It's properly accessible as io.read/io.write
> though.
>

Yes. We already have calls to pci.read that use this.

> In general though, everything is either a pointer or a u64, so if it's
> too messy to detect pointer type, the cast is still probably safe in
> practice.

Yes. I'm open to suggestions on how to improve this, but mixed mode is
somewhat of a maintenance burden, so if new future functionality needs
to leave mixed mode behind, I'm not too bothered.

Thanks,
Ard.

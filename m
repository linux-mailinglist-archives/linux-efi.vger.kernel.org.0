Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4F62A6420
	for <lists+linux-efi@lfdr.de>; Wed,  4 Nov 2020 13:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgKDMUA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 07:20:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgKDMUA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Nov 2020 07:20:00 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BDF921734
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604492399;
        bh=PPmfgF6j0XJ+9iXetO3G4OZyvWJKZDAB9USuCWVQbwg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HAHWApHouB31cocPkUknsl7jEuptZ5XxU2Yk3kyClw6edkKg67nvs6p8JV1ZOYyLE
         w45hcXmTUErZFW5+BJl2ZmqvH+6CJIz+FE86QaSz1YVJ9gZTWrh6HJlNlEd5ZRh1Tl
         X+Rs+UFtHSKA9dgzWwrFCS5qXE2sdwTI42kfbrT8=
Received: by mail-oi1-f174.google.com with SMTP id m13so12877767oih.8
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 04:19:59 -0800 (PST)
X-Gm-Message-State: AOAM532LPf2D1RUal0S4VxeD1xUclg1AJxwKQpWCZqSA2c2oeQbvQhEp
        0y7Yg6xlEwxXeupEa9GpHMmGwh8V0y1nF+b3n7A=
X-Google-Smtp-Source: ABdhPJwO2j5Eb3lf+poDrQIw4SUkyfzKB2GZ5QRWZdk0gaHgE5XkcpyH8D9v6FQ7uuVPqmFDqRowcDqzxzG4sQ+PWGs=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr2561078oif.174.1604492398763;
 Wed, 04 Nov 2020 04:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20201025134941.4805-1-ard.biesheuvel@arm.com> <20201025134941.4805-2-ard.biesheuvel@arm.com>
 <20201104121146.GT1664@vanye>
In-Reply-To: <20201104121146.GT1664@vanye>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Nov 2020 13:19:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHfqcDpkPekm7jjgxi5KGCWnBTygrTgBoK2A74MZ6MvkQ@mail.gmail.com>
Message-ID: <CAMj1kXHfqcDpkPekm7jjgxi5KGCWnBTygrTgBoK2A74MZ6MvkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] linux/arm: fix ARM Linux header layout
To:     Leif Lindholm <leif@nuviainc.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Daniel Kiper <daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Nov 2020 at 13:11, Leif Lindholm <leif@nuviainc.com> wrote:
>
> On Sun, Oct 25, 2020 at 14:49:34 +0100, Ard Biesheuvel wrote:
> > The hdr_offset member of the ARM Linux image header appears at
> > offset 0x3c, matching the PE/COFF spec's placement of the COFF
> > header offset in the MS-DOS header. We're currently off by four,
> > so fix that.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> > ---
> >  include/grub/arm/linux.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/grub/arm/linux.h b/include/grub/arm/linux.h
> > index 2e98a6689696..bcd5a7eb186e 100644
> > --- a/include/grub/arm/linux.h
> > +++ b/include/grub/arm/linux.h
> > @@ -30,7 +30,7 @@ struct linux_arm_kernel_header {
> >    grub_uint32_t magic;
> >    grub_uint32_t start; /* _start */
> >    grub_uint32_t end;   /* _edata */
> > -  grub_uint32_t reserved2[4];
> > +  grub_uint32_t reserved2[3];
> >    grub_uint32_t hdr_offset;
>
> How did this ever work?
>

By ignoring the value of hdr_offset entirely everywhere else

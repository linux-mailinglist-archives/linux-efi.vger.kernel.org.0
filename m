Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83531569FB
	for <lists+linux-efi@lfdr.de>; Sun,  9 Feb 2020 12:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgBILfq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 9 Feb 2020 06:35:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39826 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgBILfq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 9 Feb 2020 06:35:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so7399203wme.4
        for <linux-efi@vger.kernel.org>; Sun, 09 Feb 2020 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0IdXZltvvU3REYmb4R5iXSctuV1F7mmZGfNkNXsTGQ=;
        b=oqwUw25QDsnczj0ffV1lgqOR9ummqiOBmmJVUv+PwjDYcp9/9TtJJ1L4SXVli4DSaU
         VrJc5H28RBQNglcoTCexAUZfzd7TKkPytR4mwFbhyR96K+v3RfcnNactz1chjjxsVHdu
         KgadqaKNZ25jqh/j+ttkUB62atGbSYltdJcRRAAATds0zJydBX3EPAF5glBYOqFD1QBY
         jIOQtiinuht5uAM5wKXnPZ2y1TFeMyBuC58JhV/Qac5i+xPsm2/j4E6kvGEEFAE5v/DS
         4PIrVLMKMlKJcuIWNoc+n8FcwLfo0aISGX99CZ1tTok19HfI4Du9zq/SYf48g4EuNzjh
         GC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0IdXZltvvU3REYmb4R5iXSctuV1F7mmZGfNkNXsTGQ=;
        b=Ao0speVoJq2Ld3rNZwmjdL0jg/ZuADxmdICocigMJ1+K78H8GKowaUqNzTQG2/SZg7
         YdvkJA2RZOVsmp6CLoBrFImTt5iZdHc/kiu1NosxQIWg28aVn/SkeTIGLa5/cwdo43PF
         /slWWLw7yI0MPtqIExpUYTLZu66MADt+pkgIJc1VHe/hWXhHq6e3GVL4XGqE4i68eNCa
         3nilLY4bWxXCEzJ4fVlg7wWrRV2hiRoOKGffurkNhboUoIMvyU412vEHGXGTBt+9d65z
         0RiizwCKPdQ18ANI1I1rOA8nur/19sD0lHCc/RcOktrOaBmT6zMzDcqb+6Evei/xyFlu
         3Ouw==
X-Gm-Message-State: APjAAAUUxg3i9X5V+9HyIjjjwb2ovfPo8nm8UYK9L2b7qmKUlbsHbAt1
        3uPzVqjOyoBQbOfWHP9GjfO6/wt9Fc5n93DIq85cNw==
X-Google-Smtp-Source: APXvYqya0smYjoKAUL0KrnH+vxJTYrcEJsBqPunbsV7AjIOwR3KkMPb6XPpVGk4o58xfE9zr1zXzsWz6IeFW0bbAR2Y=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr9277922wmf.40.1581248144864;
 Sun, 09 Feb 2020 03:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20200206140352.6300-1-ardb@kernel.org> <20200206140352.6300-2-ardb@kernel.org>
 <20200209063907.fcwmwtiz2tjhjmol@wunner.de>
In-Reply-To: <20200209063907.fcwmwtiz2tjhjmol@wunner.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 9 Feb 2020 12:35:33 +0100
Message-ID: <CAKv+Gu-aV4REfOUpn7Ap2G6Rza9QFzfPRYU9d5hXvsJozDQNHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/libstub: add support for loading the initrd from
 a device path
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 9 Feb 2020 at 07:50, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Thu, Feb 06, 2020 at 02:03:51PM +0000, Ard Biesheuvel wrote:
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -566,6 +566,14 @@ union efi_load_file_protocol {
> >       } mixed_mode;
> >  };
> >
> > +struct efi_vendor_dev_path {
> > +     u8              type;
> > +     u8              sub_type;
> > +     u16             length;
> > +     efi_guid_t      vendorguid;
> > +     u8              vendordata[];
> > +} __packed;
>
> In commit 46cd4b75cd0e ("efi: Add device path parser") I introduced a
> struct efi_dev_path with a union for the type-specific data.  Maybe
> you can make use of it instead of introducing a new type?
>

That would make sense, but how do you take the size then? Perhaps it
would be better to have a generic struct definition for the shared
fields, struct definitions for the different types that use the
generic type as the first fields, and a separate union that ties them
altogether for the parser.

>
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -323,3 +323,68 @@ void efi_char16_printk(efi_char16_t *str)
> >       efi_call_proto(efi_table_attr(efi_system_table(), con_out),
> >                      output_string, str);
> >  }
> > +
> > +static const struct {
> > +     struct efi_vendor_dev_path      vendor;
> > +     struct efi_generic_dev_path     end;
> > +} __packed initrd_devpath = {
>
> Nit:  Can we consistently stick to "dev_path" in lieu of "devpath"?
>

Sure.

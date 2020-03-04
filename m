Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1193F179695
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 18:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgCDRVm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 12:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgCDRVm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 12:21:42 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 527AA21D56
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583342501;
        bh=JGYuhMvD3vRAF7mr6AMtAFFeUW69MZz9ct4vKKYFOLg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CynZrDF+QIEJQeClku8f4V8WbWY2IpQY+p0u1/oP6PfHw6NFeWZ9bHqHeHlkd6vhQ
         HEB/2fGkJZKeih1hrWt2b5Pl49QKrOQUYG11gu/zpPZVirMo0DAp3nxi+gT6QwP1wh
         FXNuZjz/nNLF6fl8L8FQU9/avd46fNOMQf4mzCkU=
Received: by mail-wr1-f45.google.com with SMTP id q8so3408695wrm.4
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 09:21:41 -0800 (PST)
X-Gm-Message-State: ANhLgQ2Xx/qUzuVzwIgasmpxVpZzRSW840Z5KKM48KlX/li+/3drkeeJ
        ZhdGv7V3R1IkPlMJ4pV9tYmnNMOnaHRzuJ4ergPeBA==
X-Google-Smtp-Source: ADFU+vtEcBzLi3ygUjekNiT+vyNKO03tdiFM4H8bmtuR9z7HfMivRVCDlxcmAqIP36SsnjhEjKxlxvg+Y+vreXN2lIk=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr5170540wrw.252.1583342499798;
 Wed, 04 Mar 2020 09:21:39 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
 <20200304154936.24206-1-vdronov@redhat.com> <CAKv+Gu_WFL24dGPakcPgGW3MayYx1qND9HxL87vods7h4LyZJw@mail.gmail.com>
 <1638562976.13095767.1583342296275.JavaMail.zimbra@redhat.com>
In-Reply-To: <1638562976.13095767.1583342296275.JavaMail.zimbra@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 18:21:28 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_dz2UfZbX0gdegFRk1XFWgsmaX2SkFAhoBjfbwBDU36Q@mail.gmail.com>
Message-ID: <CAKv+Gu_dz2UfZbX0gdegFRk1XFWgsmaX2SkFAhoBjfbwBDU36Q@mail.gmail.com>
Subject: Re: [PATCH v2] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     joeyli <jlee@suse.com>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Mar 2020 at 18:18, Vladis Dronov <vdronov@redhat.com> wrote:
>
> Hello, Ard, Joye, all,
>
> ----- Original Message -----
> > From: "Ard Biesheuvel" <ardb@kernel.org>
> > To: "Vladis Dronov" <vdronov@redhat.com>
> > Cc: "linux-efi" <linux-efi@vger.kernel.org>, "joeyli" <jlee@suse.com>, "Linux Kernel Mailing List"
> > <linux-kernel@vger.kernel.org>
> > Sent: Wednesday, March 4, 2020 4:57:16 PM
> > Subject: Re: [PATCH v2] efi: fix a race and a buffer overflow while reading efivars via sysfs
> >
> > On Wed, 4 Mar 2020 at 16:50, Vladis Dronov <vdronov@redhat.com> wrote:
> > >
> > > There is a race and a buffer overflow corrupting a kernel memory while
> > > reading an efi variable with a size more than 1024 bytes via the older
> > > sysfs method. This happens because accessing struct efi_variable in
> > > efivar_{attr,size,data}_read() and friends is not protected from
> > > a concurrent access leading to a kernel memory corruption and, at best,
> > > to a crash. The race scenario is the following:
> > >
> > > CPU0:                                CPU1:
> > > efivar_attr_read()
> > >   var->DataSize = 1024;
> > >   efivar_entry_get(... &var->DataSize)
> > >     down_interruptible(&efivars_lock)
> > >                                      efivar_attr_read() // same efi var
> > >                                        var->DataSize = 1024;
> > >                                        efivar_entry_get(... &var->DataSize)
> > >                                          down_interruptible(&efivars_lock)
> > >     virt_efi_get_variable()
> > >     // returns EFI_BUFFER_TOO_SMALL but
> > >     // var->DataSize is set to a real
> > >     // var size more than 1024 bytes
> > >     up(&efivars_lock)
> > >                                          virt_efi_get_variable()
> > >                                          // called with var->DataSize set
> > >                                          // to a real var size, returns
> > >                                          // successfully and overwrites
> > >                                          // a 1024-bytes kernel buffer
> > >                                          up(&efivars_lock)
> > >
> > > This can be reproduced by concurrent reading of an efi variable which size
> > > is more than 1024 bytes:
> > >
> > > ts# for cpu in $(seq 0 $(nproc --ignore=1)); do ( taskset -c $cpu \
> > > cat /sys/firmware/efi/vars/KEKDefault*/size & ) ; done
> > >
> > > Fix this by using a local variable for a var's data buffer size so it
> > > does not get overwritten. Also add a sanity check to efivar_store_raw().
> > >
> > > Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
> > > Signed-off-by: Vladis Dronov <vdronov@redhat.com>
>
> AFAIU, you can modify suggested patches, could you please, add a link here
> so further reader has a reference (I forgot to do it myself):
>
> Link: https://lore.kernel.org/linux-efi/20200303085528.27658-1-vdronov@redhat.com/T/#u
>
> > > ---
> > >  drivers/firmware/efi/efi-pstore.c |  2 +-
> > >  drivers/firmware/efi/efivars.c    | 32 ++++++++++++++++++++++---------
> > >  drivers/firmware/efi/vars.c       |  2 +-
> > >  3 files changed, 25 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/efi-pstore.c
> > > b/drivers/firmware/efi/efi-pstore.c
> > > index 9ea13e8d12ec..e4767a7ce973 100644
> > > --- a/drivers/firmware/efi/efi-pstore.c
> > > +++ b/drivers/firmware/efi/efi-pstore.c
> > > @@ -161,7 +161,7 @@ static int efi_pstore_scan_sysfs_exit(struct
> > > efivar_entry *pos,
> > >   *
> > >   * @record: pstore record to pass to callback
> > >   *
> > > - * You MUST call efivar_enter_iter_begin() before this function, and
> > > + * You MUST call efivar_entry_iter_begin() before this function, and
> > >   * efivar_entry_iter_end() afterwards.
> > >   *
> > >   */
> >
> > This hunk can be dropped now, I guess
>
> I surely do not have much experience in writing upstream patches. But I saw people
> doing small fixes like this one, say, commit 589b7289 ("While we are here, the previous
> line has some trailing whitespace; clean that up as well"). This is a small mistype
> and I just wanted to fix it and did not wanted to allocate a whole commit for that.
> I believe a bigger commit is an acceptable place to fix mistypes.
>
> AFAIU, a maintainer can modify suggested patches, so please, feel free to drop this
> hunk, if you feel this is a right thing.
>

I am not going to perform surgery on your patches. Please drop this
hunk (and the one at the end) in the next version.


> > > diff --git a/drivers/firmware/efi/efivars.c
> > > b/drivers/firmware/efi/efivars.c
> > > index 7576450c8254..16a617f9c5cf 100644
> > > --- a/drivers/firmware/efi/efivars.c
> > > +++ b/drivers/firmware/efi/efivars.c
> > > @@ -83,13 +83,16 @@ static ssize_t
> > >  efivar_attr_read(struct efivar_entry *entry, char *buf)
> > >  {
> > >         struct efi_variable *var = &entry->var;
> > > +       unsigned long size = sizeof(var->Data);
> > >         char *str = buf;
> > > +       int ret;
> > >
> > >         if (!entry || !buf)
> > >                 return -EINVAL;
> > >
> > > -       var->DataSize = 1024;
> > > -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > > var->Data))
> > > +       ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
> > > +       var->DataSize = size;
> >
> > For my understanding, could you explain why we do the assignment here?
> > Does var->DataSize matter in this case? Can it deviate from 1024?
>
> Yes, the other code expects var->DataSize to be set to a real size of a var
> after efivar_entry_get() call. For example, efivar_show_raw():
>
>     compat->DataSize = var->DataSize;
>
> and efivar_data_read():
>
>     memcpy(buf, var->Data, var->DataSize);
>     return var->DataSize;
>
> Yes, we can change the code to use size here, but this will make struct efi_variable
> *var inconsistent (name, guid, data, attr set properly, but not size). It feels so
> incorrect to leave this struct inconsistent. I'm not sure that code which calls
> efivar_{attr,size,data}_read()/efivar_show_raw() is not using this struct's ->DataSize
> field later.
>

OK, that makes sense.

> > > +       if (ret)
> > >                 return -EIO;
> > >
> > >         if (var->Attributes & EFI_VARIABLE_NON_VOLATILE)
> > > @@ -116,13 +119,16 @@ static ssize_t
> > >  efivar_size_read(struct efivar_entry *entry, char *buf)
> > >  {
> > >         struct efi_variable *var = &entry->var;
> > > +       unsigned long size = sizeof(var->Data);
> > >         char *str = buf;
> > > +       int ret;
> > >
> > >         if (!entry || !buf)
> > >                 return -EINVAL;
> > >
> > > -       var->DataSize = 1024;
> > > -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > > var->Data))
> > > +       ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
> > > +       var->DataSize = size;
> > > +       if (ret)
> > >                 return -EIO;
> > >
> > >         str += sprintf(str, "0x%lx\n", var->DataSize);
> > > @@ -133,12 +139,15 @@ static ssize_t
> > >  efivar_data_read(struct efivar_entry *entry, char *buf)
> > >  {
> > >         struct efi_variable *var = &entry->var;
> > > +       unsigned long size = sizeof(var->Data);
> > > +       int ret;
> > >
> > >         if (!entry || !buf)
> > >                 return -EINVAL;
> > >
> > > -       var->DataSize = 1024;
> > > -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > > var->Data))
> > > +       ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
> > > +       var->DataSize = size;
> > > +       if (ret)
> > >                 return -EIO;
> > >
> > >         memcpy(buf, var->Data, var->DataSize);
> > > @@ -199,6 +208,9 @@ efivar_store_raw(struct efivar_entry *entry, const char
> > > *buf, size_t count)
> > >         u8 *data;
> > >         int err;
> > >
> > > +       if (!entry || !buf)
> > > +               return -EINVAL;
> > > +
> >
> > So what are we sanity checking here? When might this occur? Does it
> > need to be in the same patch?
>
> efivar_{attr,size,data}_read()/efivar_show_raw() has this check, I believe
> it is reasonable to add it here too. In case entry or buf happen to be NULL
> it will lead to a NULL-deref later:
>
>     compat = (struct compat_efi_variable *)buf;
>     memcpy(compat->VariableName, var->VariableName, EFI_VAR_NAME_LEN);
>
> I see this as more-or-less related and too small for a whole separate commit.
> Please, feel free to drop this hunk, if you believe this is not correct. Would
> you like me to send a separate patch adding the check above in this case?
>

Yes, please. Make it a two-piece series with a cover letter.


> > >         if (in_compat_syscall()) {
> > >                 struct compat_efi_variable *compat;
> > >
> > > @@ -250,14 +262,16 @@ efivar_show_raw(struct efivar_entry *entry, char
> > > *buf)
> > >  {
> > >         struct efi_variable *var = &entry->var;
> > >         struct compat_efi_variable *compat;
> > > +       unsigned long datasize = sizeof(var->Data);
> > >         size_t size;
> > > +       int ret;
> > >
> > >         if (!entry || !buf)
> > >                 return 0;
> > >
> > > -       var->DataSize = 1024;
> > > -       if (efivar_entry_get(entry, &entry->var.Attributes,
> > > -                            &entry->var.DataSize, entry->var.Data))
> > > +       ret = efivar_entry_get(entry, &var->Attributes, &datasize,
> > > var->Data);
> > > +       var->DataSize = size;
> > > +       if (ret)
> > >                 return -EIO;
> > >
> > >         if (in_compat_syscall()) {
> > > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > > index 436d1776bc7b..5f2a4d162795 100644
> > > --- a/drivers/firmware/efi/vars.c
> > > +++ b/drivers/firmware/efi/vars.c
> > > @@ -1071,7 +1071,7 @@ EXPORT_SYMBOL_GPL(efivar_entry_iter_end);
> > >   * entry on the list. It is safe for @func to remove entries in the
> > >   * list via efivar_entry_delete().
> > >   *
> > > - * You MUST call efivar_enter_iter_begin() before this function, and
> > > + * You MUST call efivar_entry_iter_begin() before this function, and
> > >   * efivar_entry_iter_end() afterwards.
> > >   *
> > >   * It is possible to begin iteration from an arbitrary entry within
> >
> > We can drop this.

... or make it a 3 piece series if you *really* want to clean up the
whitespace :-)

> >
> > > --
> > > 2.20.1
>
> Best regards,
> Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer
>

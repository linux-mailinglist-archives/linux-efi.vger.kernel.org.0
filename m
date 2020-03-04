Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D0A17968C
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 18:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgCDRS1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 12:18:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43235 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726561AbgCDRS0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 12:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583342305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jniVOVh/M/429QHFUUGmIQdnbB+wp5Ylxxt5p5fe0t4=;
        b=igy0eGascqrgIdffGowDR3hGRQeOenhTqkEdz9WXgyyPm9jSYVYQXuqs9Peny7NsoW/GNY
        DwulbKU67oZEneK2YYHrxzprizAW1/bayEF0ZIIIAldBdXmRbVquHFJV7UBRQhptfkOgc7
        aTa/CBPquO/AUhJd9hs/NmX//3+n6yY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-AbolXN_vM-OUO44sTXxuSw-1; Wed, 04 Mar 2020 12:18:19 -0500
X-MC-Unique: AbolXN_vM-OUO44sTXxuSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7753018FE866;
        Wed,  4 Mar 2020 17:18:16 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AE1026FDF;
        Wed,  4 Mar 2020 17:18:16 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 58F7D86A04;
        Wed,  4 Mar 2020 17:18:16 +0000 (UTC)
Date:   Wed, 4 Mar 2020 12:18:16 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>, joeyli <jlee@suse.com>,
        linux-efi <linux-efi@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <1638562976.13095767.1583342296275.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAKv+Gu_WFL24dGPakcPgGW3MayYx1qND9HxL87vods7h4LyZJw@mail.gmail.com>
References: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com> <20200304154936.24206-1-vdronov@redhat.com> <CAKv+Gu_WFL24dGPakcPgGW3MayYx1qND9HxL87vods7h4LyZJw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.205, 10.4.195.2]
Thread-Topic: fix a race and a buffer overflow while reading efivars via sysfs
Thread-Index: P8sJMHmxkKIpCZVtU9rWB9NYrEezYw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello, Ard, Joye, all,

----- Original Message -----
> From: "Ard Biesheuvel" <ardb@kernel.org>
> To: "Vladis Dronov" <vdronov@redhat.com>
> Cc: "linux-efi" <linux-efi@vger.kernel.org>, "joeyli" <jlee@suse.com>, "Linux Kernel Mailing List"
> <linux-kernel@vger.kernel.org>
> Sent: Wednesday, March 4, 2020 4:57:16 PM
> Subject: Re: [PATCH v2] efi: fix a race and a buffer overflow while reading efivars via sysfs
> 
> On Wed, 4 Mar 2020 at 16:50, Vladis Dronov <vdronov@redhat.com> wrote:
> >
> > There is a race and a buffer overflow corrupting a kernel memory while
> > reading an efi variable with a size more than 1024 bytes via the older
> > sysfs method. This happens because accessing struct efi_variable in
> > efivar_{attr,size,data}_read() and friends is not protected from
> > a concurrent access leading to a kernel memory corruption and, at best,
> > to a crash. The race scenario is the following:
> >
> > CPU0:                                CPU1:
> > efivar_attr_read()
> >   var->DataSize = 1024;
> >   efivar_entry_get(... &var->DataSize)
> >     down_interruptible(&efivars_lock)
> >                                      efivar_attr_read() // same efi var
> >                                        var->DataSize = 1024;
> >                                        efivar_entry_get(... &var->DataSize)
> >                                          down_interruptible(&efivars_lock)
> >     virt_efi_get_variable()
> >     // returns EFI_BUFFER_TOO_SMALL but
> >     // var->DataSize is set to a real
> >     // var size more than 1024 bytes
> >     up(&efivars_lock)
> >                                          virt_efi_get_variable()
> >                                          // called with var->DataSize set
> >                                          // to a real var size, returns
> >                                          // successfully and overwrites
> >                                          // a 1024-bytes kernel buffer
> >                                          up(&efivars_lock)
> >
> > This can be reproduced by concurrent reading of an efi variable which size
> > is more than 1024 bytes:
> >
> > ts# for cpu in $(seq 0 $(nproc --ignore=1)); do ( taskset -c $cpu \
> > cat /sys/firmware/efi/vars/KEKDefault*/size & ) ; done
> >
> > Fix this by using a local variable for a var's data buffer size so it
> > does not get overwritten. Also add a sanity check to efivar_store_raw().
> >
> > Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
> > Signed-off-by: Vladis Dronov <vdronov@redhat.com>

AFAIU, you can modify suggested patches, could you please, add a link here
so further reader has a reference (I forgot to do it myself):

Link: https://lore.kernel.org/linux-efi/20200303085528.27658-1-vdronov@redhat.com/T/#u

> > ---
> >  drivers/firmware/efi/efi-pstore.c |  2 +-
> >  drivers/firmware/efi/efivars.c    | 32 ++++++++++++++++++++++---------
> >  drivers/firmware/efi/vars.c       |  2 +-
> >  3 files changed, 25 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/efi-pstore.c
> > b/drivers/firmware/efi/efi-pstore.c
> > index 9ea13e8d12ec..e4767a7ce973 100644
> > --- a/drivers/firmware/efi/efi-pstore.c
> > +++ b/drivers/firmware/efi/efi-pstore.c
> > @@ -161,7 +161,7 @@ static int efi_pstore_scan_sysfs_exit(struct
> > efivar_entry *pos,
> >   *
> >   * @record: pstore record to pass to callback
> >   *
> > - * You MUST call efivar_enter_iter_begin() before this function, and
> > + * You MUST call efivar_entry_iter_begin() before this function, and
> >   * efivar_entry_iter_end() afterwards.
> >   *
> >   */
> 
> This hunk can be dropped now, I guess

I surely do not have much experience in writing upstream patches. But I saw people
doing small fixes like this one, say, commit 589b7289 ("While we are here, the previous
line has some trailing whitespace; clean that up as well"). This is a small mistype
and I just wanted to fix it and did not wanted to allocate a whole commit for that.
I believe a bigger commit is an acceptable place to fix mistypes.

AFAIU, a maintainer can modify suggested patches, so please, feel free to drop this
hunk, if you feel this is a right thing.

> > diff --git a/drivers/firmware/efi/efivars.c
> > b/drivers/firmware/efi/efivars.c
> > index 7576450c8254..16a617f9c5cf 100644
> > --- a/drivers/firmware/efi/efivars.c
> > +++ b/drivers/firmware/efi/efivars.c
> > @@ -83,13 +83,16 @@ static ssize_t
> >  efivar_attr_read(struct efivar_entry *entry, char *buf)
> >  {
> >         struct efi_variable *var = &entry->var;
> > +       unsigned long size = sizeof(var->Data);
> >         char *str = buf;
> > +       int ret;
> >
> >         if (!entry || !buf)
> >                 return -EINVAL;
> >
> > -       var->DataSize = 1024;
> > -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > var->Data))
> > +       ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
> > +       var->DataSize = size;
> 
> For my understanding, could you explain why we do the assignment here?
> Does var->DataSize matter in this case? Can it deviate from 1024?

Yes, the other code expects var->DataSize to be set to a real size of a var
after efivar_entry_get() call. For example, efivar_show_raw():

    compat->DataSize = var->DataSize;

and efivar_data_read():

    memcpy(buf, var->Data, var->DataSize);
    return var->DataSize;

Yes, we can change the code to use size here, but this will make struct efi_variable
*var inconsistent (name, guid, data, attr set properly, but not size). It feels so
incorrect to leave this struct inconsistent. I'm not sure that code which calls
efivar_{attr,size,data}_read()/efivar_show_raw() is not using this struct's ->DataSize
field later.

> > +       if (ret)
> >                 return -EIO;
> >
> >         if (var->Attributes & EFI_VARIABLE_NON_VOLATILE)
> > @@ -116,13 +119,16 @@ static ssize_t
> >  efivar_size_read(struct efivar_entry *entry, char *buf)
> >  {
> >         struct efi_variable *var = &entry->var;
> > +       unsigned long size = sizeof(var->Data);
> >         char *str = buf;
> > +       int ret;
> >
> >         if (!entry || !buf)
> >                 return -EINVAL;
> >
> > -       var->DataSize = 1024;
> > -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > var->Data))
> > +       ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
> > +       var->DataSize = size;
> > +       if (ret)
> >                 return -EIO;
> >
> >         str += sprintf(str, "0x%lx\n", var->DataSize);
> > @@ -133,12 +139,15 @@ static ssize_t
> >  efivar_data_read(struct efivar_entry *entry, char *buf)
> >  {
> >         struct efi_variable *var = &entry->var;
> > +       unsigned long size = sizeof(var->Data);
> > +       int ret;
> >
> >         if (!entry || !buf)
> >                 return -EINVAL;
> >
> > -       var->DataSize = 1024;
> > -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > var->Data))
> > +       ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
> > +       var->DataSize = size;
> > +       if (ret)
> >                 return -EIO;
> >
> >         memcpy(buf, var->Data, var->DataSize);
> > @@ -199,6 +208,9 @@ efivar_store_raw(struct efivar_entry *entry, const char
> > *buf, size_t count)
> >         u8 *data;
> >         int err;
> >
> > +       if (!entry || !buf)
> > +               return -EINVAL;
> > +
> 
> So what are we sanity checking here? When might this occur? Does it
> need to be in the same patch?

efivar_{attr,size,data}_read()/efivar_show_raw() has this check, I believe
it is reasonable to add it here too. In case entry or buf happen to be NULL
it will lead to a NULL-deref later:

    compat = (struct compat_efi_variable *)buf;
    memcpy(compat->VariableName, var->VariableName, EFI_VAR_NAME_LEN);

I see this as more-or-less related and too small for a whole separate commit.
Please, feel free to drop this hunk, if you believe this is not correct. Would
you like me to send a separate patch adding the check above in this case?

> >         if (in_compat_syscall()) {
> >                 struct compat_efi_variable *compat;
> >
> > @@ -250,14 +262,16 @@ efivar_show_raw(struct efivar_entry *entry, char
> > *buf)
> >  {
> >         struct efi_variable *var = &entry->var;
> >         struct compat_efi_variable *compat;
> > +       unsigned long datasize = sizeof(var->Data);
> >         size_t size;
> > +       int ret;
> >
> >         if (!entry || !buf)
> >                 return 0;
> >
> > -       var->DataSize = 1024;
> > -       if (efivar_entry_get(entry, &entry->var.Attributes,
> > -                            &entry->var.DataSize, entry->var.Data))
> > +       ret = efivar_entry_get(entry, &var->Attributes, &datasize,
> > var->Data);
> > +       var->DataSize = size;
> > +       if (ret)
> >                 return -EIO;
> >
> >         if (in_compat_syscall()) {
> > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > index 436d1776bc7b..5f2a4d162795 100644
> > --- a/drivers/firmware/efi/vars.c
> > +++ b/drivers/firmware/efi/vars.c
> > @@ -1071,7 +1071,7 @@ EXPORT_SYMBOL_GPL(efivar_entry_iter_end);
> >   * entry on the list. It is safe for @func to remove entries in the
> >   * list via efivar_entry_delete().
> >   *
> > - * You MUST call efivar_enter_iter_begin() before this function, and
> > + * You MUST call efivar_entry_iter_begin() before this function, and
> >   * efivar_entry_iter_end() afterwards.
> >   *
> >   * It is possible to begin iteration from an arbitrary entry within
> 
> We can drop this.
> 
> > --
> > 2.20.1

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer


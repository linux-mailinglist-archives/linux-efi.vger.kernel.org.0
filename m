Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4C1F93E1
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 11:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgFOJtG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 05:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgFOJtG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Jun 2020 05:49:06 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77C81206D7;
        Mon, 15 Jun 2020 09:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592214545;
        bh=aqZT/dC6Wve5qO/VQrbYAItbuMUgPlaVWAx/VHhhRII=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LmWXsJtpJOzqqdfYw3rNIjyR3Qt+0mcOBIKwJcxOXttQ8+ha9zGkTcTZYSVTMX66c
         X7Vk1to9nbgCldwGDt6fSFPOAfw6rMloIQpPKxmQmR+W+SY5nELh9UXiPzjqsAGlc8
         AmlY66QzqgEZ2mzLeKESWS4tlNgyyNBSQJLZQXmY=
Received: by mail-oi1-f181.google.com with SMTP id b8so15368287oic.1;
        Mon, 15 Jun 2020 02:49:05 -0700 (PDT)
X-Gm-Message-State: AOAM533GQMoZL/Xw/EYD3mNXfq/ixgZUm6jkvy9DLjepm6/w8T2rnwka
        IWx3nJzdHrFQZWSUfcID9QnhnmsyXUNgszbY6d8=
X-Google-Smtp-Source: ABdhPJz+sxVzmGdTU33ig2MwYbaOjlUG/qh6Hu4FlT2D8bHzbp8K0y07kpA9+hdp6o/spnUt/6fRRKH8yd2EMeilnLQ=
X-Received: by 2002:aca:ba03:: with SMTP id k3mr1799842oif.33.1592214544820;
 Mon, 15 Jun 2020 02:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200528183804.4497-1-wu000273@umn.edu> <CAMj1kXE7soPKnsRPjB5HfUZ4MhAVX_ejbidozyOFrj4AfROjPg@mail.gmail.com>
 <CAMV6ehETfqcZS=e4Fk82neOwNJH8Qm+AXXihRQYAPfS4aqjVGg@mail.gmail.com>
In-Reply-To: <CAMV6ehETfqcZS=e4Fk82neOwNJH8Qm+AXXihRQYAPfS4aqjVGg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Jun 2020 11:48:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHhu3Vpk9239v1QeiGVsG1JmYVvQm-4W+78=wq4aouPbw@mail.gmail.com>
Message-ID: <CAMj1kXHhu3Vpk9239v1QeiGVsG1JmYVvQm-4W+78=wq4aouPbw@mail.gmail.com>
Subject: Re: [PATCH] efi/esrt: Fix reference count leak in esre_create_sysfs_entry.
To:     Qiushi Wu <wu000273@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Peter Jones <pjones@redhat.com>,
        Matt Fleming <matt.fleming@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 30 May 2020 at 06:23, Qiushi Wu <wu000273@umn.edu> wrote:
>
> Thanks for your reply!
>  > Why are you removing this kfree() call?
>
> Because  kobject_put(&entry->kobj) will call kobject_release(), which will call kobject_cleanup(), which will dynamically call get_ktype(kobj)->release(kobj); .
> In this case, the "release" function is defined as:
> static struct kobj_type esre1_ktype = {
> .release = esre_release.
> ...
> };
>
> and esre_release() is defined as :
> static void esre_release(struct kobject *kobj) {
>            struct esre_entry *entry = to_entry(kobj);
>            list_del(&entry->list);
>            kfree(entry);
> }
>
> In this case, if we call both kobject_put() and kfree(), a double-free will be introduced.
>

Thanks for the explanation

Queued in efi/urgent.

> On Fri, May 29, 2020 at 12:00 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Thu, 28 May 2020 at 20:38, <wu000273@umn.edu> wrote:
>> >
>> > From: Qiushi Wu <wu000273@umn.edu>
>> >
>> > kobject_init_and_add() takes reference even when it fails.
>> > If this function returns an error, kobject_put() must be called to
>> > properly clean up the memory associated with the object. Previous
>> > commit "b8eb718348b8" fixed a similar problem.
>> >
>> > Fixes: 0bb549052d33 ("efi: Add esrt support")
>> > Signed-off-by: Qiushi Wu <wu000273@umn.edu>
>> > ---
>> >  drivers/firmware/efi/esrt.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
>> > index e3d692696583..d5915272141f 100644
>> > --- a/drivers/firmware/efi/esrt.c
>> > +++ b/drivers/firmware/efi/esrt.c
>> > @@ -181,7 +181,7 @@ static int esre_create_sysfs_entry(void *esre, int entry_num)
>> >                 rc = kobject_init_and_add(&entry->kobj, &esre1_ktype, NULL,
>> >                                           "entry%d", entry_num);
>> >                 if (rc) {
>> > -                       kfree(entry);
>>
>> Why are you removing this kfree() call?
>>
>> > +                       kobject_put(&entry->kobj);
>> >                         return rc;
>> >                 }
>> >         }
>> > --
>> > 2.17.1
>> >

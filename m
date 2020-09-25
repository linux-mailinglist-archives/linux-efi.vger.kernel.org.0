Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA35278207
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 09:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgIYHyo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Sep 2020 03:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgIYHym (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Sep 2020 03:54:42 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9844CC0613CE
        for <linux-efi@vger.kernel.org>; Fri, 25 Sep 2020 00:54:41 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id z193so856313vsz.10
        for <linux-efi@vger.kernel.org>; Fri, 25 Sep 2020 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nc1cpnSDlXbRzr8P9/b6kU8iAwX3SL3yb53UV8YCftU=;
        b=qJP0sGkoc8edOSz39jUh0rluYSenlnPU2VduqGsi87wrrctSyvZKfb9GLSAGz2mQS6
         VblprWT+zHNfBXXK/XGIeJOjypJ9mkr0DNtkT4NG7wY4HZekj6i56LKt0O067MsAq2KI
         CNtQDeZPO33Y0IijYDI+dAc0RRnWJTgMex1/bqIuuj6NwljXihyjJSSmahQ0fOWXgyH/
         0Ab9uCwjlAyiuCovYyfyI7JmtNWsWg8e6ZBkDYX4vIQQzW8nWW1InwOhZl/0Nak46bO9
         j+mOg4uNz5Lu9nl62SXcS0fC/4MHdhHmYElIhkDpJg5FabYMzecs64PtBfAQ7/6pdOTp
         w86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nc1cpnSDlXbRzr8P9/b6kU8iAwX3SL3yb53UV8YCftU=;
        b=Fd8x/JeF4NaOWs3mJtIL0qAm4OlhgRYO1LGnDdt5599fkrolIz9AHOZc1oM/EfHIGk
         VXRa3Mh+7vN2adDuI10jZOvDHEaqQNsEViX2EZV/JDkPMFXAO9y8+wO0jvLD8hIlJJFh
         8tXPtNSLF95KqWZ2nKjgxqv+a9WGcCoLNvsezQyUPPpE4pf+Mw9I7yOluA24sGtHNTBe
         qHh4LGLu+nMsdLcNjQnEKIWVTGrDIGf+qzmLiU3ru63mPp3UjY/yLcoRQzWz5cBZIN36
         d4g5nn6zk9ylS38JA03undmfY5fxCmWm0SHTYQJyNc2wRb8Eon+U7aMQzwlSrnycWnd8
         WJHw==
X-Gm-Message-State: AOAM530w13+w4GdHyZXL86BrG8D3paPCJbh1FtS8zoCphUZ4kpzd9cX1
        nSUBC/Nyf6H0q9lEzDsWBv3AIUaeJyMyXnWS7VN89Q==
X-Google-Smtp-Source: ABdhPJzSyc9kVqTopVZTnS96i0P46m7wUwLEItWfoSiad2St+F/CNOKcmRfLpAXNv+nTbXgEFNOALl3yWPQLrEoxrDI=
X-Received: by 2002:a67:f511:: with SMTP id u17mr2376263vsn.2.1601020480605;
 Fri, 25 Sep 2020 00:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200925074502.150448-1-misch@google.com> <CAMj1kXH9B0TevUEN=CGn9TCYCgr37zX+kSfmqxeALPmUG4GWCA@mail.gmail.com>
In-Reply-To: <CAMj1kXH9B0TevUEN=CGn9TCYCgr37zX+kSfmqxeALPmUG4GWCA@mail.gmail.com>
From:   Michael Schaller <misch@google.com>
Date:   Fri, 25 Sep 2020 09:54:04 +0200
Message-ID: <CALt099+4UNaVGoeHNOfErEtBwyUuV_ZhSRFkLKksPdWnrdednQ@mail.gmail.com>
Subject: Re: [PATCH v2] efivarfs: Replace invalid slashes with exclamation
 marks in dentries.
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Michael Schaller <michael@5challer.de>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 25, 2020 at 9:49 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 25 Sep 2020 at 09:45, Michael Schaller <misch@google.com> wrote:
> >
> > Without this patch efivarfs_alloc_dentry creates dentries with slashes in
> > their name if the respective EFI variable has slashes in its name. This in
> > turn causes EIO on getdents64, which prevents a complete directory listing
> > of /sys/firmware/efi/efivars/.
> >
> > This patch replaces the invalid shlashes with exclamation marks like
> > kobject_set_name_vargs does for /sys/firmware/efi/vars/ to have consistently
> > named dentries under /sys/firmware/efi/vars/ and /sys/firmware/efi/efivars/.
> >
> > Signed-off-by: Michael Schaller <misch@google.com>
>
> Thanks
>
> > Tested-by: Michael Schaller <misch@google.com>
>
> I will drop this - in general, it is assumed that you test your own
> patches before sending them to the list, so this is implicit. Also,
> tested-by's given on the list tend to carry more weight than ones that
> are givenin private and added to the patch by the authors themselves.
>
Makes sense. Is anything else needed from my side?
>
> > ---
> >  fs/efivarfs/super.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index 28bb5689333a..15880a68faad 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -141,6 +141,9 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
> >
> >         name[len + EFI_VARIABLE_GUID_LEN+1] = '\0';
> >
> > +       /* replace invalid slashes like kobject_set_name_vargs does for /sys/firmware/efi/vars. */
> > +       strreplace(name, '/', '!');
> > +
> >         inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
> >                                    is_removable);
> >         if (!inode)
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >

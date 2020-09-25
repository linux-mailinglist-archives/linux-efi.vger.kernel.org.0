Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A90C278209
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 09:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgIYHzU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Sep 2020 03:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYHzU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 25 Sep 2020 03:55:20 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1CDC21D7F;
        Fri, 25 Sep 2020 07:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601020519;
        bh=PYpKBdfnxsl+lZy0uAbjykbMZcQ/ZeD5YtM3wnkKo5M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gNPoZTypH49YY9R/KhFolT0F8pW+EHYH7dxKak/bSFnX64hq6gfi1+8kRIwVxOZRe
         zuNM007hxQj7V0m0JveFQw/hCcJzeElZiyoRL5EGn8Zjj3beN2Phtm3hM8e7ppEvHo
         Uyc0PJjW0wzsdHA+s4lOHvqqFWEhltFWjwx5DoRg=
Received: by mail-ot1-f53.google.com with SMTP id 60so1500988otw.3;
        Fri, 25 Sep 2020 00:55:19 -0700 (PDT)
X-Gm-Message-State: AOAM532uUyBBqqi+yFqLJBGMhbhXY8iYNTtKxDBVBmS1dayx1ViYvzA1
        EMe26K2Vw7f7TsD4lxOLTKxPoyKZiVJWvq+nF50=
X-Google-Smtp-Source: ABdhPJyzAIgd2f9RlYkvBwF0nAfD7pU8wq5KUudhHCmDW47t7NNBE4tJZQj0wFDYwlN2mwgGkqVz555jZ19iot6ynio=
X-Received: by 2002:a9d:335:: with SMTP id 50mr1961284otv.90.1601020518988;
 Fri, 25 Sep 2020 00:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200925074502.150448-1-misch@google.com> <CAMj1kXH9B0TevUEN=CGn9TCYCgr37zX+kSfmqxeALPmUG4GWCA@mail.gmail.com>
 <CALt099+4UNaVGoeHNOfErEtBwyUuV_ZhSRFkLKksPdWnrdednQ@mail.gmail.com>
In-Reply-To: <CALt099+4UNaVGoeHNOfErEtBwyUuV_ZhSRFkLKksPdWnrdednQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Sep 2020 09:55:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGhdtmHkcjKsSS37hXyeR3cHD3m=Qk4LZy12Nvrkz6H2A@mail.gmail.com>
Message-ID: <CAMj1kXGhdtmHkcjKsSS37hXyeR3cHD3m=Qk4LZy12Nvrkz6H2A@mail.gmail.com>
Subject: Re: [PATCH v2] efivarfs: Replace invalid slashes with exclamation
 marks in dentries.
To:     Michael Schaller <misch@google.com>
Cc:     Michael Schaller <michael@5challer.de>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 25 Sep 2020 at 09:54, Michael Schaller <misch@google.com> wrote:
>
> On Fri, Sep 25, 2020 at 9:49 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 25 Sep 2020 at 09:45, Michael Schaller <misch@google.com> wrote:
> > >
> > > Without this patch efivarfs_alloc_dentry creates dentries with slashes in
> > > their name if the respective EFI variable has slashes in its name. This in
> > > turn causes EIO on getdents64, which prevents a complete directory listing
> > > of /sys/firmware/efi/efivars/.
> > >
> > > This patch replaces the invalid shlashes with exclamation marks like
> > > kobject_set_name_vargs does for /sys/firmware/efi/vars/ to have consistently
> > > named dentries under /sys/firmware/efi/vars/ and /sys/firmware/efi/efivars/.
> > >
> > > Signed-off-by: Michael Schaller <misch@google.com>
> >
> > Thanks
> >
> > > Tested-by: Michael Schaller <misch@google.com>
> >
> > I will drop this - in general, it is assumed that you test your own
> > patches before sending them to the list, so this is implicit. Also,
> > tested-by's given on the list tend to carry more weight than ones that
> > are givenin private and added to the patch by the authors themselves.
> >
> Makes sense. Is anything else needed from my side?

No, all good. I'll pick this up as a fix.

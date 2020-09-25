Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12E527821A
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 09:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgIYH7b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Sep 2020 03:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgIYH7b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Sep 2020 03:59:31 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303A9C0613CE
        for <linux-efi@vger.kernel.org>; Fri, 25 Sep 2020 00:59:31 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id q13so439652vkd.0
        for <linux-efi@vger.kernel.org>; Fri, 25 Sep 2020 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmzvI7bLp+HXZkXKts/TpgvUkaO+vCNm5sr9JYnyTQ4=;
        b=WWaqM1HnH54O8xGTfuKfUhYfoJNUXfoWG8s83ruOVd7Svpd/2RHIg/ZhvuqzQ78OU3
         7JD8tW55JSZfRfoxagzRNedzB3Ww4mU0JB4NULI9thCp/uw6xpnAC+31RhuoE7o2QL72
         ZEUrmUJn373uQSdBN6eAZDiZJOm20VdItOIrC2BFOFdXzRWU7t8txNmTAjH++VSOJm3P
         2VIwRMBdmDcFxM+0Yibq8y7j2Jah3ZiLa1nDdMPOIcwyeGETPIHAVbFIwwzz3Urqq9X2
         DfdjjSqD/0ZBGJQz5mDUfw/7C3Tf92UtyNXF4sEw485Tu3x38Ucs2k7GS+Z9jjK7W6w3
         8/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmzvI7bLp+HXZkXKts/TpgvUkaO+vCNm5sr9JYnyTQ4=;
        b=iCIeEQAyPkVZA1hfp3CG2xEQq4gMRiVZuN5vCM9khW9QBP6V+6LEJ34nAaRt9fzDOm
         FghAAguP0BuwyajeQ01WAiFyY952MWM0srRxoZZno3k2XygNN1B4bS/sL/Eph+Ij5sbq
         bNvnqtetLFZTB/+vUg/l1bVi9nzArUNhkL8lh1i3LX0I7U2O70eOcyMFJzCuKxJUyFzq
         79ZbMNenKPJZzQcdJ3Z9uUGlVko0X2qcHcj+ZdXsldeJnd3H3eLSoDqJzd3awwz/Ec7O
         MVxOQUquFyvt4/wpHAknIAKFj2PTNfBFndetmXGqARuOSBeMI+ZCjPBZRKkfvUVFjV5n
         Wxyw==
X-Gm-Message-State: AOAM5306aIFT2MYOVlDM7NZOXCWt+hnMO8CtkuZOJCv4UkAJKuRi7HzV
        n6o1iiXUzJabauBRLlMChAXxvELHPPyDGdEnNqf5mA==
X-Google-Smtp-Source: ABdhPJxh/GyEjB4nZEdooRuKAJCksrk4FD6fT1wE8pTBMWRm2KEzOlxumZyF07IdAGQPkmVLhBGEDf+oxw5YMTRGwL4=
X-Received: by 2002:a1f:2c42:: with SMTP id s63mr2014964vks.24.1601020770174;
 Fri, 25 Sep 2020 00:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200925074502.150448-1-misch@google.com> <CAMj1kXH9B0TevUEN=CGn9TCYCgr37zX+kSfmqxeALPmUG4GWCA@mail.gmail.com>
 <CALt099+4UNaVGoeHNOfErEtBwyUuV_ZhSRFkLKksPdWnrdednQ@mail.gmail.com> <CAMj1kXGhdtmHkcjKsSS37hXyeR3cHD3m=Qk4LZy12Nvrkz6H2A@mail.gmail.com>
In-Reply-To: <CAMj1kXGhdtmHkcjKsSS37hXyeR3cHD3m=Qk4LZy12Nvrkz6H2A@mail.gmail.com>
From:   Michael Schaller <misch@google.com>
Date:   Fri, 25 Sep 2020 09:58:53 +0200
Message-ID: <CALt099+8qzGhV_aXmrHciDVowCxmKRd4Frrz=5z8=Fq3HRqfvg@mail.gmail.com>
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

On Fri, Sep 25, 2020 at 9:55 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 25 Sep 2020 at 09:54, Michael Schaller <misch@google.com> wrote:
> >
> > On Fri, Sep 25, 2020 at 9:49 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Fri, 25 Sep 2020 at 09:45, Michael Schaller <misch@google.com> wrote:
> > > >
> > > > Without this patch efivarfs_alloc_dentry creates dentries with slashes in
> > > > their name if the respective EFI variable has slashes in its name. This in
> > > > turn causes EIO on getdents64, which prevents a complete directory listing
> > > > of /sys/firmware/efi/efivars/.
> > > >
> > > > This patch replaces the invalid shlashes with exclamation marks like
> > > > kobject_set_name_vargs does for /sys/firmware/efi/vars/ to have consistently
> > > > named dentries under /sys/firmware/efi/vars/ and /sys/firmware/efi/efivars/.
> > > >
> > > > Signed-off-by: Michael Schaller <misch@google.com>
> > >
> > > Thanks
> > >
> > > > Tested-by: Michael Schaller <misch@google.com>
> > >
> > > I will drop this - in general, it is assumed that you test your own
> > > patches before sending them to the list, so this is implicit. Also,
> > > tested-by's given on the list tend to carry more weight than ones that
> > > are givenin private and added to the patch by the authors themselves.
> > >
> > Makes sense. Is anything else needed from my side?
>
> No, all good. I'll pick this up as a fix.

Awesome. Would it make sense to consider this for stable kernels as well?
We've found this in the wild on Lenovo ThinkStation P520 machines as
they write EFI variables like this one:
05/15/2019-13:37:56-SysEvtLog:36-193545dc-3550-4d14-bdba-b7d426c6b019

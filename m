Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6221A1DBC32
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgETSBO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 14:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgETSBO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 May 2020 14:01:14 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D41D5206F1
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589997673;
        bh=CJTutn/NXqaMFGHqxoLwyqJbYo8ZQsjlPnGITmM9RSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PBFb1BwMyTwdZTSxfQcjLk3Oe9bLBKc1bC1fWGV8zvpZ+eWKqk93Cos0EnwdgVZnS
         3uiY/MHNyj0K7TFLCP9XeNPiu7sOP/G4yaAwIdr5a2ysQ7KELaITow8EVl6FSVDcuA
         zs1iTDq/rbasTjiWj17ZziwaqsGPxe6HkRdim8ck=
Received: by mail-il1-f178.google.com with SMTP id l20so4078721ilj.10
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 11:01:13 -0700 (PDT)
X-Gm-Message-State: AOAM531dXeR5Q0vIrq/7z1BLymWXtb18IjZjh7KhObWlea3jXXUzraLP
        xwoVnRLCK58DohZLMcatnFO29JtHDeZjgHXLngw=
X-Google-Smtp-Source: ABdhPJxdLGnSFCMjLmGXwqxdbVG7Wu1WPhBqu4hXIx/WQhPZVs65arN7PlB6IooFEnC8PrdtQYgko7z1kbNVGmDK2NQ=
X-Received: by 2002:a92:c948:: with SMTP id i8mr5092679ilq.258.1589997670384;
 Wed, 20 May 2020 11:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200520140903.GA30374@kadam> <20200520154308.GA3184088@rani.riverdale.lan>
 <20200520175449.GR3041@kadam> <20200520180008.GA3428271@rani.riverdale.lan>
In-Reply-To: <20200520180008.GA3428271@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 20 May 2020 20:00:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF8wyOsGgYRu9WwdNAYns3phCM-Fip5qG_BM9XKnRFvQw@mail.gmail.com>
Message-ID: <CAMj1kXF8wyOsGgYRu9WwdNAYns3phCM-Fip5qG_BM9XKnRFvQw@mail.gmail.com>
Subject: Re: [efi:next 39/40] drivers/firmware/efi/libstub/efi-stub-helper.c:265
 efi_convert_cmdline() warn: qualifier 'l' ignored for %s specifier
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 20 May 2020 at 20:00, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, May 20, 2020 at 08:54:49PM +0300, Dan Carpenter wrote:
> > On Wed, May 20, 2020 at 11:43:08AM -0400, Arvind Sankar wrote:
> > > On Wed, May 20, 2020 at 05:09:03PM +0300, Dan Carpenter wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> > > > head:   e5fbadd1179cdadeaa44d71a9ec068c5bc100524
> > > > commit: 85f5afd4322d294a7eca0d304744a1646113fbd9 [39/40] efi/libstub: Use snprintf with %ls to convert the command line
> > > > config: x86_64-defconfig (attached as .config)
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > >
> > > > New smatch warnings:
> > > > drivers/firmware/efi/libstub/efi-stub-helper.c:265 efi_convert_cmdline() warn: qualifier 'l' ignored for %s specifier
> > > >
> > > > # https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=85f5afd4322d294a7eca0d304744a1646113fbd9
> > > > git remote add efi https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
> > > > git remote update efi
> > > > git checkout 85f5afd4322d294a7eca0d304744a1646113fbd9
> > > > vim +/l +265 drivers/firmware/efi/libstub/efi-stub-helper.c
> > > >
> > > > c625d1c203941f drivers/firmware/efi/efi-stub-helper.c         H. Peter Anvin 2013-09-20  258      options_bytes++;        /* NUL termination */
> > > > 9403e462fb5ffa drivers/firmware/efi/efi-stub-helper.c         Leif Lindholm  2014-04-04  259
> > > > 1e45bf7372c48c drivers/firmware/efi/libstub/efi-stub-helper.c Ard Biesheuvel 2020-02-10  260      status = efi_allocate_pages(options_bytes, &cmdline_addr, max_addr);
> > > > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  261      if (status != EFI_SUCCESS)
> > > > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  262              return NULL;
> > > > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  263
> > > > 85f5afd4322d29 drivers/firmware/efi/libstub/efi-stub-helper.c Arvind Sankar  2020-05-18  264      snprintf((char *)cmdline_addr, options_bytes, "%.*ls",
> > > >                                                                                                                                                   ^
> > > > The "l" doesn't make sense here?
> > >
> > > The previous patches add support for wide strings to the version of
> > > snprintf used here.
> >
> > Ah.  Thanks.  I will update the Smatch check.
> >
> > regards,
> > dan carpenter
> >
> Note that the main kernel's printf still doesn't support it. It's only
> been added to the version in drivers/firmware/efi/libstub/vsprintf.c
> (added as part of this series).

... which is justified, given how heavily EFI depends on UTF-16 support.

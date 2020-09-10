Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFC264367
	for <lists+linux-efi@lfdr.de>; Thu, 10 Sep 2020 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIJKLw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Sep 2020 06:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgIJKLp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 10 Sep 2020 06:11:45 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5997E214F1
        for <linux-efi@vger.kernel.org>; Thu, 10 Sep 2020 10:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599732705;
        bh=xRo2ncH8IrtfXMJt+7+ag5JBiTgrTe6vFVGBN33zcD4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xmnCrnruHTrLFDASCRAeX66Rx6L2Q5IjPo/H/y/XuvwXVS/5MRAYdWTZMGQ2b/Sk/
         jGvReeOUmgP2p8IEU+zQpO+/lVdc4+qogAV0e+sI3QNMzS+ieTmwGXj7/MW+OXZoQk
         SS6oWML0YJI6aRqnCL2PaEpqLf7Ol8uyHDbdju4E=
Received: by mail-ot1-f42.google.com with SMTP id y5so4878400otg.5
        for <linux-efi@vger.kernel.org>; Thu, 10 Sep 2020 03:11:45 -0700 (PDT)
X-Gm-Message-State: AOAM530AJjmn1ZDzjA61v6jHVrD429R/BxuEgOVKqx4BnN4xfwjGWUyJ
        i0lkfr3VNABLLctG+wNK/ec4A2JK+OaIBDhHk5Q=
X-Google-Smtp-Source: ABdhPJwq1VzM+VimsvhUfDBYIRIQAEfLltXjh4lLMIXyn0mfSoj88YEMP/pnBGAZsj60fzBWARm16E/U8bVSMCHPJxY=
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr3245295oto.90.1599732704551;
 Thu, 10 Sep 2020 03:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
 <20200907170021.GA2284449@rani.riverdale.lan> <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
 <20200908223255.GA276578@rani.riverdale.lan> <CAO18KQgPJu2uZzBuCTsKOJydnbgsNM+EMvcJRDBE3UhSKHtpfw@mail.gmail.com>
 <20200909190038.GA474185@rani.riverdale.lan> <CAO18KQjGdcZD8bts36GuicJO8_iprbryXdh5vM+-GfAbcKV==Q@mail.gmail.com>
 <20200909203830.GA490605@rani.riverdale.lan>
In-Reply-To: <20200909203830.GA490605@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Sep 2020 13:11:33 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEAkR9_tN_o0m30e+HY_F_xf3wY_uSDUiWYOkaugcvoNw@mail.gmail.com>
Message-ID: <CAMj1kXEAkR9_tN_o0m30e+HY_F_xf3wY_uSDUiWYOkaugcvoNw@mail.gmail.com>
Subject: Re: EFISTUB arguments in Dell BIOS
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Jones <pjones@redhat.com>, mario.limonciello@dell.com
Cc:     Jacobo Pantoja <jacobopantoja@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(adding Peter and Mario)

On Wed, 9 Sep 2020 at 23:38, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Sep 09, 2020 at 09:37:02PM +0200, Jacobo Pantoja wrote:
> > > >
> > > > Result saved as image:
> > > > https://ibb.co/vcz48vC
> > > >
> > >
> > > Thanks.
> > >
> > > It looks like the firmware is passing the entire contents of the
> > > Boot0000 variable, rather than just the load options part: I think that
> > > dump will be identical to the output of
> > >
> > >         od -t x2z /sys/firmware/efi/efivars/Boot0000*
> > >
> >
> > It is almost identical. The efivar you mentioned starts with 0x0007 0x0000,
> > and after that, the dump is identical to the one displayed in the debug text
> >
>
> Right, sorry: the first 4 bytes in the sysfs file are the attributes of
> the variable (in this case indicating it is non-volatile, and accessible
> both before and after ExitBootServices). The rest is the actual data.
>
> > >
> > > Ard, do you think we could quirk the conversion to check if the passed
> > > in size was bigger than the parsed command line, and if so check to see
> > > if the bytes 0x7f 0xff 0x0004 (End Device Path) occur somewhere, and
> > > treat the stuff after that as the actual command line?
> >
> > To be honest, if this is an incompliance with UEFI, Dell should fix this.
> > Independently of whether we setup a quirk or not, I'll contact them, in the
> > past I've already got some BIOS bugs fixed (although the process is slow).
> > Obviously I can continue doing whatever testing you may wish.
> >
> > Thank you very much
>
> Ok, this is laid out in section 3.1 of the spec which defines the format
> of the EFI_LOAD_OPTION descriptor. Dell's BIOS is passing the entire
> descriptor instead of just the OptionalData part.
>
> OptionalData    The remaining bytes in the load option descriptor are a
>                 binary data buffer that is passed to the loaded image.
>                 If the field is zero bytes long, a Null pointer is
>                 passed to the loaded image. The number of bytes in
>                 OptionalData can be computed by subtracting the starting
>                 offset of OptionalData from total size in bytes of the
>                 EFI_LOAD_OPTION.
>
> https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf
>

This vaguely rings a bell so I have cc'ed some folks who may have run
into this in the past. Complete thread can be found at [0]

The firmware is obviously passing the wrong data, and I am reluctant
to quirk this out, since we'd have to interpret the contents of these
UEFI variables, and given the amount of 'value add' by the BIOS
vendors in this area, we may end up breaking things on other
platforms.

[0] https://lore.kernel.org/linux-efi/20200909203830.GA490605@rani.riverdale.lan/

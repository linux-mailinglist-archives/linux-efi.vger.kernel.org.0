Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6969A269100
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 18:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgINQCH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 12:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgINQA7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 12:00:59 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3D3C06174A
        for <linux-efi@vger.kernel.org>; Mon, 14 Sep 2020 09:00:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c2so92340ljj.12
        for <linux-efi@vger.kernel.org>; Mon, 14 Sep 2020 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFYlzCcxwX6kpKaWG+Hl3JXAG6cy2nJxEdw5uynXfy8=;
        b=gZ4QCMXgZq4QN89f1Z+enjaHWifW482U6bpFCTlwOfxx1FkC64XCCZYqX0oOVaEF2o
         matiE6tx//VzKV9mPvab129bF8dhNiPeAO94LMQ/1jkAldIr08X3q91DbNpgLmNjRPMP
         RrcrcHLujzhEzpYI+Psm55e2wfwRKrmEyA+Mnx03CC6jHKc86N0jeIvsFi4VZxScWc0P
         /7oEiwa+g633BVBU/WAtMtdfax6P6VljDs40XE/7zaUt5LN5fnh9Oo5kSw1brs2++CDV
         BCr2/FwWw9q/ZSNshC8LXGD+u+LbYIS7xGEtz2VxG5D7pwSHF2/+g7VWoupHjcah88kv
         RMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFYlzCcxwX6kpKaWG+Hl3JXAG6cy2nJxEdw5uynXfy8=;
        b=aQ6IP9IgE4eC7o1vIHfr4CmjRX24XHLlDQVh7dU6njAO2yI7HTMj9+aUyDJcrlyrqZ
         bqNmLIrKKrcbrZGjdvmlfQQCRUTy0DtHFSNHQJuWZMVrqT+L5Rx9nir++yVID0njCDEE
         nZw730AHerUkefnteqbu8E8N5knhszTTVZfmqJ8h2dJ+8YRQUXq66AFBbQSug0iCI7SX
         78HSLInSb4hqmDEZ/DZOE0JlbyfREV8/6I9tnh106mh8tSoN2ZfLH5lfNGRw8ErDRNdm
         7nV75NcHgv7UiLgN/qAWYVrON55gXCsDKIdqz28neTDA3+gSd0AzCR2AZY2CXCD8gc1Q
         6C1g==
X-Gm-Message-State: AOAM532ikMy3fia+uyPq7kFroF46ftybY0iXA2ZGgE9VOS0466ORBZ/B
        jvcHIi+Iaa148tMvBfs6xXcJdbFg3Gw8RR7BYT8=
X-Google-Smtp-Source: ABdhPJzZmQOsZbtpqjdKp764qUMQLFs1sf5r0n7yB4+UdNcqIYSFiWzSPBK1OxYCN8eyH7MBL7NTQwwWdDPLQgLhsfQ=
X-Received: by 2002:a2e:9948:: with SMTP id r8mr5132452ljj.126.1600099257195;
 Mon, 14 Sep 2020 09:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR19MB2636D9FB53FD32BC8F3FFFE4FA240@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20200912175105.2085299-1-nivedita@alum.mit.edu>
In-Reply-To: <20200912175105.2085299-1-nivedita@alum.mit.edu>
From:   Jacobo Pantoja <jacobopantoja@gmail.com>
Date:   Mon, 14 Sep 2020 17:59:51 +0200
Message-ID: <CAO18KQhgpcLusPRpFHwJb3taw=UxroAgvfPLoa8NrzWLUkawzg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Quirk to handle Dell BIOS
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 12 Sep 2020 at 19:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> I coded up the quirk to see what it looks like.
>
> First patch is the quirk itself, and the second one is a slightly
> rejiggered version of the dumping code for testing.
>
> Jacobo, can you check if this fixes the efi stub boot?

I tested the patch and works perfectly. I also tested in a non-Dell
machine, and it
also works properly.

I simplified a bit the cmdline so that it fits on the screen during testing.

This is the output of the Dell machine with the helper patch also applied:
https://ibb.co/HdDh6HK

And this is the output of the non-Dell machine:
https://ibb.co/whh1g9D

It seems that both are properly parsed.

I've also tested (just in case) the patch alone, without the helper
debug text, and it
works properly in both machines as well, as expected.

>
> Thanks.
>
> Arvind Sankar (2):
>   efi/x86: Add a quirk to support command line arguments on Dell EFI firmware
>   efi/libstub: Dump command line before/after conversion
>
>  .../firmware/efi/libstub/efi-stub-helper.c    | 139 +++++++++++++++++-
>  drivers/firmware/efi/libstub/efistub.h        |  31 ++++
>  drivers/firmware/efi/libstub/file.c           |   5 +-
>  3 files changed, 173 insertions(+), 2 deletions(-)
>
> --
> 2.26.2
>

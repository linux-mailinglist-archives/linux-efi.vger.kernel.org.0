Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9F35946E2
	for <lists+linux-efi@lfdr.de>; Tue, 16 Aug 2022 01:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352494AbiHOXDI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Aug 2022 19:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353017AbiHOXBx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Aug 2022 19:01:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66713F212
        for <linux-efi@vger.kernel.org>; Mon, 15 Aug 2022 12:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1AB4B81142
        for <linux-efi@vger.kernel.org>; Mon, 15 Aug 2022 19:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0FFC433D6
        for <linux-efi@vger.kernel.org>; Mon, 15 Aug 2022 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660593483;
        bh=TWT/8p0hPpSxjJ1M5FYNWVBw9BQuBPdWxbW6Hbxfvws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pJ9G0nwyoJVWJP1Mwpm4Lbt3JdCUxdnjHiHNDdfQAgoyqpIt0YMUt7d29yQpP3C+c
         to5MIjqxnU7KHwu6qxSk4H2JxyYX7zE0to+5mJKq4c0GjXQRqe5/0Wn4IVvHQVHvXu
         PUP+lMi1t4EL3UuPigxph49krqLjNeLDicQuV15RfvOjVC6WVAruxKZXUE9CyxK2Qw
         VLUB2pQvVnY/X7YMEWVvdI1tqPe/CBqvye+dYVpesJJ8ELFsFRDjzT2ONsM9MLdCxI
         Hq8K84zBKG5swAYakAtx9Sx7ks+p0vxFx2ViJPvcDFJoaxGQlxKPA68CrfuIVXjhrr
         EGJZuPCcz9vhw==
Received: by mail-wr1-f49.google.com with SMTP id v3so10261956wrp.0
        for <linux-efi@vger.kernel.org>; Mon, 15 Aug 2022 12:58:03 -0700 (PDT)
X-Gm-Message-State: ACgBeo2dnCuCmsz1rpdUsBQ+nQNOPK9GSF4x2jPoOFA/kTw7wVHY6rSO
        OjaNGPIvMlDh6Y9YUMUg2Fk8uQ6krOdn7NZVc5E=
X-Google-Smtp-Source: AA6agR7jTbZb2DuBJmY5f/Nr87OmajkhyqrHhBbtqST7yR8RcU4MVe+dvYHe8uBVpzDizPgyrDIce0lBl4V5fiiUJsA=
X-Received: by 2002:adf:d238:0:b0:21e:c972:7505 with SMTP id
 k24-20020adfd238000000b0021ec9727505mr9874462wrh.536.1660593481749; Mon, 15
 Aug 2022 12:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220815132028.732531-1-ardb@kernel.org> <YvqiiKBPockZbRqG@zn.tnic>
In-Reply-To: <YvqiiKBPockZbRqG@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Aug 2022 21:57:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE47YJhApf0Xkj9JdDL1cTGrCcWCuCSqJVVQ3MTi4u1dw@mail.gmail.com>
Message-ID: <CAMj1kXE47YJhApf0Xkj9JdDL1cTGrCcWCuCSqJVVQ3MTi4u1dw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-mixed: move unmitigated RET into .rodata
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 15 Aug 2022 at 21:46, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Aug 15, 2022 at 03:20:28PM +0200, Ard Biesheuvel wrote:
> > Move the EFI mixed mode return trampoline RET into .rodata, so it is
> > normally mapped without executable permissions.  And given that this
> > snippet of code is really the only kernel code that we ever execute via
> > this 1:1 mapping, let's unmap the 1:1 mapping of the kernel .text, and
> > only map the page that covers the return trampoline with executable
> > permissions.
> >
> > Note that the remainder of .rodata needs to remain mapped into the 1:1
> > mapping with RO/NX permissions, as literal GUIDs and strings may be
> > passed to the variable routines.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/platform/efi/efi_64.c       | 18 +++++++++++++-----
> >  arch/x86/platform/efi/efi_thunk_64.S |  8 +++++---
> >  2 files changed, 18 insertions(+), 8 deletions(-)
>
> Acked-by: Borislav Petkov <bp@suse.de>
>
> For some reason, objtool is not happy here:
>
> vmlinux.o: warning: objtool: efi_thunk_query_variable_info_nonblocking+0x1ba: unreachable instruction
>

I'm not seeing that warning. Any config in particular beyond
x86_64_defconfig that you have enabled?
I'm using Debian GCC 12.1.0 btw

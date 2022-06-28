Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAFA55DD30
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbiF1ID3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 04:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiF1ICW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 04:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325492CDF1;
        Tue, 28 Jun 2022 01:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B795860F9F;
        Tue, 28 Jun 2022 08:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22314C3411D;
        Tue, 28 Jun 2022 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656403340;
        bh=Q3Z41EngjihZfmuvH+X4T5I3tqKT1PAu+zjv+fwT1as=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mWuqlkfsWyCVA8weT11i/cel2b3PYXugNZfWo6r7lXIwrQrrezOKRDnsR8gqjWvmE
         5BmKr0+daQ9BBYS2S1+8ZRRltGXwAdptoHT/35/Cnw0HjmHiAJm5YG8TGJGYklPgUw
         cc36jRgeMWu8d0wyfGIqtuTbUIlaeeZnQva16ZUcWI8Dhcf1IJLlZW+QxE7y1Uvy1M
         4Dc5RmgciY51K3pz4qGUC7WVAwadavThTbOt/2cpK/nXYC8OZ57FMvweUBeV5vzrUY
         i0/feP65/7TpcDpspTpcbekWkIJQhswSih+S5vrbmAJnMj3AIRLWZYL/D4xJCxrHC5
         iM1cnV5jaUy4g==
Received: by mail-lf1-f42.google.com with SMTP id w20so20828649lfa.11;
        Tue, 28 Jun 2022 01:02:20 -0700 (PDT)
X-Gm-Message-State: AJIora9VAxpds1LV9E4e8Z4XfwD5BfHWBlMZz3PZPuhs0Axin/dhdY+L
        qrAmhs/G2gD5WiAeWsGYSIRNk6IPwgo60VvMJIM=
X-Google-Smtp-Source: AGRyM1voKD/YaRBJ3pMCgAx4T9BgUE+1wPFvTSQp8slKfZ2o6uTdgnngN48SIrLdmfT19xdyGMAPq6sJbgjNSMV39vM=
X-Received: by 2002:a05:6512:3fa6:b0:47d:c87e:f8f8 with SMTP id
 x38-20020a0565123fa600b0047dc87ef8f8mr11445747lfa.159.1656403338114; Tue, 28
 Jun 2022 01:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220331221030.889718-1-jakobkoschel@gmail.com>
 <CAMj1kXE2r4xrtFc+=OJfzutZzTtaUoFtW=f7y9+us9h+xGVEnA@mail.gmail.com>
 <9142505E-720F-401E-AD48-BA9D0880EDD1@gmail.com> <CAMj1kXFqG0n1KVPsTYo2a-qS3zb40itNmxy9gGy2A===qdPYxg@mail.gmail.com>
In-Reply-To: <CAMj1kXFqG0n1KVPsTYo2a-qS3zb40itNmxy9gGy2A===qdPYxg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 10:02:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEu1dqjNhpareKHPEj3UWqu_9jbyDOYf9aR1T21rzRk_g@mail.gmail.com>
Message-ID: <CAMj1kXEu1dqjNhpareKHPEj3UWqu_9jbyDOYf9aR1T21rzRk_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: remove use of list iterator variable after loop
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 14 Apr 2022 at 00:09, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Kees for pstore)
>
> On Wed, 13 Apr 2022 at 20:08, Jakob Koschel <jakobkoschel@gmail.com> wrote:
> >
> >
> >
> > > On 13. Apr 2022, at 19:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Fri, 1 Apr 2022 at 00:11, Jakob Koschel <jakobkoschel@gmail.com> wrote:
> > >>
> > >> In preparation to limiting the scope of a list iterator to the list
> > >> traversal loop, use a dedicated pointer to iterate through the list [1].
> > >>
> > >> In the current state the list_for_each_entry() is guaranteed to
> > >> hit a break or goto in order to work properly. If the list iterator
> > >> executes completely or the list is empty the iterator variable contains
> > >> a type confused bogus value infered from the head of the list.
> > >>
> > >> With this patch the variable used past the list iterator is only set
> > >> if the list exists early and is NULL otherwise. It should therefore
> > >> be safe to just set *prev = NULL (as it was before).
> > >>
> > >
> > > This generic boilerplate is fine to include, but it would help if you
> > > could point out why repainting the current logic with your new brush
> > > is appropriate here.
> >
> > This makes sense, I can see that the commit message should be improved here.
> >
> > >
> > > In this particular case, I wonder whether updating *prev makes sense
> > > to begin with if we are returning an error, and if we fix that, the
> > > issue disappears as well.
> >
> > Actually I'm rethinking this now. The only use of 'prev' that I can see is
> > in efi_pstore_erase_name(). It only uses it if found != 0
> > which would mean err != 0 in __efivar_entry_iter().
> >
> > This would allow massively simplifying the entire function.
> > The valid case is updating *prev when there is an "error" as far as I can tell.
> >
>
> OK, so in summary, the only user of that code that bothers to pass a
> value for prev abuses it to implement its own version of
> efivar_entry_find(), and so if we fix that caller, we can drop the
> 'prev' argument from this function altogether.
>
>
> > I've sketched up a rewritten function that should hopefully be more clear and
> > archive the same goal, I'm curious what you think:
> >
> >
> >         int __efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
> >                                 struct list_head *head, void *data,
> >                                 struct efivar_entry **prev)
> >         {
> >                 struct efivar_entry *entry, *n;
> >                 int err = 0;
> >
> >                 /* If prev is set and *prev != NULL start iterating from there */
> >                 if (prev)
> >                         entry = list_prepare_entry(*prev, head, list);
> >                 /* Otherwise start at the beginning */
> >                 else
> >                         entry = list_entry(head, typeof(*entry), list);
> >                 list_for_each_entry_safe_continue(entry, n, head, list) {
> >                         err = func(entry, data);
> >                         if (err && prev)
> >                                 *prev = entry;
> >                         if (err)
> >                                 return err;
> >                 }
> >
> >                 return 0;
> >         }
> >
>
> Thanks for this. I'll have a stab myself at fixing the EFI pstore
> code, and hopefully we can clean up __efivar_entry_iter() as I
> suggested.

This is now queued up in the EFI tree: the pstore driver no longer use
the efivar_entry API at all, and the remaining user of
efivar_entry_iter() does not use the value of the iterator variable in
the same way.

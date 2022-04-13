Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4520D500191
	for <lists+linux-efi@lfdr.de>; Thu, 14 Apr 2022 00:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiDMWLr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 18:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiDMWLp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 18:11:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525C515720;
        Wed, 13 Apr 2022 15:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 014AEB8275E;
        Wed, 13 Apr 2022 22:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B71CC385A6;
        Wed, 13 Apr 2022 22:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649887759;
        bh=jgSOQzCVRoBHmb6HoMBMfjB7ijOTlpofh5TsaaZ1DII=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UZwQtlWFGuRvynrYy3Hnku+N8GlU0fnU3TmEVni5mosTZaikBoZ+xEfcEQ0kAy8Kh
         lg9Bk5WIb4xghtorw+uyqjSKj64vtI09WL1DWHxhYiFDpMaRRonrGA3J+zZSfqutbF
         W+/N6uY0itZI3oN1lO2FEwf76DpjkpEOJXfEjbGJPI5v4AsumQXooPBpTakEKtT2X1
         KQvjpAcm/YC3BvoBq6tPvf0zY5wEXjRkWih8dWcpH6K1iIG92sFnVgwgjS/ND7DA15
         8ugfsoqFsn6+ekTDh5CWIdpnKs62N0JNUOzrCGdQXokT8LrLYvD8SBEzYlyqpFnj7Q
         LCPhQTD+5su/w==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so3445485fac.11;
        Wed, 13 Apr 2022 15:09:19 -0700 (PDT)
X-Gm-Message-State: AOAM532W2Osi9GHd6070TZzcvtoKYf14UnZLHTs3sugE3nZOL8S+f5WF
        H6EBR32kuI6MI4CTFqaOyGoKMvSt2Ey+qIaIo3Q=
X-Google-Smtp-Source: ABdhPJyFhIESFBWF4NWTke0JSO8yrNB48D6kvuTaKZGZjUJVfNqzOhAod1iXtN4jeUCBimDim5jGDX57mxsce/wQecQ=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr397925oap.228.1649887758751; Wed, 13
 Apr 2022 15:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220331221030.889718-1-jakobkoschel@gmail.com>
 <CAMj1kXE2r4xrtFc+=OJfzutZzTtaUoFtW=f7y9+us9h+xGVEnA@mail.gmail.com> <9142505E-720F-401E-AD48-BA9D0880EDD1@gmail.com>
In-Reply-To: <9142505E-720F-401E-AD48-BA9D0880EDD1@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 Apr 2022 00:09:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFqG0n1KVPsTYo2a-qS3zb40itNmxy9gGy2A===qdPYxg@mail.gmail.com>
Message-ID: <CAMj1kXFqG0n1KVPsTYo2a-qS3zb40itNmxy9gGy2A===qdPYxg@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Kees for pstore)

On Wed, 13 Apr 2022 at 20:08, Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
>
>
> > On 13. Apr 2022, at 19:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 1 Apr 2022 at 00:11, Jakob Koschel <jakobkoschel@gmail.com> wrote:
> >>
> >> In preparation to limiting the scope of a list iterator to the list
> >> traversal loop, use a dedicated pointer to iterate through the list [1].
> >>
> >> In the current state the list_for_each_entry() is guaranteed to
> >> hit a break or goto in order to work properly. If the list iterator
> >> executes completely or the list is empty the iterator variable contains
> >> a type confused bogus value infered from the head of the list.
> >>
> >> With this patch the variable used past the list iterator is only set
> >> if the list exists early and is NULL otherwise. It should therefore
> >> be safe to just set *prev = NULL (as it was before).
> >>
> >
> > This generic boilerplate is fine to include, but it would help if you
> > could point out why repainting the current logic with your new brush
> > is appropriate here.
>
> This makes sense, I can see that the commit message should be improved here.
>
> >
> > In this particular case, I wonder whether updating *prev makes sense
> > to begin with if we are returning an error, and if we fix that, the
> > issue disappears as well.
>
> Actually I'm rethinking this now. The only use of 'prev' that I can see is
> in efi_pstore_erase_name(). It only uses it if found != 0
> which would mean err != 0 in __efivar_entry_iter().
>
> This would allow massively simplifying the entire function.
> The valid case is updating *prev when there is an "error" as far as I can tell.
>

OK, so in summary, the only user of that code that bothers to pass a
value for prev abuses it to implement its own version of
efivar_entry_find(), and so if we fix that caller, we can drop the
'prev' argument from this function altogether.


> I've sketched up a rewritten function that should hopefully be more clear and
> archive the same goal, I'm curious what you think:
>
>
>         int __efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
>                                 struct list_head *head, void *data,
>                                 struct efivar_entry **prev)
>         {
>                 struct efivar_entry *entry, *n;
>                 int err = 0;
>
>                 /* If prev is set and *prev != NULL start iterating from there */
>                 if (prev)
>                         entry = list_prepare_entry(*prev, head, list);
>                 /* Otherwise start at the beginning */
>                 else
>                         entry = list_entry(head, typeof(*entry), list);
>                 list_for_each_entry_safe_continue(entry, n, head, list) {
>                         err = func(entry, data);
>                         if (err && prev)
>                                 *prev = entry;
>                         if (err)
>                                 return err;
>                 }
>
>                 return 0;
>         }
>

Thanks for this. I'll have a stab myself at fixing the EFI pstore
code, and hopefully we can clean up __efivar_entry_iter() as I
suggested.

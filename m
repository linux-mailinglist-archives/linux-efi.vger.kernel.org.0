Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ED45321D6
	for <lists+linux-efi@lfdr.de>; Tue, 24 May 2022 06:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiEXECy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 May 2022 00:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiEXECw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 May 2022 00:02:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE816899F;
        Mon, 23 May 2022 21:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD1FBB8175C;
        Tue, 24 May 2022 04:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B80C34113;
        Tue, 24 May 2022 04:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653364968;
        bh=HHJHx+9GiyyAVvOoHi2zz5AS2gjPw1RWjQFgpFvR9Xo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RrX/tFwhxGtawWgN3s5t0VHNt5O3HEA4q1CksQOaQ18+fO9rEOpsV1JFCID2bdOGB
         JG8Uz/dWgxA0tTbHIIdYPpTrIX7wYkAP3gEG39b3HYi2Lkxii1YRB9iQ/zntgB6pFy
         Tkj5fWdVd5kBnIPDgUG0mtsbwZZhlqk36+7HheyrHF305oYKVphXgpBGlsN9260CZl
         qPfZ6tN1mXMw3OH9wjRxqLUyz6LzGKh2Vc7sfh6BoVJqhDmRr+SEjBNRQBBA95lb5Y
         H785QPQZJMzv0KYhnxP2td21Dfc0QmC/hN5FHIgueNkxd+GkHBHAcczjuS7GLK9mMQ
         EPqB2ugeZsKYg==
Received: by mail-vs1-f48.google.com with SMTP id h4so5965040vsr.13;
        Mon, 23 May 2022 21:02:48 -0700 (PDT)
X-Gm-Message-State: AOAM530StxsUKLx9+vGx+YZ/kpcnEgx9ychXWHb0YNF66sduyXTeyOIB
        zAPZcc9/5ZtGjMTXZx02wJ4x556l1InX3svmBoI=
X-Google-Smtp-Source: ABdhPJzqPzYkFs1ETT2q6Twf4Yvd7ioIJxOHzE80tcmoCpV+dq4I4VUEyiQhWuNKoSSBm7/680q3vRJqOy+1Vk8ULLo=
X-Received: by 2002:a67:e1c4:0:b0:335:cdc4:395f with SMTP id
 p4-20020a67e1c4000000b00335cdc4395fmr9650618vsl.71.1653364967280; Mon, 23 May
 2022 21:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <1653360446-15598-1-git-send-email-baihaowen@meizu.com> <CAAhV-H6VX5Bbmv4r8O=LbnZVWvVRr1GNUDs=6uHx337AdD52Fw@mail.gmail.com>
In-Reply-To: <CAAhV-H6VX5Bbmv4r8O=LbnZVWvVRr1GNUDs=6uHx337AdD52Fw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 24 May 2022 12:02:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4o62v7h5o7jTsORZPyqNaxyNYF-EOZgzmJQwDjsyWn1w@mail.gmail.com>
Message-ID: <CAAhV-H4o62v7h5o7jTsORZPyqNaxyNYF-EOZgzmJQwDjsyWn1w@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix unsigned function returning negative constant
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 24, 2022 at 11:04 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Haowen,
>
> On Tue, May 24, 2022 at 10:47 AM Haowen Bai <baihaowen@meizu.com> wrote:
> >
> > The function set_virtual_map has an unsigned return type, but returns a
> > negative constant to indicate an error condition. So we change unsigned
> > to int.
> Your patch is correct, but original hasn't been upstream, I don't
> know how to handle it.
I've squash your patch to the original one and add a Co-developed-by:,
not sure it is the best solution. Thanks.

>
> Huacai
> >
> > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> > ---
> >  arch/loongarch/kernel/efi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> > index 69ebdd4220ec..f9fdeb1ae358 100644
> > --- a/arch/loongarch/kernel/efi.c
> > +++ b/arch/loongarch/kernel/efi.c
> > @@ -102,7 +102,7 @@ static void __init fix_efi_mapping(void)
> >   * in @memory_map whose EFI_MEMORY_RUNTIME attribute is set. Those descriptors
> >   * are also copied to @runtime_map, and their total count is returned in @count.
> >   */
> > -static unsigned int __init set_virtual_map(void)
> > +static int __init set_virtual_map(void)
> >  {
> >         int count = 0;
> >         unsigned int size;
> > --
> > 2.7.4
> >

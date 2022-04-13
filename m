Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08124FFC0F
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 19:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiDMRHj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 13:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbiDMRHi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 13:07:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A34D608;
        Wed, 13 Apr 2022 10:05:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C8A0B82647;
        Wed, 13 Apr 2022 17:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47141C385A4;
        Wed, 13 Apr 2022 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649869514;
        bh=WWIxMpH9GtvS1cWNsIeOZIYDmiEJjhi2r4f8nEZPIB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sJWW1cEullj1839qNY3O+KpNbTFhTNEVWK3vIl991pB6yfrBmc2nOC/UeSmekHXZp
         PpZ4vSxvp+okXfJLCPbsB3mgnGPXzXorLYSHU5LNiy3ZfHglO46ggiMg+qv/677+Pp
         0sb3jx3cBiNbxZOu2PHMES8of47TT9nnv+Icu0PVG+8MRdCFppFMRREF80yZ2S37OR
         5RXgafClhJON3vZRNQlTgBcLtrolPUbRbR1SWSufFjx3D4injRAMhI6Qek3XUz0JBC
         kWZs7ovPcARmm1o5RV+7GqV/EfADAgN/882JUVdR6GdOwkENycrJqvmWGTYiI9iZmR
         rnfchPfTTDwIg==
Received: by mail-oi1-f170.google.com with SMTP id s1so2714653oie.6;
        Wed, 13 Apr 2022 10:05:14 -0700 (PDT)
X-Gm-Message-State: AOAM5338eZ1AoROP48xlRhyfkjHbv+X8vN8gk3V0x0Y3VU7zmS6ScINR
        n4BY3uGPiHdXrDjTfEKoFjjgdLTPKEFnxvw1bqE=
X-Google-Smtp-Source: ABdhPJyRJkMVdOQ/gxiaPWQe+iM951dfmw3PWzMCuQTSaUHKFO3znZg7K3fb3bkkXp6ryuMiimz3XkmPyCuzt5jksmA=
X-Received: by 2002:a05:6808:1596:b0:2f7:5d89:eec7 with SMTP id
 t22-20020a056808159600b002f75d89eec7mr4775213oiw.228.1649869513405; Wed, 13
 Apr 2022 10:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220331221030.889718-1-jakobkoschel@gmail.com>
In-Reply-To: <20220331221030.889718-1-jakobkoschel@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Apr 2022 19:05:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE2r4xrtFc+=OJfzutZzTtaUoFtW=f7y9+us9h+xGVEnA@mail.gmail.com>
Message-ID: <CAMj1kXE2r4xrtFc+=OJfzutZzTtaUoFtW=f7y9+us9h+xGVEnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: remove use of list iterator variable after loop
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
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

On Fri, 1 Apr 2022 at 00:11, Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
> In preparation to limiting the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to iterate through the list [1].
>
> In the current state the list_for_each_entry() is guaranteed to
> hit a break or goto in order to work properly. If the list iterator
> executes completely or the list is empty the iterator variable contains
> a type confused bogus value infered from the head of the list.
>
> With this patch the variable used past the list iterator is only set
> if the list exists early and is NULL otherwise. It should therefore
> be safe to just set *prev = NULL (as it was before).
>

This generic boilerplate is fine to include, but it would help if you
could point out why repainting the current logic with your new brush
is appropriate here.

In this particular case, I wonder whether updating *prev makes sense
to begin with if we are returning an error, and if we fix that, the
issue disappears as well.


> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/firmware/efi/vars.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index cae590bd08f2..3994aad38661 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -1081,14 +1081,16 @@ int __efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
>                         struct list_head *head, void *data,
>                         struct efivar_entry **prev)
>  {
> -       struct efivar_entry *entry, *n;
> +       struct efivar_entry *entry = NULL, *iter, *n;
>         int err = 0;
>
>         if (!prev || !*prev) {
> -               list_for_each_entry_safe(entry, n, head, list) {
> -                       err = func(entry, data);
> -                       if (err)
> +               list_for_each_entry_safe(iter, n, head, list) {
> +                       err = func(iter, data);
> +                       if (err) {
> +                               entry = iter;
>                                 break;
> +                       }
>                 }
>
>                 if (prev)
>
> base-commit: d888c83fcec75194a8a48ccd283953bdba7b2550
> --
> 2.25.1
>

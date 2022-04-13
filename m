Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D7D4FFC14
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiDMRLy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 13:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbiDMRLx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 13:11:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3F2DC6;
        Wed, 13 Apr 2022 10:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA718B82651;
        Wed, 13 Apr 2022 17:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E59DC385A9;
        Wed, 13 Apr 2022 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649869768;
        bh=3u9ubt29kWBfeoohBhUaZtYjynoSHsWckWYS1SxrLGI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JK9l9xdpE9RXp5q6IKefJNSq94TlF8c8ZbbkoCEl3DfmKQX/u/Y5eHHfZiWqaCkHl
         vNMYHB60l1zE/NTHt+YX4u9UJy1Hohq9Y9uIiyZS0UesNdQY9IuDFVuXv+GZc0iSy9
         GOxJ5asWJXr46Jl7+bHKYTVBraKaKN3ELoVmWvnFKDF/qAdCvQpe01T1MOX+G+8PEJ
         W/nEdLA0FUZQtBoE+nbE/OooaTUeIGR6ZPfoVGUX75S9WmoEg6lIQExuStxle9jApw
         WsywUJ9AAHpBnPUjz1AGg6Du3ExvItn++nnt7nMp8PvIKGKyYcfGQWfcLCNvane7NZ
         0/pwBOTaVo4Ng==
Received: by mail-oo1-f50.google.com with SMTP id e7-20020a4aaac7000000b00330e3ddfd4bso449128oon.8;
        Wed, 13 Apr 2022 10:09:28 -0700 (PDT)
X-Gm-Message-State: AOAM530pyoVU2H/48WxmiYIBD4uxf7yfFA40Sa65Qpk+SFffb/NOJm06
        /y6H3VkXAcugDGxOQVBcG3K5aID+xQfh4MFowF4=
X-Google-Smtp-Source: ABdhPJy4fqCnnOJ0yVJ/sVE7NuBrsvkq3j08z26BO8f364+N+vDYbVb1R94XalEEtFRF7OhM79TTQ8/8j/SKXbF4NXU=
X-Received: by 2002:a4a:e6c2:0:b0:329:1863:6c3a with SMTP id
 v2-20020a4ae6c2000000b0032918636c3amr13572681oot.98.1649869767546; Wed, 13
 Apr 2022 10:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220331221030.889718-1-jakobkoschel@gmail.com> <20220331221030.889718-2-jakobkoschel@gmail.com>
In-Reply-To: <20220331221030.889718-2-jakobkoschel@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Apr 2022 19:09:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGqttOSOmYg1pkHOLTmVkrNVmLD5ngRLAPHiwv3j14wZg@mail.gmail.com>
Message-ID: <CAMj1kXGqttOSOmYg1pkHOLTmVkrNVmLD5ngRLAPHiwv3j14wZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: replace usage of found with dedicated list
 iterator variable
To:     Jakob Koschel <jakobkoschel@gmail.com>
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
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
>
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
>
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
>
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

I'll queue this up once we converge on a solution for the other patch.

> ---
>  drivers/firmware/efi/vars.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index 3994aad38661..e4e1cc593441 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -809,22 +809,21 @@ EXPORT_SYMBOL_GPL(efivar_entry_set_safe);
>  struct efivar_entry *efivar_entry_find(efi_char16_t *name, efi_guid_t guid,
>                                        struct list_head *head, bool remove)
>  {
> -       struct efivar_entry *entry, *n;
> +       struct efivar_entry *entry = NULL, *iter, *n;
>         int strsize1, strsize2;
> -       bool found = false;
>
> -       list_for_each_entry_safe(entry, n, head, list) {
> +       list_for_each_entry_safe(iter, n, head, list) {
>                 strsize1 = ucs2_strsize(name, 1024);
> -               strsize2 = ucs2_strsize(entry->var.VariableName, 1024);
> +               strsize2 = ucs2_strsize(iter->var.VariableName, 1024);
>                 if (strsize1 == strsize2 &&
> -                   !memcmp(name, &(entry->var.VariableName), strsize1) &&
> -                   !efi_guidcmp(guid, entry->var.VendorGuid)) {
> -                       found = true;
> +                   !memcmp(name, &(iter->var.VariableName), strsize1) &&
> +                   !efi_guidcmp(guid, iter->var.VendorGuid)) {
> +                       entry = iter;
>                         break;
>                 }
>         }
>
> -       if (!found)
> +       if (!entry)
>                 return NULL;
>
>         if (remove) {
> --
> 2.25.1
>

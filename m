Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA944BC022
	for <lists+linux-efi@lfdr.de>; Fri, 18 Feb 2022 20:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiBRTMd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Feb 2022 14:12:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiBRTMd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Feb 2022 14:12:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E204BFE4;
        Fri, 18 Feb 2022 11:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD8C61A5C;
        Fri, 18 Feb 2022 19:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A450C340EF;
        Fri, 18 Feb 2022 19:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645211535;
        bh=0e4veZFcnn6yrRxE8i8DKuPwxKv+TS/DeK6cNKOXQ54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qeWNMdspHVNInULfaQuInCBT8d3TksMptTgCh7LpndB8SfHule0W3eou5k7pnWItm
         kyi/sch6LZgNEx5NoxbGNDhpg7HVOFJBQvvbfC+JaI1CYroZIo3yBiDAjef1t+gSN8
         C2F2uR1Qm7ZivunyMbjdbl94yrer5ywR9dxC65CkMuqnluV5I4TlKUtewqNEBwXKHj
         7n/HxeSsfPOvlnDysqaQElvrA8WvGCO+ng867YbTGQG7XoSmY7eoKABOkwbqd/Wi/C
         /yfPTfqhjSLZs1NpZyEVP4CTrpFD7GjZLbTYBkT3AWEeB7xQLMUt48R4SKZ1VkMlUf
         Ju916tD+LhMSg==
Received: by mail-wr1-f44.google.com with SMTP id k1so16132029wrd.8;
        Fri, 18 Feb 2022 11:12:15 -0800 (PST)
X-Gm-Message-State: AOAM533joUi99m6tHOwqyOjALj46j60P31MJHPAHcRJXN4axWxmrGOFG
        wzLK3VkYfZ8qaivQYkLmjZmJskpoZTgpc+GjHNc=
X-Google-Smtp-Source: ABdhPJyWH4CFWTT1Ll+WXb+18S8oGb/1G5KWI/Y6rIcTot+u2tQMSfX5AgtBvvz8Ecbi6oD9pAUYOK3hEgORTiO+gTs=
X-Received: by 2002:a5d:6884:0:b0:1e4:ed7b:fd71 with SMTP id
 h4-20020a5d6884000000b001e4ed7bfd71mr7205218wru.550.1645211533454; Fri, 18
 Feb 2022 11:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20220218180559.1432559-1-jannh@google.com>
In-Reply-To: <20220218180559.1432559-1-jannh@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 18 Feb 2022 20:12:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE23L05mwadr_DH548T=BMG5dhkL0X+4+R75NDJUHxkYQ@mail.gmail.com>
Message-ID: <CAMj1kXE23L05mwadr_DH548T=BMG5dhkL0X+4+R75NDJUHxkYQ@mail.gmail.com>
Subject: Re: [PATCH] efivars: Respect "block" flag in efivar_entry_set_safe()
To:     Jann Horn <jannh@google.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 18 Feb 2022 at 19:06, Jann Horn <jannh@google.com> wrote:
>
> When the "block" flag is false, the old code would sometimes still call
> check_var_size(), which wrongly tells ->query_variable_store() that it can
> block.
>
> As far as I can tell, this can't really materialize as a bug at the moment,
> because ->query_variable_store only does something on X86 with generic EFI,
> and in that configuration we always take the efivar_entry_set_nonblocking()
> path. So I'm not marking this for stable backporting.
>
> Fixes: ca0e30dcaa53 ("efi: Add nonblocking option to efi_query_variable_store()")
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks Jann. I'll queue this up.

> ---
>
>  drivers/firmware/efi/vars.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index abdc8a6a3963..cae590bd08f2 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -742,6 +742,7 @@ int efivar_entry_set_safe(efi_char16_t *name, efi_guid_t vendor, u32 attributes,
>  {
>         const struct efivar_operations *ops;
>         efi_status_t status;
> +       unsigned long varsize;
>
>         if (!__efivars)
>                 return -EINVAL;
> @@ -764,15 +765,17 @@ int efivar_entry_set_safe(efi_char16_t *name, efi_guid_t vendor, u32 attributes,
>                 return efivar_entry_set_nonblocking(name, vendor, attributes,
>                                                     size, data);
>
> +       varsize = size + ucs2_strsize(name, 1024);
>         if (!block) {
>                 if (down_trylock(&efivars_lock))
>                         return -EBUSY;
> +               status = check_var_size_nonblocking(attributes, varsize);
>         } else {
>                 if (down_interruptible(&efivars_lock))
>                         return -EINTR;
> +               status = check_var_size(attributes, varsize);
>         }
>
> -       status = check_var_size(attributes, size + ucs2_strsize(name, 1024));
>         if (status != EFI_SUCCESS) {
>                 up(&efivars_lock);
>                 return -ENOSPC;
>
> base-commit: 83e396641110663d3c7bb25b9bc0c6a750359ecf
> --
> 2.35.1.473.g83b2b277ed-goog
>

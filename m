Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418C562C5E3
	for <lists+linux-efi@lfdr.de>; Wed, 16 Nov 2022 18:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiKPRGZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 12:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbiKPRGH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 12:06:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9B59863;
        Wed, 16 Nov 2022 09:05:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA7F061EF8;
        Wed, 16 Nov 2022 17:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28720C433C1;
        Wed, 16 Nov 2022 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668618303;
        bh=H4TU2MseEDfh27pYoEWcB2Ezu9/ASv5smgrOn2XF3tE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tHv2X2k0ksEuqCRCseCqNMS9aCodgXOr1vTbqO+CqVMA55fypP+SmYdS6fmGYmoB3
         j+zlsb2ipPAZQ0BZda6RYa5RV/IHaXtBF4/UAF1+lfOnyPcO5MzWV7Dk2YcsNz1LkO
         tCF6eXwYIWgKBFWU6/9KXKNzCVNUHALGHldgZzSahNByveO5dbIWdTfBM0QJrTH1A6
         /hNbycj7SWszAYQ1xRq54cOb1nl9qfY36MdTasxqm5yOETtlBjjcBpo8Jv2NGXvay8
         g8eG5Mk+pBexlIlvMOh8NcY2RHsPiIggRpyH06T00QIZxO9OZE+I1ivhaRnjOf4wpI
         zfEaUvNYJAiwQ==
Received: by mail-lj1-f181.google.com with SMTP id k19so22636128lji.2;
        Wed, 16 Nov 2022 09:05:03 -0800 (PST)
X-Gm-Message-State: ANoB5plk0lAZrvXbhj+6ukqMbnpqAMOo8qSo3NWK0wpaDnclM4gFN6U7
        DEOog0Gw6WGvOT34+HsXPQzmglj9N6NG4vfaci0=
X-Google-Smtp-Source: AA0mqf5xh8m9Bv/UfjWc5X505gLwlkjRl0nVJGvSgZjpMZDbRH3a6iNVW97ddntNp18YVlNk+2SekMyll25U84hqBas=
X-Received: by 2002:a2e:9593:0:b0:277:2428:3682 with SMTP id
 w19-20020a2e9593000000b0027724283682mr8713902ljh.291.1668618301194; Wed, 16
 Nov 2022 09:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20221116161642.1670235-1-Jason@zx2c4.com> <20221116161642.1670235-6-Jason@zx2c4.com>
In-Reply-To: <20221116161642.1670235-6-Jason@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 16 Nov 2022 18:04:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHZ60DCz6zgOqfQ-jBEuhc3XwvhieNbJUCY40hdEWt9CQ@mail.gmail.com>
Message-ID: <CAMj1kXHZ60DCz6zgOqfQ-jBEuhc3XwvhieNbJUCY40hdEWt9CQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 5/6] efi: efivarfs: prohibit reading random seed variables
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 16 Nov 2022 at 17:17, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Variables in the random seed GUID must remain secret, so deny all reads
> to them.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  fs/efivarfs/file.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
> index d57ee15874f9..08996ba3a373 100644
> --- a/fs/efivarfs/file.c
> +++ b/fs/efivarfs/file.c
> @@ -76,6 +76,9 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
>         while (!__ratelimit(&file->f_cred->user->ratelimit))
>                 msleep(50);
>
> +       if (guid_equal(&var->var.VendorGuid, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
> +               return -EPERM;
> +
>         err = efivar_entry_size(var, &datasize);
>
>         /*

I'd prefer it if we could just disregard them entirely, i.e., never
enumerate them so that they don't appear in the file system.

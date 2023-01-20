Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05226750F9
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jan 2023 10:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjATJZ7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Jan 2023 04:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjATJZ5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Jan 2023 04:25:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE79AAB7;
        Fri, 20 Jan 2023 01:25:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE21FB82070;
        Fri, 20 Jan 2023 09:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF21C4339B;
        Fri, 20 Jan 2023 09:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674206612;
        bh=edzJpvbcYJ9/le8XwQiv8Bj5JF2XFVSy342hKsdxn5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pQe+04cbCH4NAMc2DnOUbRbeaWSfHfSGFcX+/S5fANGycRC/uyrkJlT7SmWFpBm9O
         h1NSvR8ldgVSHkIpRHaCVSNEKRh1robNde0lORyw+T7buIVnaHdAah/q71Ls5sR6fl
         YDuzYdladzWl0EmoIEzCJrUQH7kFSPCZMDKsf8qmIc7d4GbjJ9k8nwUnWw4L4zJYEa
         7UBcACs+wMzGsoRjbmVoE5vyfsll6aNhAYnJ0Pb7B+3HFWYGnqKE2DDLwx9g6SqEkK
         e9CaieLAmum4vy6rrpak/+AmCe85nh5MuKjeTa/LGvxWG5fThfMvaJOFC+f1YBnmxB
         c86XWw9qmA4Ag==
Received: by mail-lj1-f174.google.com with SMTP id y19so4869415ljq.7;
        Fri, 20 Jan 2023 01:23:32 -0800 (PST)
X-Gm-Message-State: AFqh2kpddpUKorvwPiyWcayTcvD6I1sa7czFGdCkHYEq4XU1KenjsRXA
        mE2SyjeawKXFSWv+xSK84aHbV3u/csvtM7PSe+M=
X-Google-Smtp-Source: AMrXdXuZbc6TeXg6KE/rlsK6U8mCNclNDOV02Oo0EWJiKbhBYU3KR9hThtdr85AxyiJHOOGysNuBhz0mlFxac+ZUC/I=
X-Received: by 2002:a2e:a908:0:b0:283:33fa:ee22 with SMTP id
 j8-20020a2ea908000000b0028333faee22mr656950ljq.415.1674206610604; Fri, 20 Jan
 2023 01:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20230119164255.28091-1-johan+linaro@kernel.org> <20230119164255.28091-3-johan+linaro@kernel.org>
In-Reply-To: <20230119164255.28091-3-johan+linaro@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 20 Jan 2023 10:23:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEOOh8MrAt=L7aBt9wX5Pcmh4irnDuKqsDF7pB5-xnmog@mail.gmail.com>
Message-ID: <CAMj1kXEOOh8MrAt=L7aBt9wX5Pcmh4irnDuKqsDF7pB5-xnmog@mail.gmail.com>
Subject: Re: [PATCH 2/4] efivarfs: always register filesystem
To:     Johan Hovold <johan+linaro@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Peter, Heinrich)

On Thu, 19 Jan 2023 at 17:45, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> The efivar ops are typically registered at subsys init time so that
> they are available when efivarfs is registered at module init time.
>
> Other efivars implementations, such as Google SMI, exists and can
> currently be build as modules which means that efivar may not be
> available when efivarfs is initialised.
>
> Move the efivar availability check from module init to when the
> filesystem is mounted to allow late registration of efivars.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

I think this change is fine in principle, but I 'm not sure if there
is user space code that the distros are carrying that might get
confused by this: beforehand, efivarfs would not exist in
/proc/filesystems and now, it will but trying to mount it might fail.


> ---
>  fs/efivarfs/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index f72c529c8ec3..b67d431c861a 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -194,6 +194,9 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
>         struct dentry *root;
>         int err;
>
> +       if (!efivar_is_available())
> +               return -EOPNOTSUPP;
> +
>         sb->s_maxbytes          = MAX_LFS_FILESIZE;
>         sb->s_blocksize         = PAGE_SIZE;
>         sb->s_blocksize_bits    = PAGE_SHIFT;
> @@ -256,9 +259,6 @@ static struct file_system_type efivarfs_type = {
>
>  static __init int efivarfs_init(void)
>  {
> -       if (!efivar_is_available())
> -               return -ENODEV;
> -
>         return register_filesystem(&efivarfs_type);
>  }
>
> --
> 2.38.2
>

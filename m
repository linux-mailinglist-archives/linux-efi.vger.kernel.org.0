Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBB85AFF00
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIGIbH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 04:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiIGIbB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 04:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33FD8C445
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 01:30:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B770C617CE
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 08:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C3DC433D6
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 08:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662539457;
        bh=HqK6ybS+auhbt2FgKh+qZPv0h47sFgxqf57DuHnUjOY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iT/ztS1cRkx1DPcrx9KfzS+3EXje+xFgtIME9ZFDM4b5fcP0lUFmYK2nw2/6vZ9VZ
         RX6LkGlUyQjILeNuyJkukrztuRfIcdoKLmUXrjWzOexwwMQhAMy5V5pAxMh9BYuQB2
         G6GGgPn8OL6qaBpkYZEikcBcpr1d+giUYNrsJqrOiuGqmH/EUxWoYsrfAetrWFYVa0
         IUj6gwb8UNNskSGfbYSmNP1UfTInSJgBRh+7MUOdLxwA2zkxpBr8A0wcBP/5UIjcZh
         ikGRnpDkLfGgoUgMZRR1QRjdXHEueO5CrGJ/PlSv5OfK6Y+nmBePZ+8JyXvPpq3UzY
         VNu6bApEXrlNA==
Received: by mail-lf1-f48.google.com with SMTP id x14so5898947lfu.10
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 01:30:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo2YgeAaItv0Jwf2NpCGsH6crCN8Fr9m77vPDakyskyT2d/e242O
        TCGo8eQDk2l6F6bQBhidNmRUYeAWWtvPjpLq18k=
X-Google-Smtp-Source: AA6agR5th4zmzjT+wPRxofDxjfQar9NGe+CFrBDtFT1HjrxCWO/5zotPDX56OVrtUkxatHE+sIJm1TIteUwrN4LgTk0=
X-Received: by 2002:a05:6512:2294:b0:494:8dc5:10af with SMTP id
 f20-20020a056512229400b004948dc510afmr693729lfu.426.1662539455077; Wed, 07
 Sep 2022 01:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220626103248.GA57385@ubuntu>
In-Reply-To: <20220626103248.GA57385@ubuntu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 7 Sep 2022 10:30:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHo91v8u_RcXfu4r=x5eh-tShBu4gSDZXBRveOC275Fnw@mail.gmail.com>
Message-ID: <CAMj1kXHo91v8u_RcXfu4r=x5eh-tShBu4gSDZXBRveOC275Fnw@mail.gmail.com>
Subject: Re: [PATCH] efi/capsule-loader: Fix use-after-free in efi_capsule_write
To:     Hyunwoo Kim <imv4bel@gmail.com>
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

On Sun, 26 Jun 2022 at 12:32, Hyunwoo Kim <imv4bel@gmail.com> wrote:
>
> If the user calls close() during a copy operation in copy_from_user() of efi_capsule_write(),
> a race condition may occur in which the user's buffer is copied to the freed page.
>
> This is because .flush of file_operations is called unconditionally
> regardless of ->f_count, unlike .release.
>
> This driver is writable only with root privileges, so it is not a security vulnerability.
> However, it is recommended to add mutexes to efi_capsule_write() and efi_capsule_flush()
> as root can accidentally break the page while in use.
>

Apologies for the late reply.

Could you please elaborate? I.e., describe in more detail how the race
condition may occur?

Thanks,

> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  drivers/firmware/efi/capsule-loader.c | 12 ++++++++++++
>  include/linux/efi.h                   |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
> index 4dde8edd53b6..e50ede51ef38 100644
> --- a/drivers/firmware/efi/capsule-loader.c
> +++ b/drivers/firmware/efi/capsule-loader.c
> @@ -177,6 +177,8 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
>         if (count == 0)
>                 return 0;
>
> +       mutex_lock(&cap_info->write_lock);
> +
>         /* Return error while NO_FURTHER_WRITE_ACTION is flagged */
>         if (cap_info->index < 0)
>                 return -EIO;
> @@ -233,12 +235,16 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
>                         goto failed;
>         }
>
> +       mutex_unlock(&cap_info->write_lock);
> +
>         return write_byte;
>
>  fail_unmap:
>         kunmap(page);
>  failed:
>         efi_free_all_buff_pages(cap_info);
> +       mutex_unlock(&cap_info->write_lock);
> +
>         return ret;
>  }
>
> @@ -256,12 +262,16 @@ static int efi_capsule_flush(struct file *file, fl_owner_t id)
>         int ret = 0;
>         struct capsule_info *cap_info = file->private_data;
>
> +       mutex_lock(&cap_info->write_lock);
> +
>         if (cap_info->index > 0) {
>                 pr_err("capsule upload not complete\n");
>                 efi_free_all_buff_pages(cap_info);
>                 ret = -ECANCELED;
>         }
>
> +       mutex_unlock(&cap_info->write_lock);
> +
>         return ret;
>  }
>
> @@ -315,6 +325,8 @@ static int efi_capsule_open(struct inode *inode, struct file *file)
>                 return -ENOMEM;
>         }
>
> +       mutex_init(&cap_info->write_lock);
> +
>         file->private_data = cap_info;
>
>         return 0;
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7d9b0bb47eb3..e274c4e8d7c6 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -204,6 +204,7 @@ struct efi_image_auth {
>  struct capsule_info {
>         efi_capsule_header_t    header;
>         efi_capsule_header_t    *capsule;
> +       struct mutex            write_mutex;
>         int                     reset_type;
>         long                    index;
>         size_t                  count;
> --
> 2.25.1
>
> Dear all,
>
> I submitted this patch 2 weeks ago, this is my 3rd submission of this patch.
>
> Can I get feedback on this patch?
>
> Regards,
> Hyunwoo Kim.

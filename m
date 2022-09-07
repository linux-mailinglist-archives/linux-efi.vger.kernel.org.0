Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901735B092B
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiIGPtF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 11:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIGPtE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 11:49:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A142BB688
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 08:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AA982CE1CB3
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 15:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF55C433D7
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662565736;
        bh=BQRFJIOqucV2p+l7BKWPZl6TltLOa0mei4BgolftE4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DKTaJ+XymJxZgkUz7+aQJYkMeA7/PM6x3A0O4A262pW28aUA//NmoJ4qkXGnWRWuR
         RztG6rAMH68m5Oo6fuy4IoIzoKI2MDrGKPfTl1dYsmavmK2z5tSC5kWktQieAYhc4P
         KQ2RmLbJlR+aHyjIuXmJ76D72+a/DxSalB1BRIsRLrFao8QG7BDcyn1jaFeNEk7/xQ
         /babn1KVzGnV5u9EScYnt6ciHweNdlP2mhRG1Fxt169j3DZp8BNHn1BJhd73C8C9m7
         49439AL5Fo/t/THZDxir+AR3QZ3sAU1ihQN22lb9z1LXG1M7ceLHdkVqi/izoS9djR
         lrEJ8KxPN6gkA==
Received: by mail-lf1-f54.google.com with SMTP id w8so23055305lft.12
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 08:48:56 -0700 (PDT)
X-Gm-Message-State: ACgBeo3Gc1GEXYd+rWioIbP2zHT9FynBU5pNd6pZmwwS2udw7S7aBywi
        PDt1KJ7OR0JMiMQRCCXiwgcx16QSd0Kq3OY1yTI=
X-Google-Smtp-Source: AA6agR6fEh7oU1zIXM7W3eM2aN5UtXyDVWjLSU9rbLkDTztOpnAQJ6VrTiJVbsXVEj0JY1kpuSDVgltGarBXBw5Qcfg=
X-Received: by 2002:a05:6512:4024:b0:497:4db:6ad0 with SMTP id
 br36-20020a056512402400b0049704db6ad0mr1386145lfb.637.1662565734630; Wed, 07
 Sep 2022 08:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220907153513.GA147130@ubuntu>
In-Reply-To: <20220907153513.GA147130@ubuntu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 7 Sep 2022 17:48:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFmRj+_nKO7xqYfSC_Mfv5MsaaetFsKrKJLhDmp-4=atg@mail.gmail.com>
Message-ID: <CAMj1kXFmRj+_nKO7xqYfSC_Mfv5MsaaetFsKrKJLhDmp-4=atg@mail.gmail.com>
Subject: Re: [PATCH v4] efi: capsule-loader: Fix use-after-free in efi_capsule_write
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

On Wed, 7 Sept 2022 at 17:35, Hyunwoo Kim <imv4bel@gmail.com> wrote:
>
> A race condition may occur if the user calls close() on another
> thread during a write() operation on the device node of the efi capsule.
>
> This is a race condition that occurs between the efi_capsule_write()
> and efi_capsule_flush() functions of efi_capsule_fops,
> which ultimately results in UAF.
>
> So, the page freeing process is modified to be done in
> efi_capsule_release() instead of efi_capsule_flush().
>
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  drivers/firmware/efi/capsule-loader.c | 29 ++++++---------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
> index 4dde8edd53b6..788e860304ae 100644
> --- a/drivers/firmware/efi/capsule-loader.c
> +++ b/drivers/firmware/efi/capsule-loader.c
> @@ -243,18 +243,17 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
>  }
>
>  /**
> - * efi_capsule_flush - called by file close or file flush
> + * efi_capsule_release - called by file close
> + * @inode: not used
>   * @file: file pointer
> - * @id: not used
>   *
> - *     If a capsule is being partially uploaded then calling this function
> - *     will be treated as upload termination and will free those completed
> - *     buffer pages and -ECANCELED will be returned.
> + *     We will not free successfully submitted pages since efi update
> + *     requires data to be maintained across system reboot.
>   **/
> -static int efi_capsule_flush(struct file *file, fl_owner_t id)
> +static int efi_capsule_release(struct inode *inode, struct file *file)
>  {
> -       int ret = 0;
>         struct capsule_info *cap_info = file->private_data;
> +       int ret = 0;
>
>         if (cap_info->index > 0) {

OK, so what happens if the /dev/efi_capsule_loader is close() after a
successful write and capsule update? AIUI, the pages should not be
freed in that case, as the firmware will perform the capsule update
based on their contents.

So I assume this condition should become something like

       if (cap_info->index > 0 &&
           (cap_info->header.headersize == 0 ||
            cap_info->count < cap_info->total_size)) {

so the inverse condition of what triggers the actual call to
efi_capsule_submit_update() is used to decide whether the capsule
update happened, and whether the pages need to be preserved.


>                 pr_err("capsule upload not complete\n");
> @@ -262,21 +261,6 @@ static int efi_capsule_flush(struct file *file, fl_owner_t id)
>                 ret = -ECANCELED;

The return value of the release() hook doesn't seem to be used
anywhere so I'm not sure this is worth keeping.


>         }
>
> -       return ret;
> -}
> -
> -/**
> - * efi_capsule_release - called by file close
> - * @inode: not used
> - * @file: file pointer
> - *
> - *     We will not free successfully submitted pages since efi update
> - *     requires data to be maintained across system reboot.
> - **/
> -static int efi_capsule_release(struct inode *inode, struct file *file)
> -{
> -       struct capsule_info *cap_info = file->private_data;
> -
>         kfree(cap_info->pages);
>         kfree(cap_info->phys);
>         kfree(file->private_data);
> @@ -324,7 +308,6 @@ static const struct file_operations efi_capsule_fops = {
>         .owner = THIS_MODULE,
>         .open = efi_capsule_open,
>         .write = efi_capsule_write,
> -       .flush = efi_capsule_flush,
>         .release = efi_capsule_release,
>         .llseek = no_llseek,
>  };
> --
> 2.25.1
>

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E336C5B09D1
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiIGQNO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 12:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiIGQNN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 12:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D444B2C11C
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 09:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B576189F
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 16:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18B0C433D6
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662567190;
        bh=Jo1MmDJzV2nR2p6U1Nj6smgQArw9PCHFBQayCaCcF+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GOfuSBCkD/Bs+wqzcl2wAkTUK0bh7Qn5gNXhPCicbtbyOSt0QLy3T/XnwfIpKChpR
         6APyMybOVDqzE8ZL3kvRT0fKzDGwjshdKT53A1TSAcQB8JTFk6t/VsWoVyjH8MBmhX
         n9+woFOTMkJCFBLpzu90omidYUWP4ITi0rVSC12DGw+WmGVpmhGJhOUUUPLPbv5jer
         E1/eexcmfsuWCcxRa+SvGdr3HpZOxpbnKtVBztvv7NbDWEbanWW9zIj43dGVuVUCdf
         EdJkgEKv/PReaJW9+jaTUGOZHcSNHadSuCv4Q2yGEYvWl6itLHQGJrLAahEboKCV56
         FfxjShZDgWoDw==
Received: by mail-lf1-f48.google.com with SMTP id i26so7479945lfp.11
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 09:13:10 -0700 (PDT)
X-Gm-Message-State: ACgBeo3X8yUr19CSyV5yF/teT05xdf5iQBY111vXWFl+Pd32twewyP9r
        HGF9Sg0XoyvrQ7By7kvQNKffqOavdRBdSb80Gt8=
X-Google-Smtp-Source: AA6agR5E/IWQtGszmT/KrHS/XHzeoM80OKRFwQATu7sy8j6wqyX/+pgierbLjJYUZrqYkNveBsrLCd8mGJjCuyOwN18=
X-Received: by 2002:a05:6512:2294:b0:494:8dc5:10af with SMTP id
 f20-20020a056512229400b004948dc510afmr1243273lfu.426.1662567188881; Wed, 07
 Sep 2022 09:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220907160714.GA150039@ubuntu>
In-Reply-To: <20220907160714.GA150039@ubuntu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 7 Sep 2022 18:12:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXES-fQ2jT6icvL0Jk7twV9gKYnwUpnNE956qcg96D4RUQ@mail.gmail.com>
Message-ID: <CAMj1kXES-fQ2jT6icvL0Jk7twV9gKYnwUpnNE956qcg96D4RUQ@mail.gmail.com>
Subject: Re: [PATCH v5] efi: capsule-loader: Fix use-after-free in efi_capsule_write
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

On Wed, 7 Sept 2022 at 18:07, Hyunwoo Kim <imv4bel@gmail.com> wrote:
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

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Thanks for the fix, I will queue it up before the end of the week.

Thanks,


> ---
>  drivers/firmware/efi/capsule-loader.c | 31 ++++++---------------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
> index 4dde8edd53b6..cec826adcb51 100644
> --- a/drivers/firmware/efi/capsule-loader.c
> +++ b/drivers/firmware/efi/capsule-loader.c
> @@ -242,29 +242,6 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
>         return ret;
>  }
>
> -/**
> - * efi_capsule_flush - called by file close or file flush
> - * @file: file pointer
> - * @id: not used
> - *
> - *     If a capsule is being partially uploaded then calling this function
> - *     will be treated as upload termination and will free those completed
> - *     buffer pages and -ECANCELED will be returned.
> - **/
> -static int efi_capsule_flush(struct file *file, fl_owner_t id)
> -{
> -       int ret = 0;
> -       struct capsule_info *cap_info = file->private_data;
> -
> -       if (cap_info->index > 0) {
> -               pr_err("capsule upload not complete\n");
> -               efi_free_all_buff_pages(cap_info);
> -               ret = -ECANCELED;
> -       }
> -
> -       return ret;
> -}
> -
>  /**
>   * efi_capsule_release - called by file close
>   * @inode: not used
> @@ -277,6 +254,13 @@ static int efi_capsule_release(struct inode *inode, struct file *file)
>  {
>         struct capsule_info *cap_info = file->private_data;
>
> +       if (cap_info->index > 0 &&
> +               (cap_info->header.headersize == 0 ||
> +               cap_info->count < cap_info->total_size)) {
> +               pr_err("capsule upload not complete\n");
> +               efi_free_all_buff_pages(cap_info);
> +       }
> +
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

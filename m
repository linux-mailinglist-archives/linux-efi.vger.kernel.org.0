Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ABA1D6E22
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 01:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgEQXzg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 May 2020 19:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgEQXzg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 17 May 2020 19:55:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BB5C061A0C;
        Sun, 17 May 2020 16:55:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h4so7922034ljg.12;
        Sun, 17 May 2020 16:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AE7rvJ9bQOe5Iv3TCs9QVJvHpNjvJT7jQx0yWIClvL8=;
        b=bIdNSeebF0sOzpBjnRjJD7wq0z7acmE/98P4QdaWJBo1E1nMGwELD5ZPiegEdYlk90
         c7eXWuy87PxtZBn9S+i6+BHscYbRVzIwqcl331bTCi9/a+0TbScIdCZdFXYdiltWnYac
         jo5RxXaqI/t/ROyv6PK77QaXiMmfL4fYErE2qN4JmAcQS0zmFpV8poKeTKubuuY+Thpn
         hjjJ+Dqaf7+HAI4Rwi3gGDHvWwoa/Eig6USQfW8MnqPc3rX1qogWdjqR6IFPOeTABT9S
         Tn8XLR/G8JhhrTJX7/6gkH/0x7PMicj4+2/Dl/Ic7ZF7k2iN1RxJQyagyGYqqVvR7YfP
         bp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AE7rvJ9bQOe5Iv3TCs9QVJvHpNjvJT7jQx0yWIClvL8=;
        b=KH1Os08IyXjVe9wPkhfFz64rGUZTCabTT/Fw4wznfSVxrBNajH6j3S5h0EPJfMqmoO
         Pj4DJLqG2bFr1bReZ62hFMyvLv+tyoKTNAfox1tJKh0y4sigE72cMp3qscLmzBOmaDFr
         VDG955cOAUzvSI3Z5jBIW7KrEwgVhQuoT0BuReZwdb3F038ju7VRIydgosTofQhJepb8
         IgN/gD29xBqOTu+uQUT/gPREMl5nJYT+QtqINGmOHxTqKEBzl63dQlK9ufXPUbQ12zqr
         tIrSwbHxc2BaA+CqWegyLwM7c0XPvxLWMes4jprJGPBLuQ89ZLspT8xkfECWLOHqsh9I
         jWLw==
X-Gm-Message-State: AOAM530KqlWysk1/Sb/swz0jYNPGlggaB6uprvpyzCxDh78m0WiOt37L
        RIvm0Wi2Ov4rgmgVxpFYX0uNbRh3
X-Google-Smtp-Source: ABdhPJzEUiiYd/oJCMEpxpgajyxxfj7zK6t4yrcBlOfnsdIxAxEU1ynFF1Hmj1VKlySMgrhvkT3ktg==
X-Received: by 2002:a2e:9b0f:: with SMTP id u15mr8584980lji.272.1589759732688;
        Sun, 17 May 2020 16:55:32 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id n18sm4791094lji.2.2020.05.17.16.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 16:55:31 -0700 (PDT)
Subject: Re: [PATCH v6 2/7] mmc: block: Add mmc_bdev_to_card() helper
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        =?UTF-8?Q?Nils_=c3=96stlund?= <nils@naltan.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve McIntyre <steve@einval.com>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20200517021225.22890-1-digetx@gmail.com>
 <20200517021225.22890-3-digetx@gmail.com>
Message-ID: <7bddacf1-5fe0-5119-48ac-6a0cc65c5af0@gmail.com>
Date:   Mon, 18 May 2020 02:55:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200517021225.22890-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

17.05.2020 05:12, Dmitry Osipenko пишет:
> NVIDIA Tegra Partition Table takes into account MMC card's BOOT_SIZE_MULT
> parameter, and thus, the partition parser needs to retrieve that EXT_CSD
> value from the block device.  There are also some other parts of struct
> mmc_card that are needed for the partition parser in order to calculate
> the eMMC offset and verify different things.  This patch introduces new
> helper which takes block device for the input argument and returns the
> corresponding MMC card.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mmc/core/block.c   | 15 +++++++++++++++
>  include/linux/mmc/blkdev.h | 13 +++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 include/linux/mmc/blkdev.h
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index c5367e2c8487..99298e888381 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -40,6 +40,7 @@
>  #include <linux/debugfs.h>
>  
>  #include <linux/mmc/ioctl.h>
> +#include <linux/mmc/blkdev.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
> @@ -305,6 +306,20 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
>  	return ret;
>  }
>  
> +struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
> +{
> +	struct mmc_blk_data *md;
> +
> +	if (bdev->bd_disk->major != MMC_BLOCK_MAJOR)
> +		return NULL;
> +
> +	md = mmc_blk_get(bdev->bd_disk);
> +	if (!md)
> +		return NULL;
> +
> +	return md->queue.card;
> +}
> +
>  static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
>  {
>  	struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
> diff --git a/include/linux/mmc/blkdev.h b/include/linux/mmc/blkdev.h
> new file mode 100644
> index 000000000000..67608c58de70
> --- /dev/null
> +++ b/include/linux/mmc/blkdev.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + *  linux/include/linux/mmc/blkdev.h
> + */
> +#ifndef LINUX_MMC_BLOCK_DEVICE_H
> +#define LINUX_MMC_BLOCK_DEVICE_H
> +
> +struct block_device;
> +struct mmc_card;
> +
> +struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
> +
> +#endif /* LINUX_MMC_BLOCK_DEVICE_H */
> 

Hello Ulf / Jens and everyone,

Guys, what do you think about this change?

Currently it's not allowed to compile MMC_BLOCK as a loadable kernel
module if TEGRA_PARTITION is enabled because it depends on MMC_BLOCK
presence. I'm curious if this situation could be improved by moving
mmc_bdev_to_card() to linux/mmc/blkdev.h and then:

1. Moving all private mmc/core/block.c structs to the public
linux/mmc/blkdev.h.

2. Or adding a "private opaque" pointer to a struct block_device and
setting it to md->queue.card, for example.

3. I see that struct block_device already has some bd_private field, but
I'm not sure whether it could be used for what I'm trying to achieve.
Actually I don't see where bd_private is used in kernel at all.

I'd like get yours feedback, thanks in advance.

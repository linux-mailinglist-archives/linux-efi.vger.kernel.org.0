Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C11F1D7244
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 09:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgERHvj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgERHvj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 03:51:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A313C061A0C;
        Mon, 18 May 2020 00:51:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g1so8745734ljk.7;
        Mon, 18 May 2020 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j+XLZ770aayqNoW5d4BlZKSy7t5I9Qm2RnTjcbWff+w=;
        b=unolLHR2GOwwZox7hA9MdHNY/i+B/kkEvMFY2W8hZtb8LR04154RvMy+t152D3BMm5
         DtPrrH+3UefzUadWPZ+n/4SDb1h5ewHECDhxp+aiadMJx+KPG7XbqhWk9tuU0IoL0GqR
         ilMQSTW+7EO4EJXWpuGiyjT/3MX1OJYtyMi+6eisywEVR0nMLegJs6kBnAjGlTGwcAHl
         YafJMiKPixCOHQycT+wEh0cavdBpom1obqnDIUTGVk8q9JxDgDSVUjkW2v62BCA2DO0T
         7gcj6j+q2Lr/506YODapWd00m7dgAj5aAzajd9aNIQ5ymocZXSBkh6F4iOMGhVqaVJ2F
         lfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j+XLZ770aayqNoW5d4BlZKSy7t5I9Qm2RnTjcbWff+w=;
        b=g/mCb0RuktKgYltIYs6J4y5idoLVBkzArOSvAXcaIrsEDo4C6M/a5CHH+lO47DDMCA
         uedSQabP+DjkB7QMZ6D7skhSDIxDBwmcMo/Y8RlbxBin7p1Iq62+LrMy6aeqXdq3lnL6
         3dKpVdhwnjklyqqf6IBbDNZbkN1PP8aiZSdKudsewXNzt/JF+slS2wLBDhbUa1e00GRF
         53RdCN1ikEopQphpfzYBZ2HmJa9ig7fXQ8WbMZQMYy3E9ipuRcQSMZQ85lZeCpf5IyAQ
         vbpwhPZ99JD0I1OFb0Ex7DkyqvGJfEMW/HpWFqjrzAWwsAETDS9nmSFpz21YmwotKMiT
         oenA==
X-Gm-Message-State: AOAM532xe+IzaCi3nJnfoS2wyDPzFw2h5C9rzJoQmcz8Yulz+8dzGyzZ
        yPmKoPShvQCUVjmvp6Jfu0wb2AuF
X-Google-Smtp-Source: ABdhPJwuCPpx9lOKnvsBTiPL744FnZ7MTvYQhkr7TMA1L5ipbfiZVQF5cWQrN9uCGxWUU1vEJeoTIg==
X-Received: by 2002:a05:651c:1131:: with SMTP id e17mr10027353ljo.79.1589788296661;
        Mon, 18 May 2020 00:51:36 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id l14sm195773lfk.30.2020.05.18.00.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 00:51:35 -0700 (PDT)
Subject: Re: [PATCH v6 2/7] mmc: block: Add mmc_bdev_to_card() helper
To:     Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        =?UTF-8?Q?Nils_=c3=96stlund?= <nils@naltan.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve McIntyre <steve@einval.com>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20200517021225.22890-1-digetx@gmail.com>
 <20200517021225.22890-3-digetx@gmail.com>
 <7bddacf1-5fe0-5119-48ac-6a0cc65c5af0@gmail.com>
 <CAPDyKFrGbKSx=afZCNBN_r_6iNm_TX0tZVRLK05ZUTDBGvAuyA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <41f4739f-5fd4-b6d8-9b3b-953411d31b97@gmail.com>
Date:   Mon, 18 May 2020 10:51:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrGbKSx=afZCNBN_r_6iNm_TX0tZVRLK05ZUTDBGvAuyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

18.05.2020 10:24, Ulf Hansson пишет:
> On Mon, 18 May 2020 at 01:55, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 17.05.2020 05:12, Dmitry Osipenko пишет:
>>> NVIDIA Tegra Partition Table takes into account MMC card's BOOT_SIZE_MULT
>>> parameter, and thus, the partition parser needs to retrieve that EXT_CSD
>>> value from the block device.  There are also some other parts of struct
>>> mmc_card that are needed for the partition parser in order to calculate
>>> the eMMC offset and verify different things.  This patch introduces new
>>> helper which takes block device for the input argument and returns the
>>> corresponding MMC card.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/mmc/core/block.c   | 15 +++++++++++++++
>>>  include/linux/mmc/blkdev.h | 13 +++++++++++++
>>>  2 files changed, 28 insertions(+)
>>>  create mode 100644 include/linux/mmc/blkdev.h
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>>> index c5367e2c8487..99298e888381 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -40,6 +40,7 @@
>>>  #include <linux/debugfs.h>
>>>
>>>  #include <linux/mmc/ioctl.h>
>>> +#include <linux/mmc/blkdev.h>
>>>  #include <linux/mmc/card.h>
>>>  #include <linux/mmc/host.h>
>>>  #include <linux/mmc/mmc.h>
>>> @@ -305,6 +306,20 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
>>>       return ret;
>>>  }
>>>
>>> +struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
>>> +{
>>> +     struct mmc_blk_data *md;
>>> +
>>> +     if (bdev->bd_disk->major != MMC_BLOCK_MAJOR)
>>> +             return NULL;
>>> +
>>> +     md = mmc_blk_get(bdev->bd_disk);
>>> +     if (!md)
>>> +             return NULL;
>>> +
>>> +     return md->queue.card;
>>> +}
>>> +
>>>  static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
>>>  {
>>>       struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
>>> diff --git a/include/linux/mmc/blkdev.h b/include/linux/mmc/blkdev.h
>>> new file mode 100644
>>> index 000000000000..67608c58de70
>>> --- /dev/null
>>> +++ b/include/linux/mmc/blkdev.h
>>> @@ -0,0 +1,13 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + *  linux/include/linux/mmc/blkdev.h
>>> + */
>>> +#ifndef LINUX_MMC_BLOCK_DEVICE_H
>>> +#define LINUX_MMC_BLOCK_DEVICE_H
>>> +
>>> +struct block_device;
>>> +struct mmc_card;
>>> +
>>> +struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
>>> +
>>> +#endif /* LINUX_MMC_BLOCK_DEVICE_H */
>>>
>>
>> Hello Ulf / Jens and everyone,
> 
> Hi Dmitry,
> 
>>
>> Guys, what do you think about this change?
> 
> As I stated in an earlier reply, I am deferring the review from mmc
> point of view, until I see some confirmation from Jens that he is okay
> with adding a new partition format.
> 
> Otherwise I may just waste my time on reviews. I hope you understand.

Hello Ulf,

I understand yours concerns. However, since the v6 of this series, the
information about MMC card is also needed if we'll want to support
devices that have GPT entry and use an older bootloader version.

Jens, could you please let us know whether we aren't wasting our time
here? :) If it's not desirable to support hacks that are needed for
consumer-grade Tegra-based Android devices in upstream kernel for the
case of the eMMC storage, then I'll stop this effort and won't bother
you again with these patches.

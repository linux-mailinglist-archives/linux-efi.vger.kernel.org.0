Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA72F3EFA40
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 07:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhHRFkz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 01:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhHRFky (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 01:40:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F1DC061764;
        Tue, 17 Aug 2021 22:40:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id n7so2975041ljq.0;
        Tue, 17 Aug 2021 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZcizrYLU6y5HJFAgIb30UDjYj0374xDfzw/H/m7g3Nk=;
        b=USZdPk+yWnkedrOOtr8KxP70SGQYMIXpfOV4rV1oOKtR1tcJmcwAZIO4+d83Hb8tYr
         AMZ2zSRDxicUtsGndPolzXUSaAqF59yTalnWQjAKsY11/RPMX3aYJVXG7qgHpc6X7uCM
         jIl70tMsn4zWCRFtNZa+7xTlxgs5G8IUj42zNgX5MSgWZ1gS0IRg8IGvKrQJI05pL/PJ
         ln6vYv0e9zUn0lKkdtBHC/W5lBkoxGVYLT2kVFFHZLgryJc3zx5WdRPhsCunH+L/U0nt
         Ehuenp/VllVCgpVifKoreU7rIL416QhLB8oosr3wzph7t1UM61ajKm+w2strKi46/OXz
         64Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZcizrYLU6y5HJFAgIb30UDjYj0374xDfzw/H/m7g3Nk=;
        b=jHLiTyTrzSGAQSmRz2Uj2L2V/OmDzqylfq0lwwPjPJxULyhVSdQHamaXeCtQHY8Jsp
         SVZiz7bi9VTXB0DPS0UxZCUCfrXQX8NUeRvh4w8Xm2/G+jeMO8Ap/3R/T4H0291rdipp
         vMNLO5COPUnd9yO3acEWyr5DatMCn5HGOtfmiwLifCBs2Q6bUGSHjrg49+SzxXalVRVa
         IQpkHCac12SA/bm/L+OJXTHUwAl/dTNPmvEM3qyIUaiUu15Zjlc2xlhxkBkw5ZRnicka
         czA/cDqiDQalBApqReeDloykfs3UEuM+w14CJyT6wuSj1a5FUG7hE4nugD7pkg2F6wN9
         uIzQ==
X-Gm-Message-State: AOAM5323l0pIQ8tvVJTAZbFeF1PMWsG3TCHm6DROfp7TrF06KvaQ6T2+
        YKUah3BVXPatnvuaHPcbhX8VGP61Gdk=
X-Google-Smtp-Source: ABdhPJw2dpwLL1dbQpICuE1/Nqw4koagP47CHNPcipYd/r4HkB0E//zbKzEs+dlJBez4jh3tvWCJiQ==
X-Received: by 2002:a2e:934c:: with SMTP id m12mr6046555ljh.375.1629265218423;
        Tue, 17 Aug 2021 22:40:18 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id m5sm461818ljg.55.2021.08.17.22.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 22:40:18 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] mmc: block: Support alternative_gpt_sector()
 operation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Micha?? Miros??aw <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210818005547.14497-1-digetx@gmail.com>
 <20210818005547.14497-3-digetx@gmail.com> <YRyagtKThKYK+Eah@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <32a009f6-7357-27cc-20e3-247de6f7d786@gmail.com>
Date:   Wed, 18 Aug 2021 08:40:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRyagtKThKYK+Eah@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

18.08.2021 08:28, Christoph Hellwig пишет:
> On Wed, Aug 18, 2021 at 03:55:44AM +0300, Dmitry Osipenko wrote:
>> +static int mmc_blk_alternative_gpt_sector(struct block_device *bdev,
>> +					  sector_t *sector)
>> +{
>> +	struct mmc_card *card = mmc_bdev_to_card(bdev);
>> +
>> +	if (!card)
>> +		return -ENODEV;
>> +
>> +	if (!card->host->ops->alternative_gpt_sector)
>> +		return -EOPNOTSUPP;
>> +
>> +	return card->host->ops->alternative_gpt_sector(card, sector);
>> +}
>> +
> 
>> +static struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
>> +{
>> +	struct mmc_blk_data *md;
>> +
>> +	if (bdev->bd_disk->fops != &mmc_bdops)
>> +		return NULL;
> 
> No need for this check bow that it is only called through mmc_bdops.

Alright

>> +
>> +	md = mmc_blk_get(bdev->bd_disk);
>> +	if (!md)
>> +		return NULL;
>> +
>> +	return md->queue.card;
>> +}
> 
> This reference seems to never be dropped anywhere.
> 

Indeed, I missed that it bumps the refcnt.

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF073F3BAD
	for <lists+linux-efi@lfdr.de>; Sat, 21 Aug 2021 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhHUR1P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 21 Aug 2021 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhHUR1O (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 21 Aug 2021 13:27:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F2C061756;
        Sat, 21 Aug 2021 10:26:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d16so22871152ljq.4;
        Sat, 21 Aug 2021 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3dwb14LoxKAfgB6DE8oiaGvSSnuNSYgxKX7YUQXAb+E=;
        b=opBvcGfQy13jAYzK2t/pJ6DtaCN8Wnq8nmm6zgEKSauVXTpNabwevkf5bck4c0toke
         SUg8LVaubfXizkFWtbklnxfqJHtHjjzp3xg8/BZo0XhVGnT32fhFuY8Ur42fECL5ksO9
         T1ejOeh15LJLoz/ZTH1IYJcfWbvjrGAH5Q2BJMhSTtVk8lZMj0hXCx8C4P8GJi/LM4w4
         WoYcDQR7paDB5Qw40TO37UVLq9BmXn9/P9WgQAmVDkFEGyR6vem8jXaoi5Ah7ilFTITb
         D2Db9sw6PXxGX4PsHZ+pbkudBRbgUBbAAYzl0NIU2l8hldWha2osZ8haTPD4oozuB6w3
         myIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3dwb14LoxKAfgB6DE8oiaGvSSnuNSYgxKX7YUQXAb+E=;
        b=Cv2XqK4ZY4H1CXxx0ism7fQkxDL8rKQrIvrmLvQ/cR379fXHRTy6yA7fkLtmH/Sc5P
         oOgyDDgviCt0qxgVbssK+v+7bG1JEyipt9N6ek879WZzBsDgpVN09lTFFhcnRRPcm8Gi
         EayHZd/Hmf90qYEGgAutTDE6tOV+EL4Y3TZSDUcH02pq00l8KKxUzSEeFhxQDI1sJ3Av
         56N77158mCo91u3dYmVN4RxklrYx1bj3ARriHxqEYHclC7aglTRdKrHJdiyyIhO4wwp/
         U/nsJIQRhVlaiQWO9RXL7FcAMeptnjxeKHvaUaz8MNn1NO7RHKULANHfGcU3k7ETuDa+
         rCFg==
X-Gm-Message-State: AOAM530vISMdxh6P1S7I3cYODTPHvm33njUcFuM3Y2Yt4QI9jWZ5vlUc
        ftpVQBkgVi/JCjnxRgWBNygYUgGb17k=
X-Google-Smtp-Source: ABdhPJwcwHTO11xGNnkkjQO7ggV4qmVoBlyJSXoCE0MBgpsLbynoJwdtLnE+wTDF5J5Uv6IhUDGIeg==
X-Received: by 2002:a2e:9802:: with SMTP id a2mr15036066ljj.470.1629566791932;
        Sat, 21 Aug 2021 10:26:31 -0700 (PDT)
Received: from [192.168.2.145] (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.googlemail.com with ESMTPSA id z13sm1052961lfu.0.2021.08.21.10.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 10:26:31 -0700 (PDT)
Subject: Re: [PATCH v6 2/5] partitions/efi: Support non-standard GPT location
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210818221920.3893-1-digetx@gmail.com>
 <20210818221920.3893-3-digetx@gmail.com> <YSAwh+3xEsutWWLG@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0353b40e-0fe8-b8e3-0479-091cff2737de@gmail.com>
Date:   Sat, 21 Aug 2021 20:26:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSAwh+3xEsutWWLG@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

21.08.2021 01:45, Michał Mirosław пишет:
> On Thu, Aug 19, 2021 at 01:19:17AM +0300, Dmitry Osipenko wrote:
>> Support looking up GPT at a non-standard location specified by a block
>> device driver.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  block/partitions/efi.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
>> index aaa3dc487cb5..7ca5c4c374d4 100644
>> --- a/block/partitions/efi.c
>> +++ b/block/partitions/efi.c
>> @@ -585,6 +585,8 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>>  	gpt_header *pgpt = NULL, *agpt = NULL;
>>  	gpt_entry *pptes = NULL, *aptes = NULL;
>>  	legacy_mbr *legacymbr;
>> +	struct gendisk *disk = state->disk;
>> +	const struct block_device_operations *fops = disk->fops;
>>  	sector_t total_sectors = get_capacity(state->disk);
>>  	u64 lastlba;
>>  
>> @@ -619,6 +621,16 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>>          if (!good_agpt && force_gpt)
>>                  good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>>  
>> +	if (!good_agpt && force_gpt && fops->alternative_gpt_sector) {
>> +		sector_t agpt_sector;
>> +		int err;
>> +
>> +		err = fops->alternative_gpt_sector(disk, &agpt_sector);
>> +		if (!err)
>> +			good_agpt = is_gpt_valid(state, agpt_sector,
>> +						 &agpt, &aptes);
>> +	}
>> +
> 
> When alternative_gpt_sector is provided I would expect it to override
> the default, not be a fallback for it. But if someone tries to put
> a broken (decoy, garbage) GPT at a standard place, current ordering
> will prevent overriding it.

This will break devices that have GPT at standard location. If someone
tries to manipulate with GPT entries, then it's a problem of that someone.

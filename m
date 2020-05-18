Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BC01D7266
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 10:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgERIAv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 04:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERIAv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 04:00:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF0EC061A0C;
        Mon, 18 May 2020 01:00:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b6so8804388ljj.1;
        Mon, 18 May 2020 01:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wa0lI6K9c2yizlhSExJV0yCXbar6s/0dBsIvA7fyzwA=;
        b=oPLDLtlCK3B2UirJcEaAVEMyyyarJuhdVpRe82gCi9qltMAuPD8+OrVGJNnsu287dw
         Q+QMgQPlK7qMFybK+ZqLbtPuTyn3Dq6KSa8oEoC+5QCSMdknUudt/2FTp7r2nwyilvHA
         nqz5JzFr7pde7P+TGvcGEHny8gHDgFqR9bMeFQ8ib76BiO+aleTsPs6qsf2/q5cLLd6v
         pih0UohBzTW47QmtMyw4IutJEaa9SQJsrRs4FW5YFDQu+SOvZtAP4euOrD8LRV9yJEdZ
         DsgilaN2qQZpqi00fMZjPpyz9tBhmgX4MG8okHdhPqhfQAam3mKhAs2Ga2/o6QHy2iCF
         rfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wa0lI6K9c2yizlhSExJV0yCXbar6s/0dBsIvA7fyzwA=;
        b=DMjqZtyj4TMcMR299funv873V+nBkKKCzdBcXdJeh/j0rwkRTxei9SNWyaajOKDfOY
         qpbqc7XWICTAWVtrjGbaP6pNxXzHlox64o8ZnXTq5n4pBq03DDGHx8xqs8PA3wtCcONr
         u8vs27gv2J9kT9l2VLU0TQq6hZjd99v241xIPbWT/dwGbt0QD2Bdz6A9tZBzGAq01i42
         Ev1WNrZ1q2FFhA0GXgaWM9EfVnmOKDheg7yzqiJh1TI48g3kyOm07Uk3j9pHI9kLBKnO
         UWx1aQfQ/p5Z43jxs/i3w+1cAmf0MjgeDeYJIOCvR0nmmK1HYeJIrvjb4Y0gugYL3rCQ
         JZsA==
X-Gm-Message-State: AOAM530dHKiB8dq4V+VjnEkcfZJZcMMXRlPo7Viu0tHV6llBjfM6BAdO
        95LGcHZasEO1mZfh6t3ZFMPjQFxW
X-Google-Smtp-Source: ABdhPJxMqFz7gXK2/VXT0Hb0n/u/XYAceGn1f4MvnraJ0aqoh7Ghj6X7hlfP+a4hCXweDRrxLP2s/g==
X-Received: by 2002:a2e:a211:: with SMTP id h17mr10103921ljm.289.1589788848104;
        Mon, 18 May 2020 01:00:48 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id m10sm6452213lfd.15.2020.05.18.01.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 01:00:47 -0700 (PDT)
Subject: Re: [PATCH v5 6/6] soc/tegra: Expose Boot Configuration Table via
 sysfs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve McIntyre <steve@einval.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20200516153644.13748-1-digetx@gmail.com>
 <20200516153644.13748-7-digetx@gmail.com>
 <20200518074557.GA12306@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <75e7d242-268c-07a3-a4f9-7b8252769140@gmail.com>
Date:   Mon, 18 May 2020 11:00:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518074557.GA12306@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

18.05.2020 10:45, Michał Mirosław пишет:
> On Sat, May 16, 2020 at 06:36:44PM +0300, Dmitry Osipenko wrote:
>> It's quite useful to have unencrypted BCT exposed to userspace for
>> debugging purposes, so let's expose it via sysfs.  The BCT data will be
>> present in '/sys/tegra/boot_config_table' binary file if BCT is available.
> [...]
>> +/*
>> + * spare_bct[] will be released once kernel is booted, hence not wasting
>> + * kernel space if BCT is missing. The tegra_bct can't be allocated during
>> + * of BCT setting up because it's too early for the slab allocator.
>> + */
>> +static u8 spare_bct[SZ_8K] __initdata;
>> +static u8 *tegra_bct;
>> +
>> +static ssize_t boot_config_table_read(struct file *filp,
>> +				      struct kobject *kobj,
>> +				      struct bin_attribute *bin_attr,
>> +				      char *buf, loff_t off, size_t count)
>> +{
>> +	memcpy(buf, tegra_bct + off, count);
>> +	return count;
>> +}
>> +static BIN_ATTR_RO(boot_config_table, 0);
>> +
>> +static int __init tegra_bootdata_bct_sysfs_init(void)
>> +{
>> +	if (!bin_attr_boot_config_table.size)
>> +		return 0;
>> +
>> +	tegra_bct = kmalloc(GFP_KERNEL, bin_attr_boot_config_table.size);
>> +	if (!tegra_bct)
>> +		return -ENOMEM;
>> +
>> +	memcpy(tegra_bct, spare_bct, bin_attr_boot_config_table.size);
>> +
>> +	return sysfs_create_bin_file(tegra_soc_kobj,
>> +				     &bin_attr_boot_config_table);
> 
> Should we consider freeing the table if sysfs registration fails?

This is a good suggestion, thank you :)

>> +}
>> +late_initcall(tegra_bootdata_bct_sysfs_init)
>> +
>> +void __init tegra_bootdata_bct_setup(void __iomem *bct_ptr, size_t bct_size)
>> +{
>> +	memcpy_fromio(spare_bct, bct_ptr, bct_size);
>> +	bin_attr_boot_config_table.size = bct_size;
> [...]
> 
> The size isn't checked anywhere. How the maximum is obtained? At least
> a comment would be good if the 8k limit is guaranteed by other means.

Yes, I can add a clarifying comment about the 8K. It also should be
possible to create a union of T20/T30 BCT structs and then use use
sizeof(bct_union). I'll consider this change for the next version, thank
you for the suggestion.

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444FB1D7228
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 09:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgERHqS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 03:46:18 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:25019 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgERHqR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 18 May 2020 03:46:17 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49QWKR03ryz7B;
        Mon, 18 May 2020 09:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1589787974; bh=gPgFXLS9rqplDfNULQiE4ZROGZg9KYP2t+MjXReQkrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZwOONPRMimCnZ8qniI9/Og5meUwlsIwQu+SaDF0mP6iulU3o5QvOf7xeqHe46+sv
         eM7V/V9PiHVeuopUdxf8J4DFbhmaTDDnB1Q1x2Okc3h1iYhNzP2FueTo9R2/MVswxy
         AvqAUFezPqiW6ysElMburvQJvgC/+hl5A3IrmSMCWum8924jYCkDSwmH3KQe3f0vv8
         nlsoCJRuz8reG7AO9pUamTVfSmlVHBV+naAZZDJ3EgIJeFfkYxbGufzRrhrlSZQ7pa
         isZ/roE3heIX/MFBVYam3L7+rWxMnzA6wbHp2aTUF9FyEU719lqxI/4QLlfpkcqTtL
         aSEmu/DQrtMSg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 18 May 2020 09:45:57 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
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
        Nils =?iso-8859-2?Q?=D6stlund?= <nils@naltan.com>,
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
Subject: Re: [PATCH v5 6/6] soc/tegra: Expose Boot Configuration Table via
 sysfs
Message-ID: <20200518074557.GA12306@qmqm.qmqm.pl>
References: <20200516153644.13748-1-digetx@gmail.com>
 <20200516153644.13748-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200516153644.13748-7-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, May 16, 2020 at 06:36:44PM +0300, Dmitry Osipenko wrote:
> It's quite useful to have unencrypted BCT exposed to userspace for
> debugging purposes, so let's expose it via sysfs.  The BCT data will be
> present in '/sys/tegra/boot_config_table' binary file if BCT is available.
[...]
> +/*
> + * spare_bct[] will be released once kernel is booted, hence not wasting
> + * kernel space if BCT is missing. The tegra_bct can't be allocated during
> + * of BCT setting up because it's too early for the slab allocator.
> + */
> +static u8 spare_bct[SZ_8K] __initdata;
> +static u8 *tegra_bct;
> +
> +static ssize_t boot_config_table_read(struct file *filp,
> +				      struct kobject *kobj,
> +				      struct bin_attribute *bin_attr,
> +				      char *buf, loff_t off, size_t count)
> +{
> +	memcpy(buf, tegra_bct + off, count);
> +	return count;
> +}
> +static BIN_ATTR_RO(boot_config_table, 0);
> +
> +static int __init tegra_bootdata_bct_sysfs_init(void)
> +{
> +	if (!bin_attr_boot_config_table.size)
> +		return 0;
> +
> +	tegra_bct = kmalloc(GFP_KERNEL, bin_attr_boot_config_table.size);
> +	if (!tegra_bct)
> +		return -ENOMEM;
> +
> +	memcpy(tegra_bct, spare_bct, bin_attr_boot_config_table.size);
> +
> +	return sysfs_create_bin_file(tegra_soc_kobj,
> +				     &bin_attr_boot_config_table);

Should we consider freeing the table if sysfs registration fails?

> +}
> +late_initcall(tegra_bootdata_bct_sysfs_init)
> +
> +void __init tegra_bootdata_bct_setup(void __iomem *bct_ptr, size_t bct_size)
> +{
> +	memcpy_fromio(spare_bct, bct_ptr, bct_size);
> +	bin_attr_boot_config_table.size = bct_size;
[...]

The size isn't checked anywhere. How the maximum is obtained? At least
a comment would be good if the 8k limit is guaranteed by other means.

Best Regards,
Micha³ Miros³aw

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A55934D614
	for <lists+linux-efi@lfdr.de>; Mon, 29 Mar 2021 19:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhC2RcQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Mar 2021 13:32:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:45014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhC2RcG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 29 Mar 2021 13:32:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 437BAAFDC;
        Mon, 29 Mar 2021 17:32:02 +0000 (UTC)
Date:   Mon, 29 Mar 2021 10:31:51 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Micha?? Miros??aw <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] partitions/efi: Support gpt_sector parameter
 needed by NVIDIA Tegra devices
Message-ID: <20210329173151.urs4x36m3bq6txrf@offworld>
References: <20210327212100.3834-1-digetx@gmail.com>
 <20210327212100.3834-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210327212100.3834-4-digetx@gmail.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 28 Mar 2021, Dmitry Osipenko wrote:

>All NVIDIA Tegra20..124 Android devices use proprietary bootloader
>which supplies the gpt_sector=<sector> kernel cmdline parameter that
>should be used for looking up the EFI partition table on internal EMMC
>storage.  If the kernel cmdline parameter isn't supplied, then the
>partition is expected to be placed around the last but one sector of EMMC.
>
>Apparently this was done in order to hide the PT from a usual userspace
>tools since EFI entry exists only for compatibility with a Linux kernel,
>while a custom proprietary partition table is what is really used by
>these Android devices, thus these tools may corrupt the real PT, making
>device unbootable and very difficult to restore.
>
>Add support for the gpt_sector cmdline parameter which will be used
>for finding EFI entry on internal EMMC storage of NVIDIA Tegra20+ devices.

Since this is proprietary and playing yucky games hiding the pt, why not
just force for the fallback on Nvidia's side and always just use the entry
at the end of the block device? I'm not loving introducing a generic parameter
for an obscure ad-hoc feature.

Thanks,
Davidlohr

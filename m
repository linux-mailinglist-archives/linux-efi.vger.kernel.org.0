Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669203F5A1A
	for <lists+linux-efi@lfdr.de>; Tue, 24 Aug 2021 10:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhHXItd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Aug 2021 04:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbhHXItc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Aug 2021 04:49:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771B3C061757
        for <linux-efi@vger.kernel.org>; Tue, 24 Aug 2021 01:48:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f10so29066181lfv.6
        for <linux-efi@vger.kernel.org>; Tue, 24 Aug 2021 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pgm99jwoWBGP1CQEe7me07S8/wRl0MbrDBEScFG6VFo=;
        b=BSNop3EpKaJN7lPEWCmVApDYjCHtcC92VxTyXH5Ts1S0TS0QOCHG6DisC9r+ld2VTS
         Jmp7D1QAN48wp0ttG5QokodIRttfXa1glzP2yjcXyXYB3/OKQPGV+1DRrrNaUpXtEoNS
         OGy1CItbApT/FKNlRqHvPLIk4IXKs3N3QjrjJEUYNrTcpTUg5OuAjzeWN+TeYevfpEpI
         EVW3i7CwrHobeeADgloBP8RQPEuZL758YYycP0U/O3YgHOeBqQ5mMx2IqD+QdXxefOvi
         BXI3W/DgN+iljd5w3ywCVJVo9YsoeAcVFB9/AQ5SxNf3b6hlItFNh2G6cVJzLswUGETc
         cBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pgm99jwoWBGP1CQEe7me07S8/wRl0MbrDBEScFG6VFo=;
        b=kZGAz5XznS+KbuMYQOQpe5zzmUu6vtMNQgrRAygvTePheQWiSBnN8hBeASiwKpARjT
         JVw0/y1XgkNnfDalD8RsylrEVgCumKxl5uFPPQyoUn2UVZuXIUY44mb2UuTylpxi7sMh
         Ld1RKwGmeY7DPFYxI4l6cF7F0nj3DyE/byPlATZPGvvhMjEixwvzvOVkjK31Aj2FODbn
         dnkfqZxlzLoJH4x39qVGf8SOjoxUarvNL8rlwjLLBH/EmINiBHG6zbcd7TODUo+E6Hxl
         tHknIfhb515gzLIyBkan3quOz1ndKx9AUoIIoaqF86FM4iBz8o3+CqrJAgRuokYRhmc5
         hJPg==
X-Gm-Message-State: AOAM530vI+wviue9rXm47yVYGJFD9Jkl5zGyYg5a0PGgUkU6ek3WOk1L
        q8Fk9ZDXf4+h48ih6DXwR+nIOMfodEXxtNo2/xa4Wg==
X-Google-Smtp-Source: ABdhPJzKjnsL/v3XOHZfBiuebUr3QaCSPjRKjZ1MjuNxcSeBa/QJg75GzdG+2eShmPb6QjQyrT+EkMoLbh3vc/oQXrY=
X-Received: by 2002:a19:655e:: with SMTP id c30mr982035lfj.142.1629794926829;
 Tue, 24 Aug 2021 01:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210820004536.15791-1-digetx@gmail.com>
In-Reply-To: <20210820004536.15791-1-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 10:48:10 +0200
Message-ID: <CAPDyKFpAbLbHPP1R_iLw380Z8AgonrfC-vLBahHo6tKtQh9Fdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Support EFI partition on NVIDIA Tegra devices
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 20 Aug 2021 at 02:45, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> This series adds the most minimal EFI partition support for NVIDIA Tegra
> consumer devices, like Android tablets and game consoles, making theirs
> eMMC accessible out-of-the-box using downstream bootloader and mainline
> Linux kernel.  eMMC now works on Acer A500 tablet and Ouya game console
> that are already well supported in mainline and internal storage is the
> only biggest thing left to support.
>
> Changelog:
>
> v7: - Added r-b from Christoph Hellwig.
>
>     - Added ack from Davidlohr Bueso.
>
>     - Renamed MMC_CAP2_ALT_GPT_SECTOR to MMC_CAP2_ALT_GPT_TEGRA,
>       like it was suggested by Ulf Hansson and Thierry Reding.
>
>     - Squashed MMC raw_boot_mult patch into alternative_gpt_sector()
>       since both now belong to MMC core and it's cleaner to have them
>       in a single change.

Jens, these changes looks good to me. If you have no objections, feel
free to queue them via your tree (I don't think there will be any
conflicts with my mmc tree).

For the series:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
> v6: - Added comment for the alternative_gpt_sector() callback, which
>       was asked by Christoph Hellwig.
>
>     - Changed alternative_gpt_sector() to take disk for the argument
>       instead of blkdev. This was asked by Christoph Hellwig.
>
>     - Dropped mmc_bdops check as it was suggested by Christoph Hellwig.
>
>     - Added missing mmc_blk_put() that was spotted by Christoph Hellwig.
>
>     - Moved GPT calculation into MMC core and added MMC_CAP2_ALT_GPT_SECTOR
>       flag, like it was asked by Ulf Hansson. Me and Thierry have concerns
>       about whether it's better to have Tegra-specific function in a core
>       instead of Tegra driver, but it also works, so I decided to try that
>       variant.
>
> v5: - Implemented alternative_gpt_sector() blk/mmc callback that was
>       suggested by Christoph Hellwig in a comment to v4.
>
>     - mmc_bdev_to_card() now checks blk fops instead of the major number,
>       like it was suggested by Christoph Hellwig in a comment to v4.
>
>     - Emailed Rob Herring, which was asked by Ulf Hansson in a comment
>       to v4. Although the of-match change is gone now in v5, the matching
>       is transformed into the new SDHCI quirk of the Tegra driver.
>
> v4: - Rebased on top of recent linux-next.
>
> v3: - Removed unnecessary v1 hunk that was left by accident in efi.c of v2.
>
> v2: - This is continuation of [1] where Davidlohr Bueso suggested that it
>       should be better to avoid supporting in mainline the custom gpt_sector
>       kernel cmdline parameter that downstream Android kernels use.  We can
>       do this for the devices that are already mainlined, so I dropped the
>       cmdline from the v2 and left only the variant with a fixed GPT address.
>
> [1] https://lore.kernel.org/linux-efi/20210327212100.3834-3-digetx@gmail.com/T/
>
> Dmitry Osipenko (4):
>   block: Add alternative_gpt_sector() operation
>   partitions/efi: Support non-standard GPT location
>   mmc: block: Support alternative_gpt_sector() operation
>   mmc: sdhci-tegra: Enable MMC_CAP2_ALT_GPT_TEGRA
>
>  block/partitions/efi.c         | 12 ++++++++++++
>  drivers/mmc/core/block.c       | 21 ++++++++++++++++++++
>  drivers/mmc/core/core.c        | 35 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/core.h        |  2 ++
>  drivers/mmc/core/mmc.c         |  2 ++
>  drivers/mmc/host/sdhci-tegra.c |  9 +++++++++
>  include/linux/blkdev.h         |  7 +++++++
>  include/linux/mmc/card.h       |  1 +
>  include/linux/mmc/host.h       |  1 +
>  9 files changed, 90 insertions(+)
>
> --
> 2.32.0
>

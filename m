Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDDA3EE875
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 10:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbhHQIZ2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 04:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbhHQIZW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 04:25:22 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF5C0613CF
        for <linux-efi@vger.kernel.org>; Tue, 17 Aug 2021 01:24:50 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id 75so8689618uav.8
        for <linux-efi@vger.kernel.org>; Tue, 17 Aug 2021 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NANAeHbZiQyWuhfenDwun7W+L0Tu32AbJv1dk8kR1E4=;
        b=BO63hECkdsaSgtfDHlf58J4sqJkeHBr2/HELnfV7eRv+DvUhZu7y3vFlBpOseL+lz8
         6+LqsRaH7FIGMZMYF676JIXQQ3Ue396tTinaiBZrTqhdKQ8GNm9WxlY0eadhcY/oCIfX
         YgVfqleJEKkLAAA+r5HrPUm1mV6oIaSrRb6BgVGLrIgRhYh+MDubdQV8IIOtXhpE93Iu
         wgrne4YJCfZg3NG+lzr/B3+g/7qj/Ai6XO4IJzHcCxS/iSg919iiD+CMBrviFJe+KWjW
         DdAJvXQjpXbg9JatyowWGYbZoO6LSPBBvby8aYs3mTVCk3ODWlpey/g5lIgkk8pieJyg
         Glyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NANAeHbZiQyWuhfenDwun7W+L0Tu32AbJv1dk8kR1E4=;
        b=OAtuFCLCfn+zYE287P90ewufGC+10YHPvsSSJ+Nxs/7biSdHUOrD2R+QDd+cHPFySF
         hLadIMHGGwUKlX7mnYlaKZ7vPJRbvZzU3JBMSxvm7AFAyoMktHUEUgiG+iKIAnow7qzz
         jyT87tlomB46Q1S8Si3Sb/EUzT4LryZ6j6j+CqMCfKEryLrdBDkhK4KYoallnp59XPXQ
         zLgh+NCu4c1b4ISjvu682n1Yqs04iDT5OBqIQ4WFYh1X91fdllSYPMZgljD7ylnV+Wks
         ES3ISQYWC4gJeVwefJ9u2xuw1cyRpXrPJBxPzUmN4qfqldLpJki7QOCHH1s2W8qKR8IH
         AUHQ==
X-Gm-Message-State: AOAM530NKZHiJ9sA1fjLn3qiuERbnPSjf0rpqaTaBsnr/muCH6UwREJ7
        yqFaQOT81YyNI4G+GXU8+YxcsT+kcNJuNYA0kSgcMg==
X-Google-Smtp-Source: ABdhPJy9Sny95yIqpvu+19oA1LqUTUHjeGk3CBH8OBP6Z7x9GBG9OuU1+FI5pCNp0F6iV00JoXN9lHYUYfhPYoAKWxs=
X-Received: by 2002:ab0:72c2:: with SMTP id g2mr1214196uap.104.1629188689169;
 Tue, 17 Aug 2021 01:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210817013643.13061-1-digetx@gmail.com> <20210817013643.13061-4-digetx@gmail.com>
In-Reply-To: <20210817013643.13061-4-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Aug 2021 10:24:12 +0200
Message-ID: <CAPDyKFr3d5tTsKVhgvqw1C-Np=6N2onJ+bo_hoFqtD6JSPn2Bg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] partitions/efi: Support NVIDIA Tegra devices
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 17 Aug 2021 at 03:37, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> NVIDIA Tegra consumer devices have EMMC storage that has GPT entry at a
> non-standard location. Support looking up GPT entry at a special sector
> to enable such devices.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  block/partitions/Kconfig  |  8 +++++
>  block/partitions/Makefile |  1 +
>  block/partitions/check.h  |  2 ++
>  block/partitions/core.c   |  3 ++
>  block/partitions/efi.c    |  9 +++++
>  block/partitions/tegra.c  | 75 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 98 insertions(+)
>  create mode 100644 block/partitions/tegra.c
>
> diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
> index 278593b8e4e9..5db25e7efbb7 100644
> --- a/block/partitions/Kconfig
> +++ b/block/partitions/Kconfig
> @@ -267,3 +267,11 @@ config CMDLINE_PARTITION
>         help
>           Say Y here if you want to read the partition table from bootargs.
>           The format for the command line is just like mtdparts.
> +
> +config TEGRA_PARTITION
> +       bool "NVIDIA Tegra Partition support" if PARTITION_ADVANCED
> +       default y if ARCH_TEGRA
> +       depends on EFI_PARTITION && MMC_BLOCK && (ARCH_TEGRA || COMPILE_TEST)
> +       help
> +         Say Y here if you would like to be able to read the hard disk
> +         partition table format used by NVIDIA Tegra machines.
> diff --git a/block/partitions/Makefile b/block/partitions/Makefile
> index a7f05cdb02a8..83cb70c6d08d 100644
> --- a/block/partitions/Makefile
> +++ b/block/partitions/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_IBM_PARTITION) += ibm.o
>  obj-$(CONFIG_EFI_PARTITION) += efi.o
>  obj-$(CONFIG_KARMA_PARTITION) += karma.o
>  obj-$(CONFIG_SYSV68_PARTITION) += sysv68.o
> +obj-$(CONFIG_TEGRA_PARTITION) += tegra.o
> diff --git a/block/partitions/check.h b/block/partitions/check.h
> index d5b28e309d64..bd4b66443cf4 100644
> --- a/block/partitions/check.h
> +++ b/block/partitions/check.h
> @@ -22,6 +22,7 @@ struct parsed_partitions {
>         int limit;
>         bool access_beyond_eod;
>         char *pp_buf;
> +       sector_t force_gpt_sector;
>  };
>
>  typedef struct {
> @@ -67,4 +68,5 @@ int osf_partition(struct parsed_partitions *state);
>  int sgi_partition(struct parsed_partitions *state);
>  int sun_partition(struct parsed_partitions *state);
>  int sysv68_partition(struct parsed_partitions *state);
> +int tegra_partition_forced_gpt(struct parsed_partitions *state);
>  int ultrix_partition(struct parsed_partitions *state);
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 9265936df77e..bbfbb1621581 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -82,6 +82,9 @@ static int (*check_part[])(struct parsed_partitions *) = {
>  #endif
>  #ifdef CONFIG_SYSV68_PARTITION
>         sysv68_partition,
> +#endif
> +#ifdef CONFIG_TEGRA_PARTITION
> +       tegra_partition_forced_gpt,
>  #endif
>         NULL
>  };
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index aaa3dc487cb5..4ad151176204 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -619,6 +619,15 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>          if (!good_agpt && force_gpt)
>                  good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>
> +       /*
> +        * The force_gpt_sector is used by NVIDIA Tegra partition parser in
> +        * order to convey a non-standard location of the GPT entry for lookup.
> +        * By default force_gpt_sector is set to 0 and has no effect.
> +        */
> +       if (!good_agpt && force_gpt && state->force_gpt_sector)
> +               good_agpt = is_gpt_valid(state, state->force_gpt_sector,
> +                                        &agpt, &aptes);
> +
>          /* The obviously unsuccessful case */
>          if (!good_pgpt && !good_agpt)
>                  goto fail;
> diff --git a/block/partitions/tegra.c b/block/partitions/tegra.c
> new file mode 100644
> index 000000000000..4937e9f62398
> --- /dev/null
> +++ b/block/partitions/tegra.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt) "tegra-partition: " fmt
> +
> +#include <linux/blkdev.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/sizes.h>
> +
> +#include <linux/mmc/blkdev.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +
> +#include <soc/tegra/common.h>
> +
> +#include "check.h"
> +
> +static const struct of_device_id tegra_sdhci_match[] = {
> +       { .compatible = "nvidia,tegra20-sdhci", },
> +       { .compatible = "nvidia,tegra30-sdhci", },
> +       { .compatible = "nvidia,tegra114-sdhci", },
> +       { .compatible = "nvidia,tegra124-sdhci", },
> +       {}
> +};
> +
> +int tegra_partition_forced_gpt(struct parsed_partitions *state)
> +{
> +       struct gendisk *disk = state->disk;
> +       struct block_device *bdev = disk->part0;
> +       struct mmc_card *card = mmc_bdev_to_card(bdev);
> +       int ret, boot_offset;
> +
> +       if (!soc_is_tegra())
> +               return 0;
> +
> +       /* filter out unrelated and untested boot sources */
> +       if (!card || card->ext_csd.rev < 3 ||
> +           !mmc_card_is_blockaddr(card) ||
> +            mmc_card_is_removable(card->host) ||
> +            bdev_logical_block_size(bdev) != SZ_512 ||
> +           !of_match_node(tegra_sdhci_match, card->host->parent->of_node)) {

I think you need to convince Rob Herring that the location of the GPT
table in the eMMC flash memory is allowed to depend on the compatible
string of the sdhci controller.

In any case, I think Christoph raised some interesting ideas in his
reply. Moving more of this code into the mmc core/block layer seems
reasonable to me as well.

> +               pr_debug("%s: unexpected boot source\n", disk->disk_name);
> +               return 0;
> +       }
> +
> +       /*
> +        * eMMC storage has two special boot partitions in addition to the
> +        * main one.  NVIDIA's bootloader linearizes eMMC boot0->boot1->main
> +        * accesses, this means that the partition table addresses are shifted
> +        * by the size of boot partitions.  In accordance with the eMMC
> +        * specification, the boot partition size is calculated as follows:
> +        *
> +        *      boot partition size = 128K byte x BOOT_SIZE_MULT
> +        *
> +        * This function returns number of sectors occupied by the both boot
> +        * partitions.
> +        */
> +       boot_offset = card->ext_csd.raw_boot_mult * SZ_128K /
> +                     SZ_512 * MMC_NUM_BOOT_PARTITION;
> +
> +       /*
> +        * The fixed GPT entry address is calculated like this:
> +        *
> +        * gpt_sector = ext_csd.sectors_num - ext_csd.boot_sectors_num - 1
> +        *
> +        * This algorithm is defined by NVIDIA and used by Android devices.
> +        */
> +       state->force_gpt_sector  = get_capacity(disk);
> +       state->force_gpt_sector -= boot_offset + 1;
> +
> +       ret = efi_partition(state);
> +       state->force_gpt_sector = 0;
> +
> +       return ret;
> +}
> --
> 2.32.0
>

Kind regards
Uffe

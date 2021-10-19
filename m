Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F78432EC5
	for <lists+linux-efi@lfdr.de>; Tue, 19 Oct 2021 09:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhJSHD1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Oct 2021 03:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:32872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhJSHD0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 Oct 2021 03:03:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 751EF61264;
        Tue, 19 Oct 2021 07:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634626874;
        bh=WULQsGTEJwt19CRpdjcDl/c2CFB3gMMJnWJdmGQga0M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k04egQL83NVWTov+uXYYVSys9+ZJ4fpLBBFQTpW7Q9/EqtFRJ/kXLkqCgC/zDCU2Z
         jL69ucdnigZPLxfZLakiNRPhMNAeRgGiuEYkFoJSm7qVysMxBUpRsskYf/pt5SbzAv
         9Gv31GGoMPqSyPbycTgcPoqPteYDZCJQJ3qRwVdAqosm5MDTBQrF7OWyTG0vPbzZZU
         dRK0rmoRfTt0BXP9Vg5X6nHbQZqxgb1fSLis2oIhN8V8PFMgPj6yK6b9U+6suqx3f8
         sMsFfuId2l+y9PBaO0vp0j8t0P93Vu6p9JFA6Tea+M4tP/kGaxVgO7Tg/VZB4sgfcB
         dTsFF5/Wk3zwA==
Received: by mail-ot1-f41.google.com with SMTP id 34-20020a9d0325000000b00552cae0decbso1240841otv.0;
        Tue, 19 Oct 2021 00:01:14 -0700 (PDT)
X-Gm-Message-State: AOAM530VhIE8Q9qmTbDx9MRCtxEi09nt/EMF5K8mPvGsd6E+YloG5cY/
        wEzXClK9x+bbz48P5NT5ONUKOQmTe6fIfzWUXEU=
X-Google-Smtp-Source: ABdhPJymjcl+It0ToY7DQK4sP+e0BUZFLur21MK3HrEaeJzR8K7KPxyn64yg9VuHuGbdf8ImkTE7pfnH4j3QDG3odmM=
X-Received: by 2002:a05:6830:561:: with SMTP id f1mr3929996otc.30.1634626873733;
 Tue, 19 Oct 2021 00:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211019062024.2171074-1-hch@lst.de> <20211019062024.2171074-4-hch@lst.de>
In-Reply-To: <20211019062024.2171074-4-hch@lst.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 19 Oct 2021 09:01:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFuMtfyEyTUoVaFaSdOgZTC99CVy4M_XWYms8gFaE94fg@mail.gmail.com>
Message-ID: <CAMj1kXFuMtfyEyTUoVaFaSdOgZTC99CVy4M_XWYms8gFaE94fg@mail.gmail.com>
Subject: Re: [PATCH 3/3] partitions/ibm: use bdev_nr_sectors instead of open
 coding it
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        "open list:S390" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 19 Oct 2021 at 08:20, Christoph Hellwig <hch@lst.de> wrote:
>
> Use the proper helper to read the block device size and switch various
> places to pass the size in terms of sectors which is more practical.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/partitions/ibm.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
> index 9bca396aef4ad..d56912fe81732 100644
> --- a/block/partitions/ibm.c
> +++ b/block/partitions/ibm.c
> @@ -198,7 +198,7 @@ static int find_lnx1_partitions(struct parsed_partitions *state,
>                                 char name[],
>                                 union label_t *label,
>                                 sector_t labelsect,
> -                               loff_t i_size,
> +                               sector_t nr_sectors,
>                                 dasd_information2_t *info)
>  {
>         loff_t offset, geo_size, size;
> @@ -213,14 +213,14 @@ static int find_lnx1_partitions(struct parsed_partitions *state,
>         } else {
>                 /*
>                  * Formated w/o large volume support. If the sanity check
> -                * 'size based on geo == size based on i_size' is true, then
> +                * 'size based on geo == size based on br_sectors' is true,

nr_sectors

>                  * we can safely assume that we know the formatted size of
>                  * the disk, otherwise we need additional information
>                  * that we can only get from a real DASD device.
>                  */
>                 geo_size = geo->cylinders * geo->heads
>                         * geo->sectors * secperblk;
> -               size = i_size >> 9;
> +               size = nr_sectors;
>                 if (size != geo_size) {
>                         if (!info) {
>                                 strlcat(state->pp_buf, "\n", PAGE_SIZE);
> @@ -229,7 +229,7 @@ static int find_lnx1_partitions(struct parsed_partitions *state,
>                         if (!strcmp(info->type, "ECKD"))
>                                 if (geo_size < size)
>                                         size = geo_size;
> -                       /* else keep size based on i_size */
> +                       /* else keep size based on nr_sectors */
>                 }
>         }
>         /* first and only partition starts in the first block after the label */
> @@ -293,7 +293,8 @@ int ibm_partition(struct parsed_partitions *state)
>         struct gendisk *disk = state->disk;
>         struct block_device *bdev = disk->part0;
>         int blocksize, res;
> -       loff_t i_size, offset, size;
> +       loff_t offset, size;
> +       sector_t nr_sectors;
>         dasd_information2_t *info;
>         struct hd_geometry *geo;
>         char type[5] = {0,};
> @@ -308,8 +309,8 @@ int ibm_partition(struct parsed_partitions *state)
>         blocksize = bdev_logical_block_size(bdev);
>         if (blocksize <= 0)
>                 goto out_symbol;
> -       i_size = i_size_read(bdev->bd_inode);
> -       if (i_size == 0)
> +       nr_sectors = bdev_nr_sectors(bdev);
> +       if (nr_sectors == 0)
>                 goto out_symbol;
>         info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
>         if (info == NULL)
> @@ -336,7 +337,7 @@ int ibm_partition(struct parsed_partitions *state)
>                                                    label);
>                 } else if (!strncmp(type, "LNX1", 4)) {
>                         res = find_lnx1_partitions(state, geo, blocksize, name,
> -                                                  label, labelsect, i_size,
> +                                                  label, labelsect, nr_sectors,
>                                                    info);
>                 } else if (!strncmp(type, "CMS1", 4)) {
>                         res = find_cms1_partitions(state, geo, blocksize, name,
> @@ -353,7 +354,7 @@ int ibm_partition(struct parsed_partitions *state)
>                 res = 1;
>                 if (info->format == DASD_FORMAT_LDL) {
>                         strlcat(state->pp_buf, "(nonl)", PAGE_SIZE);
> -                       size = i_size >> 9;
> +                       size = nr_sectors;
>                         offset = (info->label_block + 1) * (blocksize >> 9);
>                         put_partition(state, 1, offset, size-offset);
>                         strlcat(state->pp_buf, "\n", PAGE_SIZE);
> --
> 2.30.2
>

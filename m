Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBE2622697
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 10:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiKIJQf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 04:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKIJPy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 04:15:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957EB205C4;
        Wed,  9 Nov 2022 01:14:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 324F261957;
        Wed,  9 Nov 2022 09:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90769C43142;
        Wed,  9 Nov 2022 09:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667985241;
        bh=1W7y9ZW1Hi3m7nzUlgOvpMez/79lPrfWcH4WKvc4GYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IoVQ87wHgCKhe7NJPYn1Q9n4firiWtp84exzCcBDRRMAcpZzefPsvJF282Un+alQ2
         wgJExUecSE++y1Bh/7v7UfJiuSdWSMDZ8JUn3aEHMA8RBZN5D9O8aRrsJPxun09f1H
         gpqyGB4UW5g3hH+QtGrpyDeNefrWH01ZY3cqMwets+JkHeolP8eKxiKBquy0u4oLi6
         pRC+9A4zqnX2bQkC6HP1GwmcW4h4GULjmQJjTzm4TjIJXnGojZR1ZDCn+lWDeqjZhH
         3PEzXX3d6hpRRuZt+pGOGFpvH0k5+rwP9JQdRrUM2V4MgzDrPxY7K4qyxF+iEQeylZ
         f0BOir1l93BgQ==
Received: by mail-lf1-f46.google.com with SMTP id d6so24734169lfs.10;
        Wed, 09 Nov 2022 01:14:01 -0800 (PST)
X-Gm-Message-State: ACrzQf1FjrfTxSsz99+6XWgqt7kFZ8S+KTmdknlXIe/Z0bgVy3OOi9HX
        PZncVMs8Die7il4nR1aueQcuZWzLVmpZZGlI+Jo=
X-Google-Smtp-Source: AMsMyM6nqNV8lABCm89TT5c/zWYEWvJqOcSZ+FOSDLV6ElwxEHIAXpfQWy3RsxJUbhi/BY42rofI3671iASHp2Xf1Vk=
X-Received: by 2002:a05:6512:151b:b0:4af:e7d3:4a46 with SMTP id
 bq27-20020a056512151b00b004afe7d34a46mr19965857lfb.583.1667985239507; Wed, 09
 Nov 2022 01:13:59 -0800 (PST)
MIME-Version: 1.0
References: <Y2rgVIbtuDsySzBr@makrotopia.org>
In-Reply-To: <Y2rgVIbtuDsySzBr@makrotopia.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Nov 2022 10:13:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG3UWUP-inYHNibJyuJfQwGzfQH8QvJqBNHZgyLc1a+6A@mail.gmail.com>
Message-ID: <CAMj1kXG3UWUP-inYHNibJyuJfQwGzfQH8QvJqBNHZgyLc1a+6A@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] partitions/efi: add support for uImage.FIT sub-partitions
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Nov 2022 at 00:05, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Add new GUID allowing to parse uImage.FIT stored in a GPT partition
> and map filesystem sub-image as sub-partitions.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

I'm not sure I follow the logic here.

You are adding uImage.FIT support as a pseudo-partition type right?
And the only partition driver that supports it is GPT?

Does that mean that all the other types would need a similar change to
be able to detect these subvolumes?

> ---
>  block/partitions/efi.c | 9 +++++++++
>  block/partitions/efi.h | 3 +++
>  2 files changed, 12 insertions(+)
>
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index 5e9be13a56a8..bf87893eabe4 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -716,6 +716,9 @@ int efi_partition(struct parsed_partitions *state)
>         gpt_entry *ptes = NULL;
>         u32 i;
>         unsigned ssz = queue_logical_block_size(state->disk->queue) / 512;
> +#ifdef CONFIG_FIT_PARTITION
> +       u32 extra_slot = 65;
> +#endif
>
>         if (!find_valid_gpt(state, &gpt, &ptes) || !gpt || !ptes) {
>                 kfree(gpt);
> @@ -749,6 +752,12 @@ int efi_partition(struct parsed_partitions *state)
>                                 ARRAY_SIZE(ptes[i].partition_name));
>                 utf16_le_to_7bit(ptes[i].partition_name, label_max, info->volname);
>                 state->parts[i + 1].has_info = true;
> +               /* If this is a U-Boot FIT volume it may have subpartitions */
> +#ifdef CONFIG_FIT_PARTITION
> +               if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_FIT_GUID))
> +                       (void) parse_fit_partitions(state, start * ssz, size * ssz,
> +                                                   &extra_slot, 127, 1);
> +#endif
>         }
>         kfree(ptes);
>         kfree(gpt);
> diff --git a/block/partitions/efi.h b/block/partitions/efi.h
> index 84b9f36b9e47..06c11f6ae398 100644
> --- a/block/partitions/efi.h
> +++ b/block/partitions/efi.h
> @@ -51,6 +51,9 @@
>  #define PARTITION_LINUX_LVM_GUID \
>      EFI_GUID( 0xe6d6d379, 0xf507, 0x44c2, \
>                0xa2, 0x3c, 0x23, 0x8f, 0x2a, 0x3d, 0xf9, 0x28)
> +#define PARTITION_LINUX_FIT_GUID \
> +    EFI_GUID( 0xcae9be83, 0xb15f, 0x49cc, \
> +              0x86, 0x3f, 0x08, 0x1b, 0x74, 0x4a, 0x2d, 0x93)
>
>  typedef struct _gpt_header {
>         __le64 signature;
> --
> 2.38.1
>

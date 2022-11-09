Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32B1622ABA
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 12:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKILkw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 06:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKILkv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 06:40:51 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45440264B7;
        Wed,  9 Nov 2022 03:40:50 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1osjRQ-0007kT-Bq; Wed, 09 Nov 2022 12:40:24 +0100
Date:   Wed, 9 Nov 2022 11:40:21 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH v4 3/5] partitions/efi: add support for uImage.FIT
 sub-partitions
Message-ID: <Y2uRpY8QVZMZlMCo@makrotopia.org>
References: <Y2rgVIbtuDsySzBr@makrotopia.org>
 <CAMj1kXG3UWUP-inYHNibJyuJfQwGzfQH8QvJqBNHZgyLc1a+6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG3UWUP-inYHNibJyuJfQwGzfQH8QvJqBNHZgyLc1a+6A@mail.gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 09, 2022 at 10:13:48AM +0100, Ard Biesheuvel wrote:
> On Wed, 9 Nov 2022 at 00:05, Daniel Golle <daniel@makrotopia.org> wrote:
> >
> > Add new GUID allowing to parse uImage.FIT stored in a GPT partition
> > and map filesystem sub-image as sub-partitions.
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> I'm not sure I follow the logic here.
> 
> You are adding uImage.FIT support as a pseudo-partition type right?

Yes, exactly.

> And the only partition driver that supports it is GPT?

Support for uImage.FIT subvolumes is added only for GPT partitions for
now. Being the most flexible/modern partition table type I don't think
anything else is actually relevant for new designs.

In other patches in the series following this one I also want to allow
enabling scanning for partitions on mtdblock and ubiblock devices.

On embedded devices with raw NOR or NAND storage those can then be used
to directly store a uImage.FIT and the FIT partition parsers is then
used on that whole block device, mapping the filesystem sub-image(s)
as mtdblockXpY or ubiblockXpY.

> 
> Does that mean that all the other types would need a similar change to
> be able to detect these subvolumes?

If you wanted to support uImage.FIT subvolumes inside other types of
partitions, then yes, this would have to be implemented for those as
well.

I've also written a (not very clean) implementation of that for MBR
partitions, it is needed e.g. on MT7623 because one cannot use GPT on
the block device used for booting with that SoC as the BootROM expects
to load the preloader exactly from where GPT would be located...
I wasn't planning on submitting that upstream though.

And other than for GPT and MBR, I don't think implementing detection of
uImage.FIT subvolumes makes any sense (but maybe I got something wrong
here or didn't fully understand your question).

> 
> > ---
> >  block/partitions/efi.c | 9 +++++++++
> >  block/partitions/efi.h | 3 +++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> > index 5e9be13a56a8..bf87893eabe4 100644
> > --- a/block/partitions/efi.c
> > +++ b/block/partitions/efi.c
> > @@ -716,6 +716,9 @@ int efi_partition(struct parsed_partitions *state)
> >         gpt_entry *ptes = NULL;
> >         u32 i;
> >         unsigned ssz = queue_logical_block_size(state->disk->queue) / 512;
> > +#ifdef CONFIG_FIT_PARTITION
> > +       u32 extra_slot = 65;
> > +#endif
> >
> >         if (!find_valid_gpt(state, &gpt, &ptes) || !gpt || !ptes) {
> >                 kfree(gpt);
> > @@ -749,6 +752,12 @@ int efi_partition(struct parsed_partitions *state)
> >                                 ARRAY_SIZE(ptes[i].partition_name));
> >                 utf16_le_to_7bit(ptes[i].partition_name, label_max, info->volname);
> >                 state->parts[i + 1].has_info = true;
> > +               /* If this is a U-Boot FIT volume it may have subpartitions */
> > +#ifdef CONFIG_FIT_PARTITION
> > +               if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_FIT_GUID))
> > +                       (void) parse_fit_partitions(state, start * ssz, size * ssz,
> > +                                                   &extra_slot, 127, 1);
> > +#endif
> >         }
> >         kfree(ptes);
> >         kfree(gpt);
> > diff --git a/block/partitions/efi.h b/block/partitions/efi.h
> > index 84b9f36b9e47..06c11f6ae398 100644
> > --- a/block/partitions/efi.h
> > +++ b/block/partitions/efi.h
> > @@ -51,6 +51,9 @@
> >  #define PARTITION_LINUX_LVM_GUID \
> >      EFI_GUID( 0xe6d6d379, 0xf507, 0x44c2, \
> >                0xa2, 0x3c, 0x23, 0x8f, 0x2a, 0x3d, 0xf9, 0x28)
> > +#define PARTITION_LINUX_FIT_GUID \
> > +    EFI_GUID( 0xcae9be83, 0xb15f, 0x49cc, \
> > +              0x86, 0x3f, 0x08, 0x1b, 0x74, 0x4a, 0x2d, 0x93)
> >
> >  typedef struct _gpt_header {
> >         __le64 signature;
> > --
> > 2.38.1
> >

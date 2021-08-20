Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793343F2835
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 10:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhHTIR6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 04:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhHTIRt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Aug 2021 04:17:49 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42815C061760
        for <linux-efi@vger.kernel.org>; Fri, 20 Aug 2021 01:17:12 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id bb10so2260663vkb.9
        for <linux-efi@vger.kernel.org>; Fri, 20 Aug 2021 01:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5t+2Oo5yym0OJ3etipsjRBTyv7Vn0GjQI8wMxvms5k=;
        b=mxFXngFqSxmVJjIcBJy/PJZ2TZWD4D5JgMEkMuzRL0oGlZFRZ9zL5SwmdMPPbE/vma
         1AO5vPktkKK5CNZ9usJdbW1SXZqYKUV1u08LPaDbkMtiuPINpDQkHiReRpZPx7D0EbQY
         AU1ZC/2cX+ZExtSdZHMcBho5essfmpQhJC/a9JQNHFoGhaM1IcsP0fRD3H1fbSYqbkwd
         Pq3YFwLf1qU9W9gP57vSn2z+//1jkgMXqbL83W5GWBPSxtZGnfCH3mzyC2cnjdPojhiZ
         yQTL5cY980LMxa4KnuBnXmE6o72yA6dNoXoeceG9wooQSrV5DCP//ide8LOdfVNJdLoG
         quog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5t+2Oo5yym0OJ3etipsjRBTyv7Vn0GjQI8wMxvms5k=;
        b=BAUqVyjlS8DVDhl8lavYvfef7tSQDH71iAoMUJ3ITTQlxpAijS6cPtS/lVOZVsp9z3
         pdTXpuHAndWMAj7DZ9m9DT76SnQV3CLUZfE/Y/FuNP8Sw8RbxBocLUMPUxEef1BSDNom
         zQSHqeNsASe9Ipz78Eca99f0WyL9LBSGzsydccV1Q6eepeaFIKNuLGt6Ew6CYlyZhPvs
         njEPOktzFuOgI79JXVmtB/MgCXqS7JG6cN1EGio8qdRSzk/LxOZ6+4nqAtlc++gr9HCJ
         Fl+o9LO3NWnw1KNTSFpEMKKvVg3Xg2w1yHHXZaKxFMhMCnReQD4eB1pAJBtUcMQCkHKt
         siLg==
X-Gm-Message-State: AOAM531v8Cr73LRhO14r+n1DUUZ9QHhMxHKjUmFPANeQp8DR02SZLq5C
        gZuq+ccD0FnXQMVibR2ckY2uwzYlZTk/suiLRnRF9A==
X-Google-Smtp-Source: ABdhPJwnXcF5jSuimmLI3XIw81d0SDbFuLoIO4o4UILtPyGEj2uz+uCsImanEERqS9WiyHwD5N9GEei+p0qvMLjeqbs=
X-Received: by 2002:a1f:a555:: with SMTP id o82mr14607010vke.8.1629447430991;
 Fri, 20 Aug 2021 01:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210818005547.14497-1-digetx@gmail.com> <20210818005547.14497-5-digetx@gmail.com>
 <CAPDyKFqQbe4k-Sem436Fzsr6mbvwZr83VtEaEZTF8oWYoHHQwg@mail.gmail.com>
 <YR0MrlxFLTpsR628@orome.fritz.box> <CAPDyKFpObGwWhnwDKG59wdt6Pr35DodogXbDjzPJGoshMD7piQ@mail.gmail.com>
 <YR6SuVxJ37IoxyBF@orome.fritz.box>
In-Reply-To: <YR6SuVxJ37IoxyBF@orome.fritz.box>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Aug 2021 10:16:34 +0200
Message-ID: <CAPDyKFoT3Qw47ecnZbhBtGNB=NruWW9VnKPEb+ST3ozX4H+-sA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] mmc: sdhci-tegra: Implement alternative_gpt_sector()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, Jens Axboe <axboe@kernel.dk>,
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

On Thu, 19 Aug 2021 at 19:19, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Thu, Aug 19, 2021 at 03:20:57PM +0200, Ulf Hansson wrote:
> > On Wed, 18 Aug 2021 at 15:35, Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > On Wed, Aug 18, 2021 at 11:55:05AM +0200, Ulf Hansson wrote:
> > > > On Wed, 18 Aug 2021 at 02:57, Dmitry Osipenko <digetx@gmail.com> wrote:
> > > > >
> > > > > Tegra20/30/114/124 Android devices place GPT at a non-standard location.
> > > > > Implement alternative_gpt_sector() callback of the MMC host ops which
> > > > > specifies that GPT location for the partition scanner.
> > > > >
> > > > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > > ---
> > > > >  drivers/mmc/host/sdhci-tegra.c | 42 ++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 42 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > > > > index 387ce9cdbd7c..24a713689d5b 100644
> > > > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > > > @@ -116,6 +116,8 @@
> > > > >   */
> > > > >  #define NVQUIRK_HAS_TMCLK                              BIT(10)
> > > > >
> > > > > +#define NVQUIRK_HAS_ANDROID_GPT_SECTOR                 BIT(11)
> > > > > +
> > > > >  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
> > > > >  #define SDHCI_TEGRA_CQE_BASE_ADDR                      0xF000
> > > > >
> > > > > @@ -1361,6 +1363,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
> > > > >         .pdata = &sdhci_tegra20_pdata,
> > > > >         .dma_mask = DMA_BIT_MASK(32),
> > > > >         .nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
> > > > > +                   NVQUIRK_HAS_ANDROID_GPT_SECTOR |
> > > > >                     NVQUIRK_ENABLE_BLOCK_GAP_DET,
> > > > >  };
> > > > >
> > > > > @@ -1390,6 +1393,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
> > > > >         .nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
> > > > >                     NVQUIRK_ENABLE_SDR50 |
> > > > >                     NVQUIRK_ENABLE_SDR104 |
> > > > > +                   NVQUIRK_HAS_ANDROID_GPT_SECTOR |
> > > > >                     NVQUIRK_HAS_PADCALIB,
> > > > >  };
> > > > >
> > > > > @@ -1422,6 +1426,7 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
> > > > >  static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
> > > > >         .pdata = &sdhci_tegra114_pdata,
> > > > >         .dma_mask = DMA_BIT_MASK(32),
> > > > > +       .nvquirks = NVQUIRK_HAS_ANDROID_GPT_SECTOR,
> > > > >  };
> > > > >
> > > > >  static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
> > > > > @@ -1438,6 +1443,7 @@ static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
> > > > >  static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
> > > > >         .pdata = &sdhci_tegra124_pdata,
> > > > >         .dma_mask = DMA_BIT_MASK(34),
> > > > > +       .nvquirks = NVQUIRK_HAS_ANDROID_GPT_SECTOR,
> > > > >  };
> > > > >
> > > > >  static const struct sdhci_ops tegra210_sdhci_ops = {
> > > > > @@ -1590,6 +1596,38 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > +static int sdhci_tegra_alternative_gpt_sector(struct mmc_card *card,
> > > > > +                                             sector_t *gpt_sector)
> > > > > +{
> > > > > +       unsigned int boot_sectors_num;
> > > > > +
> > > > > +       /* filter out unrelated cards */
> > > > > +       if (card->ext_csd.rev < 3 ||
> > > > > +           !mmc_card_mmc(card) ||
> > > > > +           !mmc_card_is_blockaddr(card) ||
> > > > > +            mmc_card_is_removable(card->host))
> > > > > +               return -ENOENT;
> > > > > +
> > > > > +       /*
> > > > > +        * eMMC storage has two special boot partitions in addition to the
> > > > > +        * main one.  NVIDIA's bootloader linearizes eMMC boot0->boot1->main
> > > > > +        * accesses, this means that the partition table addresses are shifted
> > > > > +        * by the size of boot partitions.  In accordance with the eMMC
> > > > > +        * specification, the boot partition size is calculated as follows:
> > > > > +        *
> > > > > +        *      boot partition size = 128K byte x BOOT_SIZE_MULT
> > > > > +        *
> > > > > +        * Calculate number of sectors occupied by the both boot partitions.
> > > > > +        */
> > > > > +       boot_sectors_num = card->ext_csd.raw_boot_mult * SZ_128K /
> > > > > +                          SZ_512 * MMC_NUM_BOOT_PARTITION;
> > > > > +
> > > > > +       /* Defined by NVIDIA and used by Android devices. */
> > > > > +       *gpt_sector = card->ext_csd.sectors - boot_sectors_num - 1;
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > >
> > > > I suggest you move this code into the mmc core/block layer instead (it
> > > > better belongs there).
> > > >
> > > > Additionally, let's add a new host cap, MMC_CAP_ALTERNATIVE_GPT, to
> > > > let the core know when it should use the code above.
> > >
> > > Couldn't a generic "alternative GPT" mean pretty much anything? As far
> > > as I know this is very specific to a series of Tegra chips and firmware
> > > running on them. On some of these devices you can even replace the OEM
> > > firmware by something custom that's less quirky.
> >
> > Good point!
> >
> > Perhaps naming the cap MMC_CAP_TEGRA_GPT would make this more clear.
>
> Yeah, that sounds like a better name. Or if people are hung up on
> "alternative", perhaps MMC_CAP_ALTERNATIVE_GPT_TEGRA.

That works too. Dmitry can pick what he prefers.

>
> > > I'm not aware of anyone else employing this kind of quirk, so I don't
> > > want anyone to get any ideas that this is a good thing. Putting it into
> > > the core runs the risk of legitimizing this.
> >
> > I certainly don't want to legitimize this. But no matter what, that is
> > exactly what we are doing, anyways.
>
> I think there's a difference between supporting a quirk and legitimizing
> it. I certainly would hate for anyone to come across this "feature" and
> then go: "Oh, this is neat, let's implement this on our new platform!".
>
> > In summary, I still prefer code to be put in their proper layers, and
> > there aren't any host specific things going on here, except for
> > parsing a compatible string.
>
> Fair enough. Perhaps if we put enough warnings in the comments
> surrounding this and are vigilant enough during code review we can
> prevent this from proliferating. Obviously, once somebody implements
> this in their flash/boot stack, it can become difficult to change it,
> so by the time we get to review the kernel bits it might already be
> set in stone.

Sure, good idea. Some recommendations in the form of comments in the
code would be nice.

>
> Then again, like you hinted at already, once we support it, we support
> it. So no real harm is done if anyone copies this.
>
> I don't exactly know how this came about in the first place, but it's
> pretty exotic, so I doubt that anyone else will come up with something
> like this anytime soon.

Hopefully, but who knows. :-)

In the end, I think a lot of these homebrewed flash layouts, have been
invented to store bootbinararies in a robust way, tolerating data loss
and sudden power failures.

That said, let me take the opportunity to highlight the work
ARM/Linaro is doing on EBBR [1]. We should have done that many years
ago, but better late than never.

Kind regards
Uffe

[1] EBBR - Embedded Base Boot Requirements
https://github.com/ARM-software/ebbr

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8B23F1A43
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 15:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhHSNWM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 09:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239990AbhHSNWK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 09:22:10 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B49CC061575
        for <linux-efi@vger.kernel.org>; Thu, 19 Aug 2021 06:21:34 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id a201so4010664vsd.3
        for <linux-efi@vger.kernel.org>; Thu, 19 Aug 2021 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hf1yJDYIDGADSw5A4tH23JVq6j6wfNQ2ElnJXlKhovQ=;
        b=cXNkUsEngfNONv9xhaw53/XRtaqkqhBK66EA61+iNDvrWHfa7y28Pylj8ZQ0+Rwv/j
         h0ftvfRWCFxdFMYqLs6ehB9raQ6lFqFpj9yczIf+Nf5CbB1xoSjOy9c0oPWSvd9fiOS7
         Bmle4ujkj1j82g8qlJiGbcrkmq63313H9DDNnWvne5YF8l2NampiEg/657xVQsznvvdz
         bC64D0loGf9OlFmy6X51u3SXmhXrxk4sxvFg6EBnNn6MZDEp75/YMLpR5u5TZjLLgvBC
         26GPB68eUIaw71qGi5455oTaMtSR3GqKuCETlHwGbzv2IAJAWplW8LsZxSW9IGDzODuP
         36ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hf1yJDYIDGADSw5A4tH23JVq6j6wfNQ2ElnJXlKhovQ=;
        b=onV0LJml6f/EN28N9xz5E1+evhw/2iajQNlRvI5/wx3U9x4kCLkFQGrpm66s5N6H7r
         k+uOr4rvYFK1wDBFe1H6gylbuBTF1DidNtH+i8aex9UPsSsjm9iriz+NUzrmqHRTicOD
         LLnt1UY0OHJVXy2Ry0iaWVSJDt+b1FdrHLXG3tuP8pvkHFW0KyO0RiuaMXmRhJcXsD3+
         we/+42hSCnLDZibJKISNVICXGvN49K1tMfFkfqJQNQaipt+SZYkrfuAtVmlL4ePyqpHJ
         K1531SShipzq5nIrfcjXAyytw8JRlimRYbDokkkvPQyuLXqgI0by7oQ+sb0Q3lgueGQJ
         qxpw==
X-Gm-Message-State: AOAM530sf35MKMJjf69oNofN+cuadGkaRJBpkRoZIjqxBPHTCycRlc3h
        UJblv33lZJb2YOqFUxUSay3ZShE9/YeermyFFQfFyQ==
X-Google-Smtp-Source: ABdhPJwuuqiFukYJzvrQOxOwpI3rwad1HDjWXxDECbZgyWZWjHPEUwn3rqOes1yZ/d8dHbJKY0dEKgFucV1GTbcf2lM=
X-Received: by 2002:a67:f6d8:: with SMTP id v24mr12359854vso.48.1629379293738;
 Thu, 19 Aug 2021 06:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210818005547.14497-1-digetx@gmail.com> <20210818005547.14497-5-digetx@gmail.com>
 <CAPDyKFqQbe4k-Sem436Fzsr6mbvwZr83VtEaEZTF8oWYoHHQwg@mail.gmail.com> <YR0MrlxFLTpsR628@orome.fritz.box>
In-Reply-To: <YR0MrlxFLTpsR628@orome.fritz.box>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Aug 2021 15:20:57 +0200
Message-ID: <CAPDyKFpObGwWhnwDKG59wdt6Pr35DodogXbDjzPJGoshMD7piQ@mail.gmail.com>
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

On Wed, 18 Aug 2021 at 15:35, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Aug 18, 2021 at 11:55:05AM +0200, Ulf Hansson wrote:
> > On Wed, 18 Aug 2021 at 02:57, Dmitry Osipenko <digetx@gmail.com> wrote:
> > >
> > > Tegra20/30/114/124 Android devices place GPT at a non-standard location.
> > > Implement alternative_gpt_sector() callback of the MMC host ops which
> > > specifies that GPT location for the partition scanner.
> > >
> > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > ---
> > >  drivers/mmc/host/sdhci-tegra.c | 42 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > > index 387ce9cdbd7c..24a713689d5b 100644
> > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > @@ -116,6 +116,8 @@
> > >   */
> > >  #define NVQUIRK_HAS_TMCLK                              BIT(10)
> > >
> > > +#define NVQUIRK_HAS_ANDROID_GPT_SECTOR                 BIT(11)
> > > +
> > >  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
> > >  #define SDHCI_TEGRA_CQE_BASE_ADDR                      0xF000
> > >
> > > @@ -1361,6 +1363,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
> > >         .pdata = &sdhci_tegra20_pdata,
> > >         .dma_mask = DMA_BIT_MASK(32),
> > >         .nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
> > > +                   NVQUIRK_HAS_ANDROID_GPT_SECTOR |
> > >                     NVQUIRK_ENABLE_BLOCK_GAP_DET,
> > >  };
> > >
> > > @@ -1390,6 +1393,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
> > >         .nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
> > >                     NVQUIRK_ENABLE_SDR50 |
> > >                     NVQUIRK_ENABLE_SDR104 |
> > > +                   NVQUIRK_HAS_ANDROID_GPT_SECTOR |
> > >                     NVQUIRK_HAS_PADCALIB,
> > >  };
> > >
> > > @@ -1422,6 +1426,7 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
> > >  static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
> > >         .pdata = &sdhci_tegra114_pdata,
> > >         .dma_mask = DMA_BIT_MASK(32),
> > > +       .nvquirks = NVQUIRK_HAS_ANDROID_GPT_SECTOR,
> > >  };
> > >
> > >  static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
> > > @@ -1438,6 +1443,7 @@ static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
> > >  static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
> > >         .pdata = &sdhci_tegra124_pdata,
> > >         .dma_mask = DMA_BIT_MASK(34),
> > > +       .nvquirks = NVQUIRK_HAS_ANDROID_GPT_SECTOR,
> > >  };
> > >
> > >  static const struct sdhci_ops tegra210_sdhci_ops = {
> > > @@ -1590,6 +1596,38 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
> > >         return ret;
> > >  }
> > >
> > > +static int sdhci_tegra_alternative_gpt_sector(struct mmc_card *card,
> > > +                                             sector_t *gpt_sector)
> > > +{
> > > +       unsigned int boot_sectors_num;
> > > +
> > > +       /* filter out unrelated cards */
> > > +       if (card->ext_csd.rev < 3 ||
> > > +           !mmc_card_mmc(card) ||
> > > +           !mmc_card_is_blockaddr(card) ||
> > > +            mmc_card_is_removable(card->host))
> > > +               return -ENOENT;
> > > +
> > > +       /*
> > > +        * eMMC storage has two special boot partitions in addition to the
> > > +        * main one.  NVIDIA's bootloader linearizes eMMC boot0->boot1->main
> > > +        * accesses, this means that the partition table addresses are shifted
> > > +        * by the size of boot partitions.  In accordance with the eMMC
> > > +        * specification, the boot partition size is calculated as follows:
> > > +        *
> > > +        *      boot partition size = 128K byte x BOOT_SIZE_MULT
> > > +        *
> > > +        * Calculate number of sectors occupied by the both boot partitions.
> > > +        */
> > > +       boot_sectors_num = card->ext_csd.raw_boot_mult * SZ_128K /
> > > +                          SZ_512 * MMC_NUM_BOOT_PARTITION;
> > > +
> > > +       /* Defined by NVIDIA and used by Android devices. */
> > > +       *gpt_sector = card->ext_csd.sectors - boot_sectors_num - 1;
> > > +
> > > +       return 0;
> > > +}
> >
> > I suggest you move this code into the mmc core/block layer instead (it
> > better belongs there).
> >
> > Additionally, let's add a new host cap, MMC_CAP_ALTERNATIVE_GPT, to
> > let the core know when it should use the code above.
>
> Couldn't a generic "alternative GPT" mean pretty much anything? As far
> as I know this is very specific to a series of Tegra chips and firmware
> running on them. On some of these devices you can even replace the OEM
> firmware by something custom that's less quirky.

Good point!

Perhaps naming the cap MMC_CAP_TEGRA_GPT would make this more clear.

>
> I'm not aware of anyone else employing this kind of quirk, so I don't
> want anyone to get any ideas that this is a good thing. Putting it into
> the core runs the risk of legitimizing this.

I certainly don't want to legitimize this. But no matter what, that is
exactly what we are doing, anyways.

In summary, I still prefer code to be put in their proper layers, and
there aren't any host specific things going on here, except for
parsing a compatible string.

Kind regards
Uffe

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B613F04E9
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhHRNgV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 09:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhHRNgV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 09:36:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B4FC061764;
        Wed, 18 Aug 2021 06:35:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f10so1658554wml.2;
        Wed, 18 Aug 2021 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DthKa3X7J67lnJcE+psAH6WMu5xghWQjfpmVnxuXZkY=;
        b=OWvsLPklkVuXUzGcq4Vn3RTniheuYd18rv8U5574kX+IKGwv1GBfM155sk38FXNsm+
         rf7GVlZQAtaMVDU8bp33wvLuf5eqKDUgw8WjjuiOHJ/M19p0Bok0vYS+v2/5VIbXfTeh
         eJgXvVaPKvlzFdOdYvIA12H8JjMcc+nRa7Mtp8c4TyZ55x1k2swUOjkJShmfFoBbJUFF
         VTt7yzFdD+O1nuy42z2eweiTPZ9NHxOD5L/WAEggh68YUUINHEqeAAZuyM+2srsn2eZp
         wQ4acy31yprABVEZPaOnRU1h54ETEPbiFt282HD4Ke/Mp7uFNtHSjVf5/y58KqaMjh9k
         qjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DthKa3X7J67lnJcE+psAH6WMu5xghWQjfpmVnxuXZkY=;
        b=al8Oxa0Xd5gjmlDe9mEE/Ovn9+QwTrZJaE+cUlHv07GsK0bywFz+mitrY8hQG4bRoo
         GJcJ7vC1yY+pEXWkGG1AUJ+FT12tk0j0G+RGvvjcpjHcH1I0wKx1iv6piFSpjBVWudWX
         CkHW6Kf4Nd+1VAPDUjtexHGQ6q8+u4AXJYpy04o4h3t60QAdBDztGkxesvqjniR4ZzCY
         Bcl3fRUZ4jb/ZqK06EN+mS19VwA/EXU77/SszT55gXf8U5eNbxOuWj/OkVJEoU6tjUpX
         Q72twTTCJ337C3THpu+T6/LVTGFF3sfSOxnIBGBt+ySaObQWCYKmbQCjgQUW58OoJPZ0
         Y8vQ==
X-Gm-Message-State: AOAM532P8UrzTgRgFIH0qc5kF3rmz1MYgTvns7QbmQ4nW0R4T/r6lHd3
        byvHvruZV42ZITDA2rDJt1E=
X-Google-Smtp-Source: ABdhPJyC6Z3pw7oMHgghz75BdjG+2G4bMawsJFPJhR70xadEWmNlssYvZAFSY1W/ckwoxrb/IUBoGA==
X-Received: by 2002:a1c:23d6:: with SMTP id j205mr8818671wmj.185.1629293744832;
        Wed, 18 Aug 2021 06:35:44 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id r129sm5255234wmr.7.2021.08.18.06.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 06:35:43 -0700 (PDT)
Date:   Wed, 18 Aug 2021 15:35:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
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
Subject: Re: [PATCH v5 4/5] mmc: sdhci-tegra: Implement
 alternative_gpt_sector()
Message-ID: <YR0MrlxFLTpsR628@orome.fritz.box>
References: <20210818005547.14497-1-digetx@gmail.com>
 <20210818005547.14497-5-digetx@gmail.com>
 <CAPDyKFqQbe4k-Sem436Fzsr6mbvwZr83VtEaEZTF8oWYoHHQwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YsFHapze9CfLadea"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqQbe4k-Sem436Fzsr6mbvwZr83VtEaEZTF8oWYoHHQwg@mail.gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--YsFHapze9CfLadea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 18, 2021 at 11:55:05AM +0200, Ulf Hansson wrote:
> On Wed, 18 Aug 2021 at 02:57, Dmitry Osipenko <digetx@gmail.com> wrote:
> >
> > Tegra20/30/114/124 Android devices place GPT at a non-standard location.
> > Implement alternative_gpt_sector() callback of the MMC host ops which
> > specifies that GPT location for the partition scanner.
> >
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 42 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-te=
gra.c
> > index 387ce9cdbd7c..24a713689d5b 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -116,6 +116,8 @@
> >   */
> >  #define NVQUIRK_HAS_TMCLK                              BIT(10)
> >
> > +#define NVQUIRK_HAS_ANDROID_GPT_SECTOR                 BIT(11)
> > +
> >  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
> >  #define SDHCI_TEGRA_CQE_BASE_ADDR                      0xF000
> >
> > @@ -1361,6 +1363,7 @@ static const struct sdhci_tegra_soc_data soc_data=
_tegra20 =3D {
> >         .pdata =3D &sdhci_tegra20_pdata,
> >         .dma_mask =3D DMA_BIT_MASK(32),
> >         .nvquirks =3D NVQUIRK_FORCE_SDHCI_SPEC_200 |
> > +                   NVQUIRK_HAS_ANDROID_GPT_SECTOR |
> >                     NVQUIRK_ENABLE_BLOCK_GAP_DET,
> >  };
> >
> > @@ -1390,6 +1393,7 @@ static const struct sdhci_tegra_soc_data soc_data=
_tegra30 =3D {
> >         .nvquirks =3D NVQUIRK_ENABLE_SDHCI_SPEC_300 |
> >                     NVQUIRK_ENABLE_SDR50 |
> >                     NVQUIRK_ENABLE_SDR104 |
> > +                   NVQUIRK_HAS_ANDROID_GPT_SECTOR |
> >                     NVQUIRK_HAS_PADCALIB,
> >  };
> >
> > @@ -1422,6 +1426,7 @@ static const struct sdhci_pltfm_data sdhci_tegra1=
14_pdata =3D {
> >  static const struct sdhci_tegra_soc_data soc_data_tegra114 =3D {
> >         .pdata =3D &sdhci_tegra114_pdata,
> >         .dma_mask =3D DMA_BIT_MASK(32),
> > +       .nvquirks =3D NVQUIRK_HAS_ANDROID_GPT_SECTOR,
> >  };
> >
> >  static const struct sdhci_pltfm_data sdhci_tegra124_pdata =3D {
> > @@ -1438,6 +1443,7 @@ static const struct sdhci_pltfm_data sdhci_tegra1=
24_pdata =3D {
> >  static const struct sdhci_tegra_soc_data soc_data_tegra124 =3D {
> >         .pdata =3D &sdhci_tegra124_pdata,
> >         .dma_mask =3D DMA_BIT_MASK(34),
> > +       .nvquirks =3D NVQUIRK_HAS_ANDROID_GPT_SECTOR,
> >  };
> >
> >  static const struct sdhci_ops tegra210_sdhci_ops =3D {
> > @@ -1590,6 +1596,38 @@ static int sdhci_tegra_add_host(struct sdhci_hos=
t *host)
> >         return ret;
> >  }
> >
> > +static int sdhci_tegra_alternative_gpt_sector(struct mmc_card *card,
> > +                                             sector_t *gpt_sector)
> > +{
> > +       unsigned int boot_sectors_num;
> > +
> > +       /* filter out unrelated cards */
> > +       if (card->ext_csd.rev < 3 ||
> > +           !mmc_card_mmc(card) ||
> > +           !mmc_card_is_blockaddr(card) ||
> > +            mmc_card_is_removable(card->host))
> > +               return -ENOENT;
> > +
> > +       /*
> > +        * eMMC storage has two special boot partitions in addition to =
the
> > +        * main one.  NVIDIA's bootloader linearizes eMMC boot0->boot1-=
>main
> > +        * accesses, this means that the partition table addresses are =
shifted
> > +        * by the size of boot partitions.  In accordance with the eMMC
> > +        * specification, the boot partition size is calculated as foll=
ows:
> > +        *
> > +        *      boot partition size =3D 128K byte x BOOT_SIZE_MULT
> > +        *
> > +        * Calculate number of sectors occupied by the both boot partit=
ions.
> > +        */
> > +       boot_sectors_num =3D card->ext_csd.raw_boot_mult * SZ_128K /
> > +                          SZ_512 * MMC_NUM_BOOT_PARTITION;
> > +
> > +       /* Defined by NVIDIA and used by Android devices. */
> > +       *gpt_sector =3D card->ext_csd.sectors - boot_sectors_num - 1;
> > +
> > +       return 0;
> > +}
>=20
> I suggest you move this code into the mmc core/block layer instead (it
> better belongs there).
>=20
> Additionally, let's add a new host cap, MMC_CAP_ALTERNATIVE_GPT, to
> let the core know when it should use the code above.

Couldn't a generic "alternative GPT" mean pretty much anything? As far
as I know this is very specific to a series of Tegra chips and firmware
running on them. On some of these devices you can even replace the OEM
firmware by something custom that's less quirky.

I'm not aware of anyone else employing this kind of quirk, so I don't
want anyone to get any ideas that this is a good thing. Putting it into
the core runs the risk of legitimizing this.

Thierry

--YsFHapze9CfLadea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEdDKsACgkQ3SOs138+
s6FtIw//V/GnAyD/VAGosaUf38C4hqMB1AJ4bDuwQT9AT4gX8IoZinxrKlfTv8E1
qp0MDApPw2Lqivhd2eAVG6RekK34TGTS933ocNPRFgR6W74MrKImmFINIvIFseCy
X5ZgxP4yjM9YX6kbgUD7DncOzQFcGqjxQoRAlhCBdGd5nO9VyZwWzFqlT3vvvS4t
GG6gzZH7yieuvzoW2wNNi+Llsn68krvrxNDJo2qzIAtf00l6IGxRuPCNfIRakMMZ
YrKZ1XIBkZLiYDdu8BzVv99Ng+2CcesPuhiXx41xEf3IkrylFJUNJ1A3KXGzIoPt
aTseq307wkpKOnRKsfSw4cS0Y8AEbNGjtkDeEuWB5WRhyDzmzzQOVBB++lvZo0vE
pNsvlwc8p8kdUwKLMRDxqRKbCcl+azla6XSXXDeuzKJLiT0B1gIvrZkcZ5KEGmDs
0h4nRuhABUuozqVcCRkcDY0DAhhVwC1Z+YLLIjeq0ksi4YC+GSgNr3b3HGQms5nq
85Kson9ouXaOGMh0rYmxtRjotolxnO0bQxHYbo7sct4Mhv/NTo/QYXXDuAEQ2MvK
XOP0s5oxcBUH/FGNbIupCVky4SoNnG5EQh9jmm6BmD9jLfCyCt6dAlvFR4nj/DUh
JHV388UVIqOOexOKvkVYSCTQiD7zueR2KlT6WtG70Bf50pq3/EQ=
=Ht4G
-----END PGP SIGNATURE-----

--YsFHapze9CfLadea--

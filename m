Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FA93F1EEC
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 19:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhHSRUe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 13:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhHSRUe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 13:20:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5F5C061575;
        Thu, 19 Aug 2021 10:19:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l11so10208514wrx.4;
        Thu, 19 Aug 2021 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sEq0lwEDOHOEFuz0+oPfms4uMqVVjDnlfnYTZojhez0=;
        b=ZoQpyh3CC4Pr2wrSJYUmzWB7pUbmqd6tXm3K2nGDD0ExI78SIy7A/a/MS4fCR1qfyg
         0nd9xPakHKF/3bw4H0rwRHDHCyzGhM6izcIxeBHfvbvqaHX3x54qip0UdUMgOM+Wj4YN
         HnrsDqUCeJUSW+ePJ2a7QVbGgpBaCkyZOVrgJ0jqrhD4eswtAYqW7HP0SiVYII62xhcU
         e6i9R9qzG/onR411Vs1LXavtkYtEBp+Zw6fS44Mo+YY4DC5hkxuzMGUwOs/6/5PrOnLV
         Y0+Wwv/NVYXfWBPZiGQ40zpykcWgIDgRFlSdjMMUf8EDgvyO3cDShbQx3r78SqjbevW0
         +OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sEq0lwEDOHOEFuz0+oPfms4uMqVVjDnlfnYTZojhez0=;
        b=ZCVFf+8dyOxjICjhmTDYgY5c8O3x6cKKcTtjMKpdR+I+mWJfy3C6SfI5uwsuzfTvE/
         VGZ+Sc1U6kSIt2avAaONuDBWcgWoDVS6LwdMi9ubPk3M3UbwvI3UeOGgIURRGsMKBOqh
         CgATU580KuNcAey2QxNj7tCmZuKAY/OxnQImPAzpbmElQ3Wse0sL+O+nLX0sdJgBnRej
         QZDcOAjly9ngIICdJbJ3ZhWOZX4uBhBCMbjwKT4N1Y8+PX+/3X+bk1o37y3Y4Ki9Gle4
         /pp3u3tx2DGipO+9An6xA/6zA6/kTemsBtBLOCpMHONtzOpSQ9f71P1HYURr1CLOgeoX
         IwUA==
X-Gm-Message-State: AOAM531H7e1+9c+9Y7t/ohlTtN1reWFSCrQS+nEFlnJSMtVHAetacKxS
        BINNqUxsxoJj0iOOw6sh2Wo=
X-Google-Smtp-Source: ABdhPJzeWk7sW1+9o6OUq4fhozdEDnehtgz3v3DMWAvVZtOkqj58WgYqzgRySrsYpX9qAvlNdIniMw==
X-Received: by 2002:a05:6000:18c8:: with SMTP id w8mr5201491wrq.90.1629393596032;
        Thu, 19 Aug 2021 10:19:56 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id v5sm2572897wru.37.2021.08.19.10.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:19:54 -0700 (PDT)
Date:   Thu, 19 Aug 2021 19:19:53 +0200
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
Message-ID: <YR6SuVxJ37IoxyBF@orome.fritz.box>
References: <20210818005547.14497-1-digetx@gmail.com>
 <20210818005547.14497-5-digetx@gmail.com>
 <CAPDyKFqQbe4k-Sem436Fzsr6mbvwZr83VtEaEZTF8oWYoHHQwg@mail.gmail.com>
 <YR0MrlxFLTpsR628@orome.fritz.box>
 <CAPDyKFpObGwWhnwDKG59wdt6Pr35DodogXbDjzPJGoshMD7piQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+3a88Daz9jNA1Brs"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpObGwWhnwDKG59wdt6Pr35DodogXbDjzPJGoshMD7piQ@mail.gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--+3a88Daz9jNA1Brs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 19, 2021 at 03:20:57PM +0200, Ulf Hansson wrote:
> On Wed, 18 Aug 2021 at 15:35, Thierry Reding <thierry.reding@gmail.com> w=
rote:
> >
> > On Wed, Aug 18, 2021 at 11:55:05AM +0200, Ulf Hansson wrote:
> > > On Wed, 18 Aug 2021 at 02:57, Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> > > >
> > > > Tegra20/30/114/124 Android devices place GPT at a non-standard loca=
tion.
> > > > Implement alternative_gpt_sector() callback of the MMC host ops whi=
ch
> > > > specifies that GPT location for the partition scanner.
> > > >
> > > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > ---
> > > >  drivers/mmc/host/sdhci-tegra.c | 42 ++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 42 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhc=
i-tegra.c
> > > > index 387ce9cdbd7c..24a713689d5b 100644
> > > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > > @@ -116,6 +116,8 @@
> > > >   */
> > > >  #define NVQUIRK_HAS_TMCLK                              BIT(10)
> > > >
> > > > +#define NVQUIRK_HAS_ANDROID_GPT_SECTOR                 BIT(11)
> > > > +
> > > >  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
> > > >  #define SDHCI_TEGRA_CQE_BASE_ADDR                      0xF000
> > > >
> > > > @@ -1361,6 +1363,7 @@ static const struct sdhci_tegra_soc_data soc_=
data_tegra20 =3D {
> > > >         .pdata =3D &sdhci_tegra20_pdata,
> > > >         .dma_mask =3D DMA_BIT_MASK(32),
> > > >         .nvquirks =3D NVQUIRK_FORCE_SDHCI_SPEC_200 |
> > > > +                   NVQUIRK_HAS_ANDROID_GPT_SECTOR |
> > > >                     NVQUIRK_ENABLE_BLOCK_GAP_DET,
> > > >  };
> > > >
> > > > @@ -1390,6 +1393,7 @@ static const struct sdhci_tegra_soc_data soc_=
data_tegra30 =3D {
> > > >         .nvquirks =3D NVQUIRK_ENABLE_SDHCI_SPEC_300 |
> > > >                     NVQUIRK_ENABLE_SDR50 |
> > > >                     NVQUIRK_ENABLE_SDR104 |
> > > > +                   NVQUIRK_HAS_ANDROID_GPT_SECTOR |
> > > >                     NVQUIRK_HAS_PADCALIB,
> > > >  };
> > > >
> > > > @@ -1422,6 +1426,7 @@ static const struct sdhci_pltfm_data sdhci_te=
gra114_pdata =3D {
> > > >  static const struct sdhci_tegra_soc_data soc_data_tegra114 =3D {
> > > >         .pdata =3D &sdhci_tegra114_pdata,
> > > >         .dma_mask =3D DMA_BIT_MASK(32),
> > > > +       .nvquirks =3D NVQUIRK_HAS_ANDROID_GPT_SECTOR,
> > > >  };
> > > >
> > > >  static const struct sdhci_pltfm_data sdhci_tegra124_pdata =3D {
> > > > @@ -1438,6 +1443,7 @@ static const struct sdhci_pltfm_data sdhci_te=
gra124_pdata =3D {
> > > >  static const struct sdhci_tegra_soc_data soc_data_tegra124 =3D {
> > > >         .pdata =3D &sdhci_tegra124_pdata,
> > > >         .dma_mask =3D DMA_BIT_MASK(34),
> > > > +       .nvquirks =3D NVQUIRK_HAS_ANDROID_GPT_SECTOR,
> > > >  };
> > > >
> > > >  static const struct sdhci_ops tegra210_sdhci_ops =3D {
> > > > @@ -1590,6 +1596,38 @@ static int sdhci_tegra_add_host(struct sdhci=
_host *host)
> > > >         return ret;
> > > >  }
> > > >
> > > > +static int sdhci_tegra_alternative_gpt_sector(struct mmc_card *car=
d,
> > > > +                                             sector_t *gpt_sector)
> > > > +{
> > > > +       unsigned int boot_sectors_num;
> > > > +
> > > > +       /* filter out unrelated cards */
> > > > +       if (card->ext_csd.rev < 3 ||
> > > > +           !mmc_card_mmc(card) ||
> > > > +           !mmc_card_is_blockaddr(card) ||
> > > > +            mmc_card_is_removable(card->host))
> > > > +               return -ENOENT;
> > > > +
> > > > +       /*
> > > > +        * eMMC storage has two special boot partitions in addition=
 to the
> > > > +        * main one.  NVIDIA's bootloader linearizes eMMC boot0->bo=
ot1->main
> > > > +        * accesses, this means that the partition table addresses =
are shifted
> > > > +        * by the size of boot partitions.  In accordance with the =
eMMC
> > > > +        * specification, the boot partition size is calculated as =
follows:
> > > > +        *
> > > > +        *      boot partition size =3D 128K byte x BOOT_SIZE_MULT
> > > > +        *
> > > > +        * Calculate number of sectors occupied by the both boot pa=
rtitions.
> > > > +        */
> > > > +       boot_sectors_num =3D card->ext_csd.raw_boot_mult * SZ_128K /
> > > > +                          SZ_512 * MMC_NUM_BOOT_PARTITION;
> > > > +
> > > > +       /* Defined by NVIDIA and used by Android devices. */
> > > > +       *gpt_sector =3D card->ext_csd.sectors - boot_sectors_num - =
1;
> > > > +
> > > > +       return 0;
> > > > +}
> > >
> > > I suggest you move this code into the mmc core/block layer instead (it
> > > better belongs there).
> > >
> > > Additionally, let's add a new host cap, MMC_CAP_ALTERNATIVE_GPT, to
> > > let the core know when it should use the code above.
> >
> > Couldn't a generic "alternative GPT" mean pretty much anything? As far
> > as I know this is very specific to a series of Tegra chips and firmware
> > running on them. On some of these devices you can even replace the OEM
> > firmware by something custom that's less quirky.
>=20
> Good point!
>=20
> Perhaps naming the cap MMC_CAP_TEGRA_GPT would make this more clear.

Yeah, that sounds like a better name. Or if people are hung up on
"alternative", perhaps MMC_CAP_ALTERNATIVE_GPT_TEGRA.

> > I'm not aware of anyone else employing this kind of quirk, so I don't
> > want anyone to get any ideas that this is a good thing. Putting it into
> > the core runs the risk of legitimizing this.
>=20
> I certainly don't want to legitimize this. But no matter what, that is
> exactly what we are doing, anyways.

I think there's a difference between supporting a quirk and legitimizing
it. I certainly would hate for anyone to come across this "feature" and
then go: "Oh, this is neat, let's implement this on our new platform!".

> In summary, I still prefer code to be put in their proper layers, and
> there aren't any host specific things going on here, except for
> parsing a compatible string.

Fair enough. Perhaps if we put enough warnings in the comments
surrounding this and are vigilant enough during code review we can
prevent this from proliferating. Obviously, once somebody implements
this in their flash/boot stack, it can become difficult to change it,
so by the time we get to review the kernel bits it might already be
set in stone.

Then again, like you hinted at already, once we support it, we support
it. So no real harm is done if anyone copies this.

I don't exactly know how this came about in the first place, but it's
pretty exotic, so I doubt that anyone else will come up with something
like this anytime soon.

Thierry

--+3a88Daz9jNA1Brs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEekrcACgkQ3SOs138+
s6GKtA/+Kw6EDIkS3bNhVnDZQcb0qcjxRRsy1h2tNW6JDvIPDo2zlbvZB7KuMAHE
y9LNlMgD+fyEi4C0DwDxLH3A9ul5ZYJrvFeuWTs7tM5c8yJ0sx+qnHQxRiX2hGxQ
qknG++ne402iIdy6dGEOqHQkwHXvl9UGhba70e4Y4Ij4GmUZZ5UoAtQ0yZtwkMKO
+RkCwX+iWpENcpS0esxn27BlHgUIIkTOaOhYcgKWpjWOOsEAX3mbo1BMtaRhwb03
2mjkHBwU5uLNAf7nn7d1lItV9po2miTSfocDgKwH0adh2fSS5B6HNui5wmLyf31a
28ZuKxouFfHqaQ2IBUXC95+fsMqHOWzNol6J8lC7RkyO4LoDtkC1Fk2v8L2K5eUs
YH4yTMV+B87XzGBFrSAivPh4TmTsJGs9AdWZmoRydTv3fZDBMDZPFKjGHG+ytH/Y
aT/l00NwdMlWJy6gsCM7QUcvpIGdH2BYs9CbDMcVsXLGOG39A1vhCxU0Tx0ZB9NV
fmf9NN9gqYhuZEdvbd0Ue/OuFJai6XmPKaLOoqX3JZ/fY1Tak2adxcZR3c3ttHbH
dEJBSJ1gzC7RkXDVqKAP6vWTsPISNZKSQUsY8Jqywym7bUJ0Dbp8hsVn2ztYT2C5
cNMPd/y35A30cHjoadKCBmElgSXvZrnIPmo/KQmeq+71tz330U8=
=EKSH
-----END PGP SIGNATURE-----

--+3a88Daz9jNA1Brs--

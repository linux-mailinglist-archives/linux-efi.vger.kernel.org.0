Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A54D3F15A7
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 10:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhHSI70 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 04:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhHSI70 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 04:59:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4580EC061575;
        Thu, 19 Aug 2021 01:58:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso6276999wmc.5;
        Thu, 19 Aug 2021 01:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z38F0XNM2HD3DPs8Ijd+gshF2I+/sBEtK/FrXOsIrGE=;
        b=R6zRnRHg6YIX/gSJasAXfOiWLszXHyp67WQIBOpd2xIcJZO7INZ9VyhwQxqd5Htx/7
         1RimCSebvePX3cf6ZwWl+I1C1lU2u1+r6hXkg9lcEZ1R9qZd/eBbU2BQR4engccM0Xja
         EqZ+rrjBtW/+jSfz2coLAVqq0HrXMTqJjcSfBSdUR+DtUSFZULa7vQ29eOzH4JM4WWZd
         tbQ2Z9xNibm8WpCYjJnIPE2TgMz7vxa7xi2CzL4CX6GTNVBSaMaCJc73b4zovlUdoqdk
         rkZcEyfpg3QMvPB9qD5z/kAg11CKMC9izM5BTC0YinVKqPtKtn1r7tIozprHMq5XgtmZ
         CNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z38F0XNM2HD3DPs8Ijd+gshF2I+/sBEtK/FrXOsIrGE=;
        b=q6bi16COnVcWg/Sv1ofT0q4LeorqJwfKqhLU26UWibaKjuzpzaGviS3noMMCRXovi3
         XXGY3Tve+DNOoUS62xqCUSxfz6IwuDTeit82b0DLR1Qz008Hq/WFHGmQVOgUhic0tlnS
         m2thvq63F+BqsIOncfv3++dJvpOJK8rxH5MKG/OCRJWod+pwUmb4dnukfVcsT48ua7qJ
         T2eK6MX2GXL+aUvfQXO78TKHOChda5DsEHfMXPmTGxxKTf6Ad8s2XC0H3Y/H4nEz9r0B
         t4cppYmmyC3HorMkUQYaXbSkfA+3f9+N421MqduVqlRFtO9gT0HIunY7aAC8cl+lPjPt
         9zZg==
X-Gm-Message-State: AOAM532+2avIekOpnB/NYx/opLbQQ1FWORAxONRyDYeFmq9vt+gDIrZk
        ZNjDAPu7qRncGMzBw0MMOkI=
X-Google-Smtp-Source: ABdhPJxqmXxAMCXp4IXUlg2eDj9b+GUxYuWZqV9DLZIc7v+3b1DT8CciAiIivCmwu4UQBiojAzOVLg==
X-Received: by 2002:a1c:2042:: with SMTP id g63mr12853516wmg.27.1629363528793;
        Thu, 19 Aug 2021 01:58:48 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id h11sm8405106wmc.23.2021.08.19.01.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:58:47 -0700 (PDT)
Date:   Thu, 19 Aug 2021 10:58:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <YR4dRuhjOBDkNAa7@orome.fritz.box>
References: <20210818005547.14497-1-digetx@gmail.com>
 <20210818005547.14497-5-digetx@gmail.com>
 <CAPDyKFqQbe4k-Sem436Fzsr6mbvwZr83VtEaEZTF8oWYoHHQwg@mail.gmail.com>
 <YR0MrlxFLTpsR628@orome.fritz.box>
 <90dcb1e9-30df-e721-5ddc-156ae295636e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1USK1c4jx3g2y1dp"
Content-Disposition: inline
In-Reply-To: <90dcb1e9-30df-e721-5ddc-156ae295636e@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--1USK1c4jx3g2y1dp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 18, 2021 at 07:15:43PM +0300, Dmitry Osipenko wrote:
> 18.08.2021 16:35, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> +static int sdhci_tegra_alternative_gpt_sector(struct mmc_card *card,
> >>> +                                             sector_t *gpt_sector)
> >>> +{
> >>> +       unsigned int boot_sectors_num;
> >>> +
> >>> +       /* filter out unrelated cards */
> >>> +       if (card->ext_csd.rev < 3 ||
> >>> +           !mmc_card_mmc(card) ||
> >>> +           !mmc_card_is_blockaddr(card) ||
> >>> +            mmc_card_is_removable(card->host))
> >>> +               return -ENOENT;
> >>> +
> >>> +       /*
> >>> +        * eMMC storage has two special boot partitions in addition t=
o the
> >>> +        * main one.  NVIDIA's bootloader linearizes eMMC boot0->boot=
1->main
> >>> +        * accesses, this means that the partition table addresses ar=
e shifted
> >>> +        * by the size of boot partitions.  In accordance with the eM=
MC
> >>> +        * specification, the boot partition size is calculated as fo=
llows:
> >>> +        *
> >>> +        *      boot partition size =3D 128K byte x BOOT_SIZE_MULT
> >>> +        *
> >>> +        * Calculate number of sectors occupied by the both boot part=
itions.
> >>> +        */
> >>> +       boot_sectors_num =3D card->ext_csd.raw_boot_mult * SZ_128K /
> >>> +                          SZ_512 * MMC_NUM_BOOT_PARTITION;
> >>> +
> >>> +       /* Defined by NVIDIA and used by Android devices. */
> >>> +       *gpt_sector =3D card->ext_csd.sectors - boot_sectors_num - 1;
> >>> +
> >>> +       return 0;
> >>> +}
> >> I suggest you move this code into the mmc core/block layer instead (it
> >> better belongs there).
> >>
> >> Additionally, let's add a new host cap, MMC_CAP_ALTERNATIVE_GPT, to
> >> let the core know when it should use the code above.
> > Couldn't a generic "alternative GPT" mean pretty much anything? As far
> > as I know this is very specific to a series of Tegra chips and firmware
> > running on them. On some of these devices you can even replace the OEM
> > firmware by something custom that's less quirky.
> >=20
> > I'm not aware of anyone else employing this kind of quirk, so I don't
> > want anyone to get any ideas that this is a good thing. Putting it into
> > the core runs the risk of legitimizing this.
>=20
> I also think it's better to keep it internal to Tegra. Ulf, could you
> please clarify why do you want to have it moved into the core? Are you
> aware of any other platforms that want exactly the same quirk? Thierry
> should be correct that it's relevant only to Tegra SoCs.
>=20
> Regarding the 'legitimizing', it's not a bad thing to me at all. If we
> want to run more devices with a mainline kernel, then such quirks are
> inevitable.

That's not what I meant. What I meant to say is that putting it into the
core might give somebody else the idea that this is actually a good
thing and therefore they might end up implementing a similar quirk. That
is definitely not something we want to encourage.

Thierry

--1USK1c4jx3g2y1dp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEeHUQACgkQ3SOs138+
s6Hqqw/+MHJXq9glVT+k9gTqOu+9+LmLYv7ieeuFK+13S/fxhGkUDXWxgNlIW8GD
y9sm8OxbxhGczsvTc4Pf9fdbRoOsSPi0jbspzrYAVZQBNAoOGbnDLFDPgUCIF0Ta
VeXgej4e3vF70ECEQ3ZHPe5jj0C3H4652o5YMLP8S0cKE0zjnG/MKwO7PIvAIzss
ggG3xhTVVTM8d7MaXWa5vQ7EZ1qL7XUCDxEqk5VUQtNW/OoOuWKduz/R9+m4GNzT
i5jNXV60+Z1txZCd7Okqzkx0UaRZi/wPNaj+1LRP/S525dgwiV/GMNHNUHH/SW9i
T9Tf+jCSOe2nabXUXqB/nrFLrbCQX0HfaHxVgJ1GZoT5aPGzoHhi5dlzvMBOj0Hr
/s5fK9ZZkM40AKbUzbhgR3eOu0fiCIjyRPxmm5GNMBJU82fZyshR8x6Fg3A2FkWe
pO1l5jRBF90EzzYcc26pU5OrIKdJbx6Ed2p4jQX2lSqY/bapC+SOeGD+Q/HMuOIX
/R8Btmpe8OFmwz/qWqII4DYfWot5bIqo2OXh5sIkRM3Ql0n5ykDfkKlaiipqQEHq
CUxDT77/lBNgt5JTn21058lLlEGMB+MFR3QpcSHj1quBsQmBq3tD3M/g5E0dhr3r
ltZksh5jokb21hDWO8f+O7lrheBewOc50CCt/Fm4hByin/D+nOg=
=3dyg
-----END PGP SIGNATURE-----

--1USK1c4jx3g2y1dp--

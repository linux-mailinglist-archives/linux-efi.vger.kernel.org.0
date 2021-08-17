Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B177A3EEE2C
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 16:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbhHQOLq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 10:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbhHQOLp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 10:11:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92AC061764;
        Tue, 17 Aug 2021 07:11:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g138so13802238wmg.4;
        Tue, 17 Aug 2021 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G+wzONEKGs2tcL1CzgRs5jjCLpQK+a9gblJaRcWbhR8=;
        b=ayzVWjoihikSQUVCVr0EcXp3CyfdGuJ/tBbW7pe8hjodC/wu+X7xnJls9kP01pXGjE
         YB+tJPQa1xGsCX1REs+fJNWqO8SjJJ0KUSw8HWpNf0vK/9XmBd/I8R6oh7BLtgkYJXw8
         FHN7SnU+NNn6fftn6tuEHXF+5zQ5MoW8Lmre29ZIYwOEfbk66+L+8A3MG75rAc3ubvr3
         YlQmk8Or/VWfeGJHxMcebnTI4r/lOsUC5VE2bdpW9vVSjJLleL/NxR+F++l54t9VSBXt
         RWKc64Huq7oVzZ4Q1e2w+h9GWrtkWgghKFf1HziNQ8qGnpoUhfEqcCZjTrzTdtKvGMia
         vbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G+wzONEKGs2tcL1CzgRs5jjCLpQK+a9gblJaRcWbhR8=;
        b=Qt7mEBgh61N3wsHpJcMK5FnDXKnu8VRyd0eZD/DXPUB+9vh63jGGw/o/S1c6WxzMV6
         2nzfdH2heGUwuioLHuXNTDBcWIfI3wtV7RrTyFfbq4Z4pg8rM0HvPgLC+OWD3XDamhiX
         YTJ+c7pLNOLd4sgROWgJQ/Cw3IUkNqGgZqX+FIxwJkottHiCVqIlKTx7R5JXeLhvrNvC
         w6Cius6I1GoVMhtYPr49MvqLBXxa86j/vqXn4sIKr7qETTnQ2EuFOujcwlJ0HAizqc/Y
         iyZ9H7Gxc+/OboieJTsuTZuYGg0gcIlPlTyiS8UyhX1kbFlO2MbN+2jB4Nc7h6sqdwAK
         AkBg==
X-Gm-Message-State: AOAM532cUuSJHXF6vO3H5JytDOMZ7/qdxcImRck4VVTSBFIDMVvBRNYP
        yob/MOV3vKkjfAAVuzeNRno=
X-Google-Smtp-Source: ABdhPJxpSCHWghNCMjKKFeb7f85rvzbQtLhlufDVDIq25OxpuhZrLPxBBB40pHeAWLXtg1+39ipmHw==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr3701902wmc.150.1629209471009;
        Tue, 17 Aug 2021 07:11:11 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id y3sm2565385wma.32.2021.08.17.07.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 07:11:09 -0700 (PDT)
Date:   Tue, 17 Aug 2021 16:11:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] partitions/efi: Support NVIDIA Tegra devices
Message-ID: <YRvDfMiYb0q7utX5@orome.fritz.box>
References: <20210817013643.13061-1-digetx@gmail.com>
 <20210817013643.13061-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5xfW2MljllZtfrq0"
Content-Disposition: inline
In-Reply-To: <20210817013643.13061-4-digetx@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--5xfW2MljllZtfrq0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 17, 2021 at 04:36:43AM +0300, Dmitry Osipenko wrote:
[...]
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
> +	{ .compatible = "nvidia,tegra20-sdhci", },
> +	{ .compatible = "nvidia,tegra30-sdhci", },
> +	{ .compatible = "nvidia,tegra114-sdhci", },

I know of a couple of OEM devices using the above SoCs that support this
alternate GPT sector mechanism...

> +	{ .compatible = "nvidia,tegra124-sdhci", },

... but I'm unaware of any using this. The only one that I could imagine
employing this quirk is the SHIELD Tablet K1 (a.k.a. ST8), but I thought
it had been changed on that device already. Do you know specifics?

Thierry

--5xfW2MljllZtfrq0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEbw3wACgkQ3SOs138+
s6EcqxAAvcvsn48s8izKAvWVHbKEilSvfL2kYYM/5DbYAw/UGuIQdjveoigKVO/Z
3uZjqIp6SjZkoE0XrAandirYe8RlD/vt8M9VUmz6XMIdVkMcOhR3ZRYAtmKrwWPi
G0nanfNzxiTzeK+df1nDJ+NhCnUPqQ1NF0HrzTTs2KXXNia8jeOLLTeEyTpvgy25
LNcU6RsyvUBPkXUOxAuFR9mOM2GzB+a6y//h7ChCir0UAWPklzAwkqwOfse2PoFm
gpmnbTwQ8mWMDdgtGl9/8hG29fr2RDkW1/Zehy3ek3WMBUrfce/5o+xGoGV+i7ff
0PdZR3Y4Fg2NsfeLGTsvonRoOSLgYG2X/JEe7DLHQQITzDLwvbkflolgqZ3KmTA0
j9jGP8YkcLcOzFr2B+k/g3bcbE7tp7ygRpuh3Pu22Me0YC9PNdkNrs/DggOUklai
ZYhtSPtBITwrsVG0MYUwl9Wl7QdTUZ3L4vWSwMoZVnxhsqZ4Wy4v8xZlQvUJmQax
JfC5xTw4GN6IuP00bqBZGyDnOt4QIJxeDW6IRxbGlOUnSCplFsJEmF2UfGCl8t25
rQgGLZgJka5B02xDvmqjkVjQHr342bI9e42QlpLUA+ibIUduzxocRVj87U8h7v3t
ST9O3w9N63x7oOAwt+c/aI7wHMfXqxquiVbHjG85dHrz0mk2y4k=
=xDap
-----END PGP SIGNATURE-----

--5xfW2MljllZtfrq0--

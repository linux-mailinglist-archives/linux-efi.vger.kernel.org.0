Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4C73F2B34
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhHTL2H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 07:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhHTL2H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Aug 2021 07:28:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7224DC061575;
        Fri, 20 Aug 2021 04:27:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id w24so5708210wmi.5;
        Fri, 20 Aug 2021 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SjDUab6ES3/gB1KniFBQUp8JcOQkZIMPeFbdvqfdXv0=;
        b=UHWERN8f9quI2rSUCk1WrRW97eftUnzajyYEM3pAovhRjKnbUtDoCXTQ88snOI+9in
         pwwOimSs5UE5xFdTBxiSPxTxOJ2WdnziXzeqkWHBC3vKkB/gCCs3cfnIe5p43usX8drp
         VIw9W2HvM9DT+QZoE3I62YBWirejOhst0auA5UlfMPd165AmcYRH+nSCfVF+QNzPaUy0
         CYjUtJ9bGnj3qzHXD7AfeCXVF1Q8v1NOU4x5h72Cdzmvp6BbJtC3NWb7oufzG8+eV5Lw
         SMzHbpEfAnUWhQ/kIjlRksYLXGoCiVB31gNhMofNVK7W8aH9fsP0br8xCx/+Tb21UaOk
         Uqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SjDUab6ES3/gB1KniFBQUp8JcOQkZIMPeFbdvqfdXv0=;
        b=U1aFYusnt0rJkFvOpLl+NtkTLfyRtgah0aLgZyYghAa7BpXNRxjci3gFIFGhGHkpAM
         64euBLK7OQUs5rt+cpi+gLlIdz5M7WFCj1k+zRFXyrqeX058GQI08fQy0YHLC/NVGCcw
         DugglT5Pa9wV1jqDrABC7zyrwVpvSnmFy58mVS0AvW2Q8/Drr8W2zDqUO7DY+3kDY8T2
         rDomBdd6wKtHIVgzF8t85ixloK0cQfjUwoWYF7I7sWqqVMzcQaZKmDwliBPSOzmknMPH
         81cVn3AHkU8qo7b2j6uz8/8rISbe6s46ixe2CWedYCmdpwJoN9entzzLEwY+ZYbCq4Ks
         9LMg==
X-Gm-Message-State: AOAM532hy1dRrRuc6Svv1K85d204t+yfdQ4VMqVV60bjpf8VaSu6rVcx
        EUaJrNylR3S8VGwpbIzU6Kw=
X-Google-Smtp-Source: ABdhPJz+RA7GGLxzMpCDOim6PSXwiUzFn+BklCCbmBg0rZ/eVC8IfFtPsUdIDQgifT4ZichVAhIcxg==
X-Received: by 2002:a05:600c:198a:: with SMTP id t10mr3397445wmq.181.1629458848076;
        Fri, 20 Aug 2021 04:27:28 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id d8sm6007515wrv.20.2021.08.20.04.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 04:27:26 -0700 (PDT)
Date:   Fri, 20 Aug 2021 13:27:25 +0200
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
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] mmc: sdhci-tegra: Enable MMC_CAP2_ALT_GPT_TEGRA
Message-ID: <YR+RnXmtvDHk7mU3@orome.fritz.box>
References: <20210820004536.15791-1-digetx@gmail.com>
 <20210820004536.15791-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P4L/5MMHcPJXc6os"
Content-Disposition: inline
In-Reply-To: <20210820004536.15791-5-digetx@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--P4L/5MMHcPJXc6os
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2021 at 03:45:36AM +0300, Dmitry Osipenko wrote:
> Tegra20/30/114/124 Android devices place GPT at a non-standard location.
> Enable GPT entry scanning at that location.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 387ce9cdbd7c..a5001875876b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -116,6 +116,8 @@
>   */
>  #define NVQUIRK_HAS_TMCLK				BIT(10)
> =20
> +#define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)

_HAS_ could be taken to imply that it always has that GPT sector,
whereas it really depends on how the system was flashed. But that's a
bit pedantic, so I think this is okay:

Acked-by: Thierry Reding <treding@nvidia.com>

--P4L/5MMHcPJXc6os
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEfkZsACgkQ3SOs138+
s6F2XhAAjZLI6fstxyhGIOp5rNCJqNDYou4sOxqEn5Lt4KC1XGOIXynv/zEhFeG4
I8w1fL5oCql8CHpsj+IN/d81K4PkM+tV5nPBt+eMUh8NkDGFhjHBRBrM1T08k7fj
vFOTJcDG0BnzevEYgY1fX0U5mFnZEOKlkUrcQXGmJRXyb3XBMCY8siuYRurnXRTu
hQMoM+MFZDQlbP7GBAihc3LY4sCUB8UGvkIpJ3VmTMydgizkv6wfY0ZK2Q3oC6Gr
lKHQj202ORXX6OTYSiDkGd7jH85viUhVSjiHgtqyy/u4dCLx94V/Zn6GXf9sKusp
p2WYSGklDiuw7ZtI8D6vllDkvqvFSkOSfLAvstZlfRPkfNweEJfW9Ks28vcp8GkR
YcOtQ/rt3hin7oArC73G9qLZG0zzoYVrlFWsQLouodS1saIVMCCwvh8xZ1vbFxuM
HYaBM8qVhGMXM5TDNpx9ALiQjmQriHovyOXi6FAZb/ZS9YH8cIUgwwE6CQMLzFlo
qOs2NRMqvr+sKW4WeDJvzj7IKg5GReEKp6BEGI0V3H2ySBJ/DC5kT8D6d349F8Pc
BXvLe7zStMP/FIY1aUH+LBPnfIdEqBXtSwYFkqqAV+iDGgR4qMPrimrASBYu4hMa
XqdjGmxxDMykYJLygZYwgcL729a0pm15VULpw8Cb+SceMxKM15s=
=pZM7
-----END PGP SIGNATURE-----

--P4L/5MMHcPJXc6os--

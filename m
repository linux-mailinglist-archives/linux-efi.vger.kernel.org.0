Return-Path: <linux-efi+bounces-3026-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAA2A67A75
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35F8172541
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8160211711;
	Tue, 18 Mar 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2j09nvz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8D192D8A;
	Tue, 18 Mar 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317854; cv=none; b=MaXidZsZQ/4sTOGaWnoXAUX2rguFNmXGN1CYuirpdpk7Td5vE/KDX/pggQVsFowqyTdozahQenazZAKIYLE6bgTtrlZ96wqcNq9ssgG1wEpH5rpdcY2mOsW2t93dc1nVnGbhiIiet8KPVjsyvPbs8S56Oegl+pt5m7+IqmtLBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317854; c=relaxed/simple;
	bh=4fZsF7KO9e7D0v1oaS5HV+QtS1/Bl7uHzyrhdn3MpZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ltkko7S5GdXA2kW0FSIJ+G7a4mRqkRH3HBqtb0fu53pDjszAyIO4c1KRYExfcNNWO4U5YzpGS+i2mQBgojzT3fLpqg3bHaFrsD6TMrTp2MyNziZA2o3Oj++IIaPd4LVmqGbn+raFR5amd3jf48LoQke8cdPeZD5+NGlU4pYnuqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2j09nvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310C1C4CEEE;
	Tue, 18 Mar 2025 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742317854;
	bh=4fZsF7KO9e7D0v1oaS5HV+QtS1/Bl7uHzyrhdn3MpZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E2j09nvzZk4viDdA+BXpQYBvifB5cKxJ16nBmz4U00ibb5NrV/nQjQTWulO99ZFe5
	 zVbb2sB4F8R3ZE1Qg0K0l1yZBHbudQy79ilM6uN+SH3X4yykAYyfwSqmVGmQtHcTCG
	 KghGaAl2O4tYsoXZAUQoJBuGLwaAf2bKlW/N190zm+4Yp388W5OrV7FhNTLqKe4+Se
	 mUFBrFytZa2OT2R6xGDfWvAJGipG2kjh69TaFwKtZgrxvuoMAl8WVsbcYEnYNtdrSD
	 zq+duV+O4KvJF8uUmY40hJCwn8a/X4qKXxfrhlnofYP/yAbVTId4cpW7El8LRmEZWx
	 RebP6RAgwC2gg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-549b159c84cso5820211e87.3;
        Tue, 18 Mar 2025 10:10:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7mI885ilYJ9PcGiA0gqsyIp3Oa0cSiYP93+ALHJvldPeN9V+sOXdK6njfGljkQXd7E/toZAyr2lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVlDaQSQTHNKUzshQd9HjVKzfC2zAYdzIm5sJDuFF/AvYaen+4
	BYCMRGRxRLNl2ayp028NzhQqw93/S5MZrGNpd655xV3rtUYBhNoJrywlO1djovvgQHW9C/UFYa8
	L1RTxjcFaTt8hXzb5hAiuHPRLYY0=
X-Google-Smtp-Source: AGHT+IEkCe/XZYA4UQha/rri0TTl+l1brOgC48J1UlrN84Qqz9lNFkyBKDRMWNxhA6iXUqh6/autFpqU/3j+G3CBaS0=
X-Received: by 2002:a05:6512:31c8:b0:546:2fde:d2d9 with SMTP id
 2adb3069b0e04-549c39187b6mr10573595e87.28.1742317852498; Tue, 18 Mar 2025
 10:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com> <20250318-plat2faux_dev-v2-5-e6cc73f78478@arm.com>
In-Reply-To: <20250318-plat2faux_dev-v2-5-e6cc73f78478@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Mar 2025 18:10:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGJkApH73r9qEGABe3M4pXP2gMW3tDXfz2F6WGPZ3nhug@mail.gmail.com>
X-Gm-Features: AQ5f1JpopHuHi8p6uFegKC8Z0bFArBBVadyBes88D9LM5rt036Qc3UYZOaeBTmg
Message-ID: <CAMj1kXGJkApH73r9qEGABe3M4pXP2gMW3tDXfz2F6WGPZ3nhug@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] virt: efi_secret: Transition to the faux device interface
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 18:02, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The EFI secret area driver does not require the creation of a platform
> device. Originally, this approach was chosen for simplicity when the
> driver was first implemented.
>
> With the introduction of the lightweight faux device interface, we now
> have a more appropriate alternative. Migrate the driver to utilize the
> faux bus, given that the platform device it previously created was not
> a real one anyway. This will simplify the code, reducing its footprint
> while maintaining functionality.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

So how is module autoload supposed to work with this driver?


> ---
>  drivers/firmware/efi/efi.c                |  5 -----
>  drivers/virt/coco/efi_secret/efi_secret.c | 29 ++++++++---------------------
>  2 files changed, 8 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 8aebc747c65bc1b63d514a50fe6f35a9e3c1af0a..862b7744c28ecc9e5a64bbb3533c34119f50267f 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -465,11 +465,6 @@ static int __init efisubsys_init(void)
>         if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
>                 efi_debugfs_init();
>
> -#ifdef CONFIG_EFI_COCO_SECRET
> -       if (efi.coco_secret != EFI_INVALID_TABLE_ADDR)
> -               platform_device_register_simple("efi_secret", 0, NULL, 0);
> -#endif
> -
>         return 0;
>
>  err_remove_group:
> diff --git a/drivers/virt/coco/efi_secret/efi_secret.c b/drivers/virt/coco/efi_secret/efi_secret.c
> index 1864f9f80617e082feb574a15327949972c8cc1e..a60976750bef787c78401bf4569ee5d0c7d2b5f4 100644
> --- a/drivers/virt/coco/efi_secret/efi_secret.c
> +++ b/drivers/virt/coco/efi_secret/efi_secret.c
> @@ -16,7 +16,7 @@
>   * is the GUID of the secret entry, and its content is the secret data.
>   */
>
> -#include <linux/platform_device.h>
> +#include <linux/device/faux.h>
>  #include <linux/seq_file.h>
>  #include <linux/fs.h>
>  #include <linux/kernel.h>
> @@ -152,17 +152,12 @@ static const struct inode_operations efi_secret_dir_inode_operations = {
>         .unlink         = efi_secret_unlink,
>  };
>
> -static int efi_secret_map_area(struct platform_device *dev)
> +static int efi_secret_map_area(struct faux_device *dev)
>  {
>         int ret;
>         struct efi_secret *s = efi_secret_get();
>         struct linux_efi_coco_secret_area *secret_area;
>
> -       if (efi.coco_secret == EFI_INVALID_TABLE_ADDR) {
> -               dev_err(&dev->dev, "Secret area address is not available\n");
> -               return -EINVAL;
> -       }
> -
>         secret_area = memremap(efi.coco_secret, sizeof(*secret_area), MEMREMAP_WB);
>         if (secret_area == NULL) {
>                 dev_err(&dev->dev, "Could not map secret area EFI config entry\n");
> @@ -191,7 +186,7 @@ static int efi_secret_map_area(struct platform_device *dev)
>         return ret;
>  }
>
> -static void efi_secret_securityfs_teardown(struct platform_device *dev)
> +static void efi_secret_securityfs_teardown(struct faux_device *dev)
>  {
>         struct efi_secret *s = efi_secret_get();
>         int i;
> @@ -210,7 +205,7 @@ static void efi_secret_securityfs_teardown(struct platform_device *dev)
>         dev_dbg(&dev->dev, "Removed securityfs entries\n");
>  }
>
> -static int efi_secret_securityfs_setup(struct platform_device *dev)
> +static int efi_secret_securityfs_setup(struct faux_device *dev)
>  {
>         struct efi_secret *s = efi_secret_get();
>         int ret = 0, i = 0, bytes_left;
> @@ -307,7 +302,7 @@ static void efi_secret_unmap_area(void)
>         }
>  }
>
> -static int efi_secret_probe(struct platform_device *dev)
> +static int efi_secret_probe(struct faux_device *dev)
>  {
>         int ret;
>
> @@ -326,23 +321,15 @@ static int efi_secret_probe(struct platform_device *dev)
>         return ret;
>  }
>
> -static void efi_secret_remove(struct platform_device *dev)
> +static void efi_secret_remove(struct faux_device *dev)
>  {
>         efi_secret_securityfs_teardown(dev);
>         efi_secret_unmap_area();
>  }
>
> -static struct platform_driver efi_secret_driver = {
> -       .probe = efi_secret_probe,
> -       .remove = efi_secret_remove,
> -       .driver = {
> -               .name = "efi_secret",
> -       },
> -};
> -
> -module_platform_driver(efi_secret_driver);
> +module_faux_driver(efi_secret, efi_secret_probe, efi_secret_remove,
> +                  efi.coco_secret != EFI_INVALID_TABLE_ADDR);
>
>  MODULE_DESCRIPTION("Confidential computing EFI secret area access");
>  MODULE_AUTHOR("IBM");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:efi_secret");
>
> --
> 2.34.1
>


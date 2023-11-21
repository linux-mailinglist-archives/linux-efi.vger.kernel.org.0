Return-Path: <linux-efi+bounces-71-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F2F7F337C
	for <lists+linux-efi@lfdr.de>; Tue, 21 Nov 2023 17:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010781C21AF9
	for <lists+linux-efi@lfdr.de>; Tue, 21 Nov 2023 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607625A0EE;
	Tue, 21 Nov 2023 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQnYJ74n"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4CB5A0EB;
	Tue, 21 Nov 2023 16:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0751C433C9;
	Tue, 21 Nov 2023 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700583599;
	bh=/ftsIOr6PtvXmwDXJG2lgHpbTRDyOZqNHqOkYX1msmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qQnYJ74n8oQzVtLAxKlA0npDWvAXMG5BczCbtm8Q7r1U9tmCrT/NYDhrCDJgV4dxH
	 FpzqPbjUjkeuZ1oqf8JbcXboxg0/5HF3aXuCOud2H9tRy3N1oeJO28yQVzyEPboON7
	 tHv97fMIje/U8dP08iA6XHgtkk/cXHcezhCVMTdr2aJ0F/tAE2VrMR+7xF82QLBeUn
	 ELAtG3qCN7qEO9ahwWMgIlGiuJby3jBl04eev+q+T54u5IjB0I2A3PEj3YfbuSFFmc
	 05pobXOY9fPL66pCFy2QE3Tq5YI8vodE9OrSts1ygetRcZ6fP85P+BVaydWq75EdPz
	 CeAb/VRx+JLbw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c8879a1570so22352571fa.1;
        Tue, 21 Nov 2023 08:19:59 -0800 (PST)
X-Gm-Message-State: AOJu0Yx8QC+R9Ctqz1UXYhkqq/JDF0l4ip6o1CI757nS3wwxzLLUn/HJ
	6zMhzVP9q+6qFAzMus5i1n4vq1wWP8YvsCxhE4w=
X-Google-Smtp-Source: AGHT+IEtMGQDvBsJOPcKtWdelsFIWrHMFFYwL5uPNIQYz3nN/aRSQXRn2eA7w9M9xQKYjfsRUgSQym1LFQCd9rSwY0M=
X-Received: by 2002:a2e:9e1a:0:b0:2c5:1f92:b464 with SMTP id
 e26-20020a2e9e1a000000b002c51f92b464mr6822339ljk.10.1700583597994; Tue, 21
 Nov 2023 08:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121103829.10027-1-raag.jadav@intel.com> <20231121103829.10027-6-raag.jadav@intel.com>
In-Reply-To: <20231121103829.10027-6-raag.jadav@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 21 Nov 2023 11:19:46 -0500
X-Gmail-Original-Message-ID: <CAMj1kXEr2O8LZNq1r0zr1ZHPhtpbNu0PmZBk=UQvp7m0=ETodA@mail.gmail.com>
Message-ID: <CAMj1kXEr2O8LZNq1r0zr1ZHPhtpbNu0PmZBk=UQvp7m0=ETodA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] efi: dev-path-parser: use acpi_dev_uid_match() for
 matching _UID
To: Raag Jadav <raag.jadav@intel.com>
Cc: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, will@kernel.org, 
	mark.rutland@arm.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Nov 2023 at 05:39, Raag Jadav <raag.jadav@intel.com> wrote:
>
> Now that we have _UID matching support for integer types, we can use
> acpi_dev_uid_match() for it.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/dev-path-parser.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
> index f80d87c199c3..937be269fee8 100644
> --- a/drivers/firmware/efi/dev-path-parser.c
> +++ b/drivers/firmware/efi/dev-path-parser.c
> @@ -18,8 +18,6 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
>         struct acpi_device *adev;
>         struct device *phys_dev;
>         char hid[ACPI_ID_LEN];
> -       u64 uid;
> -       int ret;
>
>         if (node->header.length != 12)
>                 return -EINVAL;
> @@ -31,10 +29,9 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
>                         node->acpi.hid >> 16);
>
>         for_each_acpi_dev_match(adev, hid, NULL, -1) {
> -               ret = acpi_dev_uid_to_integer(adev, &uid);
> -               if (ret == 0 && node->acpi.uid == uid)
> +               if (acpi_dev_uid_match(adev, node->acpi.uid))
>                         break;
> -               if (ret == -ENODATA && node->acpi.uid == 0)
> +               if (!acpi_device_uid(adev) && node->acpi.uid == 0)
>                         break;
>         }
>         if (!adev)
> --
> 2.17.1
>


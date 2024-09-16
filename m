Return-Path: <linux-efi+bounces-1783-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C776A979CCA
	for <lists+linux-efi@lfdr.de>; Mon, 16 Sep 2024 10:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09FA1C212BA
	for <lists+linux-efi@lfdr.de>; Mon, 16 Sep 2024 08:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F8C13D8B0;
	Mon, 16 Sep 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGbCsTMo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE33770C;
	Mon, 16 Sep 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475402; cv=none; b=Q3eUPDG7qtozPrPfda1yOMSdLSOihoPL3lpVsqpQSa4WKLOd221M3BsuAuMVO80l4EpqdhPkvBv5OOYwGWw4/toBUPMeBt3Et5IEqaOwLS2/9cIvcdG29vZlorZpwU4LCJxhaUJ3mzzyp+O+b4ucsnVjfDroGg0wtlWPtHVnf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475402; c=relaxed/simple;
	bh=yfBFDbB93iEmu5WRyN3txgKZPZ1pPumVZZsmFoI6+r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNRAbQj3qtJaCyZlhquWK8RDcmPb2fZxkq1//YUu6Cnl7LW8aeG8iB1S50TCjeRe8BpHS5mTekJyJb1uOt57Np/m2l5n1iq9DNuerGHrcyS7U1bwSE82kWAHZ4pNJRh3fr80AsxAUOZqPOpXxHyRkb9vV/xtwZMO7naHgITdhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGbCsTMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42987C4CECC;
	Mon, 16 Sep 2024 08:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726475401;
	bh=yfBFDbB93iEmu5WRyN3txgKZPZ1pPumVZZsmFoI6+r4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sGbCsTMoCY3c66R9QUrs6zy7mO3MDoscPw+hxXhdSP6C+EmuBPoRIBsxcMT6B9tVA
	 S1lWgRz7F0GQHpMqkp7LCvdAQf7+AFuc4p9sgqbLy8SL/g+gA5r6D/M8AU0YEtFlX7
	 rAAGmxG9/jjL8vJfsG2XrH0OTTPZNviUgAJHzNHHhs4c3OZKO6wOd1+8FkiG+SKuLq
	 //Ql7zobhO9vF2c+mtqju3hsRR4NmhlGF91FGaPIFHJzTSrN5S5biA+kXrhP99afr5
	 JLZrak3RYM8dBnHGxzCo3fDiZzs55kDKahk8sJjLbR6wm3PQd2TzSkvTXNGq0XZZWr
	 Vjg9fVYYaLJ/g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f6580c2bbfso45864771fa.1;
        Mon, 16 Sep 2024 01:30:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgKM5hzIFyJ0biZvwUFWtk4zPfNle708zs7t2OTBU/z4tP8ww184s8RSZdMVLpQhMlN0Ae/FJ64DqFISk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnTSvc3exfrQzXjMpA6Jdy9L2boIpX2umb19tdS14Zyfeyls6v
	pAYPAuuEu+mwLYSMtp8PpM8EIBHe5+uLfcOgIsX5pUpgqHNHdstR1s8CyCcU85EYDMQK9PDhAsz
	MdV2bjP1WyRBNX4gvD0qYUl+B9hE=
X-Google-Smtp-Source: AGHT+IEZX4IxWSr7/56EKB8ikJTe+xpkGjICaT97FvK0IV4bmcKJwBp7nEQDn7i8Qq9aphDKzXMZDzUHN4V/mU+NbRY=
X-Received: by 2002:a2e:a58b:0:b0:2f7:708f:d1c6 with SMTP id
 38308e7fff4ca-2f7a4b012d2mr14174991fa.12.1726475399647; Mon, 16 Sep 2024
 01:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913231954.20081-1-gourry@gourry.net> <20240913231954.20081-3-gourry@gourry.net>
In-Reply-To: <20240913231954.20081-3-gourry@gourry.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 16 Sep 2024 10:29:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH+QE+C78n84jRUn6ACUPbO9pU_EeeTcTa-nWitCKpt-Q@mail.gmail.com>
Message-ID: <CAMj1kXH+QE+C78n84jRUn6ACUPbO9pU_EeeTcTa-nWitCKpt-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tpm: do not ignore memblock_reserve return value
To: Gregory Price <gourry@gourry.net>, Dave Young <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org, 
	usamaarif642@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"

(cc Dave)

On Sat, 14 Sept 2024 at 15:26, Gregory Price <gourry@gourry.net> wrote:
>
> tpm code currently ignores a relevant failure case silently.
> Add an error to make this failure non-silent.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/firmware/efi/tpm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 9c3613e6af15..b0cc2cc11d7e 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -61,7 +61,12 @@ int __init efi_tpm_eventlog_init(void)
>         }
>
>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> -       memblock_reserve(efi.tpm_log, tbl_size);
> +       if (memblock_reserve(efi.tpm_log, tbl_size)) {
> +               pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
> +                      efi.tpm_log, tbl_size);
> +               ret = -ENOMEM;
> +               goto out;
> +       }
>

Given the discussion in the other thread, I wonder if this should be
efi_mem_reserve() instead - might as well fix that too.

Dave?


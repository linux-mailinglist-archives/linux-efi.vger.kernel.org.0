Return-Path: <linux-efi+bounces-1606-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843CE960758
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 12:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C82A1F2234D
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4261213B588;
	Tue, 27 Aug 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh1CYYRF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238F8F54;
	Tue, 27 Aug 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754222; cv=none; b=IPSoXJC8QWIHBXm9+zFKp+ciig/7Ql2crnc9NU8JSxKdlQCUeSCo8ZCZtNKYaf/Pj9nUJuMaxOduJQfZs4o0KIq4sgqgQ+yNkRnBFG7WS9uwgVBnFS99xFfIeMbCB3d7AOzjpLLRhgwDWliTpQWSksZombJb71xsmFJass/Oyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754222; c=relaxed/simple;
	bh=FmVs2H9fVl8fLd76/0s13jcKNXHjR7KwW4GTUDCgZwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwvG/gLlmM1ZFOrUoH6NauseVlv/KrlfYML3Qaassh69eWKg/uT874JRp8/KmIXnhm2RMyEb4TXzjwb1o6Lhd367XRz+39Tx0IGnk5J+sgCm7SsEEzssZBbIC3yFBEDVgaE1goJTyzuSv+ddcKIviTLjZHM2/kfArhPTdN59w1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh1CYYRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95322C8B7A0;
	Tue, 27 Aug 2024 10:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724754220;
	bh=FmVs2H9fVl8fLd76/0s13jcKNXHjR7KwW4GTUDCgZwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oh1CYYRFQwf5jTLB4Z/z0FIiLTnD8Te0npL99FxV8r3sxNKXsbJvXjS98Si2TR2WJ
	 T6ZlRX3GYyjvyQLEMAwzzccsVQCTW9qXzOyZjtSWupPJ4enIaYPK0kXuSNeKy7J9EY
	 el08cH5eJpAgvdapcX2pfiYyJahSXBvKG/Wo9VazQbQo0e5ZaWvP4hR25wg51MkLbP
	 pe99biHsx6BeBlLPYaXKLBj/K47cYG0a7RzFxT9eQj8FYOn1reTJFCbzTo4UTm8jR0
	 zP3BdzMCt0z/Mv5lnguS1p/e3P7JOgd1uP7MzoS5gxffo3EW9Sce0/8rwiVP4NwLWz
	 BVaEEEQLQYItg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso53759681fa.2;
        Tue, 27 Aug 2024 03:23:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVKl8uInj5xOlBhhvvYE4a8MM9fS31eMwclhOTqQ4NreP4VZIouTneGMzVnKddipBer0zWhQw1Qqvv@vger.kernel.org, AJvYcCVEBXoNqDA5u1tUekbW843QR4svF5sVf53s3xBl9pi0oByRUezddkK1qdJ8/8CIxER0+5hkfFC2eNUp@vger.kernel.org, AJvYcCWrQtO18ozlOyKT8+H4MYvrr8jrDUP0yIHpK7D1l1qz4GHXJTjqauL1tbXxYJDMRSOm0hW0oMndXS6ZFy/T@vger.kernel.org
X-Gm-Message-State: AOJu0YyTnqzH4VCcBlnSIjf7YqtRpfBFUIkECEigOULWjKeACitvWu3a
	uasOHUWM4EvknAdcBptSqt/NeN5XOYc/Pte6fywwhY8O7PBc9+9GWICCxgVN/SMa8t74rT+4awJ
	9zsHcnSq6zhUHObazxsnMRbns8AU=
X-Google-Smtp-Source: AGHT+IG8JqpafPZFJda1gwsxLaFO95Z3if+yPodfh+gkWBoK4uXw0HSkZtO/iat3COUmo3EiHSR2/ZVuezlgoUt1lak=
X-Received: by 2002:a2e:a547:0:b0:2f0:1d51:a8fa with SMTP id
 38308e7fff4ca-2f514b987f9mr18065741fa.30.1724754218921; Tue, 27 Aug 2024
 03:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823002422.3056599-1-avadhut.naik@amd.com>
In-Reply-To: <20240823002422.3056599-1-avadhut.naik@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Aug 2024 12:23:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFUDy3qSp5q3UxWkuSCLwJ3O3SaFN25f+9tojJL=sFNJQ@mail.gmail.com>
Message-ID: <CAMj1kXFUDy3qSp5q3UxWkuSCLwJ3O3SaFN25f+9tojJL=sFNJQ@mail.gmail.com>
Subject: Re: [PATCH] efi/cper: Print correctable AER information
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-efi@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, 
	james.morse@arm.com, tony.luck@intel.com, ilpo.jarvinen@linux.intel.com, 
	ira.weiny@intel.com, yazen.ghannam@amd.com, avadnaik@amd.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 02:24, Avadhut Naik <avadhut.naik@amd.com> wrote:
>
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>
> Currently, cper_print_pcie() only logs Uncorrectable Error Status, Mask
> and Severity registers along with the TLP header.
>
> If a correctable error is received immediately preceding or following an
> Uncorrectable Fatal Error, its information is lost since Correctable
> Error Status and Mask registers are not logged.
>
> As such, to avoid skipping any possible error information, Correctable
> Error Status and Mask registers should also be logged.
>
> Additionally, ensure that AER information is also available through
> cper_print_pcie() for Correctable and Uncorrectable Non-Fatal Errors.
>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Tested-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  drivers/firmware/efi/cper.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>

Queued for v6.12 - thanks.


> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 7d2cdd9e2227..b69e68ef3f02 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -434,12 +434,17 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
>         "%s""bridge: secondary_status: 0x%04x, control: 0x%04x\n",
>         pfx, pcie->bridge.secondary_status, pcie->bridge.control);
>
> -       /* Fatal errors call __ghes_panic() before AER handler prints this */
> -       if ((pcie->validation_bits & CPER_PCIE_VALID_AER_INFO) &&
> -           (gdata->error_severity & CPER_SEV_FATAL)) {
> +       /*
> +        * Print all valid AER info. Record may be from BERT (boot-time) or GHES (run-time).
> +        *
> +        * Fatal errors call __ghes_panic() before AER handler prints this.
> +        */
> +       if (pcie->validation_bits & CPER_PCIE_VALID_AER_INFO) {
>                 struct aer_capability_regs *aer;
>
>                 aer = (struct aer_capability_regs *)pcie->aer_info;
> +               printk("%saer_cor_status: 0x%08x, aer_cor_mask: 0x%08x\n",
> +                      pfx, aer->cor_status, aer->cor_mask);
>                 printk("%saer_uncor_status: 0x%08x, aer_uncor_mask: 0x%08x\n",
>                        pfx, aer->uncor_status, aer->uncor_mask);
>                 printk("%saer_uncor_severity: 0x%08x\n",
>
> base-commit: fdf969bbceb389f5a7c69e226daf2cb724ea66ba
> --
> 2.34.1
>


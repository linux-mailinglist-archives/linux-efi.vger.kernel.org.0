Return-Path: <linux-efi+bounces-737-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A4D873221
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 10:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A99C28F152
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE95FDD2;
	Wed,  6 Mar 2024 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OCPru/fL"
X-Original-To: linux-efi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8218C5D8EA;
	Wed,  6 Mar 2024 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715785; cv=none; b=LDDvHwkfrNyX5WrhYIeW7jIllr896D50nYBL+lxkYdBrn6ZBulCIpbO0jnJjFmNRnCxKL6IDpyPrpPO4ypAo4lCe+U3mGAhUIIA8W+u3AkJGAmmxukDUHKYMMvkzUf4SUW/3Xcsi/iRBNi6uhgw+RGrOVPKT7xc8FVpw1E2W+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715785; c=relaxed/simple;
	bh=uV64QgV0J/+QZOGrjbCPihXYSBl0rMMCx3JYQNRjgpQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMp4IumhUrTOxv9qQ6E8151uMfCzrS1j0HYpwyAQc33OfhIvjXaUlvj6jNRGem4/DXqATRv8eTdSewMjmfD7U1ECmdq2UYanlzg2sNvldRx0VS7ScWNT9sYtVgjy0G0izWBpkLntvEVXPwF1xXgZSKS+QNLM2iGWpDT7L4XbIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OCPru/fL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709715784; x=1741251784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uV64QgV0J/+QZOGrjbCPihXYSBl0rMMCx3JYQNRjgpQ=;
  b=OCPru/fLr4vtFwkdD8z3eyyxLC68fcBtTxqbAArqopj87JRiU3eczmaT
   AC6ugC2xGLNaIvIn+oSYi8L4RN2iyeuEfRtz5LPk16TPSQ1S68G3P1Z7V
   ascEzgecPjWE2gElAQGgHIbkQNZ+nj39igM+oL2tPwtyxjMcJ1aloXn7u
   6FCg94EQ5pqJCN/k250EPkBcx+05x5vSeioNG5qcv06+rfn9/T3GwtvCo
   phJlX6KDd3rxGSsB9BtsZQYbf1QswDATZUCNL9yDV5wJHLaLcOZ6/t8Ar
   P1CqV3ZiYjjxdDf0ZWdxbfEebcFCsOwU6P+E29GvUuTC1x0pDB+OoJT/F
   Q==;
X-CSE-ConnectionGUID: 4dqBU33OR6GCmN6Rg1LReA==
X-CSE-MsgGUID: ker7b5MQRvW9rJIKupvRzQ==
X-IronPort-AV: E=Sophos;i="6.06,207,1705388400"; 
   d="asc'?scan'208";a="248037788"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 02:03:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 02:02:48 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 6 Mar 2024 02:02:46 -0700
Date: Wed, 6 Mar 2024 09:02:01 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<ardb@kernel.org>, <xuzhipeng.1973@bytedance.com>, <alexghiti@rivosinc.com>,
	<samitolvanen@google.com>, <bp@alien8.de>, <xiao.w.wang@intel.com>,
	<jan.kiszka@siemens.com>, <kirill.shutemov@linux.intel.com>,
	<nathan@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 1/3] Revert "riscv/efistub: Ensure GP-relative addressing
 is not used"
Message-ID: <20240306-zippy-magazine-9a4ecfe1758a@wendy>
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UQFtTkia6S6WEuRu"
Content-Disposition: inline
In-Reply-To: <20240306085622.87248-1-cuiyunhui@bytedance.com>

--UQFtTkia6S6WEuRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 04:56:20PM +0800, Yunhui Cui wrote:
> This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.
>=20
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Reverts are commits too. You still need to write commit messages
justifying the revert.

Thanks,
Conor.

> ---
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi=
/libstub/Makefile
> index 31eb1e287ce1..475f37796779 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)		+=3D -DEFI_HAVE_STRLEN -DEFI_HAVE=
_STRNLEN \
>  				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>  				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>  				   $(call cc-option,-mno-single-pic-base)
> -cflags-$(CONFIG_RISCV)		+=3D -fpic -DNO_ALTERNATIVE -mno-relax
> +cflags-$(CONFIG_RISCV)		+=3D -fpic -DNO_ALTERNATIVE
>  cflags-$(CONFIG_LOONGARCH)	+=3D -fpie
> =20
>  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+=3D -I$(srctree)/scripts/dtc/libfdt
> --=20
> 2.20.1
>=20

--UQFtTkia6S6WEuRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZegw/QAKCRB4tDGHoIJi
0ufrAP0fOFW/zftAQMBV1enoDhJMzqNOQWXj+pDwdOj2qTybjwD/exFfXude+jUl
xvXn4DE7ZGib8U52zF+vq1DDE3/XmgM=
=eSX3
-----END PGP SIGNATURE-----

--UQFtTkia6S6WEuRu--


Return-Path: <linux-efi+bounces-4391-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D433B07D56
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 21:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E742D7A9C1A
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 19:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE0E28507C;
	Wed, 16 Jul 2025 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqtN2jo8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC541BD01D;
	Wed, 16 Jul 2025 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692576; cv=none; b=o+lwEUsnF7SvMGK1RToQ0c4e+UPJoEVC/IJ5opcUtIQsMTPf4vRumm5yNa7C29+aYUl7J3nNF87dKPIpmorwH8cdGYk0bX+/vFfoIJwcZLk/TTinRtOcWRjU+qcb7YmwKJjwHNHuaS9S4slCVeehgbPtyxCkGBv0d5nxal5IQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692576; c=relaxed/simple;
	bh=bef9KrYszCOyAn/Gpb5m62WS2dlMDwaxiTRKKJJ+JWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy2DHvpP7NTY1oYBUixt29ztCpJ7ETsPYplptuHdTm27FwK52ct2cEzgHWQx+QUhqvxbskYUeUpNuG58o0lGmoZ0N6QZ35iEL8Yh+tWIT5idUxPPpO/dq169XS8TnsMDDrhS1n8r57wZqkopM8x/S+A4W2Hd7mag9ZlMuSHREWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqtN2jo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DF1C4CEE7;
	Wed, 16 Jul 2025 19:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752692576;
	bh=bef9KrYszCOyAn/Gpb5m62WS2dlMDwaxiTRKKJJ+JWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqtN2jo823CampHz2Hd0lPbaqmI2x9Jx63+NkKj2EK/tX6O8h7xKuqs34mXPlJ3Dd
	 6X9ukp8/T5ZdKihlxax3A7TnyXKKCadYtSy4WeCtb9xYITSMotAqRn+ChDi3zsgoOk
	 rWPHCfQDhxssIz5nwbkKGUu5YVe87zQfWxEZp65LuJa3Pcq6+J8s950n9EeYcljlpV
	 yNIIf8WsbI5HDivfpXpwuCjBNDa5/KK4G9PwPkdXGJzoXzbZu1mWoWBgZm9xydwEe6
	 m+j0aFWE4Xq2tyOPtiEVI5OE/i9DWqvRo3vpqRAtmWfZafvvP1JjvI5UKQ3T84VHPP
	 ck3Bi6Fp4dY7w==
Date: Wed, 16 Jul 2025 14:02:53 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Steev Klimaszewski <steev@kali.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 5/8] firmware; qcom: scm: enable QSEECOM on SC8280XP
 CRD
Message-ID: <ggqoniunmds7ghvbp4t4kmbas4mr5vm5xvmjv22yznp6sq3bin@j55eff6yxb5b>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-5-aacca9306cee@oss.qualcomm.com>
 <e5e3e8f1-4328-4929-825a-3d8e836cf072@oss.qualcomm.com>
 <95c46d39-5b4a-46dd-aa73-1b3b9bf81019@oss.qualcomm.com>
 <aF6NUeNLPrR5vqEf@hovoldconsulting.com>
 <f55a057d-2cdd-411e-97b9-5ede1300a4e9@oss.qualcomm.com>
 <aF6Tkh75LRym8MQY@hovoldconsulting.com>
 <hf66fa3pvm5jrw3qv57xoofmkoz74ds4g3nwzsdz7pip6e7nej@w3h7qn7qu457>
 <aGKAOtgJtTozo-ac@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGKAOtgJtTozo-ac@hovoldconsulting.com>

On Mon, Jun 30, 2025 at 02:16:58PM +0200, Johan Hovold wrote:
> On Sat, Jun 28, 2025 at 05:50:49PM +0300, Dmitry Baryshkov wrote:
> > On Fri, Jun 27, 2025 at 02:50:26PM +0200, Johan Hovold wrote:
> > > On Fri, Jun 27, 2025 at 02:26:41PM +0200, Konrad Dybcio wrote:
> > > > On 6/27/25 2:23 PM, Johan Hovold wrote:
> > > > > On Fri, Jun 27, 2025 at 01:54:37AM +0200, Konrad Dybcio wrote:
> > > > >> On 6/27/25 1:34 AM, Konrad Dybcio wrote:
> > > > >>> On 6/25/25 12:53 AM, Dmitry Baryshkov wrote:
> > > 
> > > > >>>> As reported by Johan, this platform also doesn't currently support
> > > > >>>> updating of the UEFI variables. In preparation to reworking match list
> > > > >>>> for QSEECOM mark this platform as supporting QSEECOM with R/O UEFI
> > > > >>>> variables.
> > > 
> > > > >>>> +	{ .compatible = "qcom,sc8280xp-crd", .data = &qcom_qseecom_ro_uefi, },
> > > > >>>
> > > > >>> R/W works for me (tm).. the META version may be (inconclusive) 2605
> > > > >>
> > > > >> Looked at the wrong SoC META table.. the build date is 05/25/2023
> > > > > 
> > > > > Could be that my machine was not provisioned properly. Do you boot from
> > > > > UFS or NVMe?
> > > > > 
> > > > > My fw is also older: 01/10/2022.
> > > > 
> > > > The machine has UFS, NVME and SPINOR, however the boot log definitely says:
> > > > 
> > > > S - Boot Interface: SPI
> > > 
> > > Mine says:
> > > 
> > > S - Boot Interface: UFS
> > 
> > Is this META even supported? I think it's recommended to update
> > firmware to the latest releases.
> 
> It most likely has nothing to do with the meta version, but whether you
> boot from SPI-NOR or UFS.
> 

It would make sense that the UFS firmware then acts as the firwmare on
any other UFS-based device relies on UFS for EFI variable storage -
using yet to be implemented mechanisms. This would explain why you don't
have persistent storage on your device after ExitBootServices...

Regards,
Bjorn

> Johan


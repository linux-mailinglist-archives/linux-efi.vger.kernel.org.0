Return-Path: <linux-efi+bounces-4050-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E1AEDC82
	for <lists+linux-efi@lfdr.de>; Mon, 30 Jun 2025 14:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B342C3A9BF2
	for <lists+linux-efi@lfdr.de>; Mon, 30 Jun 2025 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2124242905;
	Mon, 30 Jun 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJwRz5aA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B140123ABB4;
	Mon, 30 Jun 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285819; cv=none; b=JmIqGL1RBz4mjQZb+IGwoeIASAPHPYGGx1tiL+DXJRHM46wA56byOb4S1Q/Xpkb76tGOc1m7wcy+5JNTZHCpGGhMKak6UbUXDEFW/ckn871tHWjrOzR41sx6SCZqrxFGvAJwNhfnhIrHTdC0q8+B7JXOomjrYcvCjUS138+hmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285819; c=relaxed/simple;
	bh=uQZcfFAB5Bb7SjYLcY68iLqgdgJyMWcOHBypnwxmhyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDnXnUI9BUpep3PJ7L0K7HhuVwJ4qg+lhbF7MURUfgQaTxdXW4RZzcGMmUbZfPvWTkukO5lkrm2QAJfnmQDYwBq2fDY1r6RuKEeMxurSZe5BsXejBqIxmOzpu710cBXOQB2lMCb3oH7Q6Qk3HsTUzCTgSZaz8g/upnRGqb4HbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJwRz5aA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F761C4CEEF;
	Mon, 30 Jun 2025 12:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751285819;
	bh=uQZcfFAB5Bb7SjYLcY68iLqgdgJyMWcOHBypnwxmhyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJwRz5aAx7jcJWw3lPuS9bGqoAON5GghHR6EAD4CeEveFyp8xg0HqbF6gz55DJmMU
	 ZEIBv21SrhR4w0wsY9/HByBgu6JyHJZK+nOp5XSYS4J8kX07n6MuEUjT9O40vSbonu
	 9hLrH273cP1ATUIrlmOZADP5+mlE9UpJIqELHVhfasHhyxNbPdQ0RNknHlNZn5SuNm
	 FHnFDRlv7jRC5oBpfDNY3xJe+ojUlVqmwYU1U6SQ/pAAP1sP5LHKNuM/whPLftD6GY
	 i0P8ysPMnqdN1jehMy8i6PedO2J/jEl+VGounXt06p0ttnPKMWeZM4sVPXKaM5x/Wa
	 e5PO5kbeqCkZw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uWDRS-000000007l6-0dNF;
	Mon, 30 Jun 2025 14:16:58 +0200
Date: Mon, 30 Jun 2025 14:16:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 5/8] firmware; qcom: scm: enable QSEECOM on SC8280XP
 CRD
Message-ID: <aGKAOtgJtTozo-ac@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-5-aacca9306cee@oss.qualcomm.com>
 <e5e3e8f1-4328-4929-825a-3d8e836cf072@oss.qualcomm.com>
 <95c46d39-5b4a-46dd-aa73-1b3b9bf81019@oss.qualcomm.com>
 <aF6NUeNLPrR5vqEf@hovoldconsulting.com>
 <f55a057d-2cdd-411e-97b9-5ede1300a4e9@oss.qualcomm.com>
 <aF6Tkh75LRym8MQY@hovoldconsulting.com>
 <hf66fa3pvm5jrw3qv57xoofmkoz74ds4g3nwzsdz7pip6e7nej@w3h7qn7qu457>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hf66fa3pvm5jrw3qv57xoofmkoz74ds4g3nwzsdz7pip6e7nej@w3h7qn7qu457>

On Sat, Jun 28, 2025 at 05:50:49PM +0300, Dmitry Baryshkov wrote:
> On Fri, Jun 27, 2025 at 02:50:26PM +0200, Johan Hovold wrote:
> > On Fri, Jun 27, 2025 at 02:26:41PM +0200, Konrad Dybcio wrote:
> > > On 6/27/25 2:23 PM, Johan Hovold wrote:
> > > > On Fri, Jun 27, 2025 at 01:54:37AM +0200, Konrad Dybcio wrote:
> > > >> On 6/27/25 1:34 AM, Konrad Dybcio wrote:
> > > >>> On 6/25/25 12:53 AM, Dmitry Baryshkov wrote:
> > 
> > > >>>> As reported by Johan, this platform also doesn't currently support
> > > >>>> updating of the UEFI variables. In preparation to reworking match list
> > > >>>> for QSEECOM mark this platform as supporting QSEECOM with R/O UEFI
> > > >>>> variables.
> > 
> > > >>>> +	{ .compatible = "qcom,sc8280xp-crd", .data = &qcom_qseecom_ro_uefi, },
> > > >>>
> > > >>> R/W works for me (tm).. the META version may be (inconclusive) 2605
> > > >>
> > > >> Looked at the wrong SoC META table.. the build date is 05/25/2023
> > > > 
> > > > Could be that my machine was not provisioned properly. Do you boot from
> > > > UFS or NVMe?
> > > > 
> > > > My fw is also older: 01/10/2022.
> > > 
> > > The machine has UFS, NVME and SPINOR, however the boot log definitely says:
> > > 
> > > S - Boot Interface: SPI
> > 
> > Mine says:
> > 
> > S - Boot Interface: UFS
> 
> Is this META even supported? I think it's recommended to update
> firmware to the latest releases.

It most likely has nothing to do with the meta version, but whether you
boot from SPI-NOR or UFS.

Johan


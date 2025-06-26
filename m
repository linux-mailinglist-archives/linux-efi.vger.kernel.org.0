Return-Path: <linux-efi+bounces-4015-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D575AE9E17
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 15:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076FC1C2625D
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D12E426E;
	Thu, 26 Jun 2025 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d97u/9rd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFE1D5CD7;
	Thu, 26 Jun 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942955; cv=none; b=hHv65hFzkVF2IuQNMEhq0KMDGcB2MEkUhWlBFmLhUGpgJjfWk4N0b1eK1xrDbZ2up9vCKnQgekQhb2FW1BJpDIMZsZXNR5Hwz6mi9jz9pOJHLasLUj1XjOS7bcsmvCei1bjcQyLxAxER9wE8rl/dGGMiwMGrbBtu7+kxcSPZkqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942955; c=relaxed/simple;
	bh=B9wUOZTtzw7U+McrdNxlBvk4qao6W70+MTISb8uB31E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZxsCbGUSiK8Z2bYv4b8Uu919bJ/wD+XWGd9xMuxaXV0fUOSvAQCHX4FUyt33bg1IUtidDGIkDyohQCICIjOh3Y2PiG0jd33A5V1p+dODm47FcYNq4n7bIh3DPHldZSjxuZyHEjjpPhHnX/vhXCk5euKcNETjd1j7Dnr5K8q1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d97u/9rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9553CC4CEEE;
	Thu, 26 Jun 2025 13:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750942953;
	bh=B9wUOZTtzw7U+McrdNxlBvk4qao6W70+MTISb8uB31E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d97u/9rd4UUJdL+gccU/JkXG8I08gH5sa2Gy0tHeIYgPl6AE2mXqoaIehOQf4lpUo
	 hoKDlOkTwuqXTjtjP8Ljgc1Jeeb3WHOb8qOnyjKBvF+upRFoA+B8/T1SxagvN6l16x
	 q6HD3TEq8fZUr4vyL5Ewl9uh5N/XftHmmbRkXG0z3bToIXvdpie7Kj7x9fEoACjJco
	 7hzQPzrqzrcFkGHNxVTmqa9AncMmVOcFRLN0SNoH02yKKbtAdDB9TpWBMx4k3M1+k2
	 Vs53yvWGuzl/Hr0vIKRZ3uMmBis/cSAEUXbKOX1ZiJ5iOaHipnjHdbd6pjbjJlbDC4
	 cjHdEjd6q/V+g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUmFN-000000002Qu-3bt6;
	Thu, 26 Jun 2025 15:02:33 +0200
Date: Thu, 26 Jun 2025 15:02:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 7/8] firmware: qcom: scm: rework QSEECOM allowlist
Message-ID: <aF1E6VfnYMydhib8@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-7-aacca9306cee@oss.qualcomm.com>
 <aF0ZMcVcgHpqsKoG@hovoldconsulting.com>
 <3jrz5dtblgmacp32zda6yai76qkp3wxzj5axj7cwnzpdgk3uxr@5tnwyayvzlyu>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3jrz5dtblgmacp32zda6yai76qkp3wxzj5axj7cwnzpdgk3uxr@5tnwyayvzlyu>

On Thu, Jun 26, 2025 at 02:09:08PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 26, 2025 at 11:56:01AM +0200, Johan Hovold wrote:
> > On Wed, Jun 25, 2025 at 01:53:26AM +0300, Dmitry Baryshkov wrote:

> > > +	{ .compatible = "qcom,sc8180x", },
> > > +	{ .compatible = "qcom,sc8280xp", },
> > >  	{ .compatible = "qcom,sc8280xp-crd", .data = &qcom_qseecom_ro_uefi, },
> > 
> > You need to have the machine specific entries before the SoC fallbacks
> > for this to work.
> 
> I don't think so. It's not how OF matching works.

Ah, right, too used to USB matching.

Johan


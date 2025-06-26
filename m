Return-Path: <linux-efi+bounces-4003-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0485EAE9AED
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 12:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97C93A7416
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A94221CC62;
	Thu, 26 Jun 2025 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha4LBTh+"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDF221CA0E;
	Thu, 26 Jun 2025 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932680; cv=none; b=cTsiKu8fwX5IKjZ8bsaNPdE3PCxJ8C2Zh0r2l9xPLm6qDGea8+/p5YrugwVuzbZ29nIt9We+cV0dBJR4yjx3lUZGoam8PL1HLq5aKuajYSgfDPFWK8EupCttvsFvkB7/sFrfIj+kfAKntYnZcDSXLEJRPpXMepW7UgQYiv3idLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932680; c=relaxed/simple;
	bh=hk5xqBm8kcJRDQ/Tpz/eCbR4dHy273+yDFMPzSNURyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSvEaxEaXCshRcz1Zlw7Hbh6BTU57yE31kA7yQtxAyMCgDp9QE4wz5c4sVMsfMIHPUeT+l6e/W7Io1SvmskMsm8sO788FpT8hxp2lqOElSIPNjBQ+tgSY3fJTnJdCOdFMeQdUsGwkSzNQCGbs6nHXnv2vN3kzNOb6LsVe/GZUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha4LBTh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B53C4CEEB;
	Thu, 26 Jun 2025 10:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750932680;
	bh=hk5xqBm8kcJRDQ/Tpz/eCbR4dHy273+yDFMPzSNURyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ha4LBTh+lw+wR4M5R9ROgQmZ2LE1GHd2O6WtlAqkpSBlnoeG1H2Wo0Lqn0JOiZ3YM
	 ZgaOnGSxc21WeJbCm5Ofp8+vZWwy8scQ1rzmvdd2G/h9INXD84c7irH/r+WG0qmcAC
	 39X4yF/gfjIFvHOgokN7L2XB3IWBsAHTeTdF5rvWn8H1HjsdVNayUPZtHcLKyV6RqL
	 Dn/sqdIxDdvh27yL6wDTMB6t3UKKbBdEfCSoPoNxigstYB8VN01o4lsQiWy4YmXKs6
	 FqiY+LqLZ5h0XARdKKcioygv3yvnwzgLVrBKfihivMlVHllwwRTlLPw/6h5zCfNwj5
	 bo0Q6uGVDbUHQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUjZg-000000007ks-02Ya;
	Thu, 26 Jun 2025 12:11:20 +0200
Date: Thu, 26 Jun 2025 12:11:20 +0200
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
Subject: Re: [PATCH v4 6/8] firmware: qcom: scm: add modparam to control
 QSEECOM enablement
Message-ID: <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>

On Wed, Jun 25, 2025 at 01:53:25AM +0300, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> In preparation to enabling QSEECOM for the platforms rather than
> individual machines provide a mechanism for the user to override default
> selection. Allow users to use qcom_scm.qseecom modparam.
> 
> Setting it to 'force' will enable QSEECOM even if it disabled or not
> handled by the allowlist.
> 
> Setting it to 'off' will forcibly disable the QSEECOM interface,
> allowing incompatible machines to function.
> 
> Setting it to 'roefivars' will enable the QSEECOM interface, making UEFI
> variables read-only.
> 
> All other values mean 'auto', trusting the allowlist in the module.

I don't see the need for this. The kernel should just provide sensible
defaults.

Johan


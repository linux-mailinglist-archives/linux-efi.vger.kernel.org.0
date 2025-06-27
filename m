Return-Path: <linux-efi+bounces-4037-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4705BAEB795
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 14:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39901C43234
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78C729C32C;
	Fri, 27 Jun 2025 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEHFYzri"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DEA2192FC;
	Fri, 27 Jun 2025 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751027025; cv=none; b=rIcx+ZI5jNbki/7eLdMjuxauaV+dCLxyQ6XmF7uJbG2MElTUy54hMmxrRh9xQd5cALt8ebNOekIZLMsqyK1UbG04kb2G7GSuiYUsfcNO1uQtOxzJXeJ96rBqixcxSw1QoQFssX0dPD7idpFC9Ib4NaU2JHoylMpPtYMn29qqfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751027025; c=relaxed/simple;
	bh=qahv5Tq7jGF0NN87NRcfiY7/L+h4popzWEl2wIA/lfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP//+n6mU2rNfUdQmJM9MS20ZmpRhpwP5LDyKGpQOkk2caBeV2W6iA3VcElGYg6zFxeoikThlr5CJEGZkq2h1qudBBHVu9twzzt1lAx27iz3mR5Xn8oMN13BaWWs4tHz6LFKYw5hnqBLIroxKaAX8hOh2nan1Jmt8Jr3zw6qX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEHFYzri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055C6C4CEE3;
	Fri, 27 Jun 2025 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751027025;
	bh=qahv5Tq7jGF0NN87NRcfiY7/L+h4popzWEl2wIA/lfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cEHFYzriJIlpqczXymVQz2pn20PPw8mIG5uwsQJm7hv6/D666vHwKsHni7VAQ4vEY
	 +RsImDw0KQ+70cJwRk22bDVw41KLm37WaXiWSxSEw5W7E77YWrHB9TzibiUSDyMgSH
	 D004oP8nMRMA9pKw4bj21U3u4Je/8xdKvEvNB7p1Sn0pmILtifdtJXM6dn9ToDly95
	 WEnMhELaCbp+3grE9GYoahIBOOfZdtKfHhVcPSHV5PkaJtAzhuTFu4anBXhHhBT112
	 EPY4m425LTmyrHVdwF70/d5D+ydUjmUovSmti39riDiYXGfpVD8iAPZsycu1D1Hc9R
	 YlE6OEWQ1QQAw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uV87N-000000004aq-3DSO;
	Fri, 27 Jun 2025 14:23:45 +0200
Date: Fri, 27 Jun 2025 14:23:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
Message-ID: <aF6NUeNLPrR5vqEf@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-5-aacca9306cee@oss.qualcomm.com>
 <e5e3e8f1-4328-4929-825a-3d8e836cf072@oss.qualcomm.com>
 <95c46d39-5b4a-46dd-aa73-1b3b9bf81019@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95c46d39-5b4a-46dd-aa73-1b3b9bf81019@oss.qualcomm.com>

On Fri, Jun 27, 2025 at 01:54:37AM +0200, Konrad Dybcio wrote:
> On 6/27/25 1:34 AM, Konrad Dybcio wrote:
> > On 6/25/25 12:53 AM, Dmitry Baryshkov wrote:
> >> As reported by Johan, this platform also doesn't currently support
> >> updating of the UEFI variables. In preparation to reworking match list
> >> for QSEECOM mark this platform as supporting QSEECOM with R/O UEFI
> >> variables.
> >>
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >> ---
> >>  drivers/firmware/qcom/qcom_scm.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> >> index dbb77c3f69ddaa931e7faa73911207a83634bda1..27ef2497089e11b5a902d949de2e16b7443a2ca4 100644
> >> --- a/drivers/firmware/qcom/qcom_scm.c
> >> +++ b/drivers/firmware/qcom/qcom_scm.c
> >> @@ -2005,6 +2005,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
> >>  	{ .compatible = "microsoft,romulus13", },
> >>  	{ .compatible = "microsoft,romulus15", },
> >>  	{ .compatible = "qcom,sc8180x-primus" },
> >> +	{ .compatible = "qcom,sc8280xp-crd", .data = &qcom_qseecom_ro_uefi, },
> > 
> > R/W works for me (tm).. the META version may be (inconclusive) 2605
> 
> Looked at the wrong SoC META table.. the build date is 05/25/2023

Could be that my machine was not provisioned properly. Do you boot from
UFS or NVMe?

My fw is also older: 01/10/2022.

Johan


Return-Path: <linux-efi+bounces-4014-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665B0AE9DF7
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 14:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1157F3B5787
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2252E1C50;
	Thu, 26 Jun 2025 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3yxb+Cs"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7392DFF0D;
	Thu, 26 Jun 2025 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942733; cv=none; b=T98Vcy329cZHks5ouqtAvowE/6F7h6nReQEladQ0PdLHMtQUykklKokPzqJZid5vbtqByB521FV7J5K58h/GxYt1lbhvRTvvCk5Uqs6C1NEp/dOg4hvcITYixvUEhKnQ01mXDnuIV/ZEF7tA7uZRCf9cSYkdb9FvGlHFVW7xn20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942733; c=relaxed/simple;
	bh=gIcKzGmixtfuDAqr28LKW77me+FkhQYqRYpW4sob8MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6n40c4U/oeX3si8KngKZdZQHJ7j9URl2SXmh5XM6VqwwIP9NPNdbN4QANGMpZHjZspR0o8rpx6NtxieuUTd1eqUalsQ7PolhT1Ikn14zoLAFHnvLpeVWnRWpxH8zVlM9GXp2jQuXBwFK2vaGJjQw7pRYPjbTtRWUjElPzI4B1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3yxb+Cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD6CC4CEEB;
	Thu, 26 Jun 2025 12:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750942733;
	bh=gIcKzGmixtfuDAqr28LKW77me+FkhQYqRYpW4sob8MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3yxb+CspUY3rHCqPrnM1Zjq+hc/pNGKpABNh8Inc4a/hmAdYL3UB+eR4KhfJYJi9
	 SpkOaVZQDf7UEoQU3NTywHCdnKQIXT3N6llYUOsKBO7rHoxuiBGji4hLfI4aFvokkJ
	 Rz8qhhx3vD/R+09HLo0a6wxrEl0Pvs7egSYmbFqBGkxOEzXjTrS5T3teYYrGIB874a
	 PjFDvWaEGx4+dL5QSl+aUpFQ1jzxmbVr9VCu3tzxjBXQGChu7OGPU6clBR9ci0Olo0
	 dE3c+z5g3JBnLxtrS74gn6g3jdObkK1WXYRsVhyq2BCYLYzYoObxWi5OTSTi16q6PL
	 gPyHxiua6av9g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUmBo-000000002MI-2T8s;
	Thu, 26 Jun 2025 14:58:53 +0200
Date: Thu, 26 Jun 2025 14:58:52 +0200
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
Message-ID: <aF1EDMsw1KQTlteX@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
 <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
 <gqoba4uu62sh4qxapqkhlufxnliatevnsqcxvijvb74tposf2b@iyonh347aext>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gqoba4uu62sh4qxapqkhlufxnliatevnsqcxvijvb74tposf2b@iyonh347aext>

On Thu, Jun 26, 2025 at 02:08:23PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 26, 2025 at 12:11:20PM +0200, Johan Hovold wrote:
> > On Wed, Jun 25, 2025 at 01:53:25AM +0300, Dmitry Baryshkov wrote:
> > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > 
> > > In preparation to enabling QSEECOM for the platforms rather than
> > > individual machines provide a mechanism for the user to override default
> > > selection. Allow users to use qcom_scm.qseecom modparam.
> > > 
> > > Setting it to 'force' will enable QSEECOM even if it disabled or not
> > > handled by the allowlist.
> > > 
> > > Setting it to 'off' will forcibly disable the QSEECOM interface,
> > > allowing incompatible machines to function.
> > > 
> > > Setting it to 'roefivars' will enable the QSEECOM interface, making UEFI
> > > variables read-only.
> > > 
> > > All other values mean 'auto', trusting the allowlist in the module.
> > 
> > I don't see the need for this. The kernel should just provide sensible
> > defaults.
> 
> It does provide _defaults_. However with the next commit we mass-enable
> QSEECOM for SoC families, which includes untested WoA devices. If the
> user observes a misbehaviour of the UEFI vars or any other
> QSEECOM-related driver on those platforms, it is much easier to let
> users test and workaround UEFI misbehaviour.

You basically know by now which machines supports qseecom and which do
not, right (e.g. UFS storage means non-persistent EFI vars)?

And it's a pretty bad user experience to have people trying to write
efivariables when setting up a machine and then spend hours trying to
debug why they don't persist after a reboot.

I don't think that's fair to users.

Let whoever brings up a new machine figure this out. It's just one
entry, no scaling issues, and we get accurate information (unless
Qualcomm, who sits on the documentation, is willing to provide it
upfront).

Johan


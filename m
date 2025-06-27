Return-Path: <linux-efi+bounces-4040-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0868CAEB803
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 14:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B664F179088
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5B62D8DBA;
	Fri, 27 Jun 2025 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKGU4jzr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A83243399;
	Fri, 27 Jun 2025 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028398; cv=none; b=coNkJ9t1qwdfbrXm3c2J2lzejaOQpV2NAygAHpZ4k6Qu+8squVoUJm2EA4PL7sPErIfQTggrRWmRrFFL1xq0ksghdqN391f/uN1DPHlQKBQZEzcOH2YXiA1X2Rl3Jt5+HvEipfWWPRL2vfdKj/I4HZ1e18EfPKFp/EhuEBdxexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028398; c=relaxed/simple;
	bh=hdRIwaQfjGhQfLcNXhzn0OydMzDP3qq9qBl4cnmChyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XX5mC0j83yp+/yJUvoLyXnx3+FKAJORySqsFs5xwRVBuwQHPj/s9ltcDYQQq5tnBvGx2nBj7n7Pqd5SHITzoqtAAudZhnWGeTZfGpgSdw6LUly7ui23BB6/V4lhdh0KeLy15miaCWAZ+9BgY8CzlkaQsc/lzQ1uvzagMOOjCJxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKGU4jzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7E0C4CEE3;
	Fri, 27 Jun 2025 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751028398;
	bh=hdRIwaQfjGhQfLcNXhzn0OydMzDP3qq9qBl4cnmChyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WKGU4jzrOAQ0YhJEF1QiGBDgYvudn1jp2XBz2jhdVuS7y5vYnRfaHhKz0lkSWyF4l
	 c8B1My0vnbo25JcYJYqaEuIQVlYDoQqh7ozm043LvkflWYSkMlcZGyg+i+a6Nc1Vyn
	 hBiPJmZdXZ9BF7aCuqeqY82BKTNoKDm+J5RRrc6rZ6mOZtIqmxd5e8oMn8y4qXVEsZ
	 A9cg1L2LjERIljLumAF3ED17CZxe/B/9Jsijsef3pFoIXaRZXEZG6A869MOWQ/FuDS
	 7Eh/7LtHcR2ERwlhk0JtDn6TpM3j3lTsqck+oXdRX/s91yhj0uvpYAUjZYiP6PjNZY
	 nxLapsirq2mOQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uV8TW-000000004ti-0CrG;
	Fri, 27 Jun 2025 14:46:38 +0200
Date: Fri, 27 Jun 2025 14:46:38 +0200
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
Message-ID: <aF6Srse7BhDJkQiH@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
 <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
 <gqoba4uu62sh4qxapqkhlufxnliatevnsqcxvijvb74tposf2b@iyonh347aext>
 <aF1EDMsw1KQTlteX@hovoldconsulting.com>
 <cjinqyqn7qgvdoltoywxa2lq6bjyfrotmon3iv24tqt3bpdlpe@3xb2k42ffegj>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cjinqyqn7qgvdoltoywxa2lq6bjyfrotmon3iv24tqt3bpdlpe@3xb2k42ffegj>

On Fri, Jun 27, 2025 at 02:33:27AM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 26, 2025 at 02:58:52PM +0200, Johan Hovold wrote:
> > On Thu, Jun 26, 2025 at 02:08:23PM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Jun 26, 2025 at 12:11:20PM +0200, Johan Hovold wrote:
> > > > On Wed, Jun 25, 2025 at 01:53:25AM +0300, Dmitry Baryshkov wrote:
> > > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > 
> > > > > In preparation to enabling QSEECOM for the platforms rather than
> > > > > individual machines provide a mechanism for the user to override default
> > > > > selection. Allow users to use qcom_scm.qseecom modparam.
> > > > > 
> > > > > Setting it to 'force' will enable QSEECOM even if it disabled or not
> > > > > handled by the allowlist.
> > > > > 
> > > > > Setting it to 'off' will forcibly disable the QSEECOM interface,
> > > > > allowing incompatible machines to function.
> > > > > 
> > > > > Setting it to 'roefivars' will enable the QSEECOM interface, making UEFI
> > > > > variables read-only.
> > > > > 
> > > > > All other values mean 'auto', trusting the allowlist in the module.
> > > > 
> > > > I don't see the need for this. The kernel should just provide sensible
> > > > defaults.
> > > 
> > > It does provide _defaults_. However with the next commit we mass-enable
> > > QSEECOM for SoC families, which includes untested WoA devices. If the
> > > user observes a misbehaviour of the UEFI vars or any other
> > > QSEECOM-related driver on those platforms, it is much easier to let
> > > users test and workaround UEFI misbehaviour.
> > 
> > You basically know by now which machines supports qseecom and which do
> > not, right (e.g. UFS storage means non-persistent EFI vars)?

Do you have a theory about why on some platforms, like the one you're
currently adding support for, writing UEFI variables does not work?

Can you please include that information in the series so we can consider
alternate routes for replacing the current whitelist with this black and
white thing you're going for.

Is it related to UFS at all, for example?

> > And it's a pretty bad user experience to have people trying to write
> > efivariables when setting up a machine and then spend hours trying to
> > debug why they don't persist after a reboot.
> > 
> > I don't think that's fair to users.
> 
> So, is it a user or a developer, trying to port Linux to a new hardware?
> Also, R/O implementation makes it obvious, that the variables do not
> persist.

A developer enabling support for a new platform can patch the driver and
does not need a command line option.

If you enable it by default, suddenly a bunch of end-users are going to
have to debug why storing efi variables silently fails. That would not
be fair to them.

> > Let whoever brings up a new machine figure this out. It's just one
> > entry, no scaling issues, and we get accurate information (unless
> > Qualcomm, who sits on the documentation, is willing to provide it
> > upfront).
> 
> And that's not really scallable. All other parts of a particular device
> are described by the DT only (that's especially true on the PMIC GLINK
> machines). If we are to support new laptop in e.g. distro kernel, we
> need to provide a DT... and a patch for qcom-scm driver. I'd very much
> prefer to do it other way around: provide a DT and patch qcom-scm if the
> laptop is any way different from other laptops. E.g. we know that all
> X1Elite laptops support R/W EFI variables.

But this is just kicking the can and putting the burden on someone else.
Now a user or distro would need to pass command line parameters after
spending time debugging why efi variable updates do not persist after a
reboot.

If we know with reasonable certainty that all, say X1E, devices works,
then that that's one thing.

But if this series now enables broken EFI variable support on every
other device then I don't think that's ok (even if you provide a command
line parameter that each user now have to pass).

Then I'd rather see a proposal for how to determine which machines
support this or not, information which was not available when this
interface was reverse engineered and where a conservative whitelist
approach made perfect sense.

> Except for X1-CRD, which deserves an entry in the driver.

I think you meant my sc8280xp CRD here.

Johan


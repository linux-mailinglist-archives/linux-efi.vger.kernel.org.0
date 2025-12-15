Return-Path: <linux-efi+bounces-5840-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0AECBCDB2
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 08:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A0BD300A354
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 07:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141B329361;
	Mon, 15 Dec 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyjrkH6K"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C430E82B;
	Mon, 15 Dec 2025 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765785267; cv=none; b=FGamO8XXnM/QVtcLsaxVS/YkcrtN941U32wyMRnriYLYGr9fynRmXl8SHXqZ/t0Vb6bFeA8f0gEhKXBjbQyN2SmfUsYmFt5TMHkXtf6DbZHTprnyaDXVuwG+N1K2CFaSEEh62NAMbaYmCYAIKl6S2XjXrKPWynBXRXUCzFW1Rws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765785267; c=relaxed/simple;
	bh=v/92elu0+HvI8sObJNUPXdOl7LjF+U9jY1BY0X5X81M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHFcx4Sv+o64YYpvTXIoPB1wqMm7zI9VX8Jlrq/7TRxJ8hxIyV6GQkm5871DWen/IbVvQtXohl3a8nTSh6FapNMSh+WzrqzKDg3Xwjhf42/0NCiGa5J+VWuRVE3nGx0ki2/aSfrCP3PwxJQBgDS2Y3YqGogFDSclbjDa8rRjETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyjrkH6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22802C19421;
	Mon, 15 Dec 2025 07:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765785266;
	bh=v/92elu0+HvI8sObJNUPXdOl7LjF+U9jY1BY0X5X81M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyjrkH6KtnThxV3unDn7bby/GiiSiQSPftVpABjisSWU2uFJUOSoLOiJ1XOF8YjOp
	 I40Nc0tRoSWwyXZw3oFdsyqnAaagma7510sWIAUaNrX4+PjLfSRLD+et/jmtmNvL+p
	 fd4Yahc3vd/qAeYLCUCQr2QPTBPU15ibXG263IfBgtMJdpwq5a9dE2n/RsAVjJh07f
	 tBknFVn5nsVHGveX55SVFDgvPqaXIiTsXroBhscCr8hxdkkc2/x2GJwzqKuPDYEuTo
	 2nEzH829pMn8wb+YSsr4CldmREQ2VzSqT1cZK03HP02QTa8mhN+yfwFBVy6LBXOcO0
	 DVK3rvhjXpeNg==
Date: Mon, 15 Dec 2025 16:54:11 +0900
From: Sumit Garg <sumit.garg@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, netdev@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1 00/17] tee: Use bus callbacks instead of driver
 callbacks
Message-ID: <aT--ox375kg2Mzh-@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>

On Thu, Dec 11, 2025 at 06:14:54PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> the objective of this series is to make tee driver stop using callbacks
> in struct device_driver. These were superseded by bus methods in 2006
> (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
> methods.")) but nobody cared to convert all subsystems accordingly.
> 
> Here the tee drivers are converted. The first commit is somewhat
> unrelated, but simplifies the conversion (and the drivers). It
> introduces driver registration helpers that care about setting the bus
> and owner. (The latter is missing in all drivers, so by using these
> helpers the drivers become more correct.)
> 
> The patches #4 - #17 depend on the first two, so if they should be
> applied to their respective subsystem trees these must contain the first
> two patches first.

Thanks Uwe for your efforts to clean up the boilerplate code for TEE bus
drivers.

> 
> Note that after patch #2 is applied, unconverted drivers provoke a
> warning in driver_register(), so it would be good for the user
> experience if the whole series goes in during a single merge window.

+1

I suggest the whole series goes via the Jens tree since there shouldn't
be any chances for conflict here.

> So
> I guess an immutable branch containing the frist three patches that can
> be merged into the other subsystem trees would be sensible.
> 
> After all patches are applied, tee_bus_type can be made private to
> drivers/tee as it's not used in other places any more.
> 

Feel free to make the tee_bus_type private as the last patch in the series
such that any followup driver follows this clean approach.

-Sumit

> Best regards
> Uwe
> 
> Uwe Kleine-König (17):
>   tee: Add some helpers to reduce boilerplate for tee client drivers
>   tee: Add probe, remove and shutdown bus callbacks to tee_client_driver
>   tee: Adapt documentation to cover recent additions
>   hwrng: optee - Make use of module_tee_client_driver()
>   hwrng: optee - Make use of tee bus methods
>   rtc: optee: Migrate to use tee specific driver registration function
>   rtc: optee: Make use of tee bus methods
>   efi: stmm: Make use of module_tee_client_driver()
>   efi: stmm: Make use of tee bus methods
>   firmware: arm_scmi: optee: Make use of module_tee_client_driver()
>   firmware: arm_scmi: Make use of tee bus methods
>   firmware: tee_bnxt: Make use of module_tee_client_driver()
>   firmware: tee_bnxt: Make use of tee bus methods
>   KEYS: trusted: Migrate to use tee specific driver registration
>     function
>   KEYS: trusted: Make use of tee bus methods
>   tpm/tpm_ftpm_tee: Make use of tee specific driver registration
>   tpm/tpm_ftpm_tee: Make use of tee bus methods
> 
>  Documentation/driver-api/tee.rst             | 18 +----
>  drivers/char/hw_random/optee-rng.c           | 26 ++----
>  drivers/char/tpm/tpm_ftpm_tee.c              | 31 +++++---
>  drivers/firmware/arm_scmi/transports/optee.c | 32 +++-----
>  drivers/firmware/broadcom/tee_bnxt_fw.c      | 30 ++-----
>  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 25 ++----
>  drivers/rtc/rtc-optee.c                      | 27 ++-----
>  drivers/tee/tee_core.c                       | 84 ++++++++++++++++++++
>  include/linux/tee_drv.h                      | 12 +++
>  security/keys/trusted-keys/trusted_tee.c     | 17 ++--
>  10 files changed, 164 insertions(+), 138 deletions(-)
> 
> 
> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> -- 
> 2.47.3
> 


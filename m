Return-Path: <linux-efi+bounces-3012-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 662C8A65C11
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 19:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8F119A0365
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C511DB13A;
	Mon, 17 Mar 2025 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO/hjj+n"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DD51D934D;
	Mon, 17 Mar 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235037; cv=none; b=XAIvzORlao7sqDcLZvBBb5W2Fc6yXLR+oIeMHJ7LMz1pVwWWSBJSLiuzEMtVBIbHGOjskEbQy9PA/1tRhRSi58CLapXIjGaRN6X9Pdw+SzU/Off5rxn1fUv2niKrh1rjcWzj32IMaLF9YijptK6NIUDKOade1JX7lZncjEg0NXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235037; c=relaxed/simple;
	bh=rT/AyEOiClBtwowhaMQK+QvAwVnXhSvSxxr11FPQ6g0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VeKe04v7KO6f6l3madu+aisfSCMYgyXSeZjFdrVsJaeCqb9Valj3yDgb9jgNvfkLCTuQ0uCRb3C6L5JYCrQ+m9wRXVxRbWT4DM+fJjOvbCt/XHEV0shD2h182qb+FJS6lBC+KE0lWktAN172ZDtGrY8V0Fobznkh/BlSB+4jsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO/hjj+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BB6C4CEEE;
	Mon, 17 Mar 2025 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742235036;
	bh=rT/AyEOiClBtwowhaMQK+QvAwVnXhSvSxxr11FPQ6g0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VO/hjj+nb6Rych/h1Jvx8FICFB3n61x1Pk8D87e0n7pDkIvkOkfSqeglQ6GY71SWx
	 Jmv34hUKjnd+oRKmrRA3bofcMKIwoY/2tOQAkomHwToncXHPrBS85G1PYnkMoeFeWO
	 8cdo2H2WtTHfMBMLTpMuDzqXFbQFyx1h9HBpVCE5mLzuYKn6mHg/8gnsWkXP4TGiDY
	 i6kEN9lQWZ1sHIa9flCOnnxUcIE6SU2zN2eZ8mxHyhYAiw9IFtpPk+Q+UkuJzxpPfy
	 31bqNbgz/6l2FU7yeTkcwlQMukLa6aBkGNbxVDZM7kePp0Vg+icmrtHaJZ+DZclldS
	 evoIgTA498v3g==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-crypto@vger.kernel.org, 
 Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-rtc@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
 Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
In-Reply-To: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
Subject: Re: (subset) [PATCH 0/9] drivers: Transition to the faux device
 interface
Message-Id: <174223503227.270320.5733466951381625938.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 18:10:32 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 17 Mar 2025 10:13:12 +0000, Sudeep Holla wrote:
> Recently when debugging why one of the scmi platform device was not
> showing up under /sys/devices/platform/firmware:scmi instead was
> appearing directly under /sys/devices/platform, I noticed the new
> faux interface /sys/devices/faux.
> 
> Looking through the discussion and the background, I got excited and
> took the opportunity to clear all the platform devices under
> /sys/devices/platform on the Arm Juno/FVP platforms that are really
> faux devices. Only the platform devices created for the device nodes
> from the DT remain under /sys/devices/platform after these changes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[6/9] ASoC: soc-utils: Transition to the faux device interface
      commit: 18abb3797f1ceca97a705aa1c14cbec5c6fcab79

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark



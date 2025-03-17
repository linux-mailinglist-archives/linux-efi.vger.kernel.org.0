Return-Path: <linux-efi+bounces-3002-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57780A65021
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 14:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CDD1892F06
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 13:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DC923AE96;
	Mon, 17 Mar 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="goLK9Dhp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DD22259A;
	Mon, 17 Mar 2025 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216600; cv=none; b=LlouitI/yncX1Fn9yqE1H2OGkkYRES2MI95pYK1Jz6PzJtdMHdgbRE6sZn7go1sW8nfMwT3XuMrDIWzPncxj9SQogMlsOGFu967nn0H7m4d8Gd3WSZD4OFeEJuHlUkwMxwEUhtsNCXB02KKNQsyWxJmsI8mmCrB+V3iZq3Poo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216600; c=relaxed/simple;
	bh=fEwQ0C5kR1bbzBiLEQfApgF2TVTQ7AcnbeLV+bPV28U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDS46XcIzMn6EHqQQBcx4ZYcs6uxd5qerjcXE9RndGSgOXog/9HCPUbq6L85TayfrcfXuiNii+AlTuMdsAmSuxJ+P//jA54Alxke8IXWvRXpJDZ116WO4kxXomevclsKroRiQ5BfwNHglqdPMYgupsNs8aRwdp/G6Ng7nl4p/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=goLK9Dhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4476C4CEE3;
	Mon, 17 Mar 2025 13:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742216599;
	bh=fEwQ0C5kR1bbzBiLEQfApgF2TVTQ7AcnbeLV+bPV28U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=goLK9DhpAOLTYKopLe7M3gDVmm+fXVJUIiZTmjyu5CMRgXsZlrwDJy+GSmN8k4MjP
	 8WYiYMBl0Jo5dt7260IQmVrKiWobh6hS2rbBhEenaMs8n39NSDLYvGV1BoaIBDGDl9
	 tXu3q/tih1qNrKApDk3wjPCkD4vUGsQ8X8DuJqHg=
Date: Mon, 17 Mar 2025 14:01:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/9] drivers: Transition to the faux device interface
Message-ID: <2025031705-scouting-scolding-8ff7@gregkh>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>

On Mon, Mar 17, 2025 at 10:13:12AM +0000, Sudeep Holla wrote:
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
> All the patches are independent of each other.

That's great, but you need to send these all independently to each
subsystem as needed.  Having it all in one series doesn't work for any
of the maintainers of any of the subsystems.

And I'm glad to see this work happening, thanks for doing that!

greg k-h


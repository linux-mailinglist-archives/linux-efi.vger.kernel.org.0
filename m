Return-Path: <linux-efi+bounces-3007-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4390A65398
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 15:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CF6164432
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F4B241679;
	Mon, 17 Mar 2025 14:29:04 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D0824110F;
	Mon, 17 Mar 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221744; cv=none; b=oNTtCvFD3hGZhsW+TvFRLOu+WY2qSe6pJBfrGrFeiUmTxEox9eeZJ+2y3S8BJHrJ2/+H9u3mcgqlA0XWpa7k2EIrxV+/HT3uPV9S5A2jbWeC/o7M3UNU86VqS8L1j1V+jY5aJwwUhUE9sec2Iu9P/6aXTOd0Wu8b2r2CSnfoyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221744; c=relaxed/simple;
	bh=dzgbwvDxYKxyBzxSvxhiBD6og4kkmAH+ymh2ORT+zoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dC59diCoLT8Q+yy/wVxbEugibpXB4ooJr1X1/2v3ciEbuLZ+WTDcXgdc8UmIeJ2unNx23Tsti2MZY/4JpGtmmoidKrlmj6fd6ZApXN6HhkJj1INPmEBEyFAf80j48NKKgsZNYLkrW0KqAvalAv7ig0aSOnrXtiUE8uIizQGVQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 749A913D5;
	Mon, 17 Mar 2025 07:29:11 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA8E13F63F;
	Mon, 17 Mar 2025 07:28:58 -0700 (PDT)
Date: Mon, 17 Mar 2025 14:28:56 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <Z9gxqGHS3igb5wOq@bogus>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <2025031705-scouting-scolding-8ff7@gregkh>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031705-scouting-scolding-8ff7@gregkh>

On Mon, Mar 17, 2025 at 02:01:55PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 17, 2025 at 10:13:12AM +0000, Sudeep Holla wrote:
> > Recently when debugging why one of the scmi platform device was not
> > showing up under /sys/devices/platform/firmware:scmi instead was
> > appearing directly under /sys/devices/platform, I noticed the new
> > faux interface /sys/devices/faux.
> > 
> > Looking through the discussion and the background, I got excited and
> > took the opportunity to clear all the platform devices under
> > /sys/devices/platform on the Arm Juno/FVP platforms that are really
> > faux devices. Only the platform devices created for the device nodes
> > from the DT remain under /sys/devices/platform after these changes.
> > 
> > All the patches are independent of each other.
> 
> That's great, but you need to send these all independently to each
> subsystem as needed.  Having it all in one series doesn't work for any
> of the maintainers of any of the subsystems.
> 

Sure I can do that. I initially had idea of creating a macro that made
all of them depend on the macro but later dropped as I wanted to check
if that is good or a bad idea. I just asked you in the thread 2/9.

> And I'm glad to see this work happening, thanks for doing that!
> 

Thanks for adding faux interface!

-- 
Regards,
Sudeep


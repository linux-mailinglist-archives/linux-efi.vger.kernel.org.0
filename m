Return-Path: <linux-efi+bounces-3236-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB2DA80F34
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 17:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB4818905BC
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784E32288C6;
	Tue,  8 Apr 2025 15:01:35 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A71C5F0E;
	Tue,  8 Apr 2025 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124495; cv=none; b=UQnJRW5q/8RX3ZOssiNGVfGN4tOf0ueMEQ9dcm4QCsyHf3t2IRmt8dVT1/T0NOtQ98QYd8TtDTqhGfXfLTvTVAS4IE9KvoeFrGq+iT6PNsTT62FYRR9FeOYqGMJKDF93kYhOvGm72sOz67XoH/VrZjxwC0LeivE1GWEgGdCUDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124495; c=relaxed/simple;
	bh=hOK3clpnQjC9/5KpGRpIOFwnnxBZZcGen3Ukq1ldlD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p16emTq3WmeyGWBK1VJ2kCnQ2oIPoBrMMiqkCfVbnzTFcxC9oP6Ip5IE1RqHN+r6zYy2M5gHrKUTV3ejWca2AzTklA6SuF9LDGQ6Qu4fTvCQQWh/jMXTENlXUCeTyVO1NqQaBYi8a7IoGfsUAjH7dcvNGIZs0x2cor/sHepSjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D08651688;
	Tue,  8 Apr 2025 08:01:29 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAB5B3F59E;
	Tue,  8 Apr 2025 08:01:27 -0700 (PDT)
Date: Tue, 8 Apr 2025 16:01:24 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: (subset) [PATCH v2 4/8] rtc: efi: Transition to the faux device
 interface
Message-ID: <20250408-onyx-tody-of-recreation-adb368@sudeepholla>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-4-e6cc73f78478@arm.com>
 <174412352089.3870554.10940173443800637826.b4-ty@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174412352089.3870554.10940173443800637826.b4-ty@bootlin.com>

On Tue, Apr 08, 2025 at 04:45:31PM +0200, Alexandre Belloni wrote:
> On Tue, 18 Mar 2025 17:01:42 +0000, Sudeep Holla wrote:
> > The EFI RTC driver does not require the creation of a platform device.
> > Originally, this approach was chosen for simplicity when the driver was
> > first implemented.
> > 
> > With the introduction of the lightweight faux device interface, we now
> > have a more appropriate alternative. Migrate the driver to utilize the
> > faux bus, given that the platform device it previously created was not
> > a real one anyway. This will simplify the code, reducing its footprint
> > while maintaining functionality.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [4/8] rtc: efi: Transition to the faux device interface
>       https://git.kernel.org/abelloni/c/89a378d01e7e
> 

You need to drop it, sorry for not mentioning it explicitly.
module alias doesn't work which I think is a requirement and also
module_faux_driver() macro is not upstream.

Sorry for the trouble.

-- 
Regards,
Sudeep


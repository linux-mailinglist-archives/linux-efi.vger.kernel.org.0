Return-Path: <linux-efi+bounces-3005-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934B8A65244
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE793B7E62
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34207227BB2;
	Mon, 17 Mar 2025 14:04:14 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5F14F9F4;
	Mon, 17 Mar 2025 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220254; cv=none; b=pM98Ssv5tkITPK3X1MgSLKr79NDMoob8eYGk5rXOSTxHtm13eoyWBTwCSnxkD7/1+zDVormPT82drqLS5uQjSXyfXXIoLKRk8I8lpyuNl57Yz/Dk6fgI80EbWbUgxv3FJiBEDagh6WofC/qYz1dYxGcVgfycltlkoRDkQaY8QgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220254; c=relaxed/simple;
	bh=rCOF7+2sbxkUxGez3jb20hbtG3fg3N+Iwqx48ey03RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh+ntxRAEN658vWrJ2aagcOxckeO9mz5bJxvQNKGD8cWN8VN8/etGn/sP94vPY2zd0u9vdXJ87g+ifi98Kwas8AFQJkCMK3kk/unDe5kx4Gvd8qEDhylppAOVvJQ52iOXeaBsI1zdLvOgTlrGjxxGL3mQqZDZdp9iSrBDqv2Xbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49F4E13D5;
	Mon, 17 Mar 2025 07:04:20 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BE083F63F;
	Mon, 17 Mar 2025 07:04:09 -0700 (PDT)
Date: Mon, 17 Mar 2025 14:04:07 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH 4/9] rtc: efi: Transition to the faux device interface
Message-ID: <Z9gr11GUYPWxPMSc@bogus>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-4-5fe67c085ad5@arm.com>
 <2025031755-simile-landside-e719@gregkh>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031755-simile-landside-e719@gregkh>

On Mon, Mar 17, 2025 at 02:07:00PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 17, 2025 at 10:13:16AM +0000, Sudeep Holla wrote:
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
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: linux-rtc@vger.kernel.org
> > Cc: linux-efi@vger.kernel.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/efi/efi.c |  3 ---
> >  drivers/rtc/rtc-efi.c      | 31 ++++++++++++++++++++++---------
> >  2 files changed, 22 insertions(+), 12 deletions(-)
> > 

[...]

> > -MODULE_ALIAS("platform:rtc-efi");
> > +MODULE_ALIAS("faux:rtc-efi");
> 
> No alias please.

Thanks for the review, will drop all the alias.

-- 
Regards,
Sudeep


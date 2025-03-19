Return-Path: <linux-efi+bounces-3041-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEAFA69085
	for <lists+linux-efi@lfdr.de>; Wed, 19 Mar 2025 15:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BF3188E5CF
	for <lists+linux-efi@lfdr.de>; Wed, 19 Mar 2025 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19CB19F103;
	Wed, 19 Mar 2025 14:31:04 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D10614B08A;
	Wed, 19 Mar 2025 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394664; cv=none; b=mBegvnNfU1PL6BpYudmXhOVw3CQEPzeSnP/SgSbog3edfcGr+lYp4KSE2AH9uJSFDcI6y3dSMZMGVaA+anKBm8nheeKCRNyxNzRePvD/3xnGaI3D5TcMMjzKmkM2afHu0PHOcWqx+TZ7UMPjMqnYjeATdHiQu4cy0Jgiq2XVcYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394664; c=relaxed/simple;
	bh=UgJwiRi1wL4zZv0SCz4pWKZSwI2Az6cp3ukAa4fRYR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVVl7n73fHmL9bxfP/0GgMCfrCM7jCGedU9rGkvqP3I9hpm9NNsHgYNHfwCuJnMYi/2b3vjRxP9KoScdieLaMTWTt2taujR+Juj9j4wVmUhuNEWGyaJYjKtTrs5TsI+VHq2i5rqKfyxr+ESzJBRjbjA0GkdrgQL6DIWYGMv9oGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAFAE12FC;
	Wed, 19 Mar 2025 07:31:10 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A70433F673;
	Wed, 19 Mar 2025 07:31:01 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:30:58 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 5/8] virt: efi_secret: Transition to the faux device
 interface
Message-ID: <Z9rVIqcIguqsoMw5@bogus>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-5-e6cc73f78478@arm.com>
 <CAMj1kXGJkApH73r9qEGABe3M4pXP2gMW3tDXfz2F6WGPZ3nhug@mail.gmail.com>
 <Z9rDely6YxIQZTrK@bogus>
 <2025031942-gotten-epidermis-eeee@gregkh>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031942-gotten-epidermis-eeee@gregkh>

On Wed, Mar 19, 2025 at 07:24:53AM -0700, Greg Kroah-Hartman wrote:
> On Wed, Mar 19, 2025 at 01:15:38PM +0000, Sudeep Holla wrote:
> > On Tue, Mar 18, 2025 at 06:10:41PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 18 Mar 2025 at 18:02, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > The EFI secret area driver does not require the creation of a platform
> > > > device. Originally, this approach was chosen for simplicity when the
> > > > driver was first implemented.
> > > >
> > > > With the introduction of the lightweight faux device interface, we now
> > > > have a more appropriate alternative. Migrate the driver to utilize the
> > > > faux bus, given that the platform device it previously created was not
> > > > a real one anyway. This will simplify the code, reducing its footprint
> > > > while maintaining functionality.
> > > >
> > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > Cc: linux-efi@vger.kernel.org
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > 
> > > So how is module autoload supposed to work with this driver?
> > > 
> > 
> > IIUC, you are right. It doesn't work. I got carried away how efi_pstore was
> > autoloaded in Ubuntu even without alias or platform/faux device creation. I
> > don't know how yet but that works. This modules doesn't.
> > 
> > So we may have to retain platform device/driver for autoloading reasons ?
> 
> If that's required, yes.

Thanks for confirming. I will drop this and see if autoloading is needed
in any other modules as well.

-- 
Regards,
Sudeep


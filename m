Return-Path: <linux-efi+bounces-3039-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE512A68D87
	for <lists+linux-efi@lfdr.de>; Wed, 19 Mar 2025 14:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFC617BBF1
	for <lists+linux-efi@lfdr.de>; Wed, 19 Mar 2025 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920B4255250;
	Wed, 19 Mar 2025 13:15:44 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F425485E;
	Wed, 19 Mar 2025 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390144; cv=none; b=bxZjAE8mjvmc7JsmyB1HvUo4fWK2hC7KayPc8i9JXAbFZMMKJ5gA9LpGnj/fJlbeLkQ9WtH77YV9e9fxSUteENMB7F+pPn6j4WMzNTqiuJzKaW0yMm7XH9cwF/dEmcx1MQDNOsNoqOtAT4u/mb4bRII5dSMFMRo8ndUV2mysohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390144; c=relaxed/simple;
	bh=B1spGKoS3vibM4vKrqTUz6FzRVi/psb0X6hGW5RdDsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/hb+prxOZUQ68vlGymaRhL6bHBqfJ26F4wtl7Vr1pFS6vRBarJ3wBOcwN6g2JCKH8Ogy5vsJ2qVr4QcA4KFYnab9AZoD2UF194rmcdMroa0jS5oiixh4PaWbqbYnAufg1kfCEITW55Nn103krFvzZHV+2bCg5D5z4+yHFhT6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76BD7FEC;
	Wed, 19 Mar 2025 06:15:50 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F2393F673;
	Wed, 19 Mar 2025 06:15:41 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:15:38 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 5/8] virt: efi_secret: Transition to the faux device
 interface
Message-ID: <Z9rDely6YxIQZTrK@bogus>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-5-e6cc73f78478@arm.com>
 <CAMj1kXGJkApH73r9qEGABe3M4pXP2gMW3tDXfz2F6WGPZ3nhug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGJkApH73r9qEGABe3M4pXP2gMW3tDXfz2F6WGPZ3nhug@mail.gmail.com>

On Tue, Mar 18, 2025 at 06:10:41PM +0100, Ard Biesheuvel wrote:
> On Tue, 18 Mar 2025 at 18:02, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The EFI secret area driver does not require the creation of a platform
> > device. Originally, this approach was chosen for simplicity when the
> > driver was first implemented.
> >
> > With the introduction of the lightweight faux device interface, we now
> > have a more appropriate alternative. Migrate the driver to utilize the
> > faux bus, given that the platform device it previously created was not
> > a real one anyway. This will simplify the code, reducing its footprint
> > while maintaining functionality.
> >
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: linux-efi@vger.kernel.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> So how is module autoload supposed to work with this driver?
> 

IIUC, you are right. It doesn't work. I got carried away how efi_pstore was
autoloaded in Ubuntu even without alias or platform/faux device creation. I
don't know how yet but that works. This modules doesn't.

So we may have to retain platform device/driver for autoloading reasons ?

-- 
Regards,
Sudeep


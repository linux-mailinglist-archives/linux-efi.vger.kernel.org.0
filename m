Return-Path: <linux-efi+bounces-2226-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09BB9DB52C
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 11:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65061683CC
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF4016A956;
	Thu, 28 Nov 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOT0GXSy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F5B15854F;
	Thu, 28 Nov 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788005; cv=none; b=aH1NnVBKydz6f/RV4mUlQpiDpi1ipHS5FehlCAKQ5z1jzCya8fwH8f6iQL5dzgfEN0CgZ/nRJk5SVxYVq6bJsWsqXJvWawuG5gUTWcg2r75O/ZMP4UCjyRO90kjDjXRJEKmjosWQWnhGHaH6MxyQ0mEwl5iFMbTRmxoFL/KNBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788005; c=relaxed/simple;
	bh=tYQLxPQpxbcH3iX/1Bao/eVA36jnfdZ+ATR7y7ejkOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsUvtxrvbUswgtC9ntU7dJrBJcFwMN8Or8Fae4A7+z/mz3sBwmPDJ/drKGfd8IUOfOaXzpi7D/+6OO8ETVjAL25zx2hbotkxLLnRkxWt4mgBfFWI62PSce1ybmTBGbj4ybMA7fHEqsAmzYS55tEtw0YKnN3fyND/ZzgRMivAbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOT0GXSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F62C4CECE;
	Thu, 28 Nov 2024 10:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732788005;
	bh=tYQLxPQpxbcH3iX/1Bao/eVA36jnfdZ+ATR7y7ejkOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOT0GXSy3if50dIKEgK4YmYtal081egLlC8H4HHWwjSL8AfpaKguEJG+PxeZYsQIy
	 //rGdi2B/uq9o8+jUYHQ6EcS5//L8CGc9p0Ns40rjiI2D7tsbGlyJEVjQvyQ0qsT9N
	 y7Jx2lJc4ZHQZDRq7D8B8VVFnuCEnG0iEtCvr8Z5WqGN4EBPnFhN1zBzs1VEsxoeX0
	 Jjq9U/AkQXlgUGnmnIfULzetU7M41gwCCgCuqKQzPTxq3U0RReF600iyUYPJDYLUJ8
	 vkCVA9GzKgXWd4jhj49gQ7ipmRIC6MdKVRkTO8TXXw2eayLZKnCGoueKzoY87bKScu
	 u1X8cFX/wJeNw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tGbJU-000000000mu-3UiV;
	Thu, 28 Nov 2024 10:59:57 +0100
Date: Thu, 28 Nov 2024 10:59:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Ricardo Salveti <ricardo@foundries.io>,
	Marc Zyngier <maz@kernel.org>, linux-efi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: UEFI EBS() failures on Lenovo T14s
Message-ID: <Z0g_HL01eqXu4cwQ@hovoldconsulting.com>
References: <Z0gn1N3IsP8r3gTA@hovoldconsulting.com>
 <CAMj1kXGjiA1HydMaY82MQsYvkchpN7v7CMOB5i3NEdqcYGn19Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGjiA1HydMaY82MQsYvkchpN7v7CMOB5i3NEdqcYGn19Q@mail.gmail.com>

On Thu, Nov 28, 2024 at 09:52:33AM +0100, Ard Biesheuvel wrote:

> On Thu, 28 Nov 2024 at 09:20, Johan Hovold <johan@kernel.org> wrote:

> > We've run into a buggy UEFI implementation on the Qualcomm Snapdragon
> > based Lenovo ThinkPad T14s where ExitBootServices() often fails.

> > Based on your comments to a similar report for an older Snapdragon based
> > Lenovo UEFI implementation [1], I discovered that allocating an event
> > before calling ExitBootServices() can make the call succeed. There is
> > often no need to actually signal the event group, but the event must
> > remain allocated (i.e. CloseEvent() must not be called).
> >
> > (Raising TPL or disabling interrupts does not seem to help.)
> >
> > Also with the event signalling, ExitBootServices() sometimes fails when
> > starting the kernel automatically from a shell startup.nsh, while
> > systemd-boot seems to always work. This was only observed after removing
> > some efi_printk() used during the experiments from the stub..
.
> So the error code is EFI_INVALID_PARAMETER in all cases? In the
> upstream implementation, the only thing that can make
> ExitBootServices() return an error is a mismatch of the map key, and
> so there is something changing the memory map.

Yes, it's always EFI_INVALID_PARAMETER.

> This might be due to a handler of the
> gEfiEventBeforeExitBootServicesGuid event group that fails to close
> the event, and so it gets signaled every time. This is a fairly recent
> addition, though, so I'm not sure it even exists in QCOM's tree.
> 
> In upstream EDK2, the map key is just a monotonic counter that gets
> incremented on every memory map update, so one experiment worth
> conducting is to repeat the second call to ExitBootServices() a couple
> of times, increasing the map key each time. 

I had already tried repeating the second call (GMM + EBS) by running it
in a loop, and I do see the map_key increasing for each iteration (e.g.
by 0x1a).

> Or use GetMemoryMap() to
> just grab the map key without the actual memory map, and printing it
> to the console (although the timer is disabled on the first call so
> anything that relies on that will be shut down at this point)

I just tried adding another inner loop just calling GetMemoryMap() a few
times and I see the map_key increasing there too for each iteration
(e.g. by 0x6).

(The map size remains constant.)

I do get the feeling that efi_printk() contributes to the memory map
updates, and I can indeed get the reference design fw to similarly fail
if I try to print the map_key after each call to GetMemoryMap() in a
retry loop.

Johan


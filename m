Return-Path: <linux-efi+bounces-2341-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5EA9EB22E
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2024 14:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF1164647
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2024 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3871A08A8;
	Tue, 10 Dec 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxc8ezmA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9571E515;
	Tue, 10 Dec 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838592; cv=none; b=AtD4RiFFgrMtYG5AcyooG5C3d0rATV6wxlOfCvIpxY17w3MEll1SXv5uhGJg3aD6Glvbnyl0LhOpeEzU6MVYD4KuxPScDzmtQ6kvT+McFY05HSpChipdMYCI6Ssvsazlp8umIetM3rl4GPEcfyRWDgvtckwqh1vGzQ36Se5Wbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838592; c=relaxed/simple;
	bh=e0jZuI/DKh2/Xu1++9G8Hh1Ryx/GiiP7Fc2SzdCbW/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR2aSdvfO7dZNOsDjRkE5oBDLqHWWVkjjwzHyjz/SzdgQDEmKnllcRFst70g0U9rwDBETJ988+/XCJ/qD7NGsV7s+h6GyVTeR6TJVMhm3uaIBcx9bEeVLazH3N9LcJgBn1l/9Z/tO2aTgfyvrQRVCg0LOo3qwpyCuL4rD9UMaR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxc8ezmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20BCC4CED6;
	Tue, 10 Dec 2024 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733838591;
	bh=e0jZuI/DKh2/Xu1++9G8Hh1Ryx/GiiP7Fc2SzdCbW/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxc8ezmAQKuVvEC4VDxSFSlaB/KhNZSOwO0U5V0DM1Zzjdjs64Vf89mZd6WE+vD3c
	 gcMBush/8NmtIkKoKKABT2qJF5dk4V4XEHL6t4ej5lDfsouIKKlE9tQhAYPi9+jqgK
	 segniSDhLUt34iiHcDJMoKF6sYlZVrDPAVtMT9e20g646XY+cR8rMOHFA7g4z8lBHo
	 t31lsTHyqBR+lkDSsq+OlUKcxdycDqAkNHS5B75SN1zl24Bd7Xvs0qI/8gNqnM73xk
	 FbSkK/kTbKhbSPtfMCFt/7/yDbfC92s9Kfv5EhJh7eRz2d2g/2kKA1QfHsjuetLPx0
	 r3IOU8hNLpCrA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tL0cc-0000000039o-1jgo;
	Tue, 10 Dec 2024 14:49:54 +0100
Date: Tue, 10 Dec 2024 14:49:54 +0100
From: Johan Hovold <johan@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Ricardo Salveti <ricardo@foundries.io>,
	Marc Zyngier <maz@kernel.org>, linux-efi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: UEFI EBS() failures on Lenovo T14s
Message-ID: <Z1hHAtAcgivajR7i@hovoldconsulting.com>
References: <Z0gn1N3IsP8r3gTA@hovoldconsulting.com>
 <CAMj1kXGjiA1HydMaY82MQsYvkchpN7v7CMOB5i3NEdqcYGn19Q@mail.gmail.com>
 <Z0g_HL01eqXu4cwQ@hovoldconsulting.com>
 <CAMj1kXFtr7ejEjjSRj9dcRa7YbO0SR5OR3pm+K6OvbX2=RfhAQ@mail.gmail.com>
 <CAMj1kXHS_TY=jfBT=dqUQSXf2pBXbt12uaLsMw-FLX3uU_X6uA@mail.gmail.com>
 <Z0iCNJVWNzBzdq0C@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0iCNJVWNzBzdq0C@hovoldconsulting.com>

On Thu, Nov 28, 2024 at 03:46:12PM +0100, Johan Hovold wrote:

> From 1464360c7c16d1a6ce454bf88ee5815663f27283 Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan+linaro@kernel.org>
> Date: Wed, 27 Nov 2024 16:05:37 +0100
> Subject: [PATCH] hack: efi/libstub: fix t14s exit_boot_services() failure
> 
> The UEFI firmware on the Lenovo ThinkPad T14s is broken and
> ExitBootServices() often fails and prevents the kernel from starting:
> 
> 	EFI stub: Exiting boot services...
> 	EFI stub: Exit boot services failed.
> 
> One bootloader entry may fail to start almost consistently (once in a
> while it may start), while a second entry may always work even when the
> kernel, dtb and initramfs images are copies of the failing entry on the
> same ESP.
> 
> This can be worked around by starting and exiting a UEFI shell from the
> bootloader or by starting the bootloader manually via the Boot Menu
> (F12) before starting the kernel.
> 
> Notably starting the kernel automatically from the shell startup.nsh
> does not work, while calling the same script manually works.
> 
> Experiments have revealed that allocating an event before calling
> ExitBootServices() can make the call succeed. When providing a
> notification function there apparently is no need to actually signal the
> event group and CloseEvent() could also be called directly.

As feared, this does not really fix anything and probably just works
by changing timing or alignment or similar.

When trying to find a workaround for the EBS() failure I had moved
loading of the dtb and initamfs images from systemd-boot to the stub as
that seemed to increase the chance of getting the kernel to start.

When I tried moving the loading back to the bootloader the other day I
saw EBS() fail with the event hack still in place in the stub. This time
it did not seem to fail gracefully however, and the machine was reset by
the hypervisor after a timeout.

And now I'm occasionally seeing EBS() fail also when the stub is loading
the images.

Johan


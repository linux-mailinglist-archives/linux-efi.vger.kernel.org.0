Return-Path: <linux-efi+bounces-578-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C2A858DC7
	for <lists+linux-efi@lfdr.de>; Sat, 17 Feb 2024 08:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A231C210BC
	for <lists+linux-efi@lfdr.de>; Sat, 17 Feb 2024 07:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718421CD16;
	Sat, 17 Feb 2024 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R7aAMdwT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3227B149E08;
	Sat, 17 Feb 2024 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708156176; cv=none; b=rCvkLKHafH6KPi/gwu7S1UB7brsHLfSN2N9CLKTGpENnSWG7T6k46+N4Y3UofCCv7BQPAG0lgPEFc0A8x3S0t5ZyR9SkS1F97Hd9CI9++jyckmDlZl3HDf+5hnSvP9v8ffEf1g2TGEvyI15r6Sc0R6WoHExzYOAD//eFGVg9y7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708156176; c=relaxed/simple;
	bh=xA0BMgVgYSGSfjkjE5RXNiB5SaRQ7Z5mUofy+cyyg20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6O8H2H+ToaOMkie1HwxSzJKpQy4/UV3aSmkxZ65yZ5YzyQV/QRUbG4nRWG+GBuirvGpcfvKZuk15GgH5oSOomlfxYstdmAO/e3Clr9EbwcvEGhQGOrT7dfLvho0sX4NueDCDvprBxqJdw9jgm3E2kXm0JzLgE/Tq2oU3vfb13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R7aAMdwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E30C433F1;
	Sat, 17 Feb 2024 07:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708156175;
	bh=xA0BMgVgYSGSfjkjE5RXNiB5SaRQ7Z5mUofy+cyyg20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7aAMdwTrTwek3wpcqcU9S4FFPWfRV3+2dl07WzErYgBUGoLhYewEoBPC5sowjZ1M
	 uv0XSoycpOCGmdpT6ukdeJmrNiPnDNLVHcOjsI9pIYQqe01blTcr9CA49nflxEmRIO
	 oYsjKJkqeUhfU5fQ00NZ2XCTLlV155Q7UXNkoZno=
Date: Sat, 17 Feb 2024 08:49:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-arm-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] efi: Add ACPI_MEMORY_NVS into the linear map
Message-ID: <2024021718-dwindling-oval-8183@gregkh>
References: <20240215225116.3435953-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215225116.3435953-1-boqun.feng@gmail.com>

On Thu, Feb 15, 2024 at 02:51:06PM -0800, Boqun Feng wrote:
> Currently ACPI_MEMORY_NVS is omitted from the linear map, which causes
> a trouble with the following firmware memory region setup:
> 
> 	[..] efi:   0x0000dfd62000-0x0000dfd83fff [ACPI Reclaim|...]
> 	[..] efi:   0x0000dfd84000-0x0000dfd87fff [ACPI Mem NVS|...]
> 
> , on ARM64 with 64k page size, the whole 0x0000dfd80000-0x0000dfd8ffff
> range will be omitted from the the linear map due to 64k round-up. And
> a page fault happens when trying to access the ACPI_RECLAIM_MEMORY:
> 
> 	[...] Unable to handle kernel paging request at virtual address ffff0000dfd80000
> 
> To fix this, add ACPI_MEMORY_NVS into the linear map.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: stable@vger.kernel.org # 5.15+

What commit id does this fix?  Can you include that as well?

thanks,

greg k-h


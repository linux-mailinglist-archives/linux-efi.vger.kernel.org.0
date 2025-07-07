Return-Path: <linux-efi+bounces-4143-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4414AAFA8AB
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 02:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B2A7A5936
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 00:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E894513B58A;
	Mon,  7 Jul 2025 00:45:17 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99D54764;
	Mon,  7 Jul 2025 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751849117; cv=none; b=mkYjyZGFiUvIruFWZHBy0LUdR5r/grVU84Ah1c3Z9KRUtb4L5zKioBPfgixdOb47ZeT5wolfxYVch8q+z92HEQfEYlhn5LeE5CK4WzIYJdVCGZWf9sN0aKh5f9YS507TcNDAnayy7KdGiuln5xO8WCrqEAtjadQFCiNtEUUHPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751849117; c=relaxed/simple;
	bh=62x3490PdDEgDf+E6Qmu/HU+o5iHfEzHkOhEIqoS5jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEB+DI8UGTu3cSDAeSKWTWdVDPQ57CCWcQD7cGkcQHy7glfdGaispHXcYRpaJMDhSEENx6zbn5LzMd9uE3fi21XUzXMxc0KLJtKh9301KhbGBbSyMQpsYE+Pjnaf4s9kTD5k0XbfqLFlz/SLq0hNDeCiyyp6A0QXtYS9ShkerJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E09C4CEED;
	Mon,  7 Jul 2025 00:45:06 +0000 (UTC)
Date: Sun, 6 Jul 2025 19:45:04 -0500
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Breno Leitao <leitao@debian.org>,
	Ard Biesheuvel <ardb@kernel.org>, usamaarif642@gmail.com,
	rmikey@meta.com, andreyknvl@gmail.com, kasan-dev@googlegroups.com,
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] arm64: efi: Fix KASAN false positive for EFI runtime
 stack
Message-ID: <aGsYkFnHEkn0dBsW@arm.com>
References: <20250624-arm_kasan-v1-1-21e80eab3d70@debian.org>
 <aGaxZHLnDQc_kSur@arm.com>
 <CAMj1kXFadibWLnhFv3cOk-7Ah2MmPz8RqDuQjGr-3gmq+hEnMg@mail.gmail.com>
 <aGfK2N6po39zyVIp@gmail.com>
 <aGfYL8eXjTA9puQr@willie-the-truck>
 <aGfZwTCNO_10Ceng@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGfZwTCNO_10Ceng@J2N7QTR9R3>

On Fri, Jul 04, 2025 at 02:40:17PM +0100, Mark Rutland wrote:
> On Fri, Jul 04, 2025 at 02:33:35PM +0100, Will Deacon wrote:
> > I would actually like to select VMAP_STACK unconditionally for arm64.
> > Historically, we were held back waiting for all the various KASAN modes
> > to support vmalloc properly, but I _think_ that's fixed now...
> > 
> > The VMAP_STACK dependency is:
> > 
> > 	depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC
> > 
> > and in arm64 we have:
> > 
> > 	select KASAN_VMALLOC if KASAN
> > 
> > so it should be fine to select it afaict.
> > 
> > Any reason not to do that?
> 
> Not that I am aware of.
> 
> I'm also in favour of unconditionally selecting VMAP_STACK.

So am I.

-- 
Catalin


Return-Path: <linux-efi+bounces-1680-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239DB970801
	for <lists+linux-efi@lfdr.de>; Sun,  8 Sep 2024 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF641C21926
	for <lists+linux-efi@lfdr.de>; Sun,  8 Sep 2024 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02467170836;
	Sun,  8 Sep 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g21nXnFp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEA7613D;
	Sun,  8 Sep 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804622; cv=none; b=I/x0fyhvwypVqsyX5bWuL9/uuLzIyFSGF5iZcxXa6Q6q5eNHVKoQYFgn4fURhDnp5ecFy2tbH5seuxsDYX6r1hIVnWYIc4/ZWY7XFPmPMncsOXYbjAOMj1UE2GyaXRQjKP5z67lO3yjFFCAYYxwNJWWMjPgiR1dRzBwz020v2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804622; c=relaxed/simple;
	bh=L52NrvFH6cCL7WSJulp5eAsipG5pw57QkN8inQ79Oco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG4y420BBHrGRY4ZyB1Tap0UOIGF2bdSdxzGYR6/px5+t7gSZ7UN39qXEslW6W5dYorfwrQiZ99P8KkVG1kJwHKzeVBmZ19plibj/yXDDWWdaaigBMqDJjvZcG9SPNiEV4tvzQzrHKSsPWPYkyCE/8W2glPpNYERyrdWGm0SSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g21nXnFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66505C4CEC3;
	Sun,  8 Sep 2024 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725804622;
	bh=L52NrvFH6cCL7WSJulp5eAsipG5pw57QkN8inQ79Oco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g21nXnFpknMI2iSsRnuzU8ofufypbHq8Lycu/54iYLStunG5IRZvwfEehMdKJCFG+
	 o/lsVIe/S+2/vXnDXjLQnFUUA35NEZxM9SDl/lsd9iyNA0rTGcFNN5pZT2Uak6fhOB
	 EXTO5l2M3fz6xF3tSWgeivOPR0rTxa1b+G+P+SK0=
Date: Sun, 8 Sep 2024 16:10:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, alexghiti@rivosinc.com,
	palmer@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, anup@brainfault.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	rdunlap@infradead.org, dvlachos@ics.forth.gr, bhe@redhat.com,
	samuel.holland@sifive.com, guoren@kernel.org, linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org, willy@infradead.org,
	akpm@linux-foundation.org, fengwei.yin@intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, conor.dooley@microchip.com,
	glider@google.com, elver@google.com, dvyukov@google.com,
	kasan-dev@googlegroups.com, ardb@kernel.org,
	linux-efi@vger.kernel.org, atishp@atishpatra.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	qiaozhe@iscas.ac.cn, ryan.roberts@arm.com, ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com, vincenzo.frascino@arm.com,
	namcao@linutronix.de
Subject: Re: [PATCH 6.6 4/4] riscv: Use accessors to page table entries
 instead of direct dereference
Message-ID: <2024090808-elusive-deviate-3bbb@gregkh>
References: <20240906082254.435410-1-wangyuli@uniontech.com>
 <D68939319C9C81B0+20240906082254.435410-4-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D68939319C9C81B0+20240906082254.435410-4-wangyuli@uniontech.com>

On Fri, Sep 06, 2024 at 04:22:39PM +0800, WangYuli wrote:
> From: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [ Upstream commit edf955647269422e387732870d04fc15933a25ea ]
> 
> As very well explained in commit 20a004e7b017 ("arm64: mm: Use
> READ_ONCE/WRITE_ONCE when accessing page tables"), an architecture whose
> page table walker can modify the PTE in parallel must use
> READ_ONCE()/WRITE_ONCE() macro to avoid any compiler transformation.
> 
> So apply that to riscv which is such architecture.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Acked-by: Anup Patel <anup@brainfault.org>
> Link: https://lore.kernel.org/r/20231213203001.179237-5-alexghiti@rivosinc.com
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---

all now queued up, thanks.

greg k-h


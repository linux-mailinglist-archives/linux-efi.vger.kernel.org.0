Return-Path: <linux-efi+bounces-3317-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FDEA86FA4
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 22:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82328A0ECF
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 20:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3846118C910;
	Sat, 12 Apr 2025 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMgITAQj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B98153800;
	Sat, 12 Apr 2025 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744490726; cv=none; b=s7BUDnLaW2Jxh+h9zPqVYdiHVbve7uN13H8E73YL0Un72GVEKWAhFXBkV0Xa0mGOJtRyH8No/BMKvCFBin6nfsMvUHJAXjBjOyrRhbnzCp/KPcH36+m3GVgSf0yqGAjStxkj8LYmIsMDb8qExZ06VIC0tShsAX7kF7GoZo4+KNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744490726; c=relaxed/simple;
	bh=SMBTIEh7KtYZUHaT4RiUsEfX1krtb5+eAUPvmqJSm14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBgvQOq6h0kfoXqStE1kEZHKnjgXRFbkseSPPD9dbLNnHuXtFYj7zdDGNg73ynqevvGtDHYNdSFW5J8moX75k4FQ+niHkh9jYgL2vcpsYGAImjewUStKxb2lJmc4sba6MCrcqbs0kFLVKTuxEfYyoxl6TAdlSADRcvW2LRqyoWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMgITAQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB4DC4CEE3;
	Sat, 12 Apr 2025 20:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744490725;
	bh=SMBTIEh7KtYZUHaT4RiUsEfX1krtb5+eAUPvmqJSm14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMgITAQjW8qgenMxMeWiy3UrpYAQMsJJvFzgpqoeGz8nuP7rMhVYMGFxs8mlnXMS1
	 ymClQYz7DezEaf7E7m5wELArL9ViT2g/xNKB02g6jUEXyWm5Fos90ajEmXIoGcEbKG
	 dj+Va2IQp1fADk9PzP/dzVt8lD0s/OUgl5ymqvch6tf4SwK6Wjd5jn+5RrWUtrUJzc
	 AC8nPfbi9kMxEV9DzmfYtKGOj/6HSWzovbdvJLLGzvPUz3vJjjPzRt9oBmYuz1RGtV
	 qlWYe08ugVzLJnkyXDNeoIaxIsBy3ieivIrXCHoO4MHNhDqgzUXVZgwzXHEZLRXaZJ
	 c3yEqR79lNC1g==
Date: Sat, 12 Apr 2025 22:45:21 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-efi@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/boot] x86/boot/sev: Avoid shared GHCB page for early
 memory acceptance
Message-ID: <Z_rQ4eu4LYh6jGzY@gmail.com>
References: <20250410132850.3708703-2-ardb+git@google.com>
 <174448976513.31282.4012948519562214371.tip-bot2@tip-bot2>
 <CAMj1kXFEXZ8cGMwz6N_ToYp0Wf5Vr9UBFRueWx_MtrwbDLq+LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFEXZ8cGMwz6N_ToYp0Wf5Vr9UBFRueWx_MtrwbDLq+LQ@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Sat, 12 Apr 2025 at 22:29, tip-bot2 for Ard Biesheuvel
> <tip-bot2@linutronix.de> wrote:
> >
> > The following commit has been merged into the x86/boot branch of tip:
> >
> 
> This may be slightly premature. I took some of Tom's code, hence the
> co-developed-by, but the should really confirm that what I did is
> correct before we queue this up.

OK, I've zapped it again, especially as the rest of the series wasn't 
ready either, please include the latest version of this patch as part 
of the boot/setup/ series, which hard-relies upon it.

Thanks,
	
	Ingo


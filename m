Return-Path: <linux-efi+bounces-5344-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C5C2DC39
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 19:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8471899056
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D33218AB9;
	Mon,  3 Nov 2025 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="i/uRK79H"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664382356C6;
	Mon,  3 Nov 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196136; cv=none; b=oxo1ee/j5nvpNOpvMitaVQ++k48rWtlDK5xyfkJnxkiHY8q7nbKt01X0jqHh2K7rA7omMFG5bMYnBYCsY+DSdC93bh4IceLkWnegAHJFhzPJT/zEDDh5+Nzb7htt0NWk0svi3EpNCdIFEbFbkB4lJiULd/rpTZbIR70qMZf3G58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196136; c=relaxed/simple;
	bh=AAfW6LxIEJ0JeIn6Asw8EqMYf2wuw3+TS4WBnGzpk+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo/uoy4mHl366ya6UZvu///OhUYndd5/TpDfPhGpgTzSJCKyN+ro69ENA9Lz94nShD878zTop3GK8q4z2tL+VWaDsugr4IfOo8pI0m7T74Snx7DuQK8gD5EhPkICk7Q/hqm/MOjY0zwsX9YcDoM0CUWsjLj1IH23OiDhxzwMkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=i/uRK79H; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8649340E01A5;
	Mon,  3 Nov 2025 18:55:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zolMFbcWYv7b; Mon,  3 Nov 2025 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762196127; bh=5MivvXBLzntfAC8dFObuaGnX0yElZZ2XvecP5BVyF/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/uRK79Htngh6e8g6IfJG3pbCvTvIk30jZkODPwIvQN74OPujWuyA9j9LwH618t9C
	 6x7rWJeuDgaA2WpRuqDido+9Jvl4gkErXp49TKp8f+kN8vnPodhzKvrOIwG6rv3HMd
	 NVj3VPXJRb3yXei4lWzhg9fgTw5Ld1AzbCfh79rzsqtkRfzyN2ZZ2HAdmkI/IZPLAJ
	 bm+a5OiTHyUXjTgkDXFff6R2Ois3cVPXLgoogcTuvFMLL2jmWdxxxiE/un9fE0SnTA
	 /6nJcIfO72MY7zoQywUTo8Xl8RTRcS9GADzsxOIddwW2/z16ZUrhmZMUfnHF9ZDC7j
	 T0IW1QXyTnIocC5RgLLnYVF/A5ATAVx10QzO1LiBaYWyLvY1qB6pRFcL1f8bPmT1v4
	 wBYoAQHnna8q3QJWAXJxqem7A8fd1FucVeqUkYng95I6NDfDVvYREdbOTyapw5P+O5
	 9pqlVXwf44FIUzctqNhqDGnRESFmbLLBugKsx8Hn8R+LFEZibOFje31mz0dbMwSPhN
	 Zk+yag2zg3wVMYSTlw6fiZQRWWlT5+Y94rczowGTb3+v7kW9Im6ZJwICYD6dHdqr8o
	 4wQ5FxqP6eQ8o/bSIprwRJ5XC3h1vEdBAdiXHzgldOSuuNCc2inV1eH9Fk+PjZmY3s
	 4zwM15HR7zY6468LtbXb3e4U=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 855FB40E019D;
	Mon,  3 Nov 2025 18:55:10 +0000 (UTC)
Date: Mon, 3 Nov 2025 19:55:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Usama Arif <usamaarif642@gmail.com>
Cc: dwmw@amazon.co.uk, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com,
	x86@kernel.org, apopple@nvidia.com, thuth@redhat.com,
	nik.borisov@suse.com, kas@kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, kernel-team@meta.com,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH v3 0/2] x86: Fix kexec 5-level to 4-level paging
 transition
Message-ID: <20251103185504.GLaQj6iHx4pu9RCL7E@fat_crate.local>
References: <20251103141002.2280812-1-usamaarif642@gmail.com>
 <20251103144557.GHaQjAJZGz_2ZPVDXq@fat_crate.local>
 <e03f4b4e-dc94-4444-8fe0-6c0c18a424d5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e03f4b4e-dc94-4444-8fe0-6c0c18a424d5@gmail.com>

On Mon, Nov 03, 2025 at 09:36:41PM +0300, Usama Arif wrote:
> Yes, I did the below build tests:

Thanks!

> make LLVM=1 allnoconfig; make LLVM=1 bzImage
> make LLVM=1 defconfig; make LLVM=1 bzImage
> make LLVM=1 allmodconfig; make LLVM=1 bzImage
> make LLVM=1 allyesconfig; make LLVM=1 bzImage
> 
> make LLVM=1 ARCH=i386 allnoconfig; make LLVM=1 ARCH=i386 bzImage
> make LLVM=1 ARCH=i386 defconfig; make LLVM=1 ARCH=i386 bzImage
> make LLVM=1 ARCH=i386 allmodconfig; make LLVM=1 ARCH=i386 bzImage
> make LLVM=1 ARCH=i386 allyesconfig; make LLVM=1 ARCH=i386 bzImage

Next time try gcc too pls. :-) That's the first compiler we ever supported.

> The i386 ones had a failure in lib/math/test_mul_u64_u64_div_u64.c:156:9 for
> linux-next/master so I rebased my patches on v6.17 and tested and they all
> built successfully.

Yeah, that was pointless. 

You can simply say that the 32-bit build fails because of an unrelated reason.

But backporting it to another kernel doesn't have any bearing on the code this
is going to be applied ontop of so...

But not a problem, I'll do the rest of the testing here.

Thanks again.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


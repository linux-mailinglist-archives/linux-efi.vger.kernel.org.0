Return-Path: <linux-efi+bounces-5342-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BD4C2C775
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 15:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67EC54F03C2
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB2A2459C6;
	Mon,  3 Nov 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ecNEsXXY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C12820C6;
	Mon,  3 Nov 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181184; cv=none; b=MHd/AhOFd3LcnR8O8GzRI/k76zFnpUiLMq1hCUjqvV2L88mXxKSlkXodmxRYeDM84hxyNuQ5Lkt3exBkxeECWY7+1u/RBkaEgkrwOa/TPCiSkNIrga7k19u+Agumu3UrmZOh5OyS3h/fPMEYm2O0xo/dSvHfCNunMXOwYBMzEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181184; c=relaxed/simple;
	bh=8z+czhpz4iF9NQro+0sNAEJJ27N0vSApcoc7AZ7qim0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXZKHvU0sfcCpb6fZ4u36ovrjT2YIz5c7Zm1ao9jMiZuMBMcyIaUpwA4/8LHNlG4DGaiZE5+aGJXB6g/BkZbBDf/g1823zL+RCEYEWi4fMnb3eIc0gUUwdweMUMSskfGuu0ZpRl0rUp7P/q9neVrqV2tjhgs80T1hsVij9t9BYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ecNEsXXY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E17BB40E00DA;
	Mon,  3 Nov 2025 14:46:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sSxQ2ocjPs3C; Mon,  3 Nov 2025 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762181175; bh=hT8eG08rYV0nPYY12anJUl7D26nd64aZxsZSM+TFf0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecNEsXXYAX30YB5q8J+fY7gUjnbzt6YGQJ6kZYMhG6Y0GJIe5qcBThZj9afJe8bZ7
	 J60w6+8mzeBkWTp/TNcV7Azw6LiuZTgN/Np5fAjVjIskkW22i2k2X6NUXD4zyfgd+u
	 nYuDI/geWoZWPrS5qoAk/m6XDknMMOGBrOaLs5nDLF45Bna8cqFC3miFTezQaaANOC
	 Z16AOasHvpTFzWfABwHhx8p3bKvhF3dntLlCCAcT5iOi1hTwhp5jLgthJljCmffJE2
	 4dt42uRiasAa2rcGk1wSOUqxKJ8erq3o5hvsphCaCM7+5aPYMh5RnSxBK35n4GNQkv
	 gYOZTDfwoRpR6ci9h7IRFGRgkXotTIppW084TI6mJDAp+dTe8haPz311BL0lCS8Y2+
	 k+hst6z3zsUDVfwU8I1PsfZczJY8CdCejTdM1qA0emWOebGERx/Qa60Jl9X5QHdUlU
	 DlXprsjNCOyI4FbXR1JOyBEt3VvCx0xqLcmgDfMFSEZoImyH/BFB3MJild6tWwr7Du
	 qIfXYKYh3n62DYd92oxcCJCkG19KQdj9bCh9MUhLSYnriykXrT9MD8bXi8rp4IHfTu
	 WEpwgutEcqe1aePdIwIBpm5iaxd2QV4VFanqRBoO8cb7LaiN7nA7ez511ilYHb2JaM
	 7pJyaBtfDkscZ0jRJ6rtLgco=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 706B940E01A5;
	Mon,  3 Nov 2025 14:45:58 +0000 (UTC)
Date: Mon, 3 Nov 2025 15:45:57 +0100
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
Message-ID: <20251103144557.GHaQjAJZGz_2ZPVDXq@fat_crate.local>
References: <20251103141002.2280812-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103141002.2280812-1-usamaarif642@gmail.com>

On Mon, Nov 03, 2025 at 02:09:21PM +0000, Usama Arif wrote:
> v2 -> v3:
> - Use native_pgd_val instead of pgd_val to fix broken build with allmodconfig.
>   I wanted to keep the code between pgtable_64.c and x86-5lvl.c consistent
>   so changed it in both patches
>   (Borislav Petkov and Ard Biesheuvel)
> - Commit message improvements (Dave Hansen)

Did you run the build tests I suggested?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-efi+bounces-4578-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C9B2D63D
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 10:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140594E0163
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040DB2D8764;
	Wed, 20 Aug 2025 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oD4rECWn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAA52D838A;
	Wed, 20 Aug 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678050; cv=none; b=U5m2kRtXq4zQ5c2q87+9lLo3Nl920DmXWiUE/G7k35W0ebtwYpCFiDCQUC+hA6Uia5npieVNyaL2MQj5cdQSooak+3nSNbYdaKPuCDodSc7CfZslhNjLq7tDaT4MDBSw4bljiSTk/QGgeeN9pnTy+fh7qkon4haLUlwd89n+S0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678050; c=relaxed/simple;
	bh=F2is9zfwLMGTq7xfkgAalDyZte6T3DvSchJ62PdSzbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnLb5S05BWft18M888qxZvg7qY37gsCSECp8yi0VCmbt/QWEMlx5GDr9gcnGMOS6coDnoIg9/IvjY/vEd9R+eetuhdoTC6XOJuGCC+HSVWveX66KPI7RamD7YvKcTJWUHASwiqLqNtOT9lq7IosuF8SRNAj/UlmAWIQuZY0MgxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oD4rECWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477B1C4CEEB;
	Wed, 20 Aug 2025 08:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755678050;
	bh=F2is9zfwLMGTq7xfkgAalDyZte6T3DvSchJ62PdSzbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oD4rECWnKxGis9qi02Vw4EZJJf6aHsdLFojZnMJh7ZquqKdZ0wuyZgD6pAwCRLWGK
	 VhvMM83b+X4a15JnGeQLjSFRIBakJbjp0WPVbTfhnCIexW76mS4jbaRroP7CgIKzCz
	 Ycuo36/5Plzwz0if77Dd3AG6UGjI86yEE+D7ctWWpIiplNP16CZqCedYPYwnHLOZ8T
	 qOV9TOkmxnXpDJQf+HQyg9npiG7OMbMeSNY8q25t4qgZWiuscep7LvoVnNM/BJvWFy
	 KHdPN4SYvY3V56XaGzPRd+pa/2h9bGQxp2sQng3TXHvuew4n4Dii7cmHpXr8IjFYmJ
	 HyGfv75T5Ixcg==
Date: Wed, 20 Aug 2025 11:20:42 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH v2 0/2] efi: Fix EFI boot with kexec handover (KHO)
Message-ID: <aKWFWsk0mPPQFDyk@kernel.org>
References: <cover.1755643201.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755643201.git.epetron@amazon.de>

On Tue, Aug 19, 2025 at 11:22:44PM +0000, Evangelos Petrongonas wrote:
> This patch series fixes a kernel panic that occurs when booting with
> both EFI and KHO (Kexec HandOver) enabled.
> 
> The issue arises because EFI's `reserve_regions()` clears all memory
> regions with `memblock_remove(0, PHYS_ADDR_MAX)` before rebuilding them
> from EFI data. This destroys KHO scratch regions that were set up early
> during device tree scanning, causing a panic as the kernel has no valid
> memory regions for early allocations.
> 
> The first patch introduces `is_kho_boot()` to allow early boot
> components to reliably detect if the kernel was booted via KHO-enabled
> kexec. The existing `kho_is_enabled()` only checks the command line and
> doesn't verify if an actual KHO FDT was passed.
> 
> The second patch modifies EFI's `reserve_regions()` to selectively
> remove only non-KHO memory regions when KHO is active, preserving the
> critical scratch regions while still allowing EFI to rebuild its memory
> map.
> 
> The patchset was developed/tested on arm64.
> 
> On a side note, I have noticed that `kho_populate()` calls
> `memblock_set_kho_scratch_only()`, but the `kho` cmdline option is
> not checked until much later. Therefore, memblock will use only the
> scratch regions that were passed from the outgoing kernel, even if the
> incoming kernel doesn't explicitly want that. I am not sure if this is
> done on purpose, but in any case we can discuss this in another patch,
> as it is orthogonal to this one.

kho_populate runs earlier than we parse the command line, so there is an
implicit assumption that we are going through KHO-enabled kexec if FDT was
passed to the new kernel.

I believe the best way is to document that and make it more explicit that
kho command line parameter only affects the "out" part.
 
> Main Changes in v2 (smaller changes can be found in individual patches):
>     - Introduce is_kho_boot()
>     - Replaced manual loop with for_each_mem_region macro
> 
> Evangelos Petrongonas (2):
>   kexec: introduce is_kho_boot()
>   efi: Support booting with kexec handover (KHO)
> 
>  drivers/firmware/efi/efi-init.c | 28 ++++++++++++++++++++++++----
>  include/linux/kexec_handover.h  |  6 ++++++
>  kernel/kexec_handover.c         | 20 ++++++++++++++++++++
>  3 files changed, 50 insertions(+), 4 deletions(-)
> 
> -- 
> 2.47.3

-- 
Sincerely yours,
Mike.


Return-Path: <linux-efi+bounces-3077-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65FA7013E
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 14:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F239E841F38
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726C826B080;
	Tue, 25 Mar 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NocINLNL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246729C357
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906198; cv=none; b=fSnlooRDOS6ZujHmMgylAR1ICuh+0i3pGaTmH6AkjyNPktHC6HgLiDhyGpSJTMBlmh0OVmhgzB9dCdt/3RXCmREHd2nUZoqZT1VHVrbLX0ds03afnK4guw0UU5rsgJ8RkbmvTkE6uPyjvjjQx3HEmD7patrE8NVtFpap66RdIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906198; c=relaxed/simple;
	bh=Er4lwPLAfGL10zTaXMD77j2RPWND4+YE7GthBWbnQjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud7OO0nMcG3/BSjNvS4CLU0EAipO1uL347G8+Gx+K2QqQHopCseZVv9vc3ZGWiq7oYddHgHXN+CASBIkH8NUllrUUot7iUUQMNQpL0hk/0M+lx4fqSUJ0hOhXUtZww76txEs5HkL5Yczfbk317FxTS6RUN4vLkHHdeDL6ZkkW9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NocINLNL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742906197; x=1774442197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Er4lwPLAfGL10zTaXMD77j2RPWND4+YE7GthBWbnQjw=;
  b=NocINLNL/U3hLnQXx1FteBciozV6N91FHUkEdrj/wHcu3+EUC2sFxA2J
   SEPhs0h1sGK2oDKimsU5D/OBZswLaKcgwydfxUqkhpFQUriAMYzZRq7S4
   TbVDPsiKX72pdIG2soA+oiJncA8YkqptUaAQdG/n+QgMPV+EFuTJlnO1/
   oAQ3VY0K5QrEbXO/ul8zvmRx2H/TsgPPKriwLqa1bhp9artZD91QzW/MR
   ZVCuNWGrYfswtcLIH9V47Wz1DvEO22b35smAhTGeZ3vXLVytoe2anGpmu
   22iSnvQ2sQLBkvRuOyyHp/+TZfbjQPgZGIlWJi5Bti4znGWT69TBgLhkN
   w==;
X-CSE-ConnectionGUID: m9XmSYvhTbGXKXxuSNJW1A==
X-CSE-MsgGUID: Jc1QzBbYRfKZMYPOOknPDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44304561"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="44304561"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 05:36:37 -0700
X-CSE-ConnectionGUID: YsWLFhTJTp2a7bED0WEGFA==
X-CSE-MsgGUID: DzPeF+wgR5Ol5iV4IhfiFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="124321533"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 25 Mar 2025 05:36:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D13B4367; Tue, 25 Mar 2025 14:36:32 +0200 (EET)
Date: Tue, 25 Mar 2025 14:36:32 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-coco@lists.linux.dev, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH] efi/libstub: Do not accept parts of memory before
 ExitBootServices()
Message-ID: <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
References: <20250325091614.1203411-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325091614.1203411-2-ardb+git@google.com>

On Tue, Mar 25, 2025 at 10:16:15AM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Currently, setup_e820() in the x86 EFI stub records unaccepted memory in
> the associated bitmap, which has a 2 MiB granularity. To avoid
> ambiguities, any unaccepted region that is not aligned to 2 MiB will be
> partially accepted upfront, so that all regions recorded into the bitmap
> are aligned to the bitmap's granularity.
> 
> On SEV-SNP, this results in calls into the SEV support code before it is
> initialized, and crucially, before ExitBootServices() is called, which
> means that the firmware is still in charge at that point, and
> initializing the SEV support code is not even permitted.
> 
> So instead, round the unaccepted regions outwards, so that all
> unaccepted memory is recorded as such in the bitmap, along with possibly
> some pages that have already been accepted. This is less efficient in
> theory, but should rarely occur -and therefore not matter- in practice.

NAK.

It opens us for double-accept attacks:

https://lore.kernel.org/all/zuz27i7ffrsa3hksveuroxpwxos5qx65py23gvupaadizwrsss@uhb6ye4j2eqn/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


Return-Path: <linux-efi+bounces-3198-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DCBA7B91E
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 10:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C5A17A607
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 08:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4107219D09C;
	Fri,  4 Apr 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4dRfsZE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24C19D07B;
	Fri,  4 Apr 2025 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756204; cv=none; b=URzTptdTlqla4msp5y46/m1A/lO2TgzivOopqQqGKUoVBZBi+fjlV7+PUeaFWKp9drjFx6IclOjpzFFxP/qmnkmmKkQDGo5SWKJJcN9MdAin2Z0OlkZYUJlEQIAp5AE0yEIDxEZDBXospcafq3at1uZs3DGvEXU8cFJ16v1OdYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756204; c=relaxed/simple;
	bh=Bi9x/GwNotnQUoNI7E8KOs7TaFavJ0TZu5a21VBEtcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRkrxfMvwvXf8E5yq8HmU9OH8u9Yy6/cFmSxcfLWOKf1x9sY1Hvdgd/EObHh7Au2TfkjHTLzBjMk9st0ApDmY0qnht2DWiGmqjCojq2Jof/uQ//2FOZKcjcojKd40R/gC1fF7nt0S/aOBSZUer/5gm21n6kpnChCL9pG1wvCQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4dRfsZE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743756202; x=1775292202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bi9x/GwNotnQUoNI7E8KOs7TaFavJ0TZu5a21VBEtcM=;
  b=f4dRfsZE3Rqc5lCSIF+SqST2mz7TDxUwUFr6y8gzaR3Dfc8MmD/RsC8q
   nLlznDsq6pQKidFpM8TIFHky4FfYlQXOPWyI4sjhcgQZxNTornN2qRHmD
   CX+Ohx6QXHtOS7mvgyPCCW5wVqMU1NOe/MTnSgX0PNL33YIjC2VrRI0hB
   7Xlfy/jSivMuH4qaWUm7ViOLErh2GEteA2fFepagdTtIKFwjtKwUdp7RQ
   3im1KZyQXwYH9GwpjZ0zGNaTGJ92PPknYTSuV4iECkpdsjlxJxfioEq3d
   qUCgFKueF6JRIqVfuhDQtsjrLLDCdLmKZ/75O2zAbg0EwT6uUB1LXM2EN
   A==;
X-CSE-ConnectionGUID: Cm4FaumOSBWE+/qQutZ6Ew==
X-CSE-MsgGUID: n0nj+KLoQIiWuiMOfzZmnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="56558053"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="56558053"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 01:43:21 -0700
X-CSE-ConnectionGUID: y7dgSBLQTeKvjTRjwBSD2Q==
X-CSE-MsgGUID: 5zGsE7QkShqTm6k3phutOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="132380185"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 04 Apr 2025 01:43:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4D6A1123; Fri, 04 Apr 2025 11:43:18 +0300 (EEST)
Date: Fri, 4 Apr 2025 11:43:18 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for
 SEV-SNP
Message-ID: <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
References: <20250404082921.2767593-5-ardb+git@google.com>
 <20250404082921.2767593-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404082921.2767593-8-ardb+git@google.com>

On Fri, Apr 04, 2025 at 10:29:25AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Switch to a different API for accepting memory in SEV-SNP guests, one
> which is actually supported at the point during boot where the EFI stub
> may need to accept memory, but the SEV-SNP init code has not executed
> yet.

I probably miss the point, but why cannot decompressor use the same _early
version of accept too and avoid code duplication?

Maybe spell it out in the commit message for someone like me :P

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


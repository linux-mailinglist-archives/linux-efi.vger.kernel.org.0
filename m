Return-Path: <linux-efi+bounces-3209-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B0A7D9A6
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 11:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607D33AD072
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238FF1AAE28;
	Mon,  7 Apr 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HA0tP20R"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8914A82;
	Mon,  7 Apr 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017942; cv=none; b=dh82K+DDEX/PMul2szhxStFxnSa60gIVgv9UuIFg+pieuq+zmeRkfo3Ylau73oehJPE2TYjKyL1zb/SMqGZvVTT8dcAsoer7L67nrHlKB0pufGU17Of88Qkr3VHB8RyXwUlfNJpBT/bXsWYq8ckvqFlXIebCgF7fiMWT1+IPKIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017942; c=relaxed/simple;
	bh=TIea3HR0WabIaCEMALu390cFpJtUiF5TcTQQ8YCUWQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCudWS8bAeiA7ctgH7PW+ba3R7pp3+rQx7wpmPKuQcc7U0U2YpytCedYokpx4crFDpSnweztE3AswTtHeS851SLbji7zo7BzKJib1PBn4TJst7zuSv2LJ7/zhqoFYKTP45MSrX9Jx2/HX23IPn4KfhGVW4U9ngXx7vE1776GlqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HA0tP20R; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744017940; x=1775553940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TIea3HR0WabIaCEMALu390cFpJtUiF5TcTQQ8YCUWQE=;
  b=HA0tP20RoiPPg9ITEX3eVEHrVxJq+YMPeXOcj1QgnJt1V3d/41iw1YLK
   wZPBhGaQF60dBE6XVWfozpZmNZ3j5L4eC+TC+XF5GI2W7z8jrLX6zRAXd
   wMOSXIv53ZvZbJiCTHyrOh2XQhCfBBN8sCjp22/fC1NHs2paNkDQ2K0wy
   +Olb//8zBMh/qUIzBZcc44hjzF5n1+RyEHoqHtDH14tiedzz4013zgC/k
   NWC1tCzn1v4VZTZAGMckBOsB2JTQUxDIa0i1aM5eCUyogDubBPtOdPpt3
   PxGGHTPFrEuJ9LPE4yzJpSiUl61hxcuJJ5tmbU4AWXyzAxsqIe2QUKUJb
   A==;
X-CSE-ConnectionGUID: be5EN/82RhqV3nuJMsOilQ==
X-CSE-MsgGUID: 4aYYHBjFSaWBn89uyKUV7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="56763601"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="56763601"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:25:39 -0700
X-CSE-ConnectionGUID: 2l5//JO1RWGWyV5jJ2/czQ==
X-CSE-MsgGUID: mUFE9s3vQ1ioQu6znzjMQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132750919"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 07 Apr 2025 02:25:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 139D5340; Mon, 07 Apr 2025 12:25:35 +0300 (EEST)
Date: Mon, 7 Apr 2025 12:25:35 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for
 SEV-SNP
Message-ID: <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m>
References: <20250404082921.2767593-5-ardb+git@google.com>
 <20250404082921.2767593-8-ardb+git@google.com>
 <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
 <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
 <CAAH4kHbxMDGQy3v9ef1ZdqK0TNzpm==BJgx1KiUpRP-CRKDx4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH4kHbxMDGQy3v9ef1ZdqK0TNzpm==BJgx1KiUpRP-CRKDx4w@mail.gmail.com>

On Fri, Apr 04, 2025 at 08:07:03AM -0700, Dionna Amalie Glaze wrote:
> If the GHCB is available, we should always prefer it.

I believe we should consider the cost of code duplication in this
situation.

If the non-early version is only used in the kexec path, it will not be
tested as frequently and could be more easily broken. I think it would be
acceptable for kexec to be slightly slower if it results in more
maintainable code.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


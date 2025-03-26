Return-Path: <linux-efi+bounces-3097-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D603A71B05
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 16:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADAF3BEC5B
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CB01F1303;
	Wed, 26 Mar 2025 15:43:45 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C62747B;
	Wed, 26 Mar 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003825; cv=none; b=pNt5MCJCEomtBfZxBxGpwXDm8Gzr7fWCeo5mOV79PdW50pXH1IZz8muMbz9SuUmpM8OuqXjbN0dw1iijhdJP2EnJG0t1ANE5uVbTASrHn23ABbhHNJ3WaOdzJn5XeWnIjqw4Ocj1z5NAleUcNAulDso9rZv3sajmg2V+FBY9+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003825; c=relaxed/simple;
	bh=YL2g2vdTQCsD/VV/d7k2JXRS3ngb34nAG6s1dADB2NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvebiQ7NcAKwYzkSjfqaWGI7J4vv1PgGflUA/QJiemHVE6VyK/oX2V1PzSkddvtwuMBM4RBvyn9+TLBpNX4DcLWtJ429d2MiB5QOnespvt+86Ax4uX7DjopsiAu+55H0conARigPSB395WoNBlDOEaG9GVGPJP7e9Rl9jrq3CRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: nGJM6v/fRGue4cOjV2yGsw==
X-CSE-MsgGUID: f+xw0YD1Qim4UvCHWRS2bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="43456242"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="43456242"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:43:43 -0700
X-CSE-ConnectionGUID: A37PRNtgRBeun/0iH89Bxg==
X-CSE-MsgGUID: wJ5EablBTsq4ffeo6ftU5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124774487"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:43:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1txSuo-000000067YG-0JwM;
	Wed, 26 Mar 2025 17:43:38 +0200
Date: Wed, 26 Mar 2025 17:43:37 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] wcslen() prototype in string.h
Message-ID: <Z-QgqZW3zj-RT5dB@smile.fi.intel.com>
References: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
 <20250325-string-add-wcslen-for-llvm-opt-v1-2-b8f1e2c17888@kernel.org>
 <Z-LXHssrcpdtFqqn@smile.fi.intel.com>
 <20250325165847.GA2603000@ax162>
 <Z-LiWDbrEvVaTLZU@smile.fi.intel.com>
 <20250325214516.GA672870@ax162>
 <20250326003303.GA2394@ax162>
 <Z-PCCCAPS4uvL3jZ@smile.fi.intel.com>
 <20250326153756.GB1105284@ax162>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326153756.GB1105284@ax162>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 26, 2025 at 08:37:56AM -0700, Nathan Chancellor wrote:
> On Wed, Mar 26, 2025 at 10:59:52AM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 25, 2025 at 05:33:03PM -0700, Nathan Chancellor wrote:

...

> > >  #include <linux/init.h>
> > 
> > As I just replied to your previous mail, consider fixing this list as well
> > by adding module.h and types.h.

...

> > Overall, can you browse the Ingo's series [1] for the stuff related to this,
> > if any?
> > 
> > I would avoid doing double efforts or different approaches if we already have
> > something ready.
> 
> In Ingo's last fast-headers tree [1], nls.h only has export.h and init.h
> included, so it does not look like anything around this was changed from
> what I can tell.

Thanks for checking!

> types.h is going to be included via the new nls_types.h and while it
> does definitely look like module.h should be included, I do not really
> have the time and build capacity at the moment to incorporate testing
> that change into this series. I will stick with these two changes for
> now then I, you, or someone else can revisit cleaning up nls.h later.

Fair enough.

> [1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/tree/include/linux/nls.h?h=sched/headers

-- 
With Best Regards,
Andy Shevchenko




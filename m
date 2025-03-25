Return-Path: <linux-efi+bounces-3090-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18132A707A5
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 18:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38F91888872
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7DF25F986;
	Tue, 25 Mar 2025 17:05:35 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8704025D91E;
	Tue, 25 Mar 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922335; cv=none; b=FVv8ITD45VFyv4hxb42wRWaSMYYaalKmQdnWvD81nuufLy8P0q+eoohBtyxvW5h2SX6jVP61RsS8V++XQQhEM/y4xDNflJZ3lFS609TrswvH4n6kvzB++Y9J0PeGgT6K8ZTPAJ9CA7bSCpP5NwyiyhdAngzer4UvNfPabYoiFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922335; c=relaxed/simple;
	bh=men12D/1UWjXP6yS9n74PB9Is6POlk2936lMrSHC3c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3Pbplc8hmvi6bG1tMg/xZdLG/r5amQpFghp+/cpxRGlyyfG0K0u4YdWBPSd4DsqYaoIO9UqbhATDaFNLLPn/Oxh9cdPRGfua2VbbTskt2Ww2hV6WL7FoIu9zXVn1WQjJ1CgSrvD2Gatav1uInU5RN1ZAIHXtPLmfOQne8TyH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: ZYPZ6FthRyGDnJc3L8Yw+Q==
X-CSE-MsgGUID: 8Cabt8PHQ5S7ttiaw3dF6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="46920513"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="46920513"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 10:05:33 -0700
X-CSE-ConnectionGUID: haCryvQkSQODulqYUxvYNA==
X-CSE-MsgGUID: Gvki/IQyT9W+5MTKydAfSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124413000"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 10:05:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tx7iS-00000005oPI-1LtT;
	Tue, 25 Mar 2025 19:05:28 +0200
Date: Tue, 25 Mar 2025 19:05:28 +0200
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
Message-ID: <Z-LiWDbrEvVaTLZU@smile.fi.intel.com>
References: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
 <20250325-string-add-wcslen-for-llvm-opt-v1-2-b8f1e2c17888@kernel.org>
 <Z-LXHssrcpdtFqqn@smile.fi.intel.com>
 <20250325165847.GA2603000@ax162>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325165847.GA2603000@ax162>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 25, 2025 at 09:58:47AM -0700, Nathan Chancellor wrote:
> On Tue, Mar 25, 2025 at 06:17:34PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 25, 2025 at 08:45:19AM -0700, Nathan Chancellor wrote:

...

> > > Rename the efi function to avoid the conflict.
> > 
> > Hmm... Why not split this to two, rename patch as a standalone makes sense to
> > me even outside of this series.
> 
> How so? If nls.h is not included in printk.c via string.h, which does
> not happen without this series, what value does the rename have? I do
> not mind splitting it up that way to keep things cleaner, I am just
> wondering what would be the justification in the changelog (I guess just
> that nls.h may get included in the future for some reason)?

Inside this series the justification is obvious (a.k.a. the same), outside
yes something like "Put EFI specific function to the respective namespace
to avoid potential clash in the future when including another header."

-- 
With Best Regards,
Andy Shevchenko




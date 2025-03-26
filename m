Return-Path: <linux-efi+bounces-3093-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55549A7131A
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 09:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DFA3AC62A
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006671A725A;
	Wed, 26 Mar 2025 08:52:59 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDD1A5B89;
	Wed, 26 Mar 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742979178; cv=none; b=o7LIGblIS40ImG8NlJ7WNRaOmqRD8kgFxk8WWGUsL0H3H/hueDmEeNKWji0Y0Ga7LAYOHR44j3nMg1zM+Jx87NEKm2BL3JhhCDkcclWVxLc3PV9pLoti5wuGAQEdtXP8UhuTdZTfzeclYiKFIV8mO/BwUNPI+s+W/HNsjANnX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742979178; c=relaxed/simple;
	bh=4Z5hnXyKGxwJVzj/t4uzLnMmUwZAsEXEHL1U6aPZaQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F44bxY0BH5gSsXAkzono662yQKJvf1ayZgk89HP+nuYXtaTNA8Eiq7OFkOzt86rb2DEHHJr552+EZYD0/68weRlmgbBn06tzSPGJuCdo6pZpUwvwySA4il6ueR4GXkVgYimSD+kXso0yaR+/udemRiMCeYW3Tpc/Q6YTpjkJGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: p5heYQMpS3OXTplfbcaDVQ==
X-CSE-MsgGUID: 0PRjaD2uRjGZf2oDnDSzsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61645906"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="61645906"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:52:57 -0700
X-CSE-ConnectionGUID: PGr3WgVxRoywJoT/29DqJQ==
X-CSE-MsgGUID: DnwamAxJQ6yLd0JN+RMaBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="155589152"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:52:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1txMVH-000000061As-34iy;
	Wed, 26 Mar 2025 10:52:51 +0200
Date: Wed, 26 Mar 2025 10:52:51 +0200
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
Message-ID: <Z-PAY6t3NYCbgXpa@smile.fi.intel.com>
References: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
 <20250325-string-add-wcslen-for-llvm-opt-v1-2-b8f1e2c17888@kernel.org>
 <Z-LXHssrcpdtFqqn@smile.fi.intel.com>
 <20250325165847.GA2603000@ax162>
 <Z-LiWDbrEvVaTLZU@smile.fi.intel.com>
 <20250325214516.GA672870@ax162>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325214516.GA672870@ax162>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 25, 2025 at 02:45:16PM -0700, Nathan Chancellor wrote:
> On Tue, Mar 25, 2025 at 07:05:28PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 25, 2025 at 09:58:47AM -0700, Nathan Chancellor wrote:
> > > On Tue, Mar 25, 2025 at 06:17:34PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Mar 25, 2025 at 08:45:19AM -0700, Nathan Chancellor wrote:

...

> > > > > Rename the efi function to avoid the conflict.
> > > > 
> > > > Hmm... Why not split this to two, rename patch as a standalone makes sense to
> > > > me even outside of this series.
> > > 
> > > How so? If nls.h is not included in printk.c via string.h, which does
> > > not happen without this series, what value does the rename have? I do
> > > not mind splitting it up that way to keep things cleaner, I am just
> > > wondering what would be the justification in the changelog (I guess just
> > > that nls.h may get included in the future for some reason)?
> > 
> > Inside this series the justification is obvious (a.k.a. the same), outside
> > yes something like "Put EFI specific function to the respective namespace
> > to avoid potential clash in the future when including another header."
> 
> Okay, sounds reasonable to me. This is what I ended up with for that
> change, which will become patch one of the series.

LGTM.
However, now I'm thinking about nls.h appearing in the string.h.
The former actually lacks two headers in it: module.h and types.h.
I'm wondering if fixing nls.h would be even possible after your series.


> with basically the same changelog.
> 
> I will send v2 either tomorrow afternoon or Thursday morning to give a
> little more time for initial review/comments.

-- 
With Best Regards,
Andy Shevchenko




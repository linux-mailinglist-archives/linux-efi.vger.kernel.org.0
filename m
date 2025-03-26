Return-Path: <linux-efi+bounces-3094-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4C8A7133A
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 10:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35F13AE07C
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FE1A4E98;
	Wed, 26 Mar 2025 09:00:00 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F131A2C25;
	Wed, 26 Mar 2025 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742979600; cv=none; b=WIl33/dQWk03gHTNOMBUDWgmviuO7ggKshc1GvRMtkcv1Wy4F23N4fA91umS3uFxWQoTogKptSGrERevf0xU5L/R2FkKh0IH/6Nj0qBnzRnu5pn342EfgbPXbw2obgy8Ac7rgPHPKK8gcBWp+TWRghbtz/uw4zPc5tutmFI3oYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742979600; c=relaxed/simple;
	bh=cEOMS4NEOhLRyL6A1qhVyFvxw9AAqRQ8LmqLAn9RWWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awIQ2ohJghWsFeRAug8Lv0gY8H9z6txaw5DzTcLXFh0kAduDbheQ2f0qf20NCqVcb2aU+LmcsDZ7D19kN+oJFwe+43aKc3QxudV1ZeoTf00jRReuOg11Zj+IH5xtYpe+KCC4f+DTOWlYb9xTiobxWojB775WimlrE54hO1gUqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: o70urK2iR1yea92pXgJPpA==
X-CSE-MsgGUID: JHN6j5gRTl+Y2VsvhCeAkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43409486"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="43409486"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:59:58 -0700
X-CSE-ConnectionGUID: pyw8qMDbTZqZu4Krs27rzw==
X-CSE-MsgGUID: R7zM2+QWTt6T8FnX4whgMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="161898657"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:59:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1txMc4-000000061Ja-3Xo1;
	Wed, 26 Mar 2025 10:59:52 +0200
Date: Wed, 26 Mar 2025 10:59:52 +0200
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
Message-ID: <Z-PCCCAPS4uvL3jZ@smile.fi.intel.com>
References: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
 <20250325-string-add-wcslen-for-llvm-opt-v1-2-b8f1e2c17888@kernel.org>
 <Z-LXHssrcpdtFqqn@smile.fi.intel.com>
 <20250325165847.GA2603000@ax162>
 <Z-LiWDbrEvVaTLZU@smile.fi.intel.com>
 <20250325214516.GA672870@ax162>
 <20250326003303.GA2394@ax162>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326003303.GA2394@ax162>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 25, 2025 at 05:33:03PM -0700, Nathan Chancellor wrote:
> On Tue, Mar 25, 2025 at 02:45:21PM -0700, Nathan Chancellor wrote:

...

> > +#include <linux/nls.h>		/* for wchar_t */
> 
> Good thing I waited :) This include makes s390 unhappy:
> 
> https://lore.kernel.org/202503260611.MDurOUhF-lkp@intel.com/
> 
> It is possible that should be fixed by adding -Wno-pointer-sign to
> KBUILD_CFLAGS_DECOMPRESSOR so that arch/s390/boot matches the rest of
> the kernel but...

Ah, yes, you beat me up to commenting on this, the string.h and string.c made
in a way that they may be and are used in early boot code, i.e. it must not be
dirtyfied with the kernel code.

...

> >  #include <linux/errno.h>
> >  #include <linux/limits.h>
> >  #include <linux/linkage.h>
> > +#include <linux/nls.h>
> >  #include <linux/stddef.h>
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> 
> I wonder if would be better to do something like the below patch in lieu
> of the EFI change above (since there is no chance for a collision) then
> change both of the includes for wchar_t in this diff to nls_types.h? I
> have no strong opinion but this seems like it would be cleaner for the
> sake of backports while not being a bad solution upstream?

>  #define _LINUX_NLS_H
>  
>  #include <linux/init.h>

As I just replied to your previous mail, consider fixing this list as well
by adding module.h and types.h.

...

Overall, can you browse the Ingo's series [1] for the stuff related to this,
if any?

I would avoid doing double efforts or different approaches if we already have
something ready.

[1]: https://lore.kernel.org/linux-kernel/YjBr10JXLGHfEFfi@gmail.com/

-- 
With Best Regards,
Andy Shevchenko




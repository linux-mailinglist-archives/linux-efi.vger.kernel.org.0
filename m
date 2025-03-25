Return-Path: <linux-efi+bounces-3086-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFDBA70698
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 17:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30ED4189C51B
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6328725B673;
	Tue, 25 Mar 2025 16:17:45 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793B257ADE;
	Tue, 25 Mar 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919465; cv=none; b=b8ybpl9WZGh3cOy5juNLPr4kuMAJ8u91Aa5q3S1XH4+xc0CtpO0nRRGC/BNpQLm4G9liMGiDBIwakEsHW8DWKqNVjG2HHzenbhjHGgiQDSpDDXsitHk9s+eEVhHtx+Fl/RMhumlGnAO1VeyKh5xkVZCtX5e7pywq6E2wcznBI20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919465; c=relaxed/simple;
	bh=v8ZyraU08ohLvJyvM+Yz+14PaHZD7u7W31u6nmaUlf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdzYz0qDDHfnuobSF1w0xjagW9lfFRVGWfs0FL9GJWVgLUm4JXBgrW8acz0PPUO3ZR5kIdKDXcLjKi1rUVUK3Bp6k545ZlnmDPkAeHGxHW/Y7Li1vN12qk6UnTddyu4MMIpn5G/UOzj7phhxEjS52Qvf2k1lnk1yD5OYwiOVwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: fYOHt5KNTcWlNMxhfxsl1Q==
X-CSE-MsgGUID: 6aAnSkw/QKuO4vRjTRlHbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="66631896"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="66631896"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:17:39 -0700
X-CSE-ConnectionGUID: HoJJbwymRLqSBcxliNKrew==
X-CSE-MsgGUID: j6hdDJqnRsemhCNWtAwEPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="129265650"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:17:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tx6y6-00000005ndO-2Jrv;
	Tue, 25 Mar 2025 18:17:34 +0200
Date: Tue, 25 Mar 2025 18:17:34 +0200
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
Message-ID: <Z-LXHssrcpdtFqqn@smile.fi.intel.com>
References: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
 <20250325-string-add-wcslen-for-llvm-opt-v1-2-b8f1e2c17888@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-string-add-wcslen-for-llvm-opt-v1-2-b8f1e2c17888@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 25, 2025 at 08:45:19AM -0700, Nathan Chancellor wrote:
> If this is desired, it should be squashed into the previous change. I
> wrote it separately because it is slightly more invasive.
> 
> In order to export wcslen() to the rest of the kernel (should it ever be
> necessary elsewhere), it needs to be added to string.h, along with nls.h
> for the typedef of wchar_t. However, dragging in nls.h into string.h
> causes an error in the efistub due to a conflicting function name:
> 
>   drivers/firmware/efi/libstub/printk.c:27:5: error: static declaration of 'utf8_to_utf32' follows non-static declaration
>      27 | u32 utf8_to_utf32(const u8 **s8)
>         |     ^
>   include/linux/nls.h:55:12: note: previous declaration is here
>      55 | extern int utf8_to_utf32(const u8 *s, int len, unicode_t *pu);
>         |            ^
>   drivers/firmware/efi/libstub/printk.c:85:26: error: too few arguments to function call, expected 3, have 1
>      85 |                 c32 = utf8_to_utf32(&s8);
>         |                       ~~~~~~~~~~~~~    ^
>   include/linux/nls.h:55:12: note: 'utf8_to_utf32' declared here
>      55 | extern int utf8_to_utf32(const u8 *s, int len, unicode_t *pu);
>         |            ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   2 errors generated.
> 
> Rename the efi function to avoid the conflict.

Hmm... Why not split this to two, rename patch as a standalone makes sense to
me even outside of this series.

-- 
With Best Regards,
Andy Shevchenko




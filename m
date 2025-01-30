Return-Path: <linux-efi+bounces-2733-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE01A2339E
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2025 19:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607077A3026
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2025 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BED8831;
	Thu, 30 Jan 2025 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAF0+MBy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E51EF091;
	Thu, 30 Jan 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260898; cv=none; b=PT9lzZGWC6aXQ80SMLkAI9/DxVf2HDleBGumEjVH4fJTTDVdQbnD0/aCyndz4M4b6KCUfCX2FQFah7QhH32wByDlG4netfpJpPnVJUmsMHpqhuos5/SHYyWZm2aJU7YrZao5DjTVCMTk/vgaveYDtdubC+474cJfronjyGCFmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260898; c=relaxed/simple;
	bh=oGvIDxNz0Ljf1q05YTCDFMtv73xxjH6hoKbPHDZdvBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bg5xBfcwe43H4QW8s1FefEwDCEvAR84R8fvTjVBWrgK4GGGrxasmeQHhgAnt18cr5O6b0MKw3dW1132poZ0v8P707IjuLEcNR3U50lLNjT+hXbHUelt0rJODxwyPkC4pOZgLl7KzuyVQjHFlzYASc7Pzwd2zE1p2dNVzk0bJaS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAF0+MBy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738260896; x=1769796896;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oGvIDxNz0Ljf1q05YTCDFMtv73xxjH6hoKbPHDZdvBM=;
  b=gAF0+MByiGP7WVBvdMTopHiIGzSLg0iKOZ7t6oDKakKZsrmCR0+Xqj1R
   GYeZJJvWdxdZoPAJiEHGA9pmYhuFM4dwWxNrG+BkZyeK0j4oYXkCR10YR
   NLhww1v7Q12S41N5rPT4/oe6LMn7yNclFmFsjoEy+8FvoE1ny59yWbU41
   RMQYC+XBkHHKLxgQklH/NQ9GlSzBk6Pp0Evnj8wRi/N6A5kyZ+Cqg8ZkE
   SeUFWSsIEGqkbaAe6idhBLxQvwIijF2zSggqyjq+/gkAusbVlynEm9TuY
   GkLEQ3VRjjgTZqaaFOdsfPfpyH4ZJChEG9zPkymmMieY//v0Gm8pRGSJV
   g==;
X-CSE-ConnectionGUID: XmWnuo3RT2mp0xY5bmRxbg==
X-CSE-MsgGUID: n/wRbk2dRe+8ZR8Q7iEn1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38724316"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="38724316"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 10:14:55 -0800
X-CSE-ConnectionGUID: rxdMav3CSUO7HuIkYuGjMg==
X-CSE-MsgGUID: UgMmGrasQRy+ucWFRKFaVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="132675249"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.230]) ([10.125.108.230])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 10:14:54 -0800
Message-ID: <90be9512-2c27-431a-8387-4f2156aa6cb8@intel.com>
Date: Thu, 30 Jan 2025 10:14:56 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] A couple of build fixes for x86 when using GCC 15
To: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Sam James <sam@gentoo.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, stable@vger.kernel.org,
 Kostadin Shishmanov <kostadinshishmanov@protonmail.com>,
 Jakub Jelinek <jakub@redhat.com>
References: <20250121-x86-use-std-consistently-gcc-15-v1-0-8ab0acf645cb@kernel.org>
 <202501300804.20D8CC2@keescook>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <202501300804.20D8CC2@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/30/25 08:07, Kees Cook wrote:
> On Tue, Jan 21, 2025 at 06:11:32PM -0700, Nathan Chancellor wrote:
>> GCC 15 changed the default C standard version from gnu17 to gnu23, which
>> reveals a few places in the kernel where a C standard version was not
>> set, resulting in build failures because bool, true, and false are
>> reserved keywords in C23 [1][2]. Update these places to use the same C
>> standard version as the rest of the kernel, gnu11.
> Hello x86 maintainers!
> 
> I think this would be valuable to get into -rc1 since we're getting very
> close to a GCC 15 release. Can someone get this into -tip urgent,
> please? If everyone is busy I can take it via the hardening tree, as we
> appear to be the ones tripping over it the most currently. 🙂

Thanks for the heads up.  It's in here now:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/urgent




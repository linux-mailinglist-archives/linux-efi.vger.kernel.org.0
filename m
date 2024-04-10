Return-Path: <linux-efi+bounces-935-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD2C89F25F
	for <lists+linux-efi@lfdr.de>; Wed, 10 Apr 2024 14:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496D7282F34
	for <lists+linux-efi@lfdr.de>; Wed, 10 Apr 2024 12:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B9212EBEF;
	Wed, 10 Apr 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnULqUen"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DC169DF4;
	Wed, 10 Apr 2024 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752554; cv=none; b=msuiO5zmhCPs8KLhPb5n0jYVen4HIAKD4hjxvCFu+e5iXFonVoNw5t5nnrrsSLtfcA7mMifT5th2R5pmTrrqEN60AChtWaJbfAcPDEZ15BpsOM/Q0pbXnROZCWsgTEfyAiG83Ir4UYNIVpSekog+seLjz65G36nyhUI/KnVgVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752554; c=relaxed/simple;
	bh=htL7d10cE4l9AE5w6tcdedO8YBU43c18+GzdyjLT2fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDkEGvujH6mglN6tDVsAt0QSXnqtmslPiWtxyQKCQYcZjHZiewFOxvCTz/qPrKtklR2Db8X03OHZMWgRDn5WVaYytydHf0ULLpFnIVaAu7uIxgNQXsscKPITpJpq7hcrIgHHwcZ8ohLYd3XHZXVry0zIFcu4xndXuVePt3zDCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnULqUen; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712752552; x=1744288552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=htL7d10cE4l9AE5w6tcdedO8YBU43c18+GzdyjLT2fU=;
  b=nnULqUennFqyxIT5OxOwi81T0wftMhTM8jllrwsLJpurgv5oojJ71Dfo
   m0t61Dkl4ocm4hnp+HjfFTDsGqTZQj9LixXvs7QAJz3qMgIMYjgG4ZETI
   OUxlNkIZpP2tb/7y8QOx7bsUzscp/mqyOcdcfYg+QLDPv5tReHc7+PZZv
   ukUGSFmBJBMN7vQhtSwhEgtlkG9EDUOumSy1paQDSZT3Vk9CbbDblc25/
   GllkFul7uihZS7/O+zl1GZ8nV+r78IxtSu80xAw0wtLVolE41Cgvxr/cx
   ubkqqtqzrKpUmDvyUKsfXgTa+eJxdJyRJGZXGer+Ky/7KAPCEsBLpCrb/
   w==;
X-CSE-ConnectionGUID: IUzG11fYTW6WJX0GdwtZVg==
X-CSE-MsgGUID: b4WUxZDnSOqqa+ofhvae1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18718365"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18718365"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 05:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937094913"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937094913"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 05:35:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1E2DA161; Wed, 10 Apr 2024 15:35:39 +0300 (EEST)
Date: Wed, 10 Apr 2024 15:35:39 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org, 
	"Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
Subject: Re: [PATCH] efi/unaccepted: touch soft lockup during memory accept
Message-ID: <btc6xpiw3kvo4tj6a7cn7uahvcvge7g3jqkutrwmlnuz6g55lr@fu3lsytwhfpy>
References: <20240410102301.634677-1-yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410102301.634677-1-yu.c.chen@intel.com>

On Wed, Apr 10, 2024 at 06:23:01PM +0800, Chen Yu wrote:
> Commit 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused
> by parallel memory acceptance") has released the spinlock so
> other CPUs can do memory acceptance in parallel and not
> triggers softlockup on other CPUs.
> 
> However the softlock up was intermittent shown up if the memory
> of the TD guest is large, and the timeout of softlockup is set
> to 1 second:
> 
>  RIP: 0010:_raw_spin_unlock_irqrestore
>  Call Trace:
>  ? __hrtimer_run_queues
>  <IRQ>
>  ? hrtimer_interrupt
>  ? watchdog_timer_fn
>  ? __sysvec_apic_timer_interrupt
>  ? __pfx_watchdog_timer_fn
>  ? sysvec_apic_timer_interrupt
>  </IRQ>
>  ? __hrtimer_run_queues
>  <TASK>
>  ? hrtimer_interrupt
>  ? asm_sysvec_apic_timer_interrupt
>  ? _raw_spin_unlock_irqrestore
>  ? __sysvec_apic_timer_interrupt
>  ? sysvec_apic_timer_interrupt
>  accept_memory
>  try_to_accept_memory
>  do_huge_pmd_anonymous_page
>  get_page_from_freelist
>  __handle_mm_fault
>  __alloc_pages
>  __folio_alloc
>  ? __tdx_hypercall
>  handle_mm_fault
>  vma_alloc_folio
>  do_user_addr_fault
>  do_huge_pmd_anonymous_page
>  exc_page_fault
>  ? __do_huge_pmd_anonymous_page
>  asm_exc_page_fault
>  __handle_mm_fault

Stacktrace doesn't add much value here. Just drop it.

> When the local irq is enabled at the end of accept_memory(),
> the softlockup detects that the watchdog on single CPU has
> not been fed for a while. That is to say, even other CPUs
> will not be blocked by spinlock, the current CPU might be
> stunk with local irq disabled for a while, which hurts not
> only nmi watchdog but also softlockup.
> 
> Chao Gao pointed out that the memory accept could be time
> costly and there was similar report before. Thus to avoid
> any softlocup detection during this stage, give the
> softlockup a flag to skip the timeout check at the end of
> accept_memory(), by invoking touch_softlockup_watchdog().
> 
> Reported-by: "Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

And I think it is justified to add Fixes tag:

Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


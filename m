Return-Path: <linux-efi+bounces-4123-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F19CAF9466
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 15:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128943BB846
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71E4302056;
	Fri,  4 Jul 2025 13:40:30 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D502D77E6;
	Fri,  4 Jul 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636430; cv=none; b=UoPoL3LxJoNlzJl6N9dLKt5SVHY5UFOM9syFLA8c1Z5C+dVGnfyLZwbwTlMRX3J6wLioY3TdiawNnoclg61YRvvpibNM7U2XZ9S7Y+WJjbC6dma+RguyhsUYNWYJDD40d8dKf0WcCXIYGtTPp7Jzi2fO31T58b+Or72NlkOiHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636430; c=relaxed/simple;
	bh=GI39m2+QQLKl9kvuh15wYVtW2wZbC1V2uj5jj5sF2lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTcKWjeLpnrw29ePgl6oXoyvMSTW+yNxKilCrSBKzlLB3Ue8lpkDbPWIyOgTMTG2ieqiHtqI6rGEUs4IYUHEcViG4k9W3eg2Ef5hB4st9StIwvnYHOU6S+vhPAJA7rBpurg26VdUCOqncUibzkhOeGvwFilCkJOSktqlx3yq6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22BA9153B;
	Fri,  4 Jul 2025 06:40:08 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC95C3F6A8;
	Fri,  4 Jul 2025 06:40:19 -0700 (PDT)
Date: Fri, 4 Jul 2025 14:40:17 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, usamaarif642@gmail.com,
	rmikey@meta.com, andreyknvl@gmail.com, kasan-dev@googlegroups.com,
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] arm64: efi: Fix KASAN false positive for EFI runtime
 stack
Message-ID: <aGfZwTCNO_10Ceng@J2N7QTR9R3>
References: <20250624-arm_kasan-v1-1-21e80eab3d70@debian.org>
 <aGaxZHLnDQc_kSur@arm.com>
 <CAMj1kXFadibWLnhFv3cOk-7Ah2MmPz8RqDuQjGr-3gmq+hEnMg@mail.gmail.com>
 <aGfK2N6po39zyVIp@gmail.com>
 <aGfYL8eXjTA9puQr@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGfYL8eXjTA9puQr@willie-the-truck>

On Fri, Jul 04, 2025 at 02:33:35PM +0100, Will Deacon wrote:
> I would actually like to select VMAP_STACK unconditionally for arm64.
> Historically, we were held back waiting for all the various KASAN modes
> to support vmalloc properly, but I _think_ that's fixed now...
> 
> The VMAP_STACK dependency is:
> 
> 	depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC
> 
> and in arm64 we have:
> 
> 	select KASAN_VMALLOC if KASAN
> 
> so it should be fine to select it afaict.
> 
> Any reason not to do that?

Not that I am aware of.

I'm also in favour of unconditionally selecting VMAP_STACK.

Mark.


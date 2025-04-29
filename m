Return-Path: <linux-efi+bounces-3490-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1846AAA116D
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5502A1A85D88
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD83242D73;
	Tue, 29 Apr 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O7En+CmC"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F008BEE;
	Tue, 29 Apr 2025 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745943595; cv=none; b=Sg6BYZZX8HzDZeOrZ0KwES9jAYnm9VVBXF4tgSU2YQTO+OnIDXva2b3EwkK3dyXqiFOGaziuL6duoMCQEdDqAA6BCVl9k4JEwW4G8i3dX/X7iFutzT3ymSLcQJ8GWZ0yfBFTVbvbF5X24kzw1ouZnUIc5Ht4KsBnoF+T1dR7iPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745943595; c=relaxed/simple;
	bh=mEnsdqsn08I1GggVR6Aa/UWsmPOPO7CSGUPOdViS8uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEbUNXatmGRefqd26RYC/4ssl6QdvdSR7PrZM6POf1m32fXiupEQBOOaI649qUvqKJe0EUurxbyVCO7nVFuakL+167rK/ec9aH205GVtWGpcBeqrLvbjmVToz9arNQ1HfE41/EEWfWMA3moklFrNSDapkp81BqiaNkjSDbim7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O7En+CmC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mEnsdqsn08I1GggVR6Aa/UWsmPOPO7CSGUPOdViS8uo=; b=O7En+CmCZiOn1t8NSY8VLHLo7m
	OEmZd9uy4G7Rcgmen9k9cCjpFCxsACI5T90HPOzkf+gF1HgdEe7bkuMEB3Auw8Ongc3aUdr3H0wYg
	4BO5m/PjR3ELxCObp/15qs2D2xLpmColKf9Fg7BLNip+D20olZ+2IO0Xa2NKwg/CTa3FO3TV30G3I
	JJNXVR21LHB6WjHySwbx3CrgPAafBAQqvqQu3Jdn4cLP+3ZcAihOEyEonxPQlTwTXRCS6/rh3zOAq
	qgZV2GYCJwfRvlmvyv7+BJIvzbt53CYa53pd3rKO+YYgGpUti6VdFheDBTW9uZq/Z8xJZfTQf+EkZ
	0srHn+xw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9nf1-000000016JE-2BgQ;
	Tue, 29 Apr 2025 16:18:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3886430057C; Tue, 29 Apr 2025 18:18:11 +0200 (CEST)
Date: Tue, 29 Apr 2025 18:18:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, pawan.kumar.gupta@linux.intel.com, seanjc@google.com,
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH 6/6] objtool: Validate kCFI calls
Message-ID: <20250429161811.GC4439@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.540779611@infradead.org>
 <jsbau7iaqetgf6sa7pooebbbhkhnnidi24f2g7nieozeu63qes@flunkdj5eykb>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jsbau7iaqetgf6sa7pooebbbhkhnnidi24f2g7nieozeu63qes@flunkdj5eykb>

On Mon, Apr 14, 2025 at 04:43:26PM -0700, Josh Poimboeuf wrote:
> Can we call this ANNOTATE_NOCFI_SAFE or something?

I'm hesitant to do so, because some of these sites really are not safe.
EFI and VMX interrupt crud really are a security issue.

EFI really is unfixable but not less brokene, because the EFI code is
out of our control, the VMX thing might be fixable, not sure I
understand KVM well enough.


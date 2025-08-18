Return-Path: <linux-efi+bounces-4568-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3A6B29F65
	for <lists+linux-efi@lfdr.de>; Mon, 18 Aug 2025 12:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3624B17166A
	for <lists+linux-efi@lfdr.de>; Mon, 18 Aug 2025 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9999258EFD;
	Mon, 18 Aug 2025 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iv5DO4ZG"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FBD2C2354;
	Mon, 18 Aug 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513977; cv=none; b=DqxV3klzO2N7+C4oIof1eAqj1od5VdFvKjjvbP01kB6iOYwFGsvYGWq8Z3DhJKQIIH4qIvun5labg+6oSSZXi6zioCMxOwRTOJ/Dq09N4olAkp+ocMjySROr9iwqKHmZSg/XVuThsvQNOPPyJCjlp/A2ynPtrfe063Svpe6CWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513977; c=relaxed/simple;
	bh=g6G3zH2qzqOZqxwGeBL2KMXSUVpdHLp9NUcZNnMxD/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al2FRZJKca2N8OA0a4MtEk2lsE/yvqMNOpx7/M7YuFuxI5XL69AREMmIQqgezDYYo5Q6PRJ/YhdwhvRfYH03s2E2RmsMEJ91DCSOF3IJnf/DCUHlkJ1pDdVyLYhOseR5qR4j01Pi7jHYrP0FNBSHPltpmH1YjDDfbTYUVOqGqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Iv5DO4ZG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uN7zZfOCxxVPGBuO2MOEe4zlIzcchE60ogdgHS0G9DM=; b=Iv5DO4ZGIp6qg/EcTOQvtLutnw
	2/bmyKwut9R7SSy83T1/V4tYSoLtEkZlBI8GS/raGqFXSeKW0nJS4NCVXIwIdj40bDTzfESmjpoXL
	9Ps+aRMy6EvT5fQob0ZfZzPc7DKp9B+g9/BR8mwqOIgYecwnz8ab0sm8mZj17yjx2JU3Nb/DcyirF
	R1zIIT9vMbm2EA7hRJt0eK0luwx4JWJIQ5ys0A55KqDfw8hDb6aijuglNCrEkaPVZQzHRdyqV7DBf
	zZjeABb7neP4FCNrn3ENFoa+1Fv+wflTKgMwLlXF4xWoroP/bZvxCJOj6BTKE/yq+bNWs/7cBlAGB
	jfQNljnQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unxNL-0000000HLvN-3wBY;
	Mon, 18 Aug 2025 10:46:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0BE5230029B; Mon, 18 Aug 2025 12:46:03 +0200 (CEST)
Date: Mon, 18 Aug 2025 12:46:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"samitolvanen@google.com" <samitolvanen@google.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>
Subject: Re: [PATCH v3 12/16] x86_64,hyperv: Use direct call to hypercall-page
Message-ID: <20250818104602.GF3289052@noisy.programming.kicks-ass.net>
References: <20250714102011.758008629@infradead.org>
 <20250714103441.011387946@infradead.org>
 <SN6PR02MB4157F2108DDFBD991F5E926DD457A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F2108DDFBD991F5E926DD457A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Jul 15, 2025 at 02:52:04PM +0000, Michael Kelley wrote:
> From: Peter Zijlstra <peterz@infradead.org> Sent: Monday, July 14, 2025 3:20 AM
> > 
> 
> Same nit here:  Use "x86/hyperv:" as the Subject prefix, for consistency with
> past practice.

Sure, done. Thanks!


Return-Path: <linux-efi+bounces-3488-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C6AA1039
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 17:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05847A9394
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5825E1C3F34;
	Tue, 29 Apr 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fjuEtJt/"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5762746A;
	Tue, 29 Apr 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939955; cv=none; b=Lr71/8mUz21/msogWDMBQQjGf7ZMLRV71qaEMkCRuEse7ctS9Ozjq8vCb94cayIBFpFsrI+etDnwRzEUpmlXRjwSvmqknQEleYsqXppkM2IDj+423q4kGcAlx0LSSxh0MMWb7jIO3i5s99/vHHXA4iTD0ueUF9Vny4v2m5DdCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939955; c=relaxed/simple;
	bh=3C8fhB1fGzK7l6qdXHOl1DpkXFliBZMpdfcLMqkBWl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQqAZcsGzDrIhN+DZiFC4BMZEq8tXPX6Ho1I4enQlvGQ88nqD1LV2B7B4StmelRhn5fGHbvPSrqbsi6h3OB21IVQd9G0AAdm1HgBj0apNf47T7RmQS7+//r6S7gMf7+G99KoTwyuTk6HkNtSqMFsJildDkp83EtN8+q2GO1toeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fjuEtJt/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ylYybXRg8BOTls77x7I6uqAkR57DkifaGTI+lQneTd0=; b=fjuEtJt/emY2co4/t5cOHPVHMp
	84aONTqApzZwB60TU2nF19qlPCxs+aw9FJi/ftyWpw+VsUF+w+NiqQVEvWGSmaC7zmWMA8eINsWNA
	rKd6XgeTudO5qZcpXrpMlFdeF6OghsQxq+P83Fc9OLjMCFswQWdSGKrdmTgLOSw4zBrU1LPuyt3bK
	nrL07kVqZGE589vMsiV32QGr1XH40JZA/FSQicrLARUJYnEAw3ec2OtmbuJGvrevIfH3iY2nV/Ahh
	nzDDzEmjf6LIIy2+NLmMMGXDizYIzVq5iq+j4yr6dmR0njUFBQ0wSUmh4OdJVDi9MXrjJTdmDAEOB
	qieQq3bg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9mjg-0000000DRBs-37cP;
	Tue, 29 Apr 2025 15:19:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EAB1330035E; Tue, 29 Apr 2025 17:19:03 +0200 (CEST)
Date: Tue, 29 Apr 2025 17:19:03 +0200
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
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"samitolvanen@google.com" <samitolvanen@google.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>
Subject: Re: [PATCH 5/6] x86_64,hyperv: Use direct call to hypercall-page
Message-ID: <20250429151903.GK4198@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.435282530@infradead.org>
 <SN6PR02MB41575B92CD3027FE0FBFB9F3D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250425140355.GC35881@noisy.programming.kicks-ass.net>
 <SN6PR02MB41577A6B0E5898B68E2CD3C9D4842@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157194E753702D204C20D09D4862@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157194E753702D204C20D09D4862@SN6PR02MB4157.namprd02.prod.outlook.com>

On Sun, Apr 27, 2025 at 03:58:54AM +0000, Michael Kelley wrote:

> Indeed, control never returns from static_call_update(). Prior to
> hyperv_cleanup() running, crash_smp_send_stop() has been called to
> stop all the other CPUs, and it does not update cpu_online_mask to
> reflect the other CPUs being stopped.
> 
> static_call_update() runs this call sequence:
> 
> arch_static_call_transform()
> __static_call_transform()
> smp_text_poke_single()
> smp_text_poke_batch_finish()
> smp_text_poke_sync_each_cpu()
> 
> smp_text_poke_sync_each_cpu() sends an IPI to each CPU in
> cpu_online_mask, and of course the other CPUs never respond, so
> it waits forever.

Fair enough. I'll just remove this final call. Thanks!


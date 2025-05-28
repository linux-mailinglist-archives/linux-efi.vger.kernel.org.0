Return-Path: <linux-efi+bounces-3796-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2079AC6344
	for <lists+linux-efi@lfdr.de>; Wed, 28 May 2025 09:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8186116E499
	for <lists+linux-efi@lfdr.de>; Wed, 28 May 2025 07:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EC12459D9;
	Wed, 28 May 2025 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LsgC/GyR"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B719B3EC;
	Wed, 28 May 2025 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418313; cv=none; b=h5JdJEiZl9TdDR7s+Zy9TJiF3Bbtndlay09kwKYmG6Gk+P2I5Ci4u9h1xZIVqTBqDA5tgYOmD8hvlz+tp/zxpfcFFq/hRMn2QPz4ZJ2J0octJdJi0YQZBSOlpj612uqrODuJ2qCiMBxyH1fgfXr/BTgLSHDuhMLQU9XXDvhtl3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418313; c=relaxed/simple;
	bh=iafivI8V/MTAg4QPelROK6ZjF73rLhrtzNbr40jE06Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9Sv/yLhJbCvFuxCARs75HcJ4smRtmmtmSSDqiYIp3ApoF5qsox0IDZDwk14D17eZRBeqAW3ujNHmCPq8rYR8XYjvS4Atrh856Apesj66lmqpxyhqKYxbXiLhQmq1dBWYXgaBUflryVQjJgeIJ0Z77gOxKqsRYi+kDkpVHnfack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LsgC/GyR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iafivI8V/MTAg4QPelROK6ZjF73rLhrtzNbr40jE06Q=; b=LsgC/GyR5rTERHl0o7UzTubCfZ
	AJh7GZltqv7gxIf2314J6nKbqBoaTeQhbu6/bPN7yAzvTtCaqAH3Uq5SxT7OUamehRbcZCXpn7KBM
	D2NwnVgTmQSEqrPC02BXOilRVb4cUMw5qz12MS4FDMZcOEVU85lACRniDOt4uzVFCsooqqwSmwAw4
	dhxUoNrSvFoEvCsD5A+TCba/7u5qCsm7wBu2SCJio0AMODUc2ftmiQ5pA4uvrD1drrKLnfZzdVkP8
	S47F5d+REC77oIN8pLOiENDsJVYxGk4In1LZXRTlkYbYFLDsSJoE+0qFMilT1q6u6/VthQckhRsIq
	TiUi/m3A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBT6-0000000DMJR-0nhG;
	Wed, 28 May 2025 07:44:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60707300472; Wed, 28 May 2025 09:44:52 +0200 (CEST)
Date: Wed, 28 May 2025 09:44:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, samitolvanen@google.com,
	ojeda@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <20250528074452.GU39944@noisy.programming.kicks-ass.net>
References: <20250501103038.GB4356@noisy.programming.kicks-ass.net>
 <20250501153844.GD4356@noisy.programming.kicks-ass.net>
 <aBO9uoLnxCSD0UwT@google.com>
 <20250502084007.GS4198@noisy.programming.kicks-ass.net>
 <aBUiwLV4ZY2HdRbz@google.com>
 <20250503095023.GE4198@noisy.programming.kicks-ass.net>
 <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>
 <20250506073100.GG4198@noisy.programming.kicks-ass.net>
 <20250506133234.GH4356@noisy.programming.kicks-ass.net>
 <vukrlmb4kbpcol6rtest3tsw4y6obopbrwi5hcb5iwzogsopgt@sokysuzxvehi>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vukrlmb4kbpcol6rtest3tsw4y6obopbrwi5hcb5iwzogsopgt@sokysuzxvehi>

On Tue, May 06, 2025 at 12:18:49PM -0700, Josh Poimboeuf wrote:

> Weird, I'm not seeing that.

I Ate'nt Crazeh...

https://lore.kernel.org/all/202505280410.2qfTQCRt-lkp@intel.com/T/#u

I'll go poke at it, see if today is the day I can figure out WTF
happens.


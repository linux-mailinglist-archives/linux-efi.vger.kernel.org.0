Return-Path: <linux-efi+bounces-1379-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5821B92A25E
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 14:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEFD1F22B10
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D8B14290E;
	Mon,  8 Jul 2024 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0kbTk8b"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB51428E6;
	Mon,  8 Jul 2024 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440633; cv=none; b=iZ3/ApDoR/oxnokO9vC2ySfLFSnq1I5cKxva4BgtnWlHaRc3IR5RYlFUmA3X/JAbuXYtUEGsjA5FfXmNV/PlcU3RvHXGDYLxKUelY8qLDxnWq7byzF6wDx0ud3hQ3bKmQJTbcRji8MUn9M5ZBaw8UJ5ZwfLA7fvZeZ72datLb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440633; c=relaxed/simple;
	bh=TKpbJoO04mTWm34Ygga8OBt2nMOnAmAhnfgfsDH+FkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLdyJPnHCezPqyQFuwr2Pyn0npEUKK46fQP6wNxqiWsAczgcv0U1XxPCtB9QeFgLVLFF2xoeE0T4hJk2DorgPj6M4DWdbYE+lZQC3Y76QCcDnA+7eDht1YbkDXsGZqgQo9RvfVbbo67Zw9awycjIDxtQ0O1vHAXzJnepCW5ZYXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0kbTk8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F970C116B1;
	Mon,  8 Jul 2024 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720440633;
	bh=TKpbJoO04mTWm34Ygga8OBt2nMOnAmAhnfgfsDH+FkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h0kbTk8b6bjSvNKzBV6GgKRLO1NFr95BeX20IyyRYd23D6LzEsjLak6krtafnYibr
	 XoasDdDXl3Zksfj3nkVAutv1puQJ9DIgtQdW/wXisJIHGqS8LUV3qh6hkrxuzr4b3x
	 SdIO51Pr6aS7UxerRuJqKiQbYVUSGCch4YoUknbAKnpN+8IS6YQLfrFmRj6BfXPMo0
	 f/nHXyHr7y2mtSwLx0EZ/viOqRVore+mYV/GpIGUCnIo4K2LwF+sZnn+pLtEXq4COn
	 Z8l66sFTkCpn1K3ZNRks1F8Gjhiqepx7rymI4Re3ZDXDd3I+tP5cwoD+AeTq1AE4E1
	 aX1TbpKsMTivA==
Date: Mon, 8 Jul 2024 14:10:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Daniel Ferguson
 <danielf@os.amperecomputing.com>, Ard Biesheuvel <ardb@kernel.org>, James
 Morse <james.morse@arm.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Len Brown <lenb@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Shiju Jose <shiju.jose@huawei.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Dan
 Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] RAS: ACPI: APEI: add conditional compilation to ARM
 error report functions
Message-ID: <20240708141025.3e5ddd51@foz.lan>
In-Reply-To: <20240708113234.GDZovOUgjXFt2XoNg6@fat_crate.local>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
	<f520f2529bb27d452a2dee762b6968939df42f45.1720436039.git.mchehab+huawei@kernel.org>
	<20240708113234.GDZovOUgjXFt2XoNg6@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 8 Jul 2024 13:32:34 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Mon, Jul 08, 2024 at 01:18:10PM +0200, Mauro Carvalho Chehab wrote:
> > From: Daniel Ferguson <danielf@os.amperecomputing.com>
> > 
> > This prevents the unnecessary inclusion of ARM specific RAS error  
> 
> s/This prevents/Prevent/
> 
> Avoid having "This patch" or "This commit" or "This does <bla>" in the commit
> message. It is tautologically useless.
> 
> "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour."
> 
> From Documentation/process/submitting-patches.rst
> 
> > handling routines in non-ARM platforms.  
> 
> Ok, this does "something". Why does it do it?
> 
> Otherwise it won't build on other architectures or is it going to cause code
> bloat or why are we doing this?

Probably a better description would be:

    RAS: ACPI: APEI: add conditional compilation to ARM error report functions
    
    Don't include ARM Processor specific error handling routines in 
    non-ARM platforms, preparing it to the next patch, as arm-specific
    kAPI symbols will be used, thus avoiding build breakages when ARM
    is not selected.
    
    [mchehab: avoid unneeded ifdefs and fix coding style issues]
    Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This patch itself just add conditionals to optimize out code on
non-ARM architectures. The next one will add some ARM-specific bits
inside ARM processor CPER trace, thus causing compilation breakages
on non-ARM, due to arm-specific kAPI bits that will be used then.

Thanks,
Mauro


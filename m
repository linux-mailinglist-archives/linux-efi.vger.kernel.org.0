Return-Path: <linux-efi+bounces-1414-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5033A92DF6F
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 07:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D6F283E1A
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 05:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9832E5A7A0;
	Thu, 11 Jul 2024 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hcrtkpq0"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0211C3D;
	Thu, 11 Jul 2024 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675614; cv=none; b=uxin3HyECrssatJkFpaZ4ADd1pCcKbJIKoPaJ8S8LWLg3/Kyp7wEN6I2frsiCef7aSTDFyd/CDGdvf2cTMamcDCx1tGUZguSDdcYKx5mf9JeH7EMOZojimKrHV28b3N57WpdM+fwt2xlhuViS9zoCkoMcTceqtAh6D0a3dtGS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675614; c=relaxed/simple;
	bh=CsBxqXxsnlnIpJPe1pd2qKHMevWjw0yx/s0ljzQ6Rys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGqfp0pOTCT2i5U7yohv6JOtRkNt1hCnfmqMzo9CXGR5JWF9WxgIWMcofa8Px929xbo2yA2JGCpZiCmBYBcshoz1RK1qcMErNsQngn/xK5R20M/zT/CqpbrgiiJqjqmDJvGpJ0BpyAEIQ+lsg5l+HmAPnoEeyyyo5W/nxLvvC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hcrtkpq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DECC4AF0A;
	Thu, 11 Jul 2024 05:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720675614;
	bh=CsBxqXxsnlnIpJPe1pd2qKHMevWjw0yx/s0ljzQ6Rys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hcrtkpq0JDLkd5yfNqRKBhyrIWtytjOo8z7Gmxsu+xZ5apUxOk04diSAhdcRDmlUz
	 Wt3ySEnHuEs8ezQy70pJVV2PFNWFvPcW4V9B4DPAgcc8hVcugKqvYvOaUyzyw/lmlM
	 VSZtR4oNW3bmlLmY1ipo5IdY5iSo7GijOoAdyYSbXRn26qiF6OE6pny2PoByBLICZO
	 RJ+4r96blIyNm/HGZF5s3bLeihiXH1Tiz1Q8D5VueW0VqQl8QlrqH8Y10G0Vz6VCSl
	 i7thcRYE4iH8SfeJkPyO28HzMzZlN6f03d8FAE5akAsguEF+hoxVYvUBTjJPJ6SaXz
	 y4Y3r3RB4Fhuw==
Date: Thu, 11 Jul 2024 07:26:45 +0200
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
Message-ID: <20240711072645.776c0f5d@foz.lan>
In-Reply-To: <20240708144312.GDZov7AEzBDfSEGQEY@fat_crate.local>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
	<f520f2529bb27d452a2dee762b6968939df42f45.1720436039.git.mchehab+huawei@kernel.org>
	<20240708113234.GDZovOUgjXFt2XoNg6@fat_crate.local>
	<20240708141025.3e5ddd51@foz.lan>
	<20240708144312.GDZov7AEzBDfSEGQEY@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 8 Jul 2024 16:43:12 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Mon, Jul 08, 2024 at 02:10:25PM +0200, Mauro Carvalho Chehab wrote:
> > This patch itself just add conditionals to optimize out code on
> > non-ARM architectures. The next one will add some ARM-specific bits
> > inside ARM processor CPER trace, thus causing compilation breakages
> > on non-ARM, due to arm-specific kAPI bits that will be used then.  
> 
> Are you sure?

That is what reviews to past attempts to merge patch 2 implied. 

> I have both patches applied and then practically reverting the second one
> builds an allmodconfig just fine.

I double-checked the logic: I noticed just one kABI symbol that
it is arm-specific (CPU midr), and there is has already a wrapper 
for it.

I also did a cross-compilation for both x86_64 and s390 to verify,
and indeed it is building fine without the ifdefs.

So, I'll drop patch 1.

Thanks,
Mauro


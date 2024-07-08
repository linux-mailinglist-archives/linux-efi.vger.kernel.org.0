Return-Path: <linux-efi+bounces-1381-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFDC92A533
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 16:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC4B1F239CE
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDA01422C4;
	Mon,  8 Jul 2024 14:55:38 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CDF13FD69;
	Mon,  8 Jul 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450538; cv=none; b=KVlpL10JU8p92Ginxov8GG/aAKnWSOqoWsMaIgQrSsjMTdNe842S/bu2miA9IDCJcYgfrIwnp8lLEcC+kToaNVtS8W80DYHr71Y8KFvXnZ+1ae2s8N1S+TTaHidJ+/cWMA8ff4TS4IJvEoZOdSwWFyi4EW98kx8wB+X2jWtTKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450538; c=relaxed/simple;
	bh=rZn/8V7891ztCyBoITFmD/bjaD3U4PWwzcFKpmpp2gQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3nybfBir11++C+Plg6W69LkAKF2W5YaFjN/STWKxB8unUlmaB8LXM7ko3ezUXDmj4yS1e3d5gBH9+GXXFywU4aXOjonM1//1GeHcyHcRHNMQmhw/mnjIgcz9G0rDryulEZkDf0aRbPdeGkWrq32yv3JdCe8jCxCYJGT5v02iNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WHnFW35V5z6K6Hm;
	Mon,  8 Jul 2024 22:54:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F1AB1140A70;
	Mon,  8 Jul 2024 22:55:26 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 15:55:26 +0100
Date: Mon, 8 Jul 2024 15:55:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Daniel
 Ferguson" <danielf@os.amperecomputing.com>, Ard Biesheuvel <ardb@kernel.org>,
	James Morse <james.morse@arm.com>, Len Brown <lenb@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Shiju Jose <shiju.jose@huawei.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Dan
 Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, "Shuai Xue" <xueshuai@linux.alibaba.com>,
	<linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] RAS: ACPI: APEI: add conditional compilation to ARM
 error report functions
Message-ID: <20240708155525.00005e5b@Huawei.com>
In-Reply-To: <20240708141025.3e5ddd51@foz.lan>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
	<f520f2529bb27d452a2dee762b6968939df42f45.1720436039.git.mchehab+huawei@kernel.org>
	<20240708113234.GDZovOUgjXFt2XoNg6@fat_crate.local>
	<20240708141025.3e5ddd51@foz.lan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 8 Jul 2024 14:10:25 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 8 Jul 2024 13:32:34 +0200
> Borislav Petkov <bp@alien8.de> escreveu:
> 
> > On Mon, Jul 08, 2024 at 01:18:10PM +0200, Mauro Carvalho Chehab wrote:  
> > > From: Daniel Ferguson <danielf@os.amperecomputing.com>
> > > 
> > > This prevents the unnecessary inclusion of ARM specific RAS error    
> > 
> > s/This prevents/Prevent/
> > 
> > Avoid having "This patch" or "This commit" or "This does <bla>" in the commit
> > message. It is tautologically useless.
> > 
> > "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> > instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> > to do frotz", as if you are giving orders to the codebase to change
> > its behaviour."
> > 
> > From Documentation/process/submitting-patches.rst
> >   
> > > handling routines in non-ARM platforms.    
> > 
> > Ok, this does "something". Why does it do it?
> > 
> > Otherwise it won't build on other architectures or is it going to cause code
> > bloat or why are we doing this?  
> 
> Probably a better description would be:
> 
>     RAS: ACPI: APEI: add conditional compilation to ARM error report functions
>     
>     Don't include ARM Processor specific error handling routines in 
>     non-ARM platforms, preparing it to the next patch, as arm-specific
>     kAPI symbols will be used, thus avoiding build breakages when ARM
>     is not selected.
>     
>     [mchehab: avoid unneeded ifdefs and fix coding style issues]
>     Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
>     Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
With that change log seems fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> This patch itself just add conditionals to optimize out code on
> non-ARM architectures. The next one will add some ARM-specific bits
> inside ARM processor CPER trace, thus causing compilation breakages
> on non-ARM, due to arm-specific kAPI bits that will be used then.
> 
> Thanks,
> Mauro



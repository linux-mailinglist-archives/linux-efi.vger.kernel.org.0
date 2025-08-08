Return-Path: <linux-efi+bounces-4520-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D648B1EBDA
	for <lists+linux-efi@lfdr.de>; Fri,  8 Aug 2025 17:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA1C16BAC2
	for <lists+linux-efi@lfdr.de>; Fri,  8 Aug 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9535285CA4;
	Fri,  8 Aug 2025 15:23:30 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966B283CA7;
	Fri,  8 Aug 2025 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666610; cv=none; b=LoYLArF9wj/899syMQlbIHTeNx7SeoImzXye1A4SVyFlu9oMAsVbhohO2W8XYw1fpOBip9i4AFWOZksOFmjM7rTHWwFyRtVeORkjHn4ily9rxRWbkFSoHiTIRGyBMi6+EBDuOxzPKkBvQIo6w8z+Sr0ODVSs6Yc0rHkDu9QvgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666610; c=relaxed/simple;
	bh=cpXPAUqX/szPxgSgka2Wti093fXUZ0m0Oa9YUjPDf9k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBUNxCPJgOXC2PaQTljAYjfiHFrtLWzx0rHR2UczAiZybzTP3EeWjdmvsSc2JGiDGGgWD5vCSQpRLLsT+AOBMfyXi3Lq82P4mGL+aDMZYkBmcAiuMWUw6bDjZWBQvUDc3DgqeMwTD0bYM/jRzgWMqMhfGFfxtoWCEZKq2J48Qm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz7395NQ9z6L50v;
	Fri,  8 Aug 2025 23:18:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DB941140279;
	Fri,  8 Aug 2025 23:23:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 17:23:24 +0200
Date: Fri, 8 Aug 2025 16:23:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "James
 Morse" <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-edac@vger.kernel.org>, "Mauro Carvalho
 Chehab" <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v4 3/5] efi/cper: Add a new helper function to print
 bitmasks
Message-ID: <20250808162322.00002485@huawei.com>
In-Reply-To: <20250805-mauro_v3-v6-16-rev2-v4-3-ea538759841c@os.amperecomputing.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
	<20250805-mauro_v3-v6-16-rev2-v4-3-ea538759841c@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 05 Aug 2025 11:35:40 -0700
Daniel Ferguson <danielf@os.amperecomputing.com> wrote:

> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Add a helper function to print a string with names associated
> to each bit field.
> 
> A typical example is:
> 
> 	const char * const bits[] = {
> 		"bit 3 name",
> 		"bit 4 name",
> 		"bit 5 name",
> 	};
> 	char str[120];
>         unsigned int bitmask = BIT(3) | BIT(5);
> 
> 	#define MASK  GENMASK(5,3)
> 
> 	cper_bits_to_str(str, sizeof(str), FIELD_GET(MASK, bitmask),
> 			 bits, ARRAY_SIZE(bits));
> 
> The above code fills string "str" with "bit 3 name|bit 5 name".
> 
> Reviewed-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

oops.  That was probably my mess up.  Please fix that ; to : and
put it in the right place.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>



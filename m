Return-Path: <linux-efi+bounces-1385-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D52F92A61A
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 17:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FC8282B6A
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F29143896;
	Mon,  8 Jul 2024 15:51:05 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423621EA6F;
	Mon,  8 Jul 2024 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453864; cv=none; b=KZWbQqmvem4WqrvpE0usX+rnarJSuLiGBHkaYdDC1N7snSnC44OMBGM8QYp0lZf1DxbnuALKkDoUMSy7IUZ/kbR22r2OyXpqmTkhWdO0kwTi8LJWYAgBbLGafHIEaa9ilbDxywlcD3GADCGwlTcOS4Kx4wpScyrc4z9fXeBHAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453864; c=relaxed/simple;
	bh=e6iRe+vk5faRCS1xAM7strjnGBRYRb8V/i/6DrOfI9g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r34P+S+usX3c3sK8ke8yDaMFyFbUaXNlr8BeuAmB4TJiJ9a8h30TI10PJ8VK9rbSl/Zq70ti+CeDV7tYuYTYJpJcEim2SL4VhgeDK6wxDJt/b3GO7ctTfTupqnYnmiTvAspoNHne4sis+HWbdRoOCbKjuvqg/vFVJyzwYurpTT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WHpV75tJsz6JB3Z;
	Mon,  8 Jul 2024 23:50:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EA4F2140AA7;
	Mon,  8 Jul 2024 23:51:00 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 16:51:00 +0100
Date: Mon, 8 Jul 2024 16:50:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, James Morse <james.morse@arm.com>, "Len Brown"
	<lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Shiju Jose"
	<shiju.jose@huawei.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, Alison Schofield
	<alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] efi/cper: align ARM CPER type with UEFI 2.9A/2.10
 specs
Message-ID: <20240708165056.000012d9@Huawei.com>
In-Reply-To: <ecdee36a787c1ec2c3982e376db3d09576e07a27.1720436039.git.mchehab+huawei@kernel.org>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
	<ecdee36a787c1ec2c3982e376db3d09576e07a27.1720436039.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  8 Jul 2024 13:18:14 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Up to UEFI spec, the type byte of CPER struct for ARM processor was

Up to UEFI spec XXX?

> defined simply as:
> 
> Type at byte offset 4:
> 
> 	- Cache error
> 	- TLB Error
> 	- Bus Error
> 	- Micro-architectural Error
> 	All other values are reserved
> 
> Yet, there was no information about how this would be encoded.
> 
> Spec 2.9A errata corrected it by defining:
> 
> 	- Bit 1 - Cache Error
> 	- Bit 2 - TLB Error
> 	- Bit 3 - Bus Error
> 	- Bit 4 - Micro-architectural Error
> 	All other values are reserved
> 
> That actually aligns with the values already defined on older
> versions at N.2.4.1. Generic Processor Error Section.
> 
> Spec 2.10 also preserve the same encoding as 2.9A
> 
> Adjust CPER and GHES handling code for both generic and ARM
> processors to properly handle UEFI 2.9A and 2.10 encoding.
> 
> Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

With above tidied up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



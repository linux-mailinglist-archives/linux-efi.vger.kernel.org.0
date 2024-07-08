Return-Path: <linux-efi+bounces-1384-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1ED92A60E
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 17:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93CDEB21694
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0DC143896;
	Mon,  8 Jul 2024 15:47:07 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567313EFF3;
	Mon,  8 Jul 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453627; cv=none; b=cOo0QdQlNOW04jdOZjgo4Z4lpxDBkvHWmek8aXDzr1INWMo5lCaWigaRxodbwKGC2GHtN4drTXYyRUf9lgTIqHI5CSs+up+0ylUTZKj4/lqtq2ey31H9wBeSf1IuvdfrQ8FALHHYwFJlatPknU8SfbGL+bjWgzaAkNS9hyBlVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453627; c=relaxed/simple;
	bh=1axdbPWJ5c/v1s3yEaBZnHAgFH2hQmVUWdS89FqPcCo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T90bUA/GzkpYCrjJJgPYt3oqISYkQ/bDeEkE1v0vGt0X6nE6wEb64kQCDDA0Y5tQGJD86LtjHbj31/0+p7fsd71GiiPwhLDaGOyurLAdRKj13Qh8l+bgR/okrrntUkRgzCiEctkss37ULCo3TfQKRwMMd5dLkT6II2xdkly8tSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WHpNF5vvhz6K8pZ;
	Mon,  8 Jul 2024 23:45:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E9F8B140B63;
	Mon,  8 Jul 2024 23:47:02 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 16:47:01 +0100
Date: Mon, 8 Jul 2024 16:47:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, James Morse <james.morse@arm.com>, "Len Brown"
	<lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Shiju Jose"
	<shiju.jose@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] docs: efi: add CPER functions to driver-api
Message-ID: <20240708164700.00003b87@Huawei.com>
In-Reply-To: <2d0e11752d2bde41b61822b04b5b6f839d46b998.1720436039.git.mchehab+huawei@kernel.org>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
	<2d0e11752d2bde41b61822b04b5b6f839d46b998.1720436039.git.mchehab+huawei@kernel.org>
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

On Mon,  8 Jul 2024 13:18:15 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are two kernel-doc like descriptions at cper, which is used
> by other parts of cper and on ghes driver. They both have kernel-doc
> like descriptions.
> 
> Change the tags for them to be actual kernel-doc tags and add them
> to the driver-api documentaion at the UEFI section.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Other than the blob at the end that belongs in earlier patch LGTM.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/driver-api/firmware/efi/index.rst | 11 ++++++++---
>  drivers/firmware/efi/cper.c                     | 10 ++++------
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/driver-api/firmware/efi/index.rst b/Documentation/driver-api/firmware/efi/index.rst
> index 4fe8abba9fc6..5a6b6229592c 100644
> --- a/Documentation/driver-api/firmware/efi/index.rst
> +++ b/Documentation/driver-api/firmware/efi/index.rst
> @@ -1,11 +1,16 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -============
> -UEFI Support
> -============
> +====================================================
> +Unified Extensible Firmware Interface (UEFI) Support
> +====================================================
>  
>  UEFI stub library functions
>  ===========================
>  
>  .. kernel-doc:: drivers/firmware/efi/libstub/mem.c
>     :internal:
> +
> +UEFI Common Platform Error Record (CPER) functions
> +==================================================
> +
> +.. kernel-doc:: drivers/firmware/efi/cper.c
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index f8c8a15cd527..2785c8ea8ad8 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -69,7 +69,7 @@ const char *cper_severity_str(unsigned int severity)
>  }
>  EXPORT_SYMBOL_GPL(cper_severity_str);
>  
> -/*
> +/**
>   * cper_print_bits - print strings for set bits
>   * @pfx: prefix for each line, including log level and prefix string
>   * @bits: bit mask
> @@ -106,18 +106,16 @@ void cper_print_bits(const char *pfx, unsigned int bits,
>  		printk("%s\n", buf);
>  }
>  
> -/*
> +/**
>   * cper_bits_to_str - return a string for set bits
>   * @buf: buffer to store the output string
>   * @buf_size: size of the output string buffer
>   * @bits: bit mask
>   * @strs: string array, indexed by bit position
>   * @strs_size: size of the string array: @strs
> - * @mask: a continuous bitmask used to detect the first valid bit of the
> - *        bitmap.
>   *
> - * Add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits
> - * mask, add the corresponding string describing the bit in @strs to @buf.
> + * Add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits,
> + * add the corresponding string describing the bit in @strs to @buf.
This is in wrong patch.  No point in introducing wrong docs to fix later.

>   */
>  char *cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
>  		       const char * const strs[], unsigned int strs_size)



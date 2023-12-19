Return-Path: <linux-efi+bounces-258-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8BE8189B6
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 15:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EBF1F260DE
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD9B1B26F;
	Tue, 19 Dec 2023 14:24:32 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23111C6AE;
	Tue, 19 Dec 2023 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Svf7g0bQGz6K62v;
	Tue, 19 Dec 2023 22:23:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C19DF140DDB;
	Tue, 19 Dec 2023 22:24:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 14:24:02 +0000
Date: Tue, 19 Dec 2023 14:24:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr Bueso" <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ard
 Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 6/7] firmware/efi: Process CXL Component Events
Message-ID: <20231219142401.00000c80@Huawei.com>
In-Reply-To: <20231215-cxl-cper-v4-6-01b6dab44fcd@intel.com>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
	<20231215-cxl-cper-v4-6-01b6dab44fcd@intel.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 15 Dec 2023 15:26:32 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then send
> these events to the OS via UEFI.
> 
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference is the use of a GUID in
> the Section Type rather than a UUID as part of the event itself.
> 
> Add EFI support to detect CXL CPER records and call a registered
> notifier with the event.  Enforce that only one notifier call can be
> registered at any time.
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
One trivial thing inline.

+ Agree that notifier naming is unwise given what that means elsewhere in the
kernel.

> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 86bfcf7909ec..71f27b3e2810 100644
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -10,11 +10,38 @@
>  #ifndef LINUX_CPER_CXL_H
>  #define LINUX_CPER_CXL_H
>  
> +#include <linux/cxl-event.h>
> +
>  /* CXL Protocol Error Section */
>  #define CPER_SEC_CXL_PROT_ERR						\
>  	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
>  		  0x4B, 0x77, 0x10, 0x48)
>  
> +/* CXL Event record UUIDs are formated at GUIDs and reported in section type */

as GUIDs

> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CPER_SEC_CXL_GEN_MEDIA_GUID					\

> 



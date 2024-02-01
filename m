Return-Path: <linux-efi+bounces-447-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB884561F
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 12:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05112B21B33
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 11:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FFF15CD4F;
	Thu,  1 Feb 2024 11:22:26 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93CE4D9E8;
	Thu,  1 Feb 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786546; cv=none; b=GXCVOG7t3CwUCLMU+7eaQx0aLzlUi321Ysu6B9XHCQ2cqQhwdIrHaS59M4O/NfFKmZIseO/cUBZT3B01j1iybIE1gCMy/4AC3oakDC2oR+iKmAxWwAoE+XjH355z/RZI1GzAZzaQLNgW8erSgaquPbbgMGGdaGN6K6sIizOulyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786546; c=relaxed/simple;
	bh=E1JEBjzKqKX7niomlMIXco/erWHsqVwDhTObrROcdHk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMNcg2KIrLgdhE+zETyMSG88cjW29DeTuo5Bk8u1oy30f70Zf1V5qlD2vb3WBk73+eeJyewcjEbmYSs5X93fGrcVNVR0OUev+yyKvHqeiEEw82OCjed0xvmHJ3k6eKxg7NAQeO/TpORJ0TPMUEqxOrhuJ7ZSNP8hA56IKa39gP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQby53hVBz6JBTc;
	Thu,  1 Feb 2024 19:18:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E23C7140A36;
	Thu,  1 Feb 2024 19:22:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 11:22:15 +0000
Date: Thu, 1 Feb 2024 11:22:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/cper: Fix errant CPER prints for CXL events
Message-ID: <20240201112214.00005fea@Huawei.com>
In-Reply-To: <ZbrxDMwn4h3y5waj@aschofie-mobl2>
References: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
	<20240131-cxl-cper-fixups-v1-1-335c85b1d77b@intel.com>
	<ZbrxDMwn4h3y5waj@aschofie-mobl2>
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

On Wed, 31 Jan 2024 17:17:00 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> On Wed, Jan 31, 2024 at 03:55:38PM -0800, Ira Weiny wrote:
> > Jonathan reports that CXL CPER events dump an extra generic error
> > message.
> > 
> > 	{1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > 	{1}[Hardware Error]: event severity: recoverable
> > 	{1}[Hardware Error]:  Error 0, type: recoverable
> > 	{1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
> > 	{1}[Hardware Error]:   section length: 0x90
> > 	{1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086 ................
> > 	{1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000 ................
> > 	...
> > 
> > CXL events were rerouted though the CXL subsystem for additional
> > processing.  However, when that work was done it was missed that
> > cper_estatus_print_section() continued with a generic error message
> > which is confusing.
> > 
> > Teach CPER print code to ignore printing details of some section types.
> > Assign the CXL event GUIDs to this set to prevent confusing unknown
> > prints.  
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> 
> > 
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/acpi/apei/ghes.c    | 26 --------------------------
> >  drivers/firmware/efi/cper.c | 19 +++++++++++++++++++
> >  include/linux/cper.h        | 23 +++++++++++++++++++++++
> >  3 files changed, 42 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 7b7c605166e0..fe825a432c5b 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -680,32 +680,6 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
> >  static DECLARE_RWSEM(cxl_cper_rw_sem);
> >  static cxl_cper_callback cper_callback;
> >  
> > -/* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
> > -
> > -/*
> > - * General Media Event Record
> > - * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> > - */
> > -#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
> > -	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> > -		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> > -
> > -/*
> > - * DRAM Event Record
> > - * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> > - */
> > -#define CPER_SEC_CXL_DRAM_GUID						\
> > -	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
> > -		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> > -
> > -/*
> > - * Memory Module Event Record
> > - * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> > - */
> > -#define CPER_SEC_CXL_MEM_MODULE_GUID					\
> > -	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
> > -		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> > -
> >  static void cxl_cper_post_event(enum cxl_event_type event_type,
> >  				struct cxl_cper_event_rec *rec)
> >  {
> > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> > index 35c37f667781..9b3884ff81e6 100644
> > --- a/drivers/firmware/efi/cper.c
> > +++ b/drivers/firmware/efi/cper.c
> > @@ -523,6 +523,17 @@ static void cper_print_tstamp(const char *pfx,
> >  	}
> >  }
> >  
> > +struct ignore_section {
> > +	guid_t guid;
> > +	const char *name;
> > +};
> > +
> > +static const struct ignore_section ignore_sections[] = {
> > +	{ .guid = CPER_SEC_CXL_GEN_MEDIA_GUID, .name = "CXL General Media Event" },
> > +	{ .guid = CPER_SEC_CXL_DRAM_GUID, .name = "CXL DRAM Event" },
> > +	{ .guid = CPER_SEC_CXL_MEM_MODULE_GUID, .name = "CXL Memory Module Event" },
> > +};
> > +
> >  static void
> >  cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata,
> >  			   int sec_no)
> > @@ -543,6 +554,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
> >  		printk("%s""fru_text: %.20s\n", pfx, gdata->fru_text);
> >  
> >  	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> > +
> > +	for (int i = 0; i < ARRAY_SIZE(ignore_sections); i++) {
> > +		if (guid_equal(sec_type, &ignore_sections[i].guid)) {
> > +			printk("%ssection_type: %s\n", newpfx, ignore_sections[i].name);
> > +			return;
> > +		}
> > +	}
> > +
> >  	if (guid_equal(sec_type, &CPER_SEC_PROC_GENERIC)) {
> >  		struct cper_sec_proc_generic *proc_err = acpi_hest_get_payload(gdata);
> >  
> > diff --git a/include/linux/cper.h b/include/linux/cper.h
> > index c1a7dc325121..265b0f8fc0b3 100644
> > --- a/include/linux/cper.h
> > +++ b/include/linux/cper.h
> > @@ -90,6 +90,29 @@ enum {
> >  	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
> >  		  0x72, 0x2D, 0xEB, 0x41)
> >  
> > +/* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
> > +/*
> > + * General Media Event Record
> > + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> > + */
> > +#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
> > +	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> > +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> > +/*
> > + * DRAM Event Record
> > + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> > + */
> > +#define CPER_SEC_CXL_DRAM_GUID						\
> > +	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
> > +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> > +/*
> > + * Memory Module Event Record
> > + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> > + */
> > +#define CPER_SEC_CXL_MEM_MODULE_GUID					\
> > +	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
> > +		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> > +
> >  /*
> >   * Flags bits definitions for flags in struct cper_record_header
> >   * If set, the error has been recovered
> > 
> > -- 
> > 2.43.0
> >   
> 



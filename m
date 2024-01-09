Return-Path: <linux-efi+bounces-370-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83099828992
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 17:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DA9288062
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E13987C;
	Tue,  9 Jan 2024 16:04:43 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47DB3A1A0;
	Tue,  9 Jan 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8bKl5mnDz6D91P;
	Wed, 10 Jan 2024 00:02:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 19559140736;
	Wed, 10 Jan 2024 00:04:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 16:04:36 +0000
Date: Tue, 9 Jan 2024 16:04:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr Bueso" <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ard
 Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 0/9] efi/cxl-cper: Report CPER CXL component events
 through trace events
Message-ID: <20240109160435.00004a4a@Huawei.com>
In-Reply-To: <659cb684deb2d_127da22945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
	<20240108165855.00002f5a@Huawei.com>
	<eefc5888-4610-8e39-61ed-2d84e9ebf255@amd.com>
	<659caa8da651c_127da22947b@dwillia2-xfh.jf.intel.com.notmuch>
	<659cb0295ac1_8d749294b@iweiny-mobl.notmuch>
	<659cb684deb2d_127da22945a@dwillia2-xfh.jf.intel.com.notmuch>
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

On Mon, 8 Jan 2024 18:59:16 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Ira Weiny wrote:
> > Dan Williams wrote:  
> > > Smita Koralahalli wrote:  
> > > > On 1/8/2024 8:58 AM, Jonathan Cameron wrote:  
> > > > > On Wed, 20 Dec 2023 16:17:27 -0800
> > > > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > > >   
> > > > >> Series status/background
> > > > >> ========================
> > > > >>
> > > > >> Smita has been a great help with this series.  Thank you again!
> > > > >>
> > > > >> Smita's testing found that the GHES code ended up printing the events
> > > > >> twice.  This version avoids the duplicate print by calling the callback
> > > > >> from the GHES code instead of the EFI code as suggested by Dan.  
> > > > > 
> > > > > I'm not sure this is working as intended.
> > > > > 
> > > > > There is nothing gating the call in ghes_proc() of ghes_print_estatus()
> > > > > and now the EFI code handling that pretty printed things is missing we get
> > > > > the horrible kernel logging for an unknown block instead.
> > > > > 
> > > > > So I think we need some minimal code in cper.c to match the guids then not
> > > > > log them (on basis we are arguing there is no need for new cper records).
> > > > > Otherwise we are in for some messy kernel logs
> > > > > 
> > > > > Something like:
> > > > > 
> > > > > {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > > > > {1}[Hardware Error]: event severity: recoverable
> > > > > {1}[Hardware Error]:  Error 0, type: recoverable
> > > > > {1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
> > > > > {1}[Hardware Error]:   section length: 0x90
> > > > > {1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086  ................
> > > > > {1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000  ................
> > > > > {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > > > > {1}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
> > > > > {1}[Hardware Error]:   00000040: 00000000 00000000 00000000 00000000  ................
> > > > > {1}[Hardware Error]:   00000050: 00000000 00000000 00000000 00000000  ................
> > > > > {1}[Hardware Error]:   00000060: 00000000 00000000 00000000 00000000  ................
> > > > > {1}[Hardware Error]:   00000070: 00000000 00000000 00000000 00000000  ................
> > > > > {1}[Hardware Error]:   00000080: 00000000 00000000 00000000 00000000  ................
> > > > > cxl_general_media: memdev=mem1 host=0000:10:00.0 serial=4 log=Informational : time=0 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=0 flags='' handle=0 related_handle=0 maint_op_class=0 : dpa=0 dpa_flags='' descriptor='' type='ECC Error' transaction_type='Unknown' channel=0 rank=0 device=0 comp_id=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 validity_flags=''
> > > > > 
> > > > > (I'm filling the record with 0s currently)  
> > > > 
> > > > Yeah, when I tested this, I thought its okay for the hexdump to be there 
> > > > in dmesg from EFI as the handling is done in trace events from GHES.
> > > > 
> > > > If, we need to handle from EFI, then it would be a good reason to move 
> > > > the GUIDs out from GHES and place it in a common location for EFI/cper 
> > > > to share similar to protocol errors.  
> > > 
> > > Ah, yes, my expectation was more aligned with Jonathan's observation to
> > > do the processing in GHES code *and* skip the processing in the CPER
> > > code, something like:
> > >   
> > 
> > Agreed this was intended I did not realize the above.
> >   
> > > 
> > > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> > > index 35c37f667781..0a4eed470750 100644
> > > --- a/drivers/firmware/efi/cper.c
> > > +++ b/drivers/firmware/efi/cper.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/bcd.h>
> > >  #include <acpi/ghes.h>
> > >  #include <ras/ras_event.h>
> > > +#include <linux/cxl-event.h>
> > >  #include "cper_cxl.h"
> > >  
> > >  /*
> > > @@ -607,6 +608,15 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
> > >  			cper_print_prot_err(newpfx, prot_err);
> > >  		else
> > >  			goto err_section_too_small;
> > > +	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
> > > +		printk("%ssection_type: CXL General Media Error\n", newpfx);  
> > 
> > Do we want the printk's here?  I did not realize that a generic event
> > would be printed.  So intention was nothing would be done on this path.  
> 
> I think we do otherwise the kernel will say
> 
>     {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
>     {1}[Hardware Error]: event severity: recoverable
>     {1}[Hardware Error]:  Error 0, type: recoverable
>     ...
> 
> ...leaving the user hanging vs:
>  
>     {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
>     {1}[Hardware Error]: event severity: recoverable
>     {1}[Hardware Error]:  Error 0, type: recoverable
>     {1}[Hardware Error]:   section type: General Media Error
> 
> ...as an indicator to go follow up with rasdaemon or whatever else is
> doing the detailed monitoring of CXL events.

Agreed. Maybe push it out to a static const table though.
As the argument was that we shouldn't be spitting out big logs in this
modern world, let's make it easy for people to add more entries.

struct skip_me {
	guid_t guid;
	const char *name;
};
static const struct skip_me skip_me = {
	{ &CPER_SEC_CXL_GEN_MEDIA, "CXL General Media Error" },
etc.
};

for (i = 0; i < ARRAY_SIZE(skip_me); i++) {
	if (guid_equal(sec_type, skip_me[i].guid)) {
		printk("%asection_type: %s\n", newpfx, skip_me[i].name);
		break;	
}

or something like that in the final else.


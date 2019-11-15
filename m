Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F069FFDA25
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2019 10:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfKOJ6E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Nov 2019 04:58:04 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbfKOJ6E (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 15 Nov 2019 04:58:04 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 19CF5FEBA85D1F90A173;
        Fri, 15 Nov 2019 09:58:02 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 Nov 2019 09:58:01 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 15 Nov
 2019 09:58:01 +0000
Date:   Fri, 15 Nov 2019 09:58:00 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <nariman.poushin@linaro.org>
CC:     Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        <linux-efi@vger.kernel.org>, <ard.biesheuvel@linaro.org>,
        <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        <linux-acpi@vger.kernel.org>, <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] efi / ras: CCIX Cache error reporting
Message-ID: <20191115095800.00006ce8@Huawei.com>
In-Reply-To: <20191114131731.000011f0@huawei.com>
References: <20191113151627.7950-1-Jonathan.Cameron@huawei.com>
        <20191113151627.7950-3-Jonathan.Cameron@huawei.com>
        <20191114063846.60dd8090@kernel.org>
        <20191114131731.000011f0@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 14 Nov 2019 13:17:31 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Thu, 14 Nov 2019 06:38:46 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Wed, 13 Nov 2019 23:16:23 +0800
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:
> >   
> > > As CCIX Request Agents have fully cache coherent caches,
> > > the CCIX 1.0 Base Specification defines detailed error
> > > reporting for these caches.
> > > 
> > > A CCIX cache error is reported via a CPER record as defined in the
> > > UEFI 2.8 specification. The PER log section is defined in the
> > > CCIX 1.0 Base Specification.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---  
> ...
> 
> > > +static int cper_ccix_cache_err_details(const char *pfx,
> > > +				     struct
> > > acpi_hest_generic_data *gdata) +{
> > > +	struct cper_ccix_cache_error *full_cache_err;
> > > +	struct cper_sec_ccix_cache_error *cache_err;
> > > +	u16 vendor_data_len;
> > > +	int i;
> > > +
> > > +	if (gdata->error_data_length < sizeof(*full_cache_err))
> > > +		return -ENOSPC;
> > > +
> > > +	full_cache_err = acpi_hest_get_payload(gdata);
> > > +
> > > +	cache_err = &full_cache_err->cache_record;
> > > +
> > > +	if (cache_err->validation_bits &
> > > CCIX_CACHE_ERR_TYPE_VALID)
> > > +		printk("%s""Cache Type: %s\n", pfx,
> > > +
> > > cper_ccix_cache_type_str(cache_err->cache_type)); +
> > > +	if (cache_err->validation_bits & CCIX_CACHE_ERR_OP_VALID)
> > > +		printk("%s""Operation: %s\n", pfx,
> > > +
> > > cper_ccix_cache_err_op_str(cache_err->op_type)); +
> > > +	if (cache_err->validation_bits &
> > > CCIX_CACHE_ERR_CACHE_ERR_TYPE_VALID)
> > > +		printk("%s""Cache Error Type: %s\n", pfx,
> > > +
> > > cper_ccix_cache_err_type_str(cache_err->cache_error_type)); +
> > > +	if (cache_err->validation_bits &
> > > CCIX_CACHE_ERR_LEVEL_VALID)
> > > +		printk("%s""Level: %d\n", pfx,
> > > cache_err->cache_level); +
> > > +	if (cache_err->validation_bits &
> > > CCIX_CACHE_ERR_SET_VALID)
> > > +		printk("%s""Set: %d\n", pfx, cache_err->set);
> > > +
> > > +	if (cache_err->validation_bits &
> > > CCIX_CACHE_ERR_WAY_VALID)
> > > +		printk("%s""Way: %d\n", pfx, cache_err->way);
> > > +
> > > +	if (cache_err->validation_bits &
> > > CCIX_CACHE_ERR_INSTANCE_ID_VALID)
> > > +		printk("%s""Instance ID: %d\n", pfx,
> > > cache_err->instance); +
> > > +	if (cache_err->validation_bits &
> > > CCIX_CACHE_ERR_VENDOR_DATA_VALID) {
> > > +		if (gdata->error_data_length <
> > > sizeof(*full_cache_err) + 4)
> > > +			return -ENOSPC;
> > > +
> > > +		vendor_data_len = cache_err->vendor_data[0] &
> > > GENMASK(15, 0);
> > > +		if (gdata->error_data_length <
> > > +		    sizeof(*full_cache_err) + vendor_data_len)
> > > +			return -ENOSPC;
> > > +
> > > +		for (i = 0; i < vendor_data_len / 4 - 1; i++)
> > > +			printk("%s""Vendor%d: 0x%08x\n", pfx, i,
> > > +			       cache_err->vendor_data[i + 1]);
> > >  
> > 
> > I forgot to comment this at patch 1/6, as this is more a reflection
> > than asking for a change...
> > 
> > Not sure what's the value of also printing events to the Kernel
> > logs.
> > 
> > I mean, we do that for existent RAS drivers, mainly because the RAS
> > report mechanism came after the printks, and someone could be
> > relying at the kernel logs instead of using rasdaemon (or some
> > other alternative software someone might write).
> > 
> > For new report mechanisms, perhaps we could be smarter - at least
> > offering ways to disable the printks if a daemon is listening to
> > the trace events.
> > 
> > Boris/Tony: what do you think?
> >   
> 
> Indeed, seems like a sensible time to make such a change if people
> agree it makes sense to do so.
> I'll leave this for now and get a v5 out with the fixes you mention.

We did some experiments on using whether the tracepoint is
enabled or not to control the printing.   It's easy to use
if (static_key_false(&__tracepoint_ccix_memory_error_event.key)) etc
to block kernel log output if someone is has enabled the tracepoint.
However, this only stops the parts that occur after we have identified
the cper record type and that we actually have enough info to
identify which tracepoint to use.

So without some slightly nasty code that either:
1. Parses the record twice, once to figure out whether it will end up
   at an enabled tracepoint, second time to do printing etc if not.
2. Stores up the stuff that will be printed and passes it forwards to
   be dumped to the log once we know we don't have an open tracepoint.

we get the first few lines from the generic cper header.

So can be done but either only partly effective or ugly code flow
required.

It will need to be done separately for each possible tracepoint to
avoid losing errors if the rasdaemon version doesn't support all
the events the current kernel produces.

Thanks,

Jonathan

> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +  
> ....
> > 
> > 
> > Cheers,
> > Mauro  
> 
> 
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm



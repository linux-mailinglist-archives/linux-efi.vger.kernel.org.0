Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB53FC673
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 13:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfKNMnn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 07:43:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbfKNMnn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Nov 2019 07:43:43 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0796D822D3BCB512EE4B;
        Thu, 14 Nov 2019 20:43:40 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 20:43:34 +0800
Date:   Thu, 14 Nov 2019 12:43:26 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        <james.morse@arm.com>, <rjw@rjwysocki.net>, <tony.luck@intel.com>,
        <linuxarm@huawei.com>, <ard.biesheuvel@linaro.org>,
        <nariman.poushin@linaro.org>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>
Subject: Re: [PATCH v4 1/6] efi / ras: CCIX Memory error reporting
Message-ID: <20191114124326.0000158c@huawei.com>
In-Reply-To: <20191114062227.46d6c60e@kernel.org>
References: <20191113151627.7950-1-Jonathan.Cameron@huawei.com>
        <20191113151627.7950-2-Jonathan.Cameron@huawei.com>
        <20191114062227.46d6c60e@kernel.org>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 14 Nov 2019 06:22:27 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 13 Nov 2019 23:16:22 +0800
> Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:
> 
> > CCIX defines a number of different error types
> > (See CCIX spec 1.0) and UEFI 2.8 defines a CPER record to allow
> > for them to be reported when firmware first handling is in use.
> > The last part of that record is a copy of the CCIX protocol
> > error record which can provide very detailed information.
> > 
> > This patch introduces infrastructure and support for one of those
> > error types, CCIX Memory Errors.  Later patches will supply
> > equivalent support for the other error types.
> > 
> > The variable length and content of the different messages makes
> > a single tracepoint impractical.  As such the current RAS
> > tracepoint only covers the memory error. Additional trace points
> > will be introduced for other error types along with their
> > cper handling in a follow up series.  
> 
> I want to see the entire series before reviewing the tracepoint
> stuff.

Sorry, that's stray text left from an earlier version which only had
this patch.  The whole set are in this series.  This is the full set
of error recorded defined in the relevant specs.  I'll clear that
out in v5.

> 
> For now, I'm pointing just some issues I found at the code.
> 
> > 
> > RAS daemon support to follow shortly.  
> 
> That's ok. I probably will review RAS daemon patchsets only after we merge 
> the Kernel patchset.

This bit of the message is out of date as well.  Cover letter has link
to last posted version of RAS daemon patches.  I'll rebase those and
drop the legal boilerplate as done here.

> 
> > qemu injection patches
> > also available but not currently planing to upstream those.
> > 
...

> > +static int cper_ccix_err_location(struct cper_ccix_mem_err_compact *cmem_err,
> > +				  char *msg)
> > +{
> > +	u32 len = CPER_REC_LEN - 1;  
> 
> I don't like much the code here... I mean, based on the code below, the
> msg to be passed here should have CPER_REC_LEN, but the function  prototype
> doesn't reflect that. I would  instead, either pass len as a function parameter
> or change the above to something like:
> 
> 	static int cper_ccix_err_location(struct cper_ccix_mem_err_compact *cmem_err,
> 					  char msg[CPER_REC_LEN])
> 	{
> 		u32 len = sizeof(msg) - 1;

Annoyingly can't do this last part.  
warning: 'sizeof' on array function parameter 'msg' wil return size of 'char *'.

> 
> With that, gcc should be able to generate a warning if someone passes a
> buffer with a different size.

Agreed :) I may have taken copying local style a bit too far
here. Taken directly from cper.c cper_mem_err_location.

> 
> > +	u32 n = 0;
> > +
> > +	if (!msg)
> > +		return 0;
> > +
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_GENERIC_MEM_VALID)
> > +		n += snprintf(msg + n, len, "Pool Generic Type: %s ",
> > +			      cper_ccix_mem_err_generic_type_str(cmem_err->pool_generic_type));  
> 
> Here, n will always be 0, so no need of doing msg + n.
and can use

n = sprintf(...) One we have change the first one to not stylistically math
the others might as well go the whole way.

> 
> > +
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_MEM_ERR_TYPE_VALID)
> > +		n += snprintf(msg + n, len, "Err Type: %s ",
> > +			      cper_ccix_mem_err_type_str(cmem_err->mem_err_type));  
> 
> Well, as the msg buffer size is given by len, and you have already
> n characters there, you need to decrement the size at snprintf, in order
> to avoid going past of len, e. g., starting from here, all snprintf()
> statements should be, instead:
> 
> 		n += snprintf(msg + n, len - n, ...);

Gah. That's embarrassing.  Fixed.

> 
> 
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_OP_VALID)
> > +		n += snprintf(msg + n, len, "Operation: %s ",
> > +			     cper_ccix_mem_err_op_str(cmem_err->op_type));
> > +
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_CARD_VALID)
> > +		n += snprintf(msg + n, len, "Card: %d ", cmem_err->card);
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_MOD_VALID)
> > +		n += snprintf(msg + n, len, "Mod: %d ", cmem_err->module);
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_BANK_VALID)
> > +		n += snprintf(msg + n, len, "Bank: %d ", cmem_err->bank);
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_DEVICE_VALID)
> > +		n += snprintf(msg + n, len, "Device: %d ", cmem_err->device);
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_ROW_VALID)
> > +		n += snprintf(msg + n, len, "Row: %d ", cmem_err->row);
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_COL_VALID)
> > +		n += snprintf(msg + n, len, "Col: %d ", cmem_err->column);
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_RANK_VALID)
> > +		n += snprintf(msg + n, len, "Rank: %d ", cmem_err->rank);
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_BIT_POS_VALID)
> > +		n += snprintf(msg + n, len, "BitPos: %d ", cmem_err->bit_pos);
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_CHIP_ID_VALID)
> > +		n += snprintf(msg + n, len, "ChipID: %d ", cmem_err->chip_id);
> > +	if (cmem_err->validation_bits & CCIX_MEM_ERR_SPEC_TYPE_VALID)
> > +		n += snprintf(msg + n, len, "Pool Specific Type: %s ",
> > +			      cper_ccix_mem_err_spec_type_str(cmem_err->pool_specific_type));
> > +	n += snprintf(msg + n, len, "FRU: %d ", cmem_err->fru);
> > +
> > +	return n;
> > +}

...

Thanks, v5 to follow shortly with this stuff fixed across all patches,

Jonathan



Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF1C480BEC
	for <lists+linux-efi@lfdr.de>; Tue, 28 Dec 2021 18:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhL1RM7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Dec 2021 12:12:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56040 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233056AbhL1RM6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 28 Dec 2021 12:12:58 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 074D61EC036C;
        Tue, 28 Dec 2021 18:12:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640711573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=j59Irj+zUTsu0KOhDxbKX2aummrAw6VOEX6q3YpZiqg=;
        b=g8+TSrLPCJtjVdfwuFY5E9iiMpD4J0KgXyTNFBUFlHWwU8LN0JdpCj5Z9tcoUpFQ9rtFJO
        YRzR/7B8kH0OP/Ha6Szkar2EupvbhkfOfcMkotMEwfvozis3CIZbEYeJJMNrd0fgV4p1z5
        vmy1heYEgzAthQGaM2PL5wa2Ev2OvLo=
Date:   Tue, 28 Dec 2021 18:12:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v2 1/3] ghes_edac: unify memory error report format with
 cper
Message-ID: <YctFli9oMBYTlf7h@zn.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20211210134019.28536-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210134019.28536-2-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:40:17PM +0800, Shuai Xue wrote:
> Subject: Re: [PATCH v2 1/3] ghes_edac: unify memory error report format with

"EDAC/ghes: Unify..."

is the format we use in the EDAC tree.

> The changes are to:
> 
> - add device info into ghes_edac
> - change bit_pos to bit_position, col to column, requestorID to
>   requestor_id, etc in ghes_edac
> - move requestor_id, responder_id, target_id and chip_id into memory error
>   location in ghes_edac
> - add "DIMM location: not present." for DIMM location in ghes_edac
> - remove the 'space' delimiter after the colon in ghes_edac and cper

This commit message is useless: it should not talk about what your patch
does - that should hopefully be visible in the diff itself. Rather, it
should talk about *why* you're doing what you're doing.

Also, your patch does a bunch of things at once.

From: Documentation/process/submitting-patches.rst

"Solve only one problem per patch.  If your description starts to get
long, that's a sign that you probably need to split up your patch.
See :ref:`split_changes`."

You should have a look at that file.

Also, avoid having "This patch" or "This commit" in the commit message.
It is tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> The original EDAC and cper error log are as follows (all Validation Bits
> are enabled):
> 
> [31940.060454] EDAC MC0: 1 CE Single-symbol ChipKill ECC on unknown memory (node:0 card:0 module:0 rank:0 bank:257 bank_group:1 bank_address:1 row:75492 col:8 bit_pos:0 DIMM DMI handle: 0x0000 chipID: 0 page:0x93724c offset:0x20 grain:1 syndrome:0x0 - APEI location: node:0 card:0 module:0 rank:0 bank:257 bank_group:1 bank_address:1 row:75492 col:8 bit_pos:0 DIMM DMI handle: 0x0000 chipID: 0 status(0x0000000000000000): reserved requestorID: 0x0000000000000000 responderID: 0x0000000000000000 targetID: 0x0000000000000000)
> [31940.060459] {3}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
> [31940.060460] {3}[Hardware Error]: It has been corrected by h/w and requires no further action
> [31940.060462] {3}[Hardware Error]: event severity: corrected
> [31940.060463] {3}[Hardware Error]:  Error 0, type: corrected
> [31940.060464] {3}[Hardware Error]:   section_type: memory error
> [31940.060465] {3}[Hardware Error]:   error_status: 0x0000000000000000
> [31940.060466] {3}[Hardware Error]:   physical_address: 0x000000093724c020
> [31940.060466] {3}[Hardware Error]:   physical_address_mask: 0x0000000000000000
> [31940.060469] {3}[Hardware Error]:   node: 0 card: 0 module: 0 rank: 0 bank: 257 bank_group: 1 bank_address: 1 device: 0 row: 75492 column: 8 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000
> [31940.060470] {3}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
> [31940.060471] {3}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0000
> 
> Now, the EDAC and cper error log are properly reporting the error as
> follows (all Validation Bits are enabled):
> 
> [ 117.973657] EDAC MC0: 1 CE Single-symbol ChipKill ECC on 0x0000

What does "ECC on 0x0000" mean?

> (node:0 card:0 module:0 rank:0 bank:1026 bank_group:4
> bank_address:2 device:0 row:6749 column:8 bit_position:0

> requestor_id:0x0000000000000000
> responder_id:0x0000000000000000
> target_id:0x0000000000000000

those look useless to me too. Probably invalid/unpopulated by BIOS...

> chip_id:0 DIMM location:not present. DIMM
> DMI handle:0x0000 page:0x8d2ef4 offset:0x20 grain:1 syndrome:0x0 -
> APEI location: node:0 card:0 module:0 rank:0 bank:1026 bank_group:4
> bank_address:2 device:0 row:6749 column:8 bit_position:0
> requestor_id:0x0000000000000000 responder_id:0x0000000000000000
> target_id:0x0000000000000000 chip_id:0 DIMM location:not present. DIMM
> DMI handle:0x0000 status(0x0000000000000000):reserved)

Sorry but I fail to see how this changed error record is an improvement.

> [  117.973663] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
> [  117.973664] {2}[Hardware Error]: It has been corrected by h/w and requires no further action
> [  117.973665] {2}[Hardware Error]: event severity: corrected
> [  117.973666] {2}[Hardware Error]:  Error 0, type: corrected
> [  117.973667] {2}[Hardware Error]:   section_type: memory error
> [  117.973668] {2}[Hardware Error]:   error_status: 0x0000000000000000
> [  117.973669] {2}[Hardware Error]:   physical_address: 0x00000008d2ef4020
> [  117.973670] {2}[Hardware Error]:   physical_address_mask: 0x0000000000000000
> [  117.973672] {2}[Hardware Error]:   node:0 card:0 module:0 rank:0 bank:1026 bank_group:4 bank_address:2 device:0 row:6749 column:8 bit_position:0 requestor_id:0x0000000000000000 responder_id:0x0000000000000000 target_id:0x0000000000000000 chip_id:0
> [  117.973673] {2}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
> [  117.973674] {2}[Hardware Error]:   DIMM location: not present. DMI handle:0x0000
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/edac/ghes_edac.c    | 35 +++++++++++++++++++----------------
>  drivers/firmware/efi/cper.c | 34 +++++++++++++++++-----------------
>  2 files changed, 36 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 6d1ddecbf0da..526a28cbb19b 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -378,6 +378,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
>  		p += sprintf(p, "bank_address:%d ",
>  			     mem_err->bank & CPER_MEM_BANK_ADDRESS_MASK);
> +	if (mem_err->validation_bits & CPER_MEM_VALID_DEVICE)
> +		p += sprintf(p, "device:%d ", mem_err->device);
>  	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
>  		u32 row = mem_err->row;
>  
> @@ -385,9 +387,21 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  		p += sprintf(p, "row:%d ", row);
>  	}
>  	if (mem_err->validation_bits & CPER_MEM_VALID_COLUMN)
> -		p += sprintf(p, "col:%d ", mem_err->column);
> +		p += sprintf(p, "column:%d ", mem_err->column);
>  	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
> -		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
> +		p += sprintf(p, "bit_position:%d ", mem_err->bit_pos);

What for?

> +	if (mem_err->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
> +		p += sprintf(p, "requestor_id:0x%016llx ",
> +			     (long long)mem_err->requestor_id);
> +	if (mem_err->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
> +		p += sprintf(p, "responder_id:0x%016llx ",
> +			     (long long)mem_err->responder_id);
					^^^^^^^^^^^^^^^^^^^^^^

> +	if (mem_err->validation_bits & CPER_MEM_VALID_TARGET_ID)
> +		p += sprintf(p, "target_id:0x%016llx ",
> +			     (long long)mem_err->responder_id);
					^^^^^^^^^^^^^^^^^^^^^^

mem_err->responder_id for both responder and target?!

> +	if (mem_err->validation_bits & CPER_MEM_VALID_CHIP_ID)
> +		p += sprintf(p, "chip_id:%d ",
> +			     mem_err->extended >> CPER_MEM_CHIP_ID_SHIFT);

I don't know if some dumb BIOS simply sets those valid bits regardless
of whether those fields are populated or not... It looks like it...

Right, so first this needs to explain *why* you're doing what you're
doing. And then with each reason why, you should do a patch, one by one,
explaining the rationale.

/me goes and looks at the next patches.

Aha, and you add all that crap here just to remove it in patch 2. But
this is all useless churn.

If you want to use cper_mem_err_location(), why don't you simply use it
directly?

And so on and so on...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

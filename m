Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6356746BA1E
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 12:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhLGLeg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 06:34:36 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50926 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhLGLeg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Dec 2021 06:34:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7C93FCE1A76;
        Tue,  7 Dec 2021 11:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3DEC341C3;
        Tue,  7 Dec 2021 11:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638876662;
        bh=8ViOkLWVXQZ42WEHo2tbgKGU6m3J0kq4grEJcN0vqIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VzPVKFLwqAKwAy6m8PUkNI5HtqmPCUTK9HEXbcRZCVfKMDO4PTed7qfVz/nmt4fMQ
         uGMLIw8mzmDRhfLmF/QCkkOCQRmDhvJB0cF6RVQkUYExHllUYJokMGPdMU2qzyWGAF
         zxJUxCtO2FElRIJhNRg9GooROgsgWg6oGwHMWHUn19MV78+O8wDSJ+lmx0+TxagJSi
         g/lbHuIiy+6DbQjrIGIE6/PlkamS5GL/w9OtbMOsxrlONFRP+FC+J5miJSWhYr9SZO
         yDO5xboWZUMui4tKJ9DIrc6C29Y7UOguZG67qIfF6rrGOgFvgXNidj3af7Z1K7AqiL
         y8FVIOOONA4iQ==
Date:   Tue, 7 Dec 2021 12:30:55 +0100
From:   Robert Richter <rric@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH 1/2] ghes_edac: refactor memory error location processing
Message-ID: <Ya9F75xWt/IlwcKC@rric.localdomain>
References: <20211207031905.61906-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207031905.61906-2-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 07.12.21 11:19:04, Shuai Xue wrote:
> The memory error location processing in ghes_edac_report_mem_error() have
> Duplicated Code with cper_mem_err_location(), cper_dimm_err_location(), and
> cper_mem_err_type_str() in drivers/firmware/efi/cper.c.
> 
> To avoid the duplicated code, this patch introduces the above cper_*() into
> ghes_edac_report_mem_error().

It is not really duplicate yet, changes are slightly different which
could trigger problems in some parsers. At least those differences
should be listed in the patch description. I would rather remove the
'space' delimiter after the colon and take the ghes version of it as
logs become harder to read. So ideally there is a unification patch
before the "duplication" is removed with changes in both files as
necessary for review and to document the change.

> 
> The EDAC error log is now properly reporting the error as follows (all
> Validation Bits are enabled):
> 
> [  375.938411] EDAC MC0: 1 CE single-symbol chipkill ECC on unknown memory (node: 0 card: 0 module: 0 rank: 0 bank: 513 bank_group: 2 bank_address: 1 device: 0 row: 4887 column: 1032 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000 DIMM location: not present. DMI handle: 0x0000 page:0x898b86 offset:0x20 grain:1 syndrome:0x0 - APEI location: node: 0 card: 0 module: 0 rank: 0 bank: 513 bank_group: 2 bank_address: 1 device: 0 row: 4887 column: 1032 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000 DIMM location: not present. DMI handle: 0x0000 status(0x0000000000000000): reserved)
> [  375.938416] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
> [  375.938417] {2}[Hardware Error]: It has been corrected by h/w and requires no further action
> [  375.938418] {2}[Hardware Error]: event severity: corrected
> [  375.938419] {2}[Hardware Error]:  Error 0, type: corrected
> [  375.938420] {2}[Hardware Error]:   section_type: memory error
> [  375.938421] {2}[Hardware Error]:   error_status: 0x0000000000000000
> [  375.938422] {2}[Hardware Error]:   physical_address: 0x0000000898b86020
> [  375.938422] {2}[Hardware Error]:   physical_address_mask: 0x0000000000000000
> [  375.938426] {2}[Hardware Error]:   node: 0 card: 0 module: 0 rank: 0 bank: 513 bank_group: 2 bank_address: 1 device: 0 row: 4887 column: 1032 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000
> [  375.938426] {2}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
> [  375.938428] {2}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0000
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>


> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 6ec8edec6329..08eabb2e23f8 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -211,7 +211,7 @@ const char *cper_mem_err_type_str(unsigned int etype)
>  }
>  EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
>  
> -static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
> +int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>  {
>  	u32 len, n;
>  
> @@ -265,7 +265,7 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>  	return n;
>  }
>  
> -static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
> +int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
>  {
>  	u32 len, n;
>  	const char *bank = NULL, *device = NULL;

Even though the ghes driver cannot be built as module,
EXPORT_SYMBOL_GPL()s should be added for both.

It would be good to add a note to the description that the
UEFI_CPER/EDAC_GHES dependency is always solved through
ACPI_APEI_GHES/ACPI_APEI. But we should make the UEFI_CPER dependency
explicit for EDAC_GHES in Kconfig anyway.

-Robert

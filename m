Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB56F6E13
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2019 06:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfKKF1F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Nov 2019 00:27:05 -0500
Received: from foss.arm.com ([217.140.110.172]:40610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKF1F (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 11 Nov 2019 00:27:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D41F531B;
        Sun, 10 Nov 2019 21:27:04 -0800 (PST)
Received: from [10.163.1.187] (unknown [10.163.1.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C75D73F6C4;
        Sun, 10 Nov 2019 21:27:01 -0800 (PST)
Subject: Re: [PATCH] efi: Fix comment for efi_mem_type() wrt absent physical
 addresses
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1573449229-13918-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <dcca9d9b-449a-1a97-c792-467966d8eec2@arm.com>
Date:   Mon, 11 Nov 2019 10:57:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1573449229-13918-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/11/2019 10:43 AM, Anshuman Khandual wrote:
> A previous commit f99afd08a45f ("efi: Update efi_mem_type() to return an
> error rather than 0") changed the return type from EFI_RESERVED_TYPE to
> -EINVAL when the searched physical address is not present in any memory
> descriptor. But the comment preceding the function never changed. Lets
> change the comment now to reflect the new return type -EINVAL.

In the subject line, s/PATCH/PATCH V2/. Not sending yet another patch just
to fix this (in order to reduce spam). But please let me know in case that
will be essential.

> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V2:
> 
> - Changed comment for efi_mem_type() instead of the return type per Ard
> 
> V1: (https://lore.kernel.org/patchwork/patch/1149002/)
> 
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 77ca52d86e30..47b0bf7a2b7f 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -899,7 +899,7 @@ u64 efi_mem_attributes(unsigned long phys_addr)
>   *
>   * Search in the EFI memory map for the region covering @phys_addr.
>   * Returns the EFI memory type if the region was found in the memory
> - * map, EFI_RESERVED_TYPE (zero) otherwise.
> + * map, -EINVAL otherwise.
>   */
>  int efi_mem_type(unsigned long phys_addr)
>  {
> 

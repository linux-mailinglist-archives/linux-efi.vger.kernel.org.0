Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005372778FC
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 21:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgIXTMV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 15:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgIXTMV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Sep 2020 15:12:21 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D9C0613CE
        for <linux-efi@vger.kernel.org>; Thu, 24 Sep 2020 12:12:20 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q5so585882qkc.2
        for <linux-efi@vger.kernel.org>; Thu, 24 Sep 2020 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pz7eAR44MPmRqFfT7REbyakN7d2iTYImGTvndignSUs=;
        b=rnjlmkiQZNdxQyuUVs9GdNRsyF6X6CvsTlcocHooF7Il+nFTeZ3n4ClZPPZikLDoyP
         6Wv7z3gK+wFhMnEQ4d5+nuSIoNzfx67LCOutMKUROyCg/vRBZ/b+CR43jUo3xkL0DE/l
         zFQjfh4jgQ6EsKqPaid/dnJPUBqLJ7wcb3/xCqLGFXgH5iCnkh2KykVEudrzbaqUh/Jo
         7isg2CpoacxyVAvq8/kNpDNNLl4yARcCShIMEyNRnLI50QnFqomU9J7fk/JRy+vXmidY
         wV6uNeeV1DGM4Pl/xWmhWko/pJe889JsPUYssX1dWyZC8WXuyKIOE23vG7UQYtgDf6iB
         vJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pz7eAR44MPmRqFfT7REbyakN7d2iTYImGTvndignSUs=;
        b=TaEE+c+pUoEk/DRIZ14akRWgorqfCPOnJeBENP5lzQIEijEdac1fVBeXxwx8N6MP38
         Fq/r6YVl+CehvEuh6ndPT0aeZ8XhkffEzMF+qwX57ZCoruuppisS/nvGEVRuxHke8M+w
         VkSy46zHZkt6HSWjMm7mtBz+s9qqC+27WgFAwM3YEOVT8l/nY2h3XA5+GNbR2X3CN+Ey
         5H+qSgP62FufpYlyJIwNronsBmh/0ttiIVhovWLJbjWvpAHtv7RY5lSR3Sr/AfDWFNHU
         t77gzQ7du2VrN+Ns5vyORCJPvzXPRcNuEwSxaKgY6XbofyBM0JZjLdh+c/pGhixBPrlm
         pX5w==
X-Gm-Message-State: AOAM533GtWWRUgEmQ4+gnR/uvo5LdwmRrJrbVNi80ijGl2xxL4qRgdnn
        iRdsJIqTfyaqHr6ovdBpgr0=
X-Google-Smtp-Source: ABdhPJxuGIypKJd2KnBafc282AwIAWhHGhtTr0iekN2faZK/4LS1Dkq2EHtGnEBZsj5MP2xv9LDUVw==
X-Received: by 2002:a37:6805:: with SMTP id d5mr602094qkc.116.1600974740001;
        Thu, 24 Sep 2020 12:12:20 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u55sm354954qtu.42.2020.09.24.12.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 12:12:19 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 24 Sep 2020 15:12:17 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Lenny Szubowicz <lszubowi@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH] efi: mokvar-table: fix some issues in new code
Message-ID: <20200924191217.GA121581@rani.riverdale.lan>
References: <20200924160546.8967-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924160546.8967-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 24, 2020 at 06:05:46PM +0200, Ard Biesheuvel wrote:
> Fix a couple of issues in the new mokvar-table handling code, as
> pointed out by Arvind and Boris:
> - don't bother checking the end of the physical region against the start
>   address of the mokvar table,
> - ensure that we enter the loop with err = -EINVAL,
> - replace size_t with unsigned long to appease pedantic type equality
>   checks.
> 
> Cc: Lenny Szubowicz <lszubowi@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Arvind Sankar <nivedita@alum.mit.edu>

> ---
>  drivers/firmware/efi/mokvar-table.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
> index b1cd49893d4d..72a9e1736fef 100644
> --- a/drivers/firmware/efi/mokvar-table.c
> +++ b/drivers/firmware/efi/mokvar-table.c
> @@ -98,15 +98,14 @@ static struct kobject *mokvar_kobj;
>  void __init efi_mokvar_table_init(void)
>  {
>  	efi_memory_desc_t md;
> -	u64 end_pa;
>  	void *va = NULL;
> -	size_t cur_offset = 0;
> -	size_t offset_limit;
> -	size_t map_size = 0;
> -	size_t map_size_needed = 0;
> -	size_t size;
> +	unsigned long cur_offset = 0;
> +	unsigned long offset_limit;
> +	unsigned long map_size = 0;
> +	unsigned long map_size_needed = 0;
> +	unsigned long size;
>  	struct efi_mokvar_table_entry *mokvar_entry;
> -	int err = -EINVAL;
> +	int err;
>  
>  	if (!efi_enabled(EFI_MEMMAP))
>  		return;
> @@ -122,18 +121,16 @@ void __init efi_mokvar_table_init(void)
>  		pr_warn("EFI MOKvar config table is not within the EFI memory map\n");
>  		return;
>  	}
> -	end_pa = efi_mem_desc_end(&md);
> -	if (efi.mokvar_table >= end_pa) {
> -		pr_err("EFI memory descriptor containing MOKvar config table is invalid\n");
> -		return;
> -	}
> -	offset_limit = end_pa - efi.mokvar_table;
> +
> +	offset_limit = efi_mem_desc_end(&md) - efi.mokvar_table;
> +
>  	/*
>  	 * Validate the MOK config table. Since there is no table header
>  	 * from which we could get the total size of the MOK config table,
>  	 * we compute the total size as we validate each variably sized
>  	 * entry, remapping as necessary.
>  	 */
> +	err = -EINVAL;
>  	while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
>  		mokvar_entry = va + cur_offset;
>  		map_size_needed = cur_offset + sizeof(*mokvar_entry);
> @@ -150,7 +147,7 @@ void __init efi_mokvar_table_init(void)
>  				       offset_limit);
>  			va = early_memremap(efi.mokvar_table, map_size);
>  			if (!va) {
> -				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%zu.\n",
> +				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%lu.\n",
>  				       efi.mokvar_table, map_size);
>  				return;
>  			}
> -- 
> 2.17.1
> 

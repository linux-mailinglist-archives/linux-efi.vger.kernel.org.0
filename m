Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 096AE17967F
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgCDRPm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 12:15:42 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33848 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbgCDRPm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 12:15:42 -0500
Received: by mail-qt1-f194.google.com with SMTP id 59so1947635qtb.1
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 09:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=18PjJ2EvI+NSa7KkSMmOvlCtp3yvGzEW0A0f7T2pP8s=;
        b=pEllMFjJJwa5q+cuU1JWS/h1ZsB1V0fkEO6VOmsXJr+2lzokq/1Llm036lpEQ52U3G
         nG96hInHB8cWkKkuFcPKxlBd0udN+XrNadaIjcYSxSMxg1VJDvHpOU/Qjv4sMslsQJKM
         XDDw8Mkr081vwhdWW2nFdMSjm0+JNBTxc6Pz2NJDT8xHnJedJdjTxtXF2IsSmjZoQZIU
         PzC2TMan+UbXfNKS8Cne2xZhy6jH7IK0qNbL2B5dS9e3MpyzO31lvjM4udt3FNMjLhHx
         e1jsAb7PUQos56GSSFcfXVx9NR3PIUhUJIkcZ5COntUGGHj+sD3Jw1RnuLr66x5gVA43
         rFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=18PjJ2EvI+NSa7KkSMmOvlCtp3yvGzEW0A0f7T2pP8s=;
        b=RR4oIFLWqwZ6dVgTUNL0Hwsw1lhMYtaTLqJ+mzgMuqtxhq1O/ZDT2gSedEfBTqW5eW
         ChNCfHrIpuc+jtpoFHGAS85g3xttLfA3x4HhZePqwnptPKAV7s168d0l/5vMkDuAzXwH
         KI2B8Njb08W0nols1V7/F1lRt0zwd+liVIhZF62j5M3KfqCPR1uuihje7YN5SQ04pbgM
         cUpHcraNe9W2hVudaE9wFiucJIu9pdtjT6B7AiY8N3exVBiKqw4WKtESESqzAR+qNB1C
         qlCmbypIFapJaG+tDhM6bEB+7q4Q2vSIaikz6iUl5FX+At0+MIDoXOsOU6Fhm1L3acjt
         KKSw==
X-Gm-Message-State: ANhLgQ3sQ2B5mzcp+GOpfaR7+uUT+QvXOLWunfmXh6qJ+d0wx+KvvEw/
        UM4aQZt3wI52fmyVaJDu4S/0iV220bc=
X-Google-Smtp-Source: ADFU+vtvtah3KB1s04x83khM7naVhJ4aanZBd00th0Hsp++3qpFTkmppbBaL+zT6ue0agG5HLVDSQQ==
X-Received: by 2002:ac8:3778:: with SMTP id p53mr3286781qtb.158.1583342139993;
        Wed, 04 Mar 2020 09:15:39 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r4sm1128172qkm.98.2020.03.04.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:15:39 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 4 Mar 2020 12:15:38 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, nivedita@alum.mit.edu
Subject: Re: [PATCH efi-next] efi/x86: ignore memory attributes table on i386
Message-ID: <20200304171537.GA1449349@rani.riverdale.lan>
References: <20200304165917.5893-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304165917.5893-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 04, 2020 at 05:59:17PM +0100, Ard Biesheuvel wrote:
> Commit 3a6b6c6fb23667fa ("efi: Make EFI_MEMORY_ATTRIBUTES_TABLE
> initialization common across all architectures") moved the call to
> efi_memattr_init() from ARM specific to generic EFI init code, in
> order to be able to apply the restricted permissions described in
> that table on x86 as well.
> 
> We never enabled this feature fully on i386, and so mapping and
> reserving this table is pointless. However, due to the early call to
> memblock_reserve(), the memory bookkeeping gets confused to the point
> where it produces the splat below when we try to map the memory later
> on:
> 
>   ------------[ cut here ]------------
>   ioremap on RAM at 0x3f251000 - 0x3fa1afff
>   WARNING: CPU: 0 PID: 0 at arch/x86/mm/ioremap.c:166 __ioremap_caller ...
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0 #48
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
>   EIP: __ioremap_caller.constprop.0+0x249/0x260
>   Code: 90 0f b7 05 4e 38 40 de 09 45 e0 e9 09 ff ff ff 90 8d 45 ec c6 05 ...
>   EAX: 00000029 EBX: 00000000 ECX: de59c228 EDX: 00000001
>   ESI: 3f250fff EDI: 00000000 EBP: de3edf20 ESP: de3edee0
>   DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00200296
>   CR0: 80050033 CR2: ffd17000 CR3: 1e58c000 CR4: 00040690
>   Call Trace:
>    ioremap_cache+0xd/0x10
>    ? old_map_region+0x72/0x9d
>    old_map_region+0x72/0x9d
>    efi_map_region+0x8/0xa
>    efi_enter_virtual_mode+0x260/0x43b
>    start_kernel+0x329/0x3aa
>    i386_start_kernel+0xa7/0xab
>    startup_32_smp+0x164/0x168
>   ---[ end trace e15ccf6b9f356833 ]---
> 
> Let's work around this by disregarding the memory attributes table
> altogether on i386, which does not result in a loss of functionality
> or protection, given that we never consumed the contents.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Thanks!

Tested-by: Arvind Sankar <nivedita@alum.mit.edu>

> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index d1746a579c99..34bca039fca0 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -543,7 +543,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>  		}
>  	}
>  
> -	if (efi_enabled(EFI_MEMMAP))
> +	if (!IS_ENABLED(CONFIG_X86_32) && efi_enabled(EFI_MEMMAP))
>  		efi_memattr_init();
>  
>  	efi_tpm_eventlog_init();
> -- 
> 2.17.1
> 

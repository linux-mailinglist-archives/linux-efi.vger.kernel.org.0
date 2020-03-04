Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0891F17941C
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 16:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgCDPy2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 10:54:28 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54577 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbgCDPy2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 10:54:28 -0500
Received: by mail-pj1-f68.google.com with SMTP id np16so494785pjb.4
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 07:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vGa5mCI7dcOs3cOWCT+TZKWcDeSlSKi125K5r0DngV0=;
        b=Da593CZtjrKbOfRpFSRfVIw7+mI4XTiNuPD+dRRiGTy7UyCiVsK6J81wDgZk9DcaRO
         n0gH0NdWMlh22c1sg8e5VpnqLXAxC2kFiY1QbzQQbHlWkGCP06pw7WqhFk85usoZbTwb
         QK6nT/3XVB/Jll8ZQygfD4MNbaA3ds4ILKj5PPLOqAkpYkILAx5RmxBoFmbSzkoN27PV
         NvTltMO7hTizr3RpP5lfWWREoNg78zlO9MEQQqKrj5l1Td7BmtzpYgVgDe3cjG63qD1+
         +fILn4CEhVljiEJipKVrjuXvuW1BB0D0gr0F+1oeDk9u20JyHH9dL2eCebmJzaO11gOO
         1a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=vGa5mCI7dcOs3cOWCT+TZKWcDeSlSKi125K5r0DngV0=;
        b=HiwSOMzyjKDa74aw108SSYm+mNUc/pyERavlor//nxz+DJtuN8XP8f0696aJ/m7msB
         oe1YFHbmMjcs2JjefvQ0p59yNQeoW7dFkGPQSey7AfuEZZ9cuo6ss7nW0ZR9dUSNAOxn
         Qb3dl6PZBfDc1fdsHKlKez5e9el4BTus0iEvgPnZv2zVz65CvRfxs/nR00L85rzz53eP
         rAjOPd7/XH0FSkqCR6la8a4EfB7Bcp7jKBz3uZloBVP/nkmXrWabsbqeOm7ZOmRq+q7/
         Xsyn9qCJnqhHXKYjwdn4LZmZ2psndXFLnLf3QUe4Tq05ycaZ+08tSKcr8n4FMJC/4jFh
         Hk1A==
X-Gm-Message-State: ANhLgQ3oRTKiHmIOqLhHV4ljlZfeapzvcljQm4VIbgKH4w4NLPIJviA6
        O5jm4iIY5pdxK8cjFCF4plk=
X-Google-Smtp-Source: ADFU+vvysktEqoQAEKM8SS2QRehu64vYJC8K8FgBJU5kTV1W6HakU6xW2CzXyQwUYQRjVlw5U5aqeA==
X-Received: by 2002:a17:902:b404:: with SMTP id x4mr3688932plr.80.1583337267667;
        Wed, 04 Mar 2020 07:54:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f127sm29797088pfa.112.2020.03.04.07.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 07:54:26 -0800 (PST)
Date:   Wed, 4 Mar 2020 07:54:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: Re: [PATCH efi-next] efi/x86: preserve %ebx correctly in
 efi_set_virtual_address_map()
Message-ID: <20200304155424.GA15773@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 04, 2020 at 02:35:15PM +0100, Ard Biesheuvel wrote:
> Commit 59f2a619a2db8611 ("efi: Add 'runtime' pointer to struct efi")
> modified the assembler routine called by efi_set_virtual_address_map(),
> to grab the 'runtime' EFI service pointer while running with paging
> disabled (which is tricky to do in C code)
> 
> After the change, register %ebx is not restored correctly, resulting
> in all kinds of weird behavior, so fix that.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

(on top of next-20200304)

Thanks for the quick fix!

Guenter

> ---
>  arch/x86/platform/efi/efi_stub_32.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/efi/efi_stub_32.S b/arch/x86/platform/efi/efi_stub_32.S
> index 09237236fb25..09ec84f6ef51 100644
> --- a/arch/x86/platform/efi/efi_stub_32.S
> +++ b/arch/x86/platform/efi/efi_stub_32.S
> @@ -54,7 +54,7 @@ SYM_FUNC_START(efi_call_svam)
>  	orl	$0x80000000, %edx
>  	movl	%edx, %cr0
>  
> -	pop	%ebx
> +	movl	16(%esp), %ebx
>  	leave
>  	ret
>  SYM_FUNC_END(efi_call_svam)
> -- 
> 2.17.1
> 

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534141770F6
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 09:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgCCIWU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 03:22:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33335 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgCCIWU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 03:22:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id a20so2190225otl.0
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 00:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6EQLN6SsV+VtgLYWfNW0nRQASGUiBeXhHQHvZKJ4CM=;
        b=hZbDznaZ/8zfBcFNm9kigkVMeGC6gcQiALbMrjg9x+FlQxJib35GOZl92cSdumutaE
         U7FSTh0ijgCdKOx+r+oyAWyQWcNkdBPidCgNjimPTphK/g+WBNZJFBQev2SglQTbnD2s
         m72K1E1kh7gBRu7lXn3J8tJ0HHYRs+ySyFEFGNc7/OBNNGXhANK7MJB/7uvb2smBAsmN
         X8q1Qq/2Ea1ndNBbyni9z7LB3kA3dkRYHVHp3FY86f2na3xV4CBu6kxvCe4GTFdsqZXd
         qZyXrHTrYarAicnMeJRD8bYnuzHq8gco5tpSCphuIt60rjobptzJCkgUq+Ltp2iiDyOP
         68tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6EQLN6SsV+VtgLYWfNW0nRQASGUiBeXhHQHvZKJ4CM=;
        b=XztpngwEg33JienY9NTaOfhEFf0QrXSBcB7CSer6zZxOXnCQ/aMuC35hQSXxy2Uu8O
         gUr6hMjBBtq4lSDYSRUUo4+zQEv9aOxuXtPZq1+nX/isLQJLwhUnV1vDJbzvk9lmE0gb
         YDqxnsXQBnuPv8wzIuYnDDv/wdoXQ8R3NDeph9/z3u2qy04dbLPbzsRZssPOyGZpFY5D
         a33tpj+zYBAWnR+Pm2055GwHoyVMNVTOn2xqxFxALwHB2byEwJSznrBfF6CxpMj150LR
         +Asa7u6jjqBNc+wwUkT2sV1s4Dodn6I4vddRCJngzvW+9EIs8kIXsUEJoWT6nqD8wp0A
         rCkw==
X-Gm-Message-State: ANhLgQ2Qu5B1EN7B13OV7IycqoB2Fc54luRiQbzjTzmQG7J4b2pZIN+D
        rLw75UdgC+47KHMN4KWqxEo=
X-Google-Smtp-Source: ADFU+vs3plHE9nYhKfQDxvmFG8+9WILVpVzK3A+RHAgy9utC/dqzLEkFiIDUuwR/Ep7U9XmohuFBQQ==
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr2494839oti.32.1583223739028;
        Tue, 03 Mar 2020 00:22:19 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id m18sm7540298otf.6.2020.03.03.00.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 00:22:18 -0800 (PST)
Date:   Tue, 3 Mar 2020 01:22:16 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi/libstub/x86: deal with exit() boot service returning
Message-ID: <20200303082216.GA16908@ubuntu-m2-xlarge-x86>
References: <20200303080648.21427-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303080648.21427-1-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 03, 2020 at 09:06:48AM +0100, Ard Biesheuvel wrote:
> Even though it is uncommon, there are cases where the Exit() EFI boot
> service might return, e.g., when we were booted via the EFI handover
> protocol from OVMF and the kernel image was specified on the command
> line, in which case Exit() attempts to terminate the boot manager,
> which is not an EFI application itself. So let's drop into a deadloop
> instead.
> 
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> As a side effect, this also fixes [0], which is as yet undiagnosed.
> 
> [0] https://github.com/ClangBuiltLinux/linux/issues/917

And for that:

Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build

>  drivers/firmware/efi/libstub/x86-stub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 7f3e97c2aad3..5c7480c4d379 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -344,7 +344,7 @@ static void setup_graphics(struct boot_params *boot_params)
>  static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
>  {
>  	efi_bs_call(exit, handle, status, 0, NULL);
> -	unreachable();
> +	for(;;);

I thought this would have tripped up clang's -Wempty-body but it
doesn't so that is good.

>  }
>  
>  void startup_32(struct boot_params *boot_params);
> -- 
> 2.17.1
> 

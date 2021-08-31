Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6364B3FC45A
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbhHaIeS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 04:34:18 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57874
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240329AbhHaIeS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Aug 2021 04:34:18 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E024840179
        for <linux-efi@vger.kernel.org>; Tue, 31 Aug 2021 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630398801;
        bh=rVFvbeyORM+yDfxXk+EyYDIWSSluCwYhSXT1xfwcA1Q=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=KSN5/BrmtvV5myU4kX1so75e4E6RRBNEZKbFsJr34sRTEBBdU7AGT1VJucJJrhVVF
         S4UjCbkO2ErZyN9cOXitxOxHx8qSPgOInHQ4dv5nYvhjrk/P4+03zbV1L2hGHxxsvW
         PoZ8ZAGvg8FCRB7QV6vUzg5cS3R9VtLH6qvQLF+HgKT78bcbTZXe9nstsm2xJF/FPU
         zVngww9XzTX1h5hYjKr27BliG2CqWLzz6hP7VZbYb6OW6hFNaXpcSr4RDOYjjd141J
         to5uyf9/oHPb2TKO50X6HtyxD9wocPZUi6OOE7SqHM0dogdMEXrHRISXuS7Ahai2rs
         qIf3RxWBGDzQQ==
Received: by mail-wm1-f71.google.com with SMTP id o20-20020a05600c379400b002e755735eedso1071245wmr.0
        for <linux-efi@vger.kernel.org>; Tue, 31 Aug 2021 01:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rVFvbeyORM+yDfxXk+EyYDIWSSluCwYhSXT1xfwcA1Q=;
        b=feGRY/dVKbW15WGy46TuOn67qHx+GsW2oyPR9nZU2jo+nmdA0s4ewGriIj30u7lWYp
         urrDdim0SqvmTiA1UJb7JLFdhAkAgRZ7WYOdPorp0oPIAd7CNX7fZ7GO1Bo6TdGcendb
         KrpnIZEX6Y6hde4VohtSEuYRXV74IuRbIqowF3Yjmlqch29Kv0PBSTIGjb+QFkfG2ybq
         4J0VWOWxTMyRMtR+wvpEDRnRlLsJj7ZXVAu4m0dr55qA+lp8ruWEpMFWAbwL1j0mSJAR
         Y9sT01Uec3uFbCFf5NNHy+72cd556DrlqCWxa3OxhhdTq863J60ZIdboPa7dwDtYhAjn
         8wDg==
X-Gm-Message-State: AOAM531awDv3wNi1n/vQElnYDO8CgyI0ZGeOiDFi2ehWVvQyonqJcZtV
        ur1qNQC3xIS8VnTq4vZ2foWmlx8G6rujRIJhW8dKdJodZTX+AI0dRo1bJoWaOpCYX9PFHxVPVE+
        WcMazfoJziuee3MrzTOEpQSd4RVvGhryVh4GT9Q==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr29375474wrq.212.1630398801617;
        Tue, 31 Aug 2021 01:33:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCa7b6B3ytD/ViUfIT43xB0dQK6owLm0wzrDkfQGNGVs09vAMWylFANsy71s5LasxCEN/saQ==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr29375462wrq.212.1630398801456;
        Tue, 31 Aug 2021 01:33:21 -0700 (PDT)
Received: from [192.168.123.55] (ip-88-152-144-157.hsi03.unitymediagroup.de. [88.152.144.157])
        by smtp.gmail.com with ESMTPSA id k1sm18013796wrz.61.2021.08.31.01.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 01:33:21 -0700 (PDT)
Subject: Re: [efitools PATCH 1/1] Make.rules: enable building on riscv64
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20210401165754.131719-1-xypron.glpk@gmx.de>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Message-ID: <fb11e204-a306-8857-08a0-267d28c12ef1@canonical.com>
Date:   Tue, 31 Aug 2021 10:33:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210401165754.131719-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 4/1/21 6:57 PM, Heinrich Schuchardt wrote:
> We can use just the same flags as for aarch64.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> RISC-V patches for gnu-efi are not yet accepted in upstream. Cf.
> 
> [Gnu-efi-discuss] [PATCH 1/1] Initial support for RISCV64
> https://sourceforge.net/p/gnu-efi/mailman/gnu-efi-discuss/thread/20210401153553.103286-1-xypron.glpk%40gmx.de/#msg37253360
> [Gnu-efi-discuss] [PATCH 1/1] Undefined Status in LibGetVariableAndSize()
> https://sourceforge.net/p/gnu-efi/mailman/gnu-efi-discuss/thread/20210319162557.334645-1-xypron.glpk%40gmx.de/#msg37243995
> 
> You can use
> https://github.com/xypron/gnu-efi/releases/tag/riscv64-2021-04-01 for
> building sbsigntools and efitools.

Hello James,

I did not see any review from you on this patch yet.
https://lore.kernel.org/linux-efi/?q=Make.rules%3A+enable+building+on+riscv64

gnu-efi 3.0.14 has been released with RISC-V support.

Best regards

Heinrich

> ---
>   Make.rules | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Make.rules b/Make.rules
> index 903a5a4..69bd3bd 100644
> --- a/Make.rules
> +++ b/Make.rules
> @@ -10,6 +10,8 @@ else ifeq ($(ARCH),aarch64)
>   ARCH3264 =
>   else ifeq ($(ARCH),arm)
>   ARCH3264 =
> +else ifeq ($(ARCH),riscv64)
> +ARCH3264 =
>   else
>   $(error unknown architecture $(ARCH))
>   endif
> @@ -56,6 +58,11 @@ ifeq ($(ARCH),aarch64)
>     FORMAT = -O binary
>   endif
> 
> +ifeq ($(ARCH),riscv64)
> +  LDFLAGS += --defsym=EFI_SUBSYSTEM=0x0a
> +  FORMAT = -O binary
> +endif
> +
>   %.efi: %.so
>   	$(OBJCOPY) -j .text -j .sdata -j .data -j .dynamic -j .dynsym \
>   		   -j .rel -j .rela -j .rel.* -j .rela.* -j .rel* -j .rela* \
> --
> 2.30.2
> 

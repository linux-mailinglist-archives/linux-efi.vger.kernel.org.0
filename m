Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC9E134609
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgAHPX3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 10:23:29 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40100 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHPX3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jan 2020 10:23:29 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so1543752qvb.7
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2020 07:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eKjsa4gTkbrivv0yK3FYeN120OuQ0ajMqme/DGdEw2A=;
        b=LPlHRoeXnyCOxITgEt+7vVm1df/Mrtx7YB6ynTEdpphT90gOF3Zqr0Fcw/4XuvG06y
         qD/ndY/MaAhcRsaArBMbQ+3hUUqUTmO8CqtLEtqMSCgOGL4/VFigUzVt63p0oj1VXaV/
         XwlKm+AWgk4ozkVmX8C0F1qOPwH9gNdwR9mRnQu5qAGAcnViosgFU9GRHorXSA4YwZpJ
         WBB/M9cTKwSYNyFTEPJJeGrEj6+GG6wiSxsZgzmvgtItBBkVIEQ7Zg6PNVgpmr6Z1dgj
         oqJYhljdJ2FGkczO2/V28bnonsxtKR6OlVslullHUX/tVgZLyUJWAiaZbTn91K7YgKCZ
         0IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eKjsa4gTkbrivv0yK3FYeN120OuQ0ajMqme/DGdEw2A=;
        b=JwDBIjp1SP6FlJGWHEJzG/iJufnRs5LeYJKkReXKeDTlref9quLki0hwZaEmH2aJyC
         0ucB9QXShvGHHBo9dn8w3vEfb613ZGcgQMdhjPXpRiFxI/0Ser1g+ByOFuwE2w/ZVO13
         JvA8ZG1qPjPnVSaZQ7Cxe7eYPiiJsi7xATnLDfDA8QVlim88ePaivKph1U6VFB06wpFT
         urG9hmd0zPgvqp16Vx7a6uyK/W18pEmQDPichZVIyANCEZyVcM51Ll5XHlXMCUMyOvh8
         4yGEXlZVcU3pt0fqQW3jxYmK11wkj/se3Be9kSxjCrvM7OLPpFIDlU7qMvxuIMsPV5Jt
         VKVw==
X-Gm-Message-State: APjAAAWRqb6Hzgpwhc5reE2jeVfU2diUIfkVQONObXdwy10Q6sJn+s3u
        X0HpCuRp+KwDuabqpcj3YxtnFNQN
X-Google-Smtp-Source: APXvYqwavfZIgn4rU8sxgYhm5zH/LcCC/zoAkAaC0ibcbF+f03xKQwyBVaDs8qwzJBADHQzVGf1X0w==
X-Received: by 2002:a05:6214:192f:: with SMTP id es15mr4635614qvb.219.1578497008409;
        Wed, 08 Jan 2020 07:23:28 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t2sm1464745qkc.31.2020.01.08.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 07:23:28 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 8 Jan 2020 10:23:26 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, luto@kernel.org, x86@kernel.org,
        nivedita@alum.mit.edu
Subject: Re: [PATCH 1/2] efi/libstub/x86: use const attribute for
 efi_is_64bit()
Message-ID: <20200108152325.GA2499882@rani.riverdale.lan>
References: <20200108074502.10960-1-ardb@kernel.org>
 <20200108074502.10960-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108074502.10960-2-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 08, 2020 at 08:45:01AM +0100, Ard Biesheuvel wrote:
> Reshuffle the x86 stub code a bit so that we can tag the efi_is_64bit()
> function with the 'const' attribute, which permits the compiler to
> optimize away any redundant calls. Since we have two different entry
> points for 32 and 64 bit firmware in the startup code, this also
> simplifies the C code since we'll enter it with the efi_is64 variable
> already set.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/eboot.c   | 14 ++++++--------
>  arch/x86/boot/compressed/head_64.S |  7 +++----
>  arch/x86/include/asm/efi.h         |  2 +-
>  3 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index 4afd29eb5b34..ab3a40283db7 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -21,16 +21,18 @@
>  #include "eboot.h"
>  
>  static efi_system_table_t *sys_table;
> -static bool efi_is64 = IS_ENABLED(CONFIG_X86_64);
> +extern const bool efi_is64;
>  

Didn't we need to declare this with hidden visibility? Or use the
#pragma GCC visibility push(hidden)?

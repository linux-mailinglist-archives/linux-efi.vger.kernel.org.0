Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1831DBDC0
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 21:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgETTTo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 15:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETTTo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 15:19:44 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEFCC061A0E
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 12:19:44 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ee19so1889132qvb.11
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vhr7WCmmnoqcFtr3kVQ47NkaKX9kqEhPURBr+GaKOPE=;
        b=oXgiCKJydd49fnueKCGb5H4cYMod3t6bV/F9Tv4hI2trmfYdMKWKkYNJTmC9USAquS
         gbfcJh34ur9gQF/QbbhDDdWllbYDfR2H32MQm6oSnau/RfptHT/zvmW21upxGslSRvqt
         tMFB5QofXqApzfLFLiq2xyre1WIRR/5wXALXFil8RFkhRILzTVmpFK8irdiW4LAWnhTc
         F3C2r7GuvLRsNiy88Z3438QnxFJCLS8TOTnO2ryMxZtdvRAj1ytvq1vEbIaBKZdcL8Wq
         dqSuuL2R+DPAS6FFlMg/Xv3wKVErS3y7XgLkKIWwICc5HdiwKoNU/dy5svpxfi2TixGd
         sySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vhr7WCmmnoqcFtr3kVQ47NkaKX9kqEhPURBr+GaKOPE=;
        b=VHGjv2MjGlPdK4ROsuW3Hz500gw7A4dTLqZsL9JWboKyOJGrcUjkkgTXpB0IPRlH0R
         EXQZOHiRb39Iz4K+J/cO0i7jzab73zbVt2TFurVG7S3QvXQxMtSLrBqKFJRtco9wnZPK
         IZAL6AaFqw2NsItXOS5iWpjCLd1kwJf/5o9v7GXWQluBvSZE6D8a7l5mhgFbLazpmTQQ
         wtHsGIaI7/I4YXfYPznrjf3/vCU2fsV3LeYP7jhRCGLCdhVSOemoCiJeWF2Czn5ShUiz
         De5L4tztBd0EcMLXke3hRZuV17AMFNDsH/uyGg4extILAM3930Qbh/t+VMWV/HJVUAEA
         fyuA==
X-Gm-Message-State: AOAM530klh4Xl0s95sDWGNUvs2CA3e5YE8Fh1R+hTd/3l15MiVCkGkYo
        mqbReR97JG1XADbrsJy82+s=
X-Google-Smtp-Source: ABdhPJxhLCjx4R80wDveEb7SjkX0OA548dsm6BAttXuv5U123F12HcHzqZgryzIYInGQrTugoAbXzw==
X-Received: by 2002:ad4:556c:: with SMTP id w12mr6480472qvy.52.1590002382968;
        Wed, 20 May 2020 12:19:42 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c25sm2812083qkm.119.2020.05.20.12.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:19:42 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 20 May 2020 15:19:40 -0400
To:     Fangrui Song <maskray@google.com>
Cc:     x86@kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/boot: Discard .discard.unreachable for
 arch/x86/boot/compressed/vmlinux
Message-ID: <20200520191940.GA3450657@rani.riverdale.lan>
References: <20200520182010.242489-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520182010.242489-1-maskray@google.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 20, 2020 at 11:20:10AM -0700, Fangrui Song wrote:
> In the latest efi tree, ce5e3f909fc0ed67e58367b9c56a54c20a51080b
> "efi/printf: Add 64-bit and 8-bit integer support",
> arch/x86/boot/compressed/vmlinux may have an undesired
> .discard.unreachable section from drivers/firmware/efi/libstub/vsprintf.stub.o
> 
> .discard.unreachable contains an R_X86_64_PC32 relocation, which will be
> warned by LLD: a non-SHF_ALLOC section (.discard.unreachable) is not
> part of the memory image, thus conceptually the distance between a
> non-SHF_ALLOC and a SHF_ALLOC is not a constant which can be resolved at
> link time.
> 
> % ld.lld -m elf_x86_64 -T arch/x86/boot/compressed/vmlinux.lds ... -o arch/x86/boot/compressed/vmlinux
> ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
> 
> Reuse the DISCARDS macro which includes .discard.* to drop .discard.unreachable
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  arch/x86/boot/compressed/vmlinux.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 0dc5c2b9614b..8f1025d1f681 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -74,4 +74,6 @@ SECTIONS
>  #endif
>  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
>  	_end = .;
> +
> +	DISCARDS
>  }
> -- 
> 2.26.2.761.g0e0b3e54be-goog
> 

Thanks! Maybe add a note in the commit message that the section is
generated from unreachable() annotations when CONFIG_STACK_VALIDATION is
enabled.

Tested-by: Arvind Sankar <nivedita@alum.mit.edu>

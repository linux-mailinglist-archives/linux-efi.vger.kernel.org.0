Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B094134669
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 16:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgAHPkf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 10:40:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33876 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgAHPkf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jan 2020 10:40:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so3034648qkk.1;
        Wed, 08 Jan 2020 07:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xoQ2G52rtAlzA7YeOAcs+uhJN5/UBpPhWPg+epZhSBU=;
        b=VMEJSmcVRO9pPe3Yn3C9XLpJEntW6seCdaRRhFsXKWE2Ir7WY3b2GTFTJpbREnX+Ve
         V5H+U11JWEVlObj+Bt0mlAQsS/kEeADqmz8NZgHG3xodpf3vX6TMVT3JyVqwe5TFDGpL
         QOkAdLBl5TOsSUPqxq/q5vNEe/Sjbr6x8RTS+CFZRyQM+DqtLJxonSC3UkmQwYEh7tou
         NcnLfynvce5fVgfOG0g3CgrSXF+j2uuYuszQlQH1KSwi5MS0fr60gNY+4BjlilfIMdFk
         dVtfLvcXO/hWNLXmFIJLEvyoNwGrT/PuKkuoe5ZFY7Q+cf3caWs7EbaL/RbHtXsYnpLK
         qjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xoQ2G52rtAlzA7YeOAcs+uhJN5/UBpPhWPg+epZhSBU=;
        b=iGH3hrLmik7934zuAU/laCD4054H5w1IjYBCivVTUiBxzcaWTaLHrfJX3guNAn+t8Y
         cFcAK3c5j2Wi+UP37SE5Lpm1l4Q1X5KqtB8J/AEjbWvBcMpqvdCyrpnf4FrncQJnkq6a
         yeFjMo8huOSM15d6YiKrF1S1P0JWYn55MJxGQpT8YC3FgwctOZNuYk2bUQrMoHptBfnr
         Ai7jm/2AxRjXSLHJAjmrOD/ddiTVRBBEvcS7IHxVCNa6aBI9goSlYcUbCzRUeG2MPCfg
         sDXs8s98dZwhMeZKXvtOE3U4zoP5Z6vax7DGxrSoUZQHBFJ3ybIletGNNJYKXdIFMY3X
         V+Vg==
X-Gm-Message-State: APjAAAVNBhHNn2eI33KngHyuDB/BnF6BjdZ7krgProh/OYnNnQu7BcW6
        mwYl5jrIndlJbrxGWe9uUOg=
X-Google-Smtp-Source: APXvYqwDdYPWjunv9vkNw2spQMed16xVTf+tdB3sJ/SBF4QQ+ag/hsV0MEBLZzYzTvZkKwyL3V2zbg==
X-Received: by 2002:ae9:ed47:: with SMTP id c68mr4723724qkg.136.1578498034152;
        Wed, 08 Jan 2020 07:40:34 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u7sm1723463qtg.13.2020.01.08.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 07:40:33 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 8 Jan 2020 10:40:32 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [RFC PATCH 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
Message-ID: <20200108154031.GA2512498@rani.riverdale.lan>
References: <20200108102304.25800-1-ardb@kernel.org>
 <20200108102304.25800-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108102304.25800-3-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 08, 2020 at 11:23:03AM +0100, Ard Biesheuvel wrote:
> Eliminate all GOT entries in the decompressor binary, by forcing hidden
> visibility for all symbol references, which informs the compiler that
> such references will be resolved at link time without the need for
> allocating GOT entries.
> 
> To ensure that no GOT entries will creep back in, add an assertion to
> the decompressor linker script that will fire if the .got section has
> a non-zero size.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/Makefile      |  1 +
>  arch/x86/boot/compressed/hidden.h      | 19 +++++++++++++++++++
>  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
>  3 files changed, 21 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 56aa5fa0a66b..361df91b2288 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -39,6 +39,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
>  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> +KBUILD_CFLAGS += -include hidden.h
>  

This should be added to drivers/firmware/efi/libstub as well in case
future code changes bring in global references there?

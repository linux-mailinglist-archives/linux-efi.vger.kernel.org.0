Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097CA1DF7FC
	for <lists+linux-efi@lfdr.de>; Sat, 23 May 2020 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbgEWPSB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 23 May 2020 11:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbgEWPSB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 23 May 2020 11:18:01 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF1CC061A0E;
        Sat, 23 May 2020 08:18:01 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y1so38332qtv.12;
        Sat, 23 May 2020 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/4zaO2l4trXivdy+pqmD1CXp5UVbWNbY3ylvbv3siyc=;
        b=b6JydElEayk5uybsrcH4AQMk6EYdVHMAhwri0PCpoQruuswyuLmJvmUQB7GtQaARcM
         lW+TOIln6A0quekqsW5wChIoOHbuhBsrksKzupmT5Y8Z9le3OPTS+7+vSnojnTqAFp/u
         1vfLZS/I8EA7GJvRmf0Db7HWOQVW2sepTKOiasbKsFZVfbofhgpOyu5Xn694jDoNbNmr
         GzabGS25G1cp/eGZ8rCwSLScgzoplnqGcYcpVhemQcAVdFXvWTcK0SPwgqTOYr5htuqc
         mr0Ux2Injh2b/r0/fPIcpTHwuYgZdU/KJmMf/RFnx9+FFZrB7xSaHrs8VHbHFP3xKlgS
         2+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/4zaO2l4trXivdy+pqmD1CXp5UVbWNbY3ylvbv3siyc=;
        b=h+VmlI1JdsLAj80GK0tg+EsAO4t2yarnVYIdvireYjapbkN41a75YVQs9NKmPuvXMB
         sel19hTxHEUjmhD8ZqTK4G0Qo7cDtKfNu72EVrMcoOvmQv4Qxbhs/eLmmQv15kVV5V8P
         Uj1TdUDjk8CrK2/K/MsM77cI0PWU2lSNL/MasXS9AQYaXHQVthPG7y8wVvzJVFuESx9J
         WLCIK6xGWKDgxEHf6MFjV87qxmOLFmlrAC8iJsPI+yU0wMtxOQdj2DxQCbbj5g5yvSkX
         lNtqQHJEcCZBI8ImWDr622Y5Cj32UdDbf0b5oekZ6bpFy76wFSEoIutBBaESNhMhhzDY
         uwCw==
X-Gm-Message-State: AOAM532sqmyycT6sUerZkUo+waVg7EvGzFvOSPTacuQYX7Roe9m4t8FY
        L8ma/U8Fv7y+Vzp7sxcGvL0=
X-Google-Smtp-Source: ABdhPJze6vsgP4uZqZSGmAwM7x+8fTTSRkCTM2hud41PNQ3x54b8oB9dTZBl6nbcu7GFI4FdEwI2bg==
X-Received: by 2002:aed:206c:: with SMTP id 99mr9674188qta.87.1590247080448;
        Sat, 23 May 2020 08:18:00 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t189sm484512qkc.87.2020.05.23.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 08:18:00 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 23 May 2020 11:17:58 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 3/3] x86/boot/compressed: get rid of GOT fixup code
Message-ID: <20200523151758.GB1189358@rani.riverdale.lan>
References: <20200523120021.34996-1-ardb@kernel.org>
 <20200523120021.34996-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200523120021.34996-4-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, May 23, 2020 at 02:00:21PM +0200, Ard Biesheuvel wrote:
> In a previous patch, we have eliminated GOT entries from the decompressor
> binary and added an assertion that the .got section is empty. This means
> that the GOT fixup routines that exist in both the 32-bit and 64-bit
> startup routines have become dead code, and can be removed.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 60a99dfb9d72..d91fdda51aa8 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -43,9 +43,7 @@ SECTIONS
>  		_erodata = . ;
>  	}
>  	.got : {
> -		_got = .;
>  		KEEP(*(.got))
> -		_egot = .;
>  	}
>  	.got.plt : {
>  		KEEP(*(.got.plt))
> -- 
> 2.20.1
> 

I think you can get rid of both the KEEP's here as well?

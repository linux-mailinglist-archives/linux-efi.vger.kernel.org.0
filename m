Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1481E0F31
	for <lists+linux-efi@lfdr.de>; Mon, 25 May 2020 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390674AbgEYNOW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 May 2020 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390626AbgEYNOW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 May 2020 09:14:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E657DC061A0E;
        Mon, 25 May 2020 06:14:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l26so1100922wme.3;
        Mon, 25 May 2020 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lLb0og4tlG0+5ScJbZjLWh8El6oOSBuFzon5WeuLTO4=;
        b=i96jkpDU/ButrseZ7QFSuoa+G4ZzhfXIIph4o9JxLPuUrH4KjK86b3q2zr5C3AN3Qk
         K3tKbBD3D0ecBH47eTU1BKqPyq5McNWKNvoyNHqmPl8usDeeohnwsXLi977SE7RD2WK/
         ttoqwdNAotGk46M12G+dGyPXgNGEoLHXR3zfBmJL/g9PPTaqNUyFRRb1uD7vypNTbdHF
         toQtk3P8zMbL9pUEYlDkpdvfiI4C2O86E3pHcjjBGz4/94vAiSSvg5xsfQctnmG8LpVc
         lJQLoCtEUYYlLhRMSZi0TsllFBZMiBpqdgmiGEvZl/kdfGJqCDkys2YMdP4NOwm5FWlc
         3cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lLb0og4tlG0+5ScJbZjLWh8El6oOSBuFzon5WeuLTO4=;
        b=Fn0AQeJxEbIU5FZRTdNZXdGWAGGevry25gSDSD8GLKN+jw6Sa/l1dlU5w0Q32DhteX
         oejCEmtEOdJRh0xI//u0SUWfDY4fj9IVg+3+0PevimEEzunXwwbG3E9dmEKIQqfqpLiJ
         cujYjHsSN9G9G5ElcjqbyLUFUqyzNg2el+g6gFUBQ15g/Z1EGoVZWzfFW9js0sOUa2HU
         Qgy7bR2nooZnB/GkF0x6+fewGWoiHRnzn6TyfPyuGQRZq84viG3iQRrHic3MeBsd0fuR
         a57+DC9ImrcweN1BFzzxNcAt+xBZc1T9KssPzBn2nedK86oLnof0wKI4Kws3dUhXbh7p
         NeLw==
X-Gm-Message-State: AOAM530ci4HQuieUcY6COgSUN362NVsm8hJdNUScR5+cVJPRXeXC1Kbr
        8QHDHZj9RWSjBv1+6H2P80arIy/v
X-Google-Smtp-Source: ABdhPJylPg58OihdBLTiDOTMZiAMnlp4GjxJTJedis+A0Gvf6fegBNgbpQBUr6txkuYengzMpcy/HQ==
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr25142690wmp.73.1590412460688;
        Mon, 25 May 2020 06:14:20 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 23sm10133992wmo.18.2020.05.25.06.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 06:14:19 -0700 (PDT)
Date:   Mon, 25 May 2020 15:14:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [GIT PULL] EFI changes for v5.8
Message-ID: <20200525131417.GA3066456@gmail.com>
References: <20200525080714.23228-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525080714.23228-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> Ingo, Thomsd, Boris,
> 
> Please pull the changes below. Note that I did not incorporate the GOT
> handling changes for the x86 decompressor - Arvind has some changes on
> top that might just as well go in at the same time, and they are not
> really EFI changes anyway.
> 
> The following changes since commit 4da0b2b7e67524cc206067865666899bc02e1cb0:
> 
>   efi/libstub: Re-enable command line initrd loading for x86 (2020-04-25 12:26:32 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-changes-for-v5.8
> 
> for you to fetch changes up to 9241dfe7f2772fc73c82eb950afb1c795d2c012c:
> 
>   efi/x86: Drop the special GDT for the EFI thunk (2020-05-24 00:25:15 +0200)
> 
> Cc: Ingo Molnar <mingo@redhat.com>,
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> 
> ----------------------------------------------------------------
> More EFI changes for v5.8:
> - Rename pr_efi/pr_efi_err to efi_info/efi_err, and use them consistently
> - Simplify and unify initrd loading
> - Parse the builtin command line on x86 (if provided)
> - Implement printk() support, including support for wide character strings
> - Some fixes for issues introduced by the first batch of v5.8 changes
> - Fix a missing prototypes warning
> - Simplify GDT handling in early mixed mode thunking code
> - Some other minor fixes and cleanups

>  24 files changed, 1211 insertions(+), 313 deletions(-)

Pulled, thanks a lot Ard! Will push it out after a bit of testing.

There was one conflict, in drivers/firmware/efi/libstub/efistub.h, 
with a straightforward resolution.

	Ingo

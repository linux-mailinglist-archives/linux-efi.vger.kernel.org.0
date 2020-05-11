Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015381CE2E2
	for <lists+linux-efi@lfdr.de>; Mon, 11 May 2020 20:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgEKSgt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 May 2020 14:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729727AbgEKSgt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 May 2020 14:36:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD3C061A0C;
        Mon, 11 May 2020 11:36:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id a136so1918441qkg.6;
        Mon, 11 May 2020 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hA9NFTb1+7k7xQlzFjP2Fi9iwvqTE3WYCLOf33vGY+M=;
        b=sfNDo4R5La/bb5OB6hnHssr8h76VH8aLlD1rbbIrvmbck/Xcsy2pD667yGsFJrWSjY
         69qZrPn1OjscwhR1UkWrkAiWM0uu1dTKhxraBDKrcDO/uZCevhIjikLCLNJHUJWZdxks
         eHmU6wKWNZV0fCkzqxknLJJdTbHw06VCk3mPuBnxK3IXft7SHvpyarHkw/4OK8LprC5g
         stnM+EsOyBq+HIw856oLjv0uw6yvjDout+tkpcg48t7k+U+97m/rIQ9YxVrsFEbZy50r
         6QtfKIQRRsrvvPbWLZBMd0ABM0SzIs+NQzFvkxOPODlWrntgLVkXSmow159TwMcxKa0d
         zu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hA9NFTb1+7k7xQlzFjP2Fi9iwvqTE3WYCLOf33vGY+M=;
        b=HXgPxq3hLz6O5vtrQIID+hI202xiLsbAKZjvw8uggaTY14sbe/wm6gfTtyDqeEGr6X
         dPmwuV9Vta33X9I/QCuaB1rZ+ai2nyet43Bh9e3tPpt1RBHUaopaKcjICgGW9G2g9Jln
         HhTkgVN8DlcqPI8t+ZldXLqZCoE3qpc54oXoMuJQDCiC+jHnysp8pNhsNLC+xLidgkCe
         rVYlZamVOhNBZPUo3l5lK5H8ihEKwmx2WUykFd3MXKHa80vhxyNAbsfYs1nxJ/vi+KUo
         CQCRWDoayjga1GgZb/J81NH/BfObICrltPgIUuUhBLmWCqZ1HEn4Kv3Xn6sOk89x8OAX
         M2NA==
X-Gm-Message-State: AGi0PubCvB3lrW+rTpESKukFycWsv7m2L0+XTUJ8NWjM7nJqv1zTs3DJ
        18GQ3HmV2SotWnV7Cvm7aMk=
X-Google-Smtp-Source: APiQypJmWrK/qPSGb3yE+HiSRqj/fjCSLcZsMaJeZzIuWtFaDmCqFgjK4i5q9yCvDhdylDhKy8svZQ==
X-Received: by 2002:a37:a30f:: with SMTP id m15mr16398937qke.271.1589222207680;
        Mon, 11 May 2020 11:36:47 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e16sm10096205qtc.92.2020.05.11.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:36:46 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 11 May 2020 14:36:45 -0400
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     nivedita@alum.mit.edu, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 4/5] efi/x86: Remove extra headroom for setup block
Message-ID: <20200511183645.GA596850@rani.riverdale.lan>
References: <20200303221205.4048668-5-nivedita@alum.mit.edu>
 <20200511170149.1363260-1-mike@fireburn.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200511170149.1363260-1-mike@fireburn.co.uk>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 11, 2020 at 06:01:49PM +0100, Mike Lothian wrote:
> Hi
> 
> This patch has been causing issues for me since switching to GCC 10.1:
> 
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   HOSTCC  arch/x86/boot/tools/build
> /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld: error: linker defined: multiple definition of '_end'
> /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld: /tmp/ccEkW0jM.o: previous definition here
> collect2: error: ld returned 1 exit status
> make[1]: *** [scripts/Makefile.host:103: arch/x86/boot/tools/build] Error 1
> make: *** [arch/x86/Makefile:303: bzImage] Error 2
> 
> Cheers
> 
> Mike

I'm not getting an error even with gcc 10 for some reason, but I can see
that it is busted. It's using the linker-defined _end symbol which is
just pass the end of the .bss.

Does adding "static" to the declaration of _end fix your error?

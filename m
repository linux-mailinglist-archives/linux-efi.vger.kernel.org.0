Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9DE1C2DE7
	for <lists+linux-efi@lfdr.de>; Sun,  3 May 2020 18:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgECQQG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 3 May 2020 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgECQQF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 3 May 2020 12:16:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FCBC061A0E
        for <linux-efi@vger.kernel.org>; Sun,  3 May 2020 09:16:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so4332475pfd.4
        for <linux-efi@vger.kernel.org>; Sun, 03 May 2020 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ViMcN5Zl68ZchHHk3aJI/lSPRjfqslW7Zgmv1TQFIvw=;
        b=gq1EJB2OMmp5abc0shFR16tUj4bGIG96k8MybUp+mOKyuJxcg3rW+pPyOTqGKNKiPM
         5JyGzvLu19lW5Aea8YfWSPzjzMiHJ0jfUlkWtTAyPLK00ji0e0BFFQ1Kq6v7ZZio4IgM
         hQLjIhWSicDjoZ2pSGcGOpk4dZxAM3xEmYPqcMxCFRllFdtIm9xAqEEpM61P90O+Xpgp
         qd87BuAMzRORfZCBjht6QUdiU3I8ZLMn1pdPRZx+MZVhH5dra07QIqJ0EjFS70SuCrMh
         BjDAEBg+IwssIWpw0vz60fA31ljtsBl40G1dZsEG8OxrNMVaeceqtjL5Ef5ZT/JOsqoT
         Ebzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ViMcN5Zl68ZchHHk3aJI/lSPRjfqslW7Zgmv1TQFIvw=;
        b=VbNjnoKpQvqxy/aLHK0sgXeqi2Wk6+qGJ5NeGZXuQiw/dF/nqg6WgdUgIR/tusydVv
         0Gc2txZ2eDu3cAYYrxbaI6sEutQ4/pqC9PGt1CewRFshGTYCW7qeddpCBcnrx64BCV7U
         lwhi2xzQGOuGKbm4DkXz9bIhJ4Pm985x+zWynL0yLH4mwP+o1ZL9BcaoGk5iQmKbcjUP
         jEm5ig0f/7tVkhNoB9BoOSbRHjIxysTQhQd59MVXJdlWdNjSVJcNYFS2AN8nT7+MVMZS
         nUqT5PDxi1rk1ZHrJgyAVU//I/nbQbSM6rApaeaAkepgwF45M+PGPQpi7JxJ/Qv7VLP7
         F5Rg==
X-Gm-Message-State: AGi0PuaPOhHqoz9um/6874qeDN+xyEDS7KKP8WYj20oYvpKnaumqRqF+
        /E79P2lH9rxVwwKupah9E+o=
X-Google-Smtp-Source: APiQypI3Ejvb0SacnaWnyr9B6D9OJn2Uu3jFJ6HpUmbTerv/yu65YP2pcSgdWpBTtOyPipANVWxB6Q==
X-Received: by 2002:a62:1d1:: with SMTP id 200mr14178020pfb.286.1588522563815;
        Sun, 03 May 2020 09:16:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c12sm6151540pgk.11.2020.05.03.09.16.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 May 2020 09:16:03 -0700 (PDT)
Date:   Sun, 3 May 2020 09:16:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi/libstub/x86: fix mixed mode boot issue after macro
 refactor
Message-ID: <20200503161602.GA117639@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, May 03, 2020 at 05:45:07PM +0200, Ard Biesheuvel wrote:
> Commit
> 
>   22090f84bc3f8081 ("efi/libstub: Unify EFI call wrappers for non-x86")
> 
> refactored some macros that are used to wrap EFI service calls, and
> allow us to boot the 64-bit x86 kernel from 32-bit firmware. Sadly, due
> to an oversight, this caused a boot issue on mixed mode, due to the fact
> that efi_is_native() is not a macro on x86, and so #ifndef will not
> detect that it is already defined.
> 
> Fix this by defining the macro as well.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/x86/include/asm/efi.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index cd0c3fbf6156..42b2fd123a2f 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -240,6 +240,7 @@ static inline bool efi_is_native(void)
>  		return true;
>  	return efi_is_64bit();
>  }
> +#define efi_is_native efi_is_native
>  
>  #define efi_mixed_mode_cast(attr)					\
>  	__builtin_choose_expr(						\
> -- 
> 2.26.2
> 

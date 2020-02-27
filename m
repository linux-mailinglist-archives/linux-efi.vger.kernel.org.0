Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91D68171205
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 09:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgB0IMe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 03:12:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35041 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgB0IMe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Feb 2020 03:12:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so2139417wrt.2;
        Thu, 27 Feb 2020 00:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J70rt/SASdatn2Lg2thrZdSBV7BG+LKMP1dazjE3yCQ=;
        b=GpV0H2SJkE/VG0/Sjyv1Ph+zb12roV9bLHMK+R9OPUeDx0uLxGYGD5f9zB+pBdbbHC
         UXCNbhNdEowLPwchddkt7HdjEogyvo16lzhpKc7lewXiJDaTogUWxXye3Syvb9sW15pV
         DAWQ6NifJE/0QOU6jnw6XWQd9v6wm1EaArj5yN42hm/Q/MTZj17IY4ujc6kl1VgPvfF9
         e9hw6teZl5BZjGORRXaxr1EDxa/5XIP4pOVw7JVHn2wNzTFh+gRVDJF5RtYZlHhUzG3l
         kpsTvMI5CdrBmaWy1c0UvMrCYhKUuqKTLlcr+yqZFhSP02Agbiy3EoNEgRWrUqZnev4v
         w4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=J70rt/SASdatn2Lg2thrZdSBV7BG+LKMP1dazjE3yCQ=;
        b=XEzAFOmaXQ/vBaoidepD9cciUEgkD9Pim1LSp8vrQ8tilVEfI5oWaa7rp9VHQa/Nxg
         DNXyD48PSs97POKSlqMkh4qk0FvSe39e4jFCLF6EMLorBQBvPkQX5P5kp1gFHUvlph6R
         LfVGnHQ9/CZ4IcIwwYW0ikuK2QRyq7TnCHAb+PRKyKvskJR62G0HhEVwelW3m9g1QI/j
         TosN4kyWzB24tUW0zH7a38AWD9VtdMI4p6qhGvRfIUczQXGu/ZXDtTD3XPBLU8muAKzg
         ilPXsZubp2b9uZaIFzKGYD4Tv8a1nJ9zHYYf/N3d5ImYKoXCK8CrU8Gu65qxQdP4CptW
         vPWw==
X-Gm-Message-State: APjAAAWX1VOvjV28JA/+ZGLxv+DvCEAmeWtiTTs5ydTIKCEPTEkgsx6L
        lJdXzreeIdHr/RBnIhcv0+E=
X-Google-Smtp-Source: APXvYqxH8PNR7HbvYeuz4Q7IBO5oHistetfN+RdSbeiiUueb5WdhZiEwDrD8pbWRzWoyncCtyIrOjg==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr3529303wro.357.1582791152118;
        Thu, 27 Feb 2020 00:12:32 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 18sm6488515wmf.1.2020.02.27.00.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 00:12:31 -0800 (PST)
Date:   Thu, 27 Feb 2020 09:12:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix reloading of GDTR
 post-relocation
Message-ID: <20200227081229.GA29411@gmail.com>
References: <20200226204515.2752095-1-nivedita@alum.mit.edu>
 <20200226230031.3011645-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226230031.3011645-2-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Arvind Sankar <nivedita@alum.mit.edu> wrote:

> Commit ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
> introduced GDT setup into the 32-bit kernel's startup_32, and reloads
> the GDTR after relocating the kernel for paranoia's sake.
> 
> Commit 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of
> the buffer") introduced a similar GDTR reload in the 64-bit kernel.
> 
> The GDTR is adjusted by init_size - _end, however this may not be the
> correct offset to apply if the kernel was loaded at a misaligned address
> or below LOAD_PHYSICAL_ADDR, as in that case the decompression buffer
> has an additional offset from the original load address.
> 
> This should never happen for a conformant bootloader, but we're being
> paranoid anyway, so just store the new GDT address in there instead of
> adding any offsets, which is simpler as well.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Fixes: ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
> Fixes: 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of the buffer")

Have you or anyone else observed this condition practice, or have a 
suspicion that this could happen - or is this a mostly theoretical 
concern?

Thanks,

	Ingo

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0DDC14FC6A
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 10:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBBJer (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 04:34:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42148 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgBBJeq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 04:34:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so14045293wrd.9;
        Sun, 02 Feb 2020 01:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S2yNcMg/flOTRtk/fmlPvWyglwu5z2BGKORhR/l6zcs=;
        b=eV69YJm3Pgc4+O8vxHRxe7KVsw1/7h+hj2J0CkCzcuPv9TCzN3w5ACzJ2REvw8PfsU
         0H7D4ASAuFxlXKzVpiDZk6wC+JpHgNX+I0EzLoDdeH7d9I3ohuX3NgaUtiIc1DouMZd9
         8hDSMvmrrPWSf0U0omrLQRKy6R6Sgm4uVmS5S/hIZuFVqeov8fl386Ds0qZT2V995VHn
         nflpplGzfq0efDyhMAL8JvfYuqHCRIaHsYDGyUkE1X5xnP9FmQ9KR8qMEZd95aF/0hSF
         2QMa35nRkUMRrnlZE72+fLb67L8xG0mBnWMhHZUFrieN800n+uK3B0Q7RAtPjMN/LCU5
         vKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=S2yNcMg/flOTRtk/fmlPvWyglwu5z2BGKORhR/l6zcs=;
        b=qCIzmmYsADr21KozMxnRJ5zhIZlsHRW+JCan5Ek5MY7d1jKHvwXbRUF83ZMJqS7YsP
         VlCowc9j2cniKvsDb4Fg2G/K7s5XhpgGwAibj9HBZZt78XPvUjEUFiN88HrR1l4CkHl8
         8OvwjHI1LQ5JKgqm/n0/+eMngVddx4viMIh5L8Kv7DROa2EEsSLhzgYo3P4DZurAX1Yn
         HAbdCrckkovfc/KWMlFyrPSS0Ba5M93Ei5Ws5erivDY9HjQ40+W56I4Tzd9F5Xn5+dQK
         fANdR88T049LjMnnlQMmQZ37JS7QnrLCBYqJngOfZ8+L7R+0PhRy8xXzdlzi5aLQ+uYP
         J3Mw==
X-Gm-Message-State: APjAAAUW299L93lSrw9xYdfEIWhkS7i6kuFebaxAAiFJcPBmWVpfcNfi
        AdJUGvhhUSBFiK/r81b/0P8=
X-Google-Smtp-Source: APXvYqyMNKQiutcwPYhUaOyiBhNQm5h7ohqmGi1DwTJUBF0izw4YTB/MEG/+kGUaKwnWH9fNxQgiGw==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr4258636wrt.162.1580636084657;
        Sun, 02 Feb 2020 01:34:44 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f207sm19962533wme.9.2020.02.02.01.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 01:34:44 -0800 (PST)
Date:   Sun, 2 Feb 2020 10:34:42 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        dan.j.williams@intel.com, jrg.otte@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/x86: fix boot regression on systems with invalid
 memmap entries
Message-ID: <20200202093442.GB72728@gmail.com>
References: <20200201233304.18322-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200201233304.18322-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> In efi_clean_memmap(), we do a pass over the EFI memory map to remove
> bogus entries that may be returned on certain systems.
> 
> Commit 1db91035d01aa8bf ("efi: Add tracking for dynamically allocated
> memmaps") refactored this code to pass the input to efi_memmap_install()
> via a temporary struct on the stack, which is populated using an
> initializer which inadvertently defines the value of its size field
> in terms of its desc_size field, which value cannot be relied upon yet
> in the initializer itself.
> 
> Fix this by using efi.memmap.desc_size instead, which is where we get
> the value for desc_size from in the first place.
> 
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/platform/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 59f7f6d60cf6..ae923ee8e2b4 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -308,7 +308,7 @@ static void __init efi_clean_memmap(void)
>  			.phys_map = efi.memmap.phys_map,
>  			.desc_version = efi.memmap.desc_version,
>  			.desc_size = efi.memmap.desc_size,
> -			.size = data.desc_size * (efi.memmap.nr_map - n_removal),
> +			.size = efi.memmap.desc_size * (efi.memmap.nr_map - n_removal),
>  			.flags = 0,
>  		};

Applied, and I also added:

    Reported-by: Jörg Otte <jrg.otte@gmail.com>
    Tested-by: Jörg Otte <jrg.otte@gmail.com>

I presumptively added the Jörg's Tested-by tag: won't send the commit to 
Linus if he still has trouble booting the laptop.

I'm still amazed GCC doesn't warn about this pattern - why?

BTW., could we please also organize such assignments vertically as well:

			.phys_map	= efi.memmap.phys_map,
			.desc_version	= efi.memmap.desc_version,
			.desc_size	= efi.memmap.desc_size,
			.size		= efi.memmap.desc_size * (efi.memmap.nr_map - n_removal),
			.flags		= 0,

(See the patch below.)

Had we done that earlier the weird pattern would have stuck out a lot 
more:

			.phys_map	= efi.memmap.phys_map,
			.desc_version	= efi.memmap.desc_version,
			.desc_size	= efi.memmap.desc_size,
			.size		= data.desc_size * (efi.memmap.nr_map - n_removal),
			.flags		= 0,

BTW., is there a reason "struct efi_memory_map" doesn't embedd a "struct 
efi_memory_map_data"? Or is efi_memory_map firmware ABI?

If they shared the structure then copying would be easier.

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@kernel.org>

 arch/x86/platform/efi/efi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index ae923ee8e2b4..293c47f9cb39 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -305,11 +305,11 @@ static void __init efi_clean_memmap(void)
 
 	if (n_removal > 0) {
 		struct efi_memory_map_data data = {
-			.phys_map = efi.memmap.phys_map,
-			.desc_version = efi.memmap.desc_version,
-			.desc_size = efi.memmap.desc_size,
-			.size = efi.memmap.desc_size * (efi.memmap.nr_map - n_removal),
-			.flags = 0,
+			.phys_map	= efi.memmap.phys_map,
+			.desc_version	= efi.memmap.desc_version,
+			.desc_size	= efi.memmap.desc_size,
+			.size		= efi.memmap.desc_size * (efi.memmap.nr_map - n_removal),
+			.flags		= 0,
 		};
 
 		pr_warn("Removing %d invalid memory map entries.\n", n_removal);

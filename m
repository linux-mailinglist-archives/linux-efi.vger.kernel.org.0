Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9AC01975F4
	for <lists+linux-efi@lfdr.de>; Mon, 30 Mar 2020 09:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgC3Hr1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Mar 2020 03:47:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51972 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgC3Hr1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Mar 2020 03:47:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id c187so18901991wme.1
        for <linux-efi@vger.kernel.org>; Mon, 30 Mar 2020 00:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LWOAY4DgjcNLGyhp459FWx1XMXhcO1ETDlLIMfEa72Q=;
        b=sqW8IpF1V79Q8xk7+BFlh+q0ZAm/IGugJy8WeGH7Kpo5nLu6P8tWVmeQcBGwRkEUUA
         PgEtq40FXpqbbZT0h9Av2INmno6ItZiC8SNpFBnYxBy7yY3cramhuwR7FeXK9IhY8+yw
         DV/Zvi86HNYh7yS1YU3rRVA6FvDfKggUgEQY62otSAN/cN+/zsmMNE8+wPIci8kfSklI
         S7pzLspbBefmmBrWCR25G+eAMAOeUot8sUhERunYXsRNFJTXS8NEp8pJdtASKFGqWPPA
         5olN8Frmny2VsX4PZXsNXYxJ2gFsghknjbN41MDHig8lKx2udOs8oTvn1H7sT7kd5MLs
         vIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LWOAY4DgjcNLGyhp459FWx1XMXhcO1ETDlLIMfEa72Q=;
        b=rG6vdIJcDj+hzWDGcp62Xz+hOPnjam+iaM2o2+polvpE6gNhddkDXBf4dNlSpA6gpw
         zIgAjKN8v1auVgaXgrLjcWN5nRa6ZklFagW6uqAR3CQcNFBIxals1E7KVJ+wNX/7+Thz
         iUtCJ8q9By6PRqj3h1BvbN+uVgz7VYFJN3dgb3duP98VvWkZhrvunSLEKSVX21ODeFrA
         cjUM/h8h+UaYeJRGbk05b/9nQhacJvQ7JWel1uQ7OnqZhnWelIv3kyzjxqtnEOtO/o0L
         OhnWbIfw42KsZFvGP21cO7sEyItTnRxGD+24gaYz2VscJcbKx895Bw80+FZWXzRkvKXX
         K4Aw==
X-Gm-Message-State: ANhLgQ3R6dZkF42xqHDRtOO5QA0WUoe/Dd3uWRX5z4hk0oVteDbxrplF
        QFwjTgpL8i/fShgq0AHzupKFDQ==
X-Google-Smtp-Source: ADFU+vu0UL2EecnqgEV0Rpo8wZsnkzDV/O1+EUQ6YPNpPvgeonkHJEt+JQXkghaKvi8juGhZ5e7FeQ==
X-Received: by 2002:a1c:648b:: with SMTP id y133mr11511761wmb.173.1585554443321;
        Mon, 30 Mar 2020 00:47:23 -0700 (PDT)
Received: from bivouac.eciton.net (bivouac.eciton.net. [2a00:1098:0:86:1000:23:0:2])
        by smtp.gmail.com with ESMTPSA id l10sm20495745wrq.95.2020.03.30.00.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 00:47:22 -0700 (PDT)
Date:   Mon, 30 Mar 2020 08:47:21 +0100
From:   Leif Lindholm <leif@nuviainc.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        mikelley@microsoft.com, Boqun.Feng@microsoft.com
Subject: Re: [PATCH] efi/libstub/arm64: avoid image_base value from
 efi_loaded_image
Message-ID: <20200330074721.GV22097@bivouac.eciton.net>
References: <20200328205809.23825-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328205809.23825-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Mar 28, 2020 at 21:58:09 +0100, Ard Biesheuvel wrote:
> Commit 9f9223778ef3 ("efi/libstub/arm: Make efi_entry() an ordinary
> PE/COFF entrypoint") did some code refactoring to get rid of the
> EFI entry point assembler code, and in the process, it got rid of the
> assignment of image_addr to the value of _text. Instead, it switched
> to using the image_base field of the efi_loaded_image struct provided
> by UEFI, which should contain the same value.
> 
> However, Michael reports that this is not the case: older GRUB builds
> corrupt this value in some way, and since we can easily switch back to
> referring to _text to discover this value, let's simply do that.

It is not clear to me how "older GRUB builds" would differ here.
I think more investigation is needed before making that claim.
My suspicion is that some (old) version of non-upstream, shim-enabled
distro-specific build is playing a part.

So, do we have the option for more detailed investigations, or can we
vague the claim up to say "some GRUB builds seen in the wild, based
on an upstream 2.02" or suchlike?

/
    Leif

> While at it, fix another issue in commit 9f9223778ef3, which may result
> in the unassigned image_addr to be misidentified as the preferred load
> offset of the kernel, which is unlikely but will cause a boot crash if
> it does occur.
> 
> Finally, let's add a warning if the _text vs. image_base discrepancy is
> detected, so we can tell more easily how widespread this issue actually
> is.
> 
> Reported-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 9254cd8ab2d3..db0c1a9c1699 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -116,6 +116,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>  		 * Mustang), we can still place the kernel at the address
>  		 * 'dram_base + TEXT_OFFSET'.
>  		 */
> +		*image_addr = (unsigned long)_text;
>  		if (*image_addr == preferred_offset)
>  			return EFI_SUCCESS;
>  
> @@ -140,7 +141,11 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>  		}
>  		*image_addr = *reserve_addr + TEXT_OFFSET;
>  	}
> -	memcpy((void *)*image_addr, image->image_base, kernel_size);
> +
> +	if (image->image_base != _text)
> +		pr_efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
> +
> +	memcpy((void *)*image_addr, _text, kernel_size);
>  
>  	return EFI_SUCCESS;
>  }
> -- 
> 2.17.1
> 

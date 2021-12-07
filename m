Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67246BA52
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 12:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhLGLu5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 06:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhLGLu5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Dec 2021 06:50:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B21C061574;
        Tue,  7 Dec 2021 03:47:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84163B81753;
        Tue,  7 Dec 2021 11:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA1DC341C3;
        Tue,  7 Dec 2021 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638877644;
        bh=JLfpOmM5lL2mGmNONDtp0vTJm2VAobN91iwOZ/SgMww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWUYSewb0grImpUIs7xJQ2YUTB0T5XOPOImKyaGT+BzagxZOu1QG3BbjNfSIyCqGl
         D4MvwgwjemC9PxP9s5IF+hItoZAnbbiat6ELL9xwOGOYi7Q6h0hDV7hH1FZ1lYuk87
         h/LWvDduhwkT2PbDvwMz9QtijgVNbQVl2M8tCGgdYS8KHv2Na8W7Ylqbychur8vBgA
         hMixmpwsTmpI+T/Bx5X7TxvivsS9QkxpifDoJmUk+8CyC3vzMzUX25J4nsLS0xPKzU
         VIbnLv01IYeSTQen4Geb/a6BN3wO1HAk/qRoVU3TuxgwLN6i4NkBvvUOlG+PoXlx+K
         mC6uhBZ9EliBw==
Date:   Tue, 7 Dec 2021 12:47:17 +0100
From:   Robert Richter <rric@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH 2/2] ghes_edac: refactor error status fields decoding
Message-ID: <Ya9JxfyXYYNtLoSf@rric.localdomain>
References: <20211207031905.61906-2-xueshuai@linux.alibaba.com>
 <20211207031905.61906-3-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207031905.61906-3-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 07.12.21 11:19:05, Shuai Xue wrote:

> @@ -285,6 +285,48 @@ int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
>  	return n;
>  }
>  
> +const char *cper_mem_err_status_str(u64 status)

[...]

Same here, add an EXPORT_SYMBOL_GPL for the function.

> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -568,7 +568,8 @@ void cper_print_proc_arm(const char *pfx,
>  			 const struct cper_sec_proc_arm *proc);
>  void cper_print_proc_ia(const char *pfx,
>  			const struct cper_sec_proc_ia *proc);
> -int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
> -int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
> +int cper_mem_err_location(const struct cper_mem_err_compact *mem, char *msg);
> +int cper_dimm_err_location(const struct cper_mem_err_compact *mem, char *msg);

Do we really need that 'const' here?

> +const char *cper_mem_err_status_str(u64 status);

The function i/f is different compared to the others, though the
purpose is the same. Let's use same style:

 int cper_mem_err_status(const struct cper_mem_err_compact *mem, char *msg);

-Robert

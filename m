Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17484886B7
	for <lists+linux-efi@lfdr.de>; Sat,  8 Jan 2022 23:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiAHW1k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Jan 2022 17:27:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40314 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiAHW1k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Jan 2022 17:27:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6F4860E83;
        Sat,  8 Jan 2022 22:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA36AC36AE9;
        Sat,  8 Jan 2022 22:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641680859;
        bh=umVgocquV8ikReF/Skfwao00FsAlPxbXcqJ7YlmQi8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxhkcyF0TXM9cJB7MMDk2L+sWDgQfZ2tV8OwdKAzAX9Wus71s+TpEL3ctgeE8KOin
         fSft3T69dDPHULh9oBdaYzSDA50Q5X8GfFPMp+KDQf5g1aqHGqjHujLfiFMXbJqwsZ
         RAEIRI2WNvojmOtbJM7cLoLm0hSY+aqYKZ1FD0cTNl6R/XbR22KYfUF5ml7War8FQP
         alUCYERHzCXc8aITS0+KBoveCDP1fz7L3/3OayrCid5j/4N/7Cdo2BEC/Kot4JaF+F
         cy+O9u/CFfdIrijRujwdnP6eAqduGIK6MR9mZg/PfOaeaJ02cVwU2b+pwpLOjT9Fcd
         4QJ2LyRMXyq5Q==
Date:   Sun, 9 Jan 2022 00:27:31 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com,
        zohar@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v9 6/8] efi/mokvar: move up init order
Message-ID: <YdoP06WkzNQQbONo@iki.fi>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-7-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105235012.2497118-7-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 05, 2022 at 06:50:10PM -0500, Eric Snowberg wrote:
> Move up the init order so it can be used by the new machine keyring.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v7: Initial version
> v9: Unmodified from v7
> ---
>  drivers/firmware/efi/mokvar-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
> index 38722d2009e2..5ed0602c2f75 100644
> --- a/drivers/firmware/efi/mokvar-table.c
> +++ b/drivers/firmware/efi/mokvar-table.c
> @@ -359,4 +359,4 @@ static int __init efi_mokvar_sysfs_init(void)
>  	}
>  	return err;
>  }
> -device_initcall(efi_mokvar_sysfs_init);
> +fs_initcall(efi_mokvar_sysfs_init);
> -- 
> 2.18.4
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

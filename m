Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA03B4886BC
	for <lists+linux-efi@lfdr.de>; Sat,  8 Jan 2022 23:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiAHW2j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Jan 2022 17:28:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40820 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiAHW2j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Jan 2022 17:28:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA8BC60E96;
        Sat,  8 Jan 2022 22:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2049C36AE9;
        Sat,  8 Jan 2022 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641680918;
        bh=XSj2psnra+kFuVqOs1ccLUDetdUlwq2ZYL6t1quYVzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wbww4WJNSpivQjcm+6JNmlG7Con5JPjK5l4EljeDHtuLXuNv6Bnnw9ygx1luhU56H
         QmizS8orqJk4nuik970p0I8bpWNRJdWbMZ9Ni63T8vmm4oibYrvYBTJL//DucEExee
         u8RhLmtKR7buu04r2EwL9hYeoYZPl7kDrGEaXnL/9AuKIFJX7ckmFAfv2x6OFLn8gj
         woJZF9GbzqP9qnCWZGCi1ZtO4q5/3YxPPobuWAIHTiFUJy1+7Pl68zhMy9KZJo6KMF
         PZG7bEepTzAqPHPiDli5y0dRprYDNs9i/SBXEMEgMc6jAxQwtvqrylfSuvDOBpQCJo
         BIIOjBno8bJWA==
Date:   Sun, 9 Jan 2022 00:28:30 +0200
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
Subject: Re: [PATCH v9 7/8] integrity: Trust MOK keys if MokListTrustedRT
 found
Message-ID: <YdoQDjM2aC25M0r7@iki.fi>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-8-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105235012.2497118-8-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 05, 2022 at 06:50:11PM -0500, Eric Snowberg wrote:
> A new Machine Owner Key (MOK) variable called MokListTrustedRT has been
> introduced in shim. When this UEFI variable is set, it indicates the
> end-user has made the decision themselves that they wish to trust MOK keys
> within the Linux trust boundary.  It is not an error if this variable
> does not exist. If it does not exist, the MOK keys should not be trusted
> within the kernel.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v1: Initial version
> v2: Removed mok_keyring_trust_setup function
> v4: Unmodified from v2
> v5: Rename to machine keyring
> v6: Unmodified from v5
> v7: Use mokvar table instead of EFI var (suggested by Peter Jones)
> v9: Unmodified from v7
> ---
>  .../platform_certs/machine_keyring.c          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
> index ea2ac2f9f2b5..09fd8f20c756 100644
> --- a/security/integrity/platform_certs/machine_keyring.c
> +++ b/security/integrity/platform_certs/machine_keyring.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2021, Oracle and/or its affiliates.
>   */
>  
> +#include <linux/efi.h>
>  #include "../integrity.h"
>  
>  static __init int machine_keyring_init(void)
> @@ -40,3 +41,21 @@ void __init add_to_machine_keyring(const char *source, const void *data, size_t
>  	if (rc)
>  		pr_info("Error adding keys to machine keyring %s\n", source);
>  }
> +
> +/*
> + * Try to load the MokListTrustedRT MOK variable to see if we should trust
> + * the MOK keys within the kernel. It is not an error if this variable
> + * does not exist.  If it does not exist, MOK keys should not be trusted
> + * within the machine keyring.
> + */
> +static __init bool uefi_check_trust_mok_keys(void)
> +{
> +	struct efi_mokvar_table_entry *mokvar_entry;
> +
> +	mokvar_entry = efi_mokvar_entry_find("MokListTrustedRT");
> +
> +	if (mokvar_entry)
> +		return true;
> +
> +	return false;
> +}
> -- 
> 2.18.4
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

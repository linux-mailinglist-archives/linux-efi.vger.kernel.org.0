Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22C57A14F7
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 06:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjIOE7Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 00:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjIOE7Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 00:59:24 -0400
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 21:59:17 PDT
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B04112134;
        Thu, 14 Sep 2023 21:59:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=4q/HGcBMmA6qdxSQlab3P1FcoDQ1oazL1c+J0UR4Lu0=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20230715; t=1694753035; v=1; x=1695185035;
 b=MnC+VWj9soJQtHtYzZR3I71lvGMYJi3x3tAfTm8VOJPXJT410iOVdi5p1XIM2SG48IN9hzB6
 8mv8QsyIi9kH7BcHkVTvsbttejEg77D1PwQzXaTWzMk+a+wRaqeSHiFFlfej4AWtA7Xq+QBjV91
 jBnt1HxMdCG660Q8cUYR/GxqeKzKAuQjcN245A/4vW+8nMZVe18JezLg7ZpRJ0gGOy+QSIxA5I0
 udvQmfZX7yQL2X/5NqRiz+ED5UcOCdXWcO4JDKCBETCBEinjwZJA9duaP7XB9nwTAXoNy7w4k/L
 tmDL+2D0zxwKzCOdL80lUZA3BO6D7A0QyV/Z6KtVZHi7XMPh16M6teQ9MKsGdDlQRTdgEVHkI/C
 x14Uc1jGQEPEirjOmXsApUazNf84RakAzvsFe8YMpfdmMq0/vwLp3TJ/M4f30cVKbEYbal/bWtS
 KNRqN3opigVa4/oODdHmNydzJ1JAb6mNKsWSI6eMgtu8/Dtl47cECrti+YeK3puFHD9PkBBBUmD
 dcdJvRBew+wTsUW3IifkjocBiwTgu5zGh7BrUWDdRpnaK9yBnaTA4CzZk76tjL1bjjIOEONJcME
 xA5vbDOxYWBTeF5LWD7EEni8q9KI6mpjHNEbE1ItNarv14CjibHzlX3luGvfMbHEJ68JeBWA04j
 AUlPSassku4=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id bd7e3976; Fri, 15 Sep
 2023 00:43:55 -0400
MIME-Version: 1.0
Date:   Fri, 15 Sep 2023 00:43:55 -0400
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Anisse Astier <an.astier@criteo.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] efivarfs: fix statfs() on efivarfs
In-Reply-To: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
References: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
Message-ID: <9dec892136b296cf680a79fe71a602de@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-09-10 00:54, Heinrich Schuchardt wrote:
> Some firmware (notably U-Boot) provides GetVariable() and
> GetNextVariableName() but not QueryVariableInfo().
> 
> With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
> statfs syscall was broken for such firmware.
> 
> If QueryVariableInfo() does not exist or returns an error, just report 
> the
> file-system size as 0 as statfs_simple() previously did.
> 
> Fixes: d86ff3333cb1 ("efivarfs: expose used and total size")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	initialize remaining_space to 0
> ---
>  fs/efivarfs/super.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index e028fafa04f3..3893aae6a9be 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -29,14 +29,9 @@ static int efivarfs_statfs(struct dentry *dentry, 
> struct kstatfs *buf)
>  	const u32 attr = EFI_VARIABLE_NON_VOLATILE |
>  			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
>  			 EFI_VARIABLE_RUNTIME_ACCESS;
> -	u64 storage_space, remaining_space, max_variable_size;
> +	u64 storage_space, remaining_space = 0, max_variable_size;
>  	efi_status_t status;
> 
> -	status = efivar_query_variable_info(attr, &storage_space, 
> &remaining_space,
> -					    &max_variable_size);
> -	if (status != EFI_SUCCESS)
> -		return efi_status_to_err(status);
> -
>  	/*
>  	 * This is not a normal filesystem, so no point in pretending it has 
> a block
>  	 * size; we declare f_bsize to 1, so that we can then report the 
> exact value
> @@ -44,10 +39,19 @@ static int efivarfs_statfs(struct dentry *dentry, 
> struct kstatfs *buf)
>  	 */
>  	buf->f_bsize	= 1;
>  	buf->f_namelen	= NAME_MAX;
> -	buf->f_blocks	= storage_space;
> -	buf->f_bfree	= remaining_space;
>  	buf->f_type	= dentry->d_sb->s_magic;
> 
> +	/* Some UEFI firmware does not implement QueryVariable() */
> +	if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) 
> {
> +		status = efivar_query_variable_info(attr, &storage_space,
> +						    &remaining_space,
> +						    &max_variable_size);
> +		if (status == EFI_SUCCESS) {
> +			buf->f_blocks	= storage_space;
> +			buf->f_bfree	= remaining_space;
> +		}
> +	}
> +
>  	/*
>  	 * In f_bavail we declare the free space that the kernel will allow 
> writing
>  	 * when the storage_paranoia x86 quirk is active. To use more, users

FYI, this issue/fix affects ia64 EFI implementation as well, so adding a 
CC.

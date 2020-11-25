Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05842C3D9E
	for <lists+linux-efi@lfdr.de>; Wed, 25 Nov 2020 11:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgKYK1g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Nov 2020 05:27:36 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:58060 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgKYK1g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Nov 2020 05:27:36 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 706608AB64A;
        Wed, 25 Nov 2020 11:27:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1606300051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TSezgXHWQ2NR0n8DvwevLMAGe0d1kqEYfdPd0tKN9C4=;
        b=Qpz15R9ZqwsP4h4FnS01pUM9CbkRKO1f8/X55jPVLDizaKv6W2wXSc7pAkqVVRNfuvKM6X
        a9syJVYyMACEkTtb62EgPwHNNgJA8+ZWsJ8D3oIhmk0+ZGykxRbfCfGKRrF+cSpOvven5J
        gzGV+Gs7piLA9iN4Y6iSMIDv7WYEFDQ=
MIME-Version: 1.0
Date:   Wed, 25 Nov 2020 11:27:31 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, jk@ozlabs.org, mjg59@google.com,
        David.Laight@aculab.com,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Subject: Re: [PATCH] efivarfs: revert "fix memory leak in efivarfs_create()"
In-Reply-To: <20201125075303.3963-1-ardb@kernel.org>
References: <20201125075303.3963-1-ardb@kernel.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <309bd3399d042ca94e5bab35980d661c@natalenko.name>
X-Sender: oleksandr@natalenko.name
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 25.11.2020 08:53, Ard Biesheuvel wrote:
> The memory leak addressed by commit fe5186cf12e3 is a false positive:
> all allocations are recorded in a linked list, and freed when the
> filesystem is unmounted. This leads to double frees, and as reported
> by David, leads to crashes if SLUB is configured to self destruct when
> double frees occur.
> 
> So drop the redundant kfree() again, and instead, mark the offending
> pointer variable so the allocation is ignored by kmemleak.
> 
> Cc: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
> Fixes: fe5186cf12e3 ("efivarfs: fix memory leak in efivarfs_create()")
> Reported-by: David Laight <David.Laight@aculab.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  fs/efivarfs/inode.c | 1 +
>  fs/efivarfs/super.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
> index 96c0c86f3fff..38324427a2b3 100644
> --- a/fs/efivarfs/inode.c
> +++ b/fs/efivarfs/inode.c
> @@ -103,6 +103,7 @@ static int efivarfs_create(struct inode *dir,
> struct dentry *dentry,
>  	var->var.VariableName[i] = '\0';
> 
>  	inode->i_private = var;
> +	kmemleak_ignore(var);

Do we need to do this as well:

#include <linux/kmemleak.h>

?

Because otherwise for 5.9 I get:

[  148s] fs/efivarfs/inode.c: In function 'efivarfs_create':
[  148s] fs/efivarfs/inode.c:106:2: error: implicit declaration of 
function 'kmemleak_ignore' [-Werror=implicit-function-declaration]
[  148s]   106 |  kmemleak_ignore(var);
[  148s]       |  ^~~~~~~~~~~~~~~

> 
>  	err = efivar_entry_add(var, &efivarfs_list);
>  	if (err)
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index f943fd0b0699..15880a68faad 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -21,7 +21,6 @@ LIST_HEAD(efivarfs_list);
>  static void efivarfs_evict_inode(struct inode *inode)
>  {
>  	clear_inode(inode);
> -	kfree(inode->i_private);
>  }
> 
>  static const struct super_operations efivarfs_ops = {

-- 
   Oleksandr Natalenko (post-factum)

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70AC48869D
	for <lists+linux-efi@lfdr.de>; Sat,  8 Jan 2022 23:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiAHWWr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Jan 2022 17:22:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38266 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiAHWWr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Jan 2022 17:22:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EAAEB80975;
        Sat,  8 Jan 2022 22:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479F2C36AE9;
        Sat,  8 Jan 2022 22:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641680564;
        bh=3Ah3uJ+gKouBrMtOqo4JAPc0oDJOI4r6cYJG48wp5CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvy9s4X17sZzkBF/69NmsiT427UusDGaoXAkr6jbhZU0U9jqf0GMP+zO58YwYsqS6
         WGPholdFzvFDT4bIH/MfzyGaX9xc6BXO3PfhgzQkKodlKuDwl7c8Ztq9ptj/SRjLxE
         vAeMH59JcJbUsiyDajJ1qCJF3sGGycxlPSi8KVeXmI2GU83OkLaS7IkrZZp1FhO4Y5
         VTK6BxI811iJFcJeOmv++4iDXzWbbLbPwfyZZPZhfsRs9GTXLxiDTLO6r34SgeFOds
         hIvX/R+FbrnjutCx6snYlRZCvHj9xORgLLQKbdew+mNUN0dWKIHzzO8Z2ou8k4+09V
         XBsyxghD013iw==
Date:   Sun, 9 Jan 2022 00:22:36 +0200
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
Subject: Re: [PATCH v9 4/8] KEYS: store reference to machine keyring
Message-ID: <YdoOrAOdWaVrRzMR@iki.fi>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-5-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105235012.2497118-5-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 05, 2022 at 06:50:08PM -0500, Eric Snowberg wrote:
> Expose the .machine keyring created in integrity code by adding
> a reference.  Store a reference to the machine keyring in
> system keyring code. The system keyring code needs this to complete
> the keyring link to the machine keyring.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v2: Initial version
> v3: Unmodified from v2
> v4: Removed trust_moklist check
> v5: Rename to machine keyring
> v8: Unmodified from v5
> v9: Combine with "add reference to machine keyring" patch
> ---
>  certs/system_keyring.c        | 9 +++++++++
>  include/keys/system_keyring.h | 8 ++++++++
>  security/integrity/digsig.c   | 2 ++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 692365dee2bd..08ea542c8096 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -22,6 +22,9 @@ static struct key *builtin_trusted_keys;
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  static struct key *secondary_trusted_keys;
>  #endif
> +#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +static struct key *machine_trusted_keys;
> +#endif
>  #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
>  static struct key *platform_trusted_keys;
>  #endif
> @@ -91,6 +94,12 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
>  	return restriction;
>  }
>  #endif
> +#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +void __init set_machine_trusted_keys(struct key *keyring)
> +{
> +	machine_trusted_keys = keyring;
> +}
> +#endif
>  
>  /*
>   * Create the trusted keyrings
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 6acd3cf13a18..98c9b10cdc17 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -38,6 +38,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
>  #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
>  #endif
>  
> +#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +extern void __init set_machine_trusted_keys(struct key *keyring);
> +#else
> +static inline void __init set_machine_trusted_keys(struct key *keyring)
> +{
> +}
> +#endif
> +
>  extern struct pkcs7_message *pkcs7;
>  #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
>  extern int mark_hash_blacklisted(const char *hash);
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 2b7fa85613c0..7b719aa76188 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -112,6 +112,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
>  	} else {
>  		if (id == INTEGRITY_KEYRING_PLATFORM)
>  			set_platform_trusted_keys(keyring[id]);
> +		if (id == INTEGRITY_KEYRING_MACHINE)
> +			set_machine_trusted_keys(keyring[id]);
>  		if (id == INTEGRITY_KEYRING_IMA)
>  			load_module_cert(keyring[id]);
>  	}
> -- 
> 2.18.4
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

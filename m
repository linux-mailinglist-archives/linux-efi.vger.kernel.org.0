Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB24FBA8A
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 13:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245728AbiDKLLM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 07:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345897AbiDKLJI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 07:09:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E169A5FF9;
        Mon, 11 Apr 2022 04:06:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9F969215FC;
        Mon, 11 Apr 2022 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649675202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8l3FS8YFsk/OqORAn3rxQjestKsacMckcsHSATHBZE=;
        b=RpGdQP6AE8ApZkRf+wiTqgUy7XiIRUzzA242TdudFTdWxPJ1SJuJIXa+7c/j7bnwsyK0hs
        c6CKFY+G8yjB4D/JTMIP9VO4kBSBhE9sdI+JAEW2RZxA/dlB/cg+HR9/I7N9u2iKfEQb/Y
        O3NsJO7kukxFtJedjsk0nJDSJCccm8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649675202;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8l3FS8YFsk/OqORAn3rxQjestKsacMckcsHSATHBZE=;
        b=VuqUqLw4Phk6BXBhmJokHyII+BVnZFEpZ8ILrFTtCiBX7Vu4aNQiwDiCKwqxZGqzSqVXIV
        aUszz5eFJFXmkwAw==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CD12AA3B82;
        Mon, 11 Apr 2022 11:06:41 +0000 (UTC)
Date:   Mon, 11 Apr 2022 13:06:40 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        nayna@linux.ibm.com, zohar@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v10 8/8] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
Message-ID: <20220411110640.GC163591@kunlun.suse.cz>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
 <20220126025834.255493-9-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126025834.255493-9-eric.snowberg@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

On Tue, Jan 25, 2022 at 09:58:34PM -0500, Eric Snowberg wrote:
> With the introduction of uefi_check_trust_mok_keys, it signifies the end-

What value does such flag have?

The user is as much in control of the flag as the MOK keys.

> user wants to trust the machine keyring as trusted keys.  If they have
> chosen to trust the machine keyring, load the qualifying keys into it
> during boot, then link it to the secondary keyring .  If the user has not
> chosen to trust the machine keyring, it will be empty and not linked to
> the secondary keyring.

Why is importing the keys and using them linked together?

If later we get, say, machine keyring on powerpc managed by secvarctl
then it has its value to import the keyring and be able to list the
content with the same tools on EFI and powerpc.

It also makes sense to be able to configure the kernel to import the
keys and not use them. I don't see any value in configuring that in
shim, though. shim is both source of the key material and the flag so
the flag is redundant, it does not exist on existing shim versions
installed on user systems, and it's unlikely to exist on other
plaltforms, either.

Thanks

Michal

> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v4: Initial version
> v5: Rename to machine keyring
> v6: Unmodified from v5
> v7: Made trust_mok static
> v8: Unmodified from v7
> v10: Added Jarkko's Reviewed-by
> ---
>  security/integrity/digsig.c                      |  2 +-
>  security/integrity/integrity.h                   |  5 +++++
>  .../integrity/platform_certs/keyring_handler.c   |  2 +-
>  .../integrity/platform_certs/machine_keyring.c   | 16 ++++++++++++++++
>  4 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 7b719aa76188..c8c8a4a4e7a0 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -112,7 +112,7 @@ static int __init __integrity_init_keyring(const unsigned int id,
>  	} else {
>  		if (id == INTEGRITY_KEYRING_PLATFORM)
>  			set_platform_trusted_keys(keyring[id]);
> -		if (id == INTEGRITY_KEYRING_MACHINE)
> +		if (id == INTEGRITY_KEYRING_MACHINE && trust_moklist())
>  			set_machine_trusted_keys(keyring[id]);
>  		if (id == INTEGRITY_KEYRING_IMA)
>  			load_module_cert(keyring[id]);
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 730771eececd..2e214c761158 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -287,9 +287,14 @@ static inline void __init add_to_platform_keyring(const char *source,
>  
>  #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
>  void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
> +bool __init trust_moklist(void);
>  #else
>  static inline void __init add_to_machine_keyring(const char *source,
>  						  const void *data, size_t len)
>  {
>  }
> +static inline bool __init trust_moklist(void)
> +{
> +	return false;
> +}
>  #endif
> diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
> index 4872850d081f..1db4d3b4356d 100644
> --- a/security/integrity/platform_certs/keyring_handler.c
> +++ b/security/integrity/platform_certs/keyring_handler.c
> @@ -83,7 +83,7 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
>  __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
>  {
>  	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
> -		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
> +		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && trust_moklist())
>  			return add_to_machine_keyring;
>  		else
>  			return add_to_platform_keyring;
> diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
> index 09fd8f20c756..7aaed7950b6e 100644
> --- a/security/integrity/platform_certs/machine_keyring.c
> +++ b/security/integrity/platform_certs/machine_keyring.c
> @@ -8,6 +8,8 @@
>  #include <linux/efi.h>
>  #include "../integrity.h"
>  
> +static bool trust_mok;
> +
>  static __init int machine_keyring_init(void)
>  {
>  	int rc;
> @@ -59,3 +61,17 @@ static __init bool uefi_check_trust_mok_keys(void)
>  
>  	return false;
>  }
> +
> +bool __init trust_moklist(void)
> +{
> +	static bool initialized;
> +
> +	if (!initialized) {
> +		initialized = true;
> +
> +		if (uefi_check_trust_mok_keys())
> +			trust_mok = true;
> +	}
> +
> +	return trust_mok;
> +}
> -- 
> 2.18.4
> 

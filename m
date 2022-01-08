Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEE74886C3
	for <lists+linux-efi@lfdr.de>; Sat,  8 Jan 2022 23:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiAHWaP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Jan 2022 17:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiAHWaP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Jan 2022 17:30:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDC6C06173F;
        Sat,  8 Jan 2022 14:30:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4165B8095D;
        Sat,  8 Jan 2022 22:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC418C36AE9;
        Sat,  8 Jan 2022 22:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641681012;
        bh=wlFCQfXctgtYh+4c70NcYh18nrkot7llO/ttKYh7Q5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEv8EHI5ZFQeYflFxj/coG8/WXVrMXjGF5DSz8gFttUUh5lS0q/OyAR5dmMXb2qMW
         JxBQhcrwAmwB7MzuNDM6tACXmoGC1ulfv93pxTjzu2dP0tlOHAlsiDEks9g38IKdCt
         q8eTGkHLXpeimYCV+swDTTmEBBQ4z/g2TY78ZQZIFAl5LAq+j4ytDThtNi8JJFmMEX
         tF37/UN4QRTctjyNmWG3Z669v+G93wcOAaUXWlCoFEzLtXqwbvEVGkw9QiEsOjWjFJ
         Hsx+DIsK/h5/OEsGST5RPM5kudoJ6rhbqIv+q8csU2qIwC8P0vA2vz0TYG4nPlbbuv
         NSZ5xYju7v5jQ==
Date:   Sun, 9 Jan 2022 00:30:04 +0200
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
Subject: Re: [PATCH v9 8/8] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
Message-ID: <YdoQbKD/jJompy6I@iki.fi>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-9-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105235012.2497118-9-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 05, 2022 at 06:50:12PM -0500, Eric Snowberg wrote:
> With the introduction of uefi_check_trust_mok_keys, it signifies the end-
> user wants to trust the machine keyring as trusted keys.  If they have
> chosen to trust the machine keyring, load the qualifying keys into it
> during boot, then link it to the secondary keyring .  If the user has not
> chosen to trust the machine keyring, it will be empty and not linked to
> the secondary keyring.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v4: Initial version
> v5: Rename to machine keyring
> v6: Unmodified from v5
> v7: Made trust_mok static
> v8: Unmodified from v7
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Mimi, have you tested these patches already?

/Jarkko

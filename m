Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A7488699
	for <lists+linux-efi@lfdr.de>; Sat,  8 Jan 2022 23:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiAHWVn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Jan 2022 17:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiAHWVm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Jan 2022 17:21:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF1C06173F;
        Sat,  8 Jan 2022 14:21:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ADA6B80968;
        Sat,  8 Jan 2022 22:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4A4C36AE9;
        Sat,  8 Jan 2022 22:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641680499;
        bh=ulKgJ+KW/oj7DeYLx+FLvgBkYp9cnZnZ92PueDzjKiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGh+j0MTxXeq7cXDyRZYjkRUJVDXwpduec4N9SIi//24qRHmXsVg5aDoU9Bhve1vh
         AEh51PiHejRAUBu+QdeX7PW4WHLTcTSPl+mXkj+IIrTX0G9dsjFeBVrXTocDn/4Ojs
         DwRdDlE3KCfKk/bLK1jSrwzKoBVdKRJoio6f5qR1xOZxWFvrWbC2wCg2dD8A2Y5Jf+
         V6AnZTO0HkxnXH6zWpmZGGka5p/F7O3zs5FzOCOn5f25WLMlzr4O4V3mq90SVvpGGq
         YyyIA8oC349DoLn2Z9AIfdhVFTkvrW+mgXCwVyYKBHs1AJmF7x5+mEBK8950XIHHFv
         a+p2CpAR6Jesw==
Date:   Sun, 9 Jan 2022 00:21:31 +0200
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
Subject: Re: [PATCH v9 3/8] integrity: add new keyring handler for mok keys
Message-ID: <YdoOa45ed0IBcGhL@iki.fi>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-4-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105235012.2497118-4-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 05, 2022 at 06:50:07PM -0500, Eric Snowberg wrote:
> Currently both Secure Boot DB and Machine Owner Keys (MOK) go through
> the same keyring handler (get_handler_for_db). With the addition of the
> new machine keyring, the end-user may choose to trust MOK keys.
> 
> Introduce a new keyring handler specific for MOK keys.  If MOK keys are
> trusted by the end-user, use the new keyring handler instead.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> v1: Initial version
> v3: Only change the keyring handler if the secondary is enabled
> v4: Removed trust_moklist check
> v5: Rename to machine keyring
> v7: Unmodified from v5
> v8: Code unmodified from v7 added Mimi's Reviewed-by
> v9: Unmodified from v8
> ---
>  .../integrity/platform_certs/keyring_handler.c  | 17 ++++++++++++++++-
>  .../integrity/platform_certs/keyring_handler.h  |  5 +++++
>  security/integrity/platform_certs/load_uefi.c   |  4 ++--
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
> index e9791be98fd9..4872850d081f 100644
> --- a/security/integrity/platform_certs/keyring_handler.c
> +++ b/security/integrity/platform_certs/keyring_handler.c
> @@ -67,7 +67,7 @@ static __init void uefi_revocation_list_x509(const char *source,
>  
>  /*
>   * Return the appropriate handler for particular signature list types found in
> - * the UEFI db and MokListRT tables.
> + * the UEFI db tables.
>   */
>  __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
>  {
> @@ -76,6 +76,21 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
>  	return 0;
>  }
>  
> +/*
> + * Return the appropriate handler for particular signature list types found in
> + * the MokListRT tables.
> + */
> +__init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
> +{
> +	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
> +		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
> +			return add_to_machine_keyring;
> +		else
> +			return add_to_platform_keyring;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Return the appropriate handler for particular signature list types found in
>   * the UEFI dbx and MokListXRT tables.
> diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
> index 2462bfa08fe3..284558f30411 100644
> --- a/security/integrity/platform_certs/keyring_handler.h
> +++ b/security/integrity/platform_certs/keyring_handler.h
> @@ -24,6 +24,11 @@ void blacklist_binary(const char *source, const void *data, size_t len);
>   */
>  efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type);
>  
> +/*
> + * Return the handler for particular signature list types found in the mok.
> + */
> +efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
> +
>  /*
>   * Return the handler for particular signature list types found in the dbx.
>   */
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index f290f78c3f30..c1bfd1cd7cc3 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -94,7 +94,7 @@ static int __init load_moklist_certs(void)
>  		rc = parse_efi_signature_list("UEFI:MokListRT (MOKvar table)",
>  					      mokvar_entry->data,
>  					      mokvar_entry->data_size,
> -					      get_handler_for_db);
> +					      get_handler_for_mok);
>  		/* All done if that worked. */
>  		if (!rc)
>  			return rc;
> @@ -109,7 +109,7 @@ static int __init load_moklist_certs(void)
>  	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
>  	if (mok) {
>  		rc = parse_efi_signature_list("UEFI:MokListRT",
> -					      mok, moksize, get_handler_for_db);
> +					      mok, moksize, get_handler_for_mok);
>  		kfree(mok);
>  		if (rc)
>  			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
> -- 
> 2.18.4
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

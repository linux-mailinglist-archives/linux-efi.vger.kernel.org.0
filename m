Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888434886A3
	for <lists+linux-efi@lfdr.de>; Sat,  8 Jan 2022 23:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiAHWZl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Jan 2022 17:25:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39330 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiAHWZk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Jan 2022 17:25:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36E94B80972;
        Sat,  8 Jan 2022 22:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D2EC36AE9;
        Sat,  8 Jan 2022 22:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641680737;
        bh=0+uUgU/dGkTTDnx69h7pfbDE68Fsm1j4ayaPAkADzpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSpnrNQlMKmc9bQcaFqySSZoiLE450OE8FwipduUN1xGJy1HUCa7GwgNa5MDXVzAj
         lKi/4UXFaxNLPDnZ/jLZUCNdXhojmoqzy9f9bEbuKVj3ftURHnhO/krDLLcAW0wrpe
         PLEiSOm4RyjiLATu2UbHdO3gyAkySus2yH3G9Mw5KyzbVOnkgafEu7VezgZYCaVVE4
         vcQLKk1iOVxsi5g9oQHGwmCpf0KufG7dmUb1v4sHRlkHhchptAFWGIJJBYKmxo0aav
         jSfpoppNbOGWBrCLmBfo78VM6/JUj+I0KWxsyLLGkqY54JXuqzkwiS0QI4h8o9Tq+3
         8QUfvv5A2gtJw==
Date:   Sun, 9 Jan 2022 00:25:29 +0200
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
Subject: Re: [PATCH v9 5/8] KEYS: Introduce link restriction for machine keys
Message-ID: <YdoPWR2DvWVAF0BU@iki.fi>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-6-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105235012.2497118-6-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 05, 2022 at 06:50:09PM -0500, Eric Snowberg wrote:
> Introduce a new link restriction that includes the trusted builtin,
> secondary and machine keys. The restriction is based on the key to be
> added being vouched for by a key in any of these three keyrings.
> 
> With the introduction of the machine keyring, the end-user may choose to
> trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
> trust them, the .machine keyring will contain these keys.  If not, the
> machine keyring will always be empty.  Update the restriction check to
> allow the secondary trusted keyring and ima keyring to also trust
> machine keys.
> 
> Allow the .machine keyring to be linked to the secondary_trusted_keys.
> After the link is created, keys contained in the .machine keyring will
> automatically be searched when searching secondary_trusted_keys.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v3: Initial version
> v4: moved code under CONFIG_INTEGRITY_MOK_KEYRING
> v5: Rename to machine keyring
> v6: Change subject name (suggested by Mimi)
>     Rename restrict_link_by_builtin_secondary_and_ca_trusted
>       to restrict_link_by_builtin_secondary_and_machine (suggested by
>       Mimi)
> v7: Unmodified from v6
> v8: Add missing parameter definitions (suggested by Mimi)
> v9: Combine with "change link restriction to trust the machine keyring"
>       patch
> ---
>  certs/system_keyring.c        | 35 ++++++++++++++++++++++++++++++++++-
>  include/keys/system_keyring.h |  6 ++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 08ea542c8096..05b66ce9d1c9 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -89,7 +89,10 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
>  	if (!restriction)
>  		panic("Can't allocate secondary trusted keyring restriction\n");
>  
> -	restriction->check = restrict_link_by_builtin_and_secondary_trusted;
> +	if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
> +		restriction->check = restrict_link_by_builtin_secondary_and_machine;
> +	else
> +		restriction->check = restrict_link_by_builtin_and_secondary_trusted;
>  
>  	return restriction;
>  }
> @@ -98,6 +101,36 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
>  void __init set_machine_trusted_keys(struct key *keyring)
>  {
>  	machine_trusted_keys = keyring;
> +
> +	if (key_link(secondary_trusted_keys, machine_trusted_keys) < 0)
> +		panic("Can't link (machine) trusted keyrings\n");
> +}
> +
> +/**
> + * restrict_link_by_builtin_secondary_and_machine - Restrict keyring addition.
> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @restrict_key: A ring of keys that can be used to vouch for the new cert.
> + *
> + * Restrict the addition of keys into a keyring based on the key-to-be-added
> + * being vouched for by a key in either the built-in, the secondary, or
> + * the machine keyrings.
> + */
> +int restrict_link_by_builtin_secondary_and_machine(
> +	struct key *dest_keyring,
> +	const struct key_type *type,
> +	const union key_payload *payload,
> +	struct key *restrict_key)
> +{
> +	if (machine_trusted_keys && type == &key_type_keyring &&
> +	    dest_keyring == secondary_trusted_keys &&
> +	    payload == &machine_trusted_keys->payload)
> +		/* Allow the machine keyring to be added to the secondary */
> +		return 0;
> +
> +	return restrict_link_by_builtin_and_secondary_trusted(dest_keyring, type,
> +							      payload, restrict_key);
>  }
>  #endif
>  
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 98c9b10cdc17..2419a735420f 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -39,8 +39,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
>  #endif
>  
>  #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +extern int restrict_link_by_builtin_secondary_and_machine(
> +	struct key *dest_keyring,
> +	const struct key_type *type,
> +	const union key_payload *payload,
> +	struct key *restrict_key);
>  extern void __init set_machine_trusted_keys(struct key *keyring);
>  #else
> +#define restrict_link_by_builtin_secondary_and_machine restrict_link_by_builtin_trusted
>  static inline void __init set_machine_trusted_keys(struct key *keyring)
>  {
>  }
> -- 
> 2.18.4
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

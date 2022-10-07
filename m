Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ACC5F7D3A
	for <lists+linux-efi@lfdr.de>; Fri,  7 Oct 2022 20:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJGSWG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Oct 2022 14:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGSWF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Oct 2022 14:22:05 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E5BC61F;
        Fri,  7 Oct 2022 11:22:04 -0700 (PDT)
Message-ID: <9b68f825-675c-ff78-cd83-fb4f9428940b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665166923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+lz343jwwipYjASYwNev7eIZ97Yfa1rMEADurNp9b4=;
        b=kP0ZFmqOKScWo9yQha6VG6gvahDX/c+RChSRU2I/X9B0YpUR0a0osfU/D5WxwZbvbebBmw
        q8vGRoaIq2zaffcp3MJ2i3JS1WcnKOgmXkd4imstzALD8VPv6CAWrocOrFs86ryOIyM9Rh
        UG8P+47XwCfDJ20r1vucbH74Zptzj8E=
Date:   Fri, 7 Oct 2022 12:21:57 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] block: sed-opal: keystore access for SED Opal keys
Content-Language: en-US
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
        msuchanek@suse.de, mpe@ellerman.id.au, nayna@linux.ibm.com,
        axboe@kernel.dk, akpm@linux-foundation.org,
        linux-efi@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, jarkko@kernel.org
References: <20220819223138.1457091-1-gjoyce@linux.vnet.ibm.com>
 <20220819223138.1457091-4-gjoyce@linux.vnet.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220819223138.1457091-4-gjoyce@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

LGTM besides comment below

Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>

On 8/19/2022 4:31 PM, gjoyce@linux.vnet.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> 
> Allow for permanent SED authentication keys by
> reading/writing to the SED Opal non-volatile keystore.
> 
> Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> ---
>  block/sed-opal.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 3bdb31cf3e7c..11b0eb3a656b 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -18,6 +18,7 @@
>  #include <linux/uaccess.h>
>  #include <uapi/linux/sed-opal.h>
>  #include <linux/sed-opal.h>
> +#include <linux/sed-opal-key.h>
>  #include <linux/string.h>
>  #include <linux/kdev_t.h>
>  #include <linux/key.h>
> @@ -2697,7 +2698,13 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
>  	if (ret)
>  		return ret;
>  
> -	/* update keyring with new password */
> +	/* update keyring and arch var with new password */
> +	ret = sed_write_key(OPAL_AUTH_KEY,
> +			    opal_pw->new_user_pw.opal_key.key,
> +			    opal_pw->new_user_pw.opal_key.key_len);
> +	if (ret != -EOPNOTSUPP)
> +		pr_warn("error updating SED key: %d\n", ret);
I cant see any reason this would fail and make the keys inconsistent, but it seems
like update_sed_opal_key() should be dependent on sed_write_key() succeeding

> +
>  	ret = update_sed_opal_key(OPAL_AUTH_KEY,
>  				  opal_pw->new_user_pw.opal_key.key,
>  				  opal_pw->new_user_pw.opal_key.key_len);
> @@ -2920,6 +2927,8 @@ EXPORT_SYMBOL_GPL(sed_ioctl);
>  static int __init sed_opal_init(void)
>  {
>  	struct key *kr;
> +	char init_sed_key[OPAL_KEY_MAX];
> +	int keylen = OPAL_KEY_MAX;
>  
>  	kr = keyring_alloc(".sed_opal",
>  			   GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
> @@ -2932,6 +2941,11 @@ static int __init sed_opal_init(void)
>  
>  	sed_opal_keyring = kr;
>  
> -	return 0;
> +	if (sed_read_key(OPAL_AUTH_KEY, init_sed_key, &keylen) < 0) {
> +		memset(init_sed_key, '\0', sizeof(init_sed_key));
> +		keylen = OPAL_KEY_MAX;
> +	}
> +
> +	return update_sed_opal_key(OPAL_AUTH_KEY, init_sed_key, keylen);
>  }
>  late_initcall(sed_opal_init);

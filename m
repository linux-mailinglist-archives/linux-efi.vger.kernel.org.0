Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C17488483
	for <lists+linux-efi@lfdr.de>; Sat,  8 Jan 2022 17:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiAHQZV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Jan 2022 11:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiAHQZU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Jan 2022 11:25:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E235C06173F;
        Sat,  8 Jan 2022 08:25:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58FCBB80259;
        Sat,  8 Jan 2022 16:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93351C36AE3;
        Sat,  8 Jan 2022 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641659118;
        bh=C2VKpp7NNq9PTCZgyOANayncg/RnDrFND2NQX7+3jXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFpWeLErycJzwsyQrAW/LcCbybR22/KTbydhLNsLr0RdAjX1siuEuk1WkCVEr6lcn
         e3UOderd5PbbUcgGdnxnM5MKYi5EfcRJ8e3QBP6HUMflToHj00aTkJSYWE8Y1Fu8PG
         Md3e86tuHTK4AK1kRLmEfTudNXy04gzonMJhVAR+k5OqCcaqWlFNM/fTdRwkpQQPCB
         9gbV54PQ9ht2fpc0woPTgqMTBWRxlgZ+bIiEZcfwSKc9BmZ8QA+ZJD48Mfg/RZZ2GI
         3m43dbnwB+EHim5dn5qsGZlc0Zws5lrj8a4ron7/YLez9KZCTUO5Sjfq7H6lOfQAVZ
         6+Hvu+MzUwvDw==
Date:   Sat, 8 Jan 2022 18:25:09 +0200
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
Subject: Re: [PATCH v9 1/8] integrity: Fix warning about missing prototypes
Message-ID: <Ydm65Uruy4u9SWeO@iki.fi>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-2-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105235012.2497118-2-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 05, 2022 at 06:50:05PM -0500, Eric Snowberg wrote:
> make W=1 generates the following warning in keyring_handler.c
> 
> security/integrity/platform_certs/keyring_handler.c:71:30: warning: no previous prototype for get_handler_for_db [-Wmissing-prototypes]
>  __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
>                               ^~~~~~~~~~~~~~~~~~
> security/integrity/platform_certs/keyring_handler.c:82:30: warning: no previous prototype for get_handler_for_dbx [-Wmissing-prototypes]
>  __init efi_element_handler_t get_handler_for_dbx(const efi_guid_t *sig_type)
>                               ^~~~~~~~~~~~~~~~~~~
> Add the missing prototypes by including keyring_handler.h.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> v7: Initial version
> v8: Code unmodified from v7 added Mimi's Reviewed-by
> v9: Unmodified from v8
> ---
>  security/integrity/platform_certs/keyring_handler.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
> index 5604bd57c990..e9791be98fd9 100644
> --- a/security/integrity/platform_certs/keyring_handler.c
> +++ b/security/integrity/platform_certs/keyring_handler.c
> @@ -9,6 +9,7 @@
>  #include <keys/asymmetric-type.h>
>  #include <keys/system_keyring.h>
>  #include "../integrity.h"
> +#include "keyring_handler.h"
>  
>  static efi_guid_t efi_cert_x509_guid __initdata = EFI_CERT_X509_GUID;
>  static efi_guid_t efi_cert_x509_sha256_guid __initdata =
> -- 
> 2.18.4
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

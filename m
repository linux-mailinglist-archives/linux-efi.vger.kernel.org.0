Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511EC165032
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 21:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBSUqF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 15:46:05 -0500
Received: from mail.hallyn.com ([178.63.66.53]:40728 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgBSUqF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 15:46:05 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 1CA7E46B; Wed, 19 Feb 2020 14:46:03 -0600 (CST)
Date:   Wed, 19 Feb 2020 14:46:03 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>, x86@kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 9/9] integrity: check properly whether EFI GetVariable()
 is available
Message-ID: <20200219204603.GA28639@mail.hallyn.com>
References: <20200219171907.11894-1-ardb@kernel.org>
 <20200219171907.11894-10-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219171907.11894-10-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 19, 2020 at 06:19:07PM +0100, Ard Biesheuvel wrote:
> Testing the value of the efi.get_variable function pointer is not
> the right way to establish whether the platform supports EFI
> variables at runtime. Instead, use the newly added granular check
> that can test for the presence of each EFI runtime service
> individually.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  security/integrity/platform_certs/load_uefi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 111898aad56e..e2fe1bd3abb9 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -76,7 +76,7 @@ static int __init load_uefi_certs(void)
>  	unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
>  	int rc = 0;
>  
> -	if (!efi.get_variable)
> +	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))

Sorry, where is this defined?

>  		return false;
>  
>  	/* Get db, MokListRT, and dbx.  They might not exist, so it isn't
> -- 
> 2.17.1
